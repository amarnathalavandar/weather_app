import 'package:oz_core/oz_core.dart';
import 'package:oz_smart_key/src/core/services/hid/hid_service_monitored.dart';
import 'package:zig_flutter_hid/models/pk_pass.dart';
import 'package:zig_flutter_hid/services/zig_flutter_hid_platform_interface.dart';

part 'view_in_wallet_state.dart';

class ViewInWalletCubit extends Cubit<ViewInWalletState> {
  final ZIGFlutterHidPlatform zIGFlutterHidPlatform;
  final HidServiceMonitored hidService;

  
  ViewInWalletCubit({required this.zIGFlutterHidPlatform, required this.hidService})
      : super(const ViewInWalletState());
      
 bool isPassAvailable=false;
 bool isRemotePassAvailable =false;
 bool showViewWallet = false;

  Future<void> checkPassesAvailability() async {
    emit(state.copyWith(status: ViewInWalletStatus.loading));
    try {
    await hidService.startHid();
    isPassAvailable = await zIGFlutterHidPlatform.isDevicePassAvailable();
    isRemotePassAvailable = await zIGFlutterHidPlatform.isRemotePassAvailable();
    showViewWallet = isPassAvailable || (isPassAvailable && isRemotePassAvailable);
    print('AMAR isPassAvailable :$isPassAvailable');
     print('AMAR isRemotePassAvailable :$isRemotePassAvailable');
     print('AMAR showViewWallet1 :$showViewWallet');
     print('AMAR showViewWallet 2:$showViewWallet');
    emit(state.copyWith(
        status: ViewInWalletStatus.success, 
       isPassAvailable: isPassAvailable,
       isRemotePassAvailable: isRemotePassAvailable,
       showViewWallet:showViewWallet,
    ));
    } catch (e) {
      emit(state.copyWith(status: ViewInWalletStatus.error));
    }
  }

  Future<void> showPass() async {
     emit(state.copyWith(status: ViewInWalletStatus.loading));
     await zIGFlutterHidPlatform.showPassInWallet();
     emit(state.copyWith(
      status: ViewInWalletStatus.success,
     isPassAvailable: isPassAvailable,
     isRemotePassAvailable: isRemotePassAvailable,
     showViewWallet:showViewWallet,
    ));
  }
}
