import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:oz_spotlight/core/constants/oz_spotlight_api_constants.dart';
import 'package:oz_spotlight/core/route_arguments.dart';
import 'package:oz_spotlight/ui/cubits/recognize_workflow/recognize_workflow_cubit.dart';
import 'package:oz_spotlight/ui/cubits/recognize_workflow/recognize_workflow_state.dart';
import 'package:oz_spotlight/ui/features/activity/cubit/activity_cubit.dart';
import 'package:oz_spotlight/ui/features/activity/widgets/activity_card.dart';
import 'package:oz_spotlight/ui/features/activity/widgets/filter_toggle.dart';
import 'package:oz_spotlight/core/helpers/date_time_coverter_helper.dart';
import 'package:oz_core/oz_core.dart';
import 'package:oz_spotlight/ui/features/activity/widgets/showParticipantsModal.dart';
import 'package:oz_spotlight/ui/features/recognition_card/pages/recognition_card_page.dart';
import 'package:oz_spotlight/ui/widgets/spotlight_loader.dart';

class ActivityMobileLayout extends StatefulWidget {
  @override
  _ActivityMobileLayoutState createState() => _ActivityMobileLayoutState();
}

class _ActivityMobileLayoutState extends State<ActivityMobileLayout> {
  final _animatedListKey = GlobalKey<AnimatedListState>();

  final ScrollController _scrollController = ScrollController();
  int page = 1;
  int pageSize = 2;
  bool _isLoading = false;
  bool _hasMoreData = true; // Flag to indicate if more data is available
  String? userId;
  bool isUserAllowed = false;

  @override
  void initState() {
    super.initState();
    init();
    _scrollController.addListener(_onScroll);
  }

  void _onFilterSelected(String filterKey) {
    isUserAllowed = filterKey != 'everyone';
    init();
  }

  Future<void> init() async {
    final recognizeWorkflowCubit = context.read<RecognizeWorkflowCubit>();
    recognizeWorkflowCubit.getCurrentMember();
    userId = '';
    if (isUserAllowed) {
      userId = recognizeWorkflowCubit.currentMember?.fullName.replaceAll(' ', '.');
    }

    if (recognizeWorkflowCubit.state.statusRecognition ==
        StatusRecognition.success) {
      recognizeWorkflowCubit.resetRecognitionStatus();
      context.read<ActivityCubit>().getActivityAfterRecognize(
          page, pageSize, _animatedListKey, userId, isUserAllowed);
    } else {
      print('FIRST TIME LOADING');
      context
          .read<ActivityCubit>()
          .getAllRecognitionActivity(page, pageSize, userId, isUserAllowed,false);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
      print('AMAR TIME BEFORE PULL UP CONDITION CHECK-1 :${DateTime.now()}');
    if (_scrollController.offset ==
            _scrollController.position.minScrollExtent  &&
        !_scrollController.position.outOfRange)
            {
              print('AMAR YOU ARE PULLING UP-1 YES');
             print('AMAR TIME - 2 :${DateTime.now()}');
              print('AMAR YOU ARE PULLING UP-2 YES');
              context.read<ActivityCubit>().refreshData( userId, isUserAllowed);
            print('AMAR TIME -  6 :${DateTime.now()}');
            }
    // print('PIXELS : ${_scrollController.position.pixels}');
    // print('MIN SCROLL EVENT:${_scrollController.position.minScrollExtent}');
    // print('MAX SCROLL EVENT:${_scrollController.position.maxScrollExtent}');
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !_isLoading &&
        _hasMoreData) {
      page+=1;
      context
          .read<ActivityCubit>()
          .getAllRecognitionActivity(page, pageSize, userId, isUserAllowed,false);
    }
  }

// Future<void> _handleRefresh() async {
//   // Fetch new data and update the UI - Can be used along with native RefreshIndicator.adaptive widget
//    context.read<ActivityCubit>().getAllRecognitionActivity(1, 25, userId, isUserAllowed,false);
// }

  @override
  Widget build(BuildContext context) {
    final l10n = OZLocalizations.of(context);

    final List<Map<String, String>> filters = [
      {'key': 'everyone', 'label': l10n.spotlight_filter_everyone},
      {'key': 'my_activity', 'label': l10n.spotlight_filter_my_activity},
    ];

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: FilterToggle(
            filters: filters,
            initialSelectedKey: 'everyone',
            onFilterSelected: _onFilterSelected,
          ),
        ),
        Expanded(
         child: BlocBuilder<ActivityCubit, ActivityState>(
           builder: (context, state) {
           //final activitiesSize=state.activities!.items.length;
           // print('AMAR isPullDown :${state.isPullDown}');
             
             switch (state.status) {
               case ActivitiesStatus.loading:
               {
                 return const OZLoader();
               }
               case ActivitiesStatus.success || ActivitiesStatus.refresh:
                 return SingleChildScrollView(
                  controller:_scrollController,
                   child: Column(
                     children: [
                       if(state.isPullDown!)
                       const SpotlightLoader(),
                       ListView.builder(
                        itemCount: _hasMoreData ? state.activities!.items.length+1 : state.activities!.items.length,
                        key: _animatedListKey,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          //final activites = state.activities!.items[index];
                          //print('AMAR index:$index');
                          //print('AMAR items lenght:${state.activities?.items.length}');
                          return index >= state.activities!.items.length
                          ? const SpotlightLoader() //const OZLoader();
                          : GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => RecognitionCardPage(
                                      id: state.activities!.items[index].id!, index: index),
                                ),
                              );
                            },
                            child: SizedBox(
                              child: ActivityCard(
                                userName: state.activities!.items[index].participants![0].name!,
                                userProfileImage:
                                    state.activities!.items[index].participants![0].profileImageUrl!,
                                recognizerName: state.activities!.items[index].creator!.name!,
                                eventImage: state.activities!.items[index].eventType!,
                                date: formatRecognitionDate(state.activities!.items[index].date!),
                                body: state.activities!.items[index].message!,
                                placeholderImage: state.activities!.items[index].imageHref!,
                                likes: state.activities!.items[index].likes!.counts!,
                                comments: state.activities!.items[index].comments!.counts!,
                                participantsCount: state.activities!.items[index].participants!.length,
                                likedByCurrentMember:
                                    state.activities!.items[index].likedByCurrentMember!,
                                index: index,
                                eventId: state.activities!.items[index].id!,
                                onTap: () async {},
                                onParticipantsTap: () => showParticipantsModal(
                                    context, state.activities!.items[index].participants!),
                              ),
                            ),
                          );
                        },
                       ),
                     ],
                   ),
                 );
               case ActivitiesStatus.error:
                 return Center(
                     child: Text(l10n.something_went_wrong_try_again,
                         style: const TextStyle(color: OZColors.errorColor)));
               default:
                 return Center(
                     child: Text(l10n
                         .unable_to_retrieve_information_please_try_again));
             }
           },
         ),
                  ),
      ],
    );
  }
  
}



