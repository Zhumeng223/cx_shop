import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:hm_shop/viewmodels/user.dart';

// 需要共享的对象
class UserController extends GetxController {
  var user = UserInfo.fromJSON({}).obs;

  updateUserInfo(UserInfo newUser) {
    user.value = newUser;
  }
}
