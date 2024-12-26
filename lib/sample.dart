import 'dart:async';

import 'package:oz_core/oz_core.dart';
import 'package:oz_spotlight/data/entities/activity/activity_entity.dart';
import 'package:oz_spotlight/data/repositories/activity_repository.dart';
import 'package:oz_spotlight/data/repositories/spotlight_repository.dart';
import 'package:oz_spotlight/core/constants/oz_spotlight_api_constants.dart';
import 'package:oz_spotlight/core/di/oz_spotlight_locator.dart';
part 'activity_state.dart';

class ActivityCubit extends Cubit<ActivityState> {
  final ActivityRepository repository;
  final SpotlightRepository spotlightRepository;
  ActivityCubit({required this.repository, required this.spotlightRepository})
      : super(const ActivityState());

  Future<void> getAllRecognitionActivity(
     
    int page, int pageSize, String? userId, bool isUserAllowed,bool? isPullDown) async {
    final result = await repository.getAllRecognitionActivity(
        page: page,
        pageSize: pageSize,
        userId: userId,
        isUserAllowed: isUserAllowed);
    result.when(
      failure: (error) => _onFailure(),
      success: (activites) => _onSuccess(activites, page),
    );
  }

  Future<void> refreshData(String? userId, bool isUserAllowed) async
  {
             print('AMAR TIME - 3 :${DateTime.now()}');
    if(state.status==ActivitiesStatus.success)
    {
     // print(' AMAR REFRESHING DATA2');
     print('AMAR TIME - 4 :${DateTime.now()}');
      emit(
        state.copyWith(
          status: ActivitiesStatus.refresh,
          activities: state.activities,
          isPullDown: true
        ),
      );
      print('AMAR TIME - 5 :${DateTime.now()}');

      // print('AMAR AWAITING 3 SECONDS');
      //await Future.delayed(Duration(seconds: 5));
    }
  getAllRecognitionActivity(1, 4,  userId,isUserAllowed,false);  
  }
  

  void _onSuccess(ActivityEntity activities, int page) async {
    if (page == 1 ) {
      emit(state.copyWith(status:ActivitiesStatus.loading));
      //print('AMAR activites : ${activities.items.length}');
        
      emit(
        state.copyWith(
          status: ActivitiesStatus.success,
          activities: activities,
          isPullDown: false
        ),
      );
    } 
    // else if (page == 1 && isPullDown!) {
    //   print('AMAR page: $page');
    //   print('AMAR pullDown: $isPullDown');
    //   print('AMAR AWAITING 3 SECONDS');
    //   await Future.delayed(Duration(seconds: 3));
    //   print('AMAR activites : ${activities.items.length}');
    //   emit(
    //     state.copyWith(
    //       isPullDown: false,
    //       status: ActivitiesStatus.success,
    //       activities: activities,
    //     ),
    //   );
    // }
    else {
      
      final mutableItems = [...state.activities!.items];

      // Add next page items
      mutableItems.addAll(activities.items);
     //print(' AMAR AWAIT 3 SECONDS');
    //await Future.delayed(Duration(seconds: 3));
      // Create a new ActivityEntity with the updated list
      final finalItems = activities.copyWith(items: mutableItems);
      //print('AMAR finalItems leng: ${finalItems.items.length}');
      emit(
        state.copyWith(
          status: ActivitiesStatus.success,
          activities: finalItems,
        ),
      );
    }
  }

  void _onFailure() => emit(state.copyWith(status: ActivitiesStatus.error));

  Future<void> getActivityAfterRecognize(int page, int pageSize,
      dynamic animatedListKey, String? userId, bool isUserAllowed) async {
    await getAllRecognitionActivity(page, pageSize, userId, isUserAllowed,false)
        .then((_) async {
      const newActivitiesPage = 1;
      getNewRecognitionActivity(
          newActivitiesPage, pageSize, animatedListKey, userId, isUserAllowed);
    });
  }

  Future<void> getNewRecognitionActivity(int page, int pageSize,
      dynamic animatedListKey, String? userId, bool isUserAllowed) async {
    await Future.delayed(const Duration(seconds: 1));

    final result = await repository.getAllRecognitionActivity(
        page: page, pageSize: pageSize, userId: userId, isUserAllowed: isUserAllowed);

    result.when(
      success: (newActivities) => _onNewActivitiesSuccess(
          page, pageSize, animatedListKey, newActivities, userId, isUserAllowed),
      failure: (error) => _onNewActivitiesFailure(),
    );
  }

  void _onNewActivitiesSuccess(int page, int pageSize, dynamic animatedListKey,
      ActivityEntity newActivities, String? userId, bool isUserAllowed) async {
    if (state.activities != null) {
      final lastId = state.activities!.items.elementAt(0).id;
      final lastIndex =
          newActivities.items.indexWhere((newItem) => newItem.id == lastId);

      if (lastIndex > 0) {
        final itemsToAdd = newActivities.items.take(lastIndex).toList();

        final mutableItems = [...state.activities!.items];
        mutableItems.insertAll(0, itemsToAdd);
        if (animatedListKey.currentState != null) {
          animatedListKey.currentState!.insertAllItems(0, lastIndex);
        }

        final activities = state.activities!.copyWith(items: mutableItems);
        emit(state.copyWith(activities: activities));
      } else {
        // Recursive until we get new Data
        getNewRecognitionActivity(
            page, pageSize, animatedListKey, userId, isUserAllowed);
      }
    }
  }

  void _onNewActivitiesFailure() =>
      emit(state.copyWith(status: ActivitiesStatus.error));

  Future<bool> onLike(
      int index, String eventId, String intialLikesCount) async {
    bool response = false;
    updateLikes(eventId, true, int.parse(intialLikesCount) + 1);

    var likeActivityEventResult = await repository.likeActivityEvent(eventId);
    likeActivityEventResult.when(
      failure: (error) =>
          {_onError(error, eventId, intialLikesCount, false), response = false},
      success: (likes) => response = true,
    );
    if (!response) {
      return response;
    }

    final likesCountResult = await repository.getActivityLikes(eventId);
    int likescount = 0;
    likesCountResult.when(
      failure: (error) => likescount,
      success: (likes) => likescount = likes,
    );

    int currentCount = int.parse(intialLikesCount) + 1;
    if (likescount != 0 && likescount != currentCount) {
      updateLikes(eventId, true, likescount);
    }

    return true;
  }

  Future<bool> onUnLike(
      int index, String eventId, String intialLikesCount) async {
    bool response = false;
    updateLikes(eventId, false, int.parse(intialLikesCount) - 1);
    var unLikeActivityEventResult =
        await repository.unLikeActivityEvent(eventId);
    unLikeActivityEventResult.when(
      failure: (error) =>
          {_onError(error, eventId, intialLikesCount, true), response = false},
      success: (likes) => response = true,
    );
    if (!response) {
      return response;
    }

    final likesCountResult = await repository.getActivityLikes(eventId);
    int likescount = 0;
    likesCountResult.when(
      failure: (error) => likescount,
      success: (likes) => likescount = likes,
    );

    int currentCount = int.parse(intialLikesCount) - 1;
    if (likescount != 0 && likescount != currentCount) {
      updateLikes(eventId, false, likescount);
    }

    return true;
  }

  void updateLikes(String eventId, bool status, int likesCount) {
    final finalItems = state.activities!.copyWith(
      items: state.activities!.items.map((item) {
        if (item.id == eventId) {
          return item.copyWith(
              likedByCurrentMember: status,
              likes: item.likes!.copyWith(counts: likesCount.toString()));
        }
        return item;
      }).toList(),
    );
    emit(
      state.copyWith(status: ActivitiesStatus.success, activities: finalItems),
    );
  }

  void _onError(
      BluError error, String eventId, String intialLikesCount, bool isLike) {
    updateLikes(eventId, isLike, int.parse(intialLikesCount));
    locator<TelemetryService>().submitError(
      isFatal: false,
      error:
          '$tag Failed on activity like status change: $eventId. Error: $error',
      trace: StackTrace.current,
    );
  }
}
