import 'package:rive/rive.dart';

class ControllerTeddy {
  static final _success = SimpleAnimation("success", autoplay: false);
  static final _idle = SimpleAnimation("idle", autoplay: true);
  static final _fail = SimpleAnimation("fail", autoplay: false);
  static final _pass = SimpleAnimation("hands_up", autoplay: false);
  static final _viewpass = SimpleAnimation("hands_down", autoplay: true);
  static final _left = SimpleAnimation("Look_down_left", autoplay: false);
  static final _right = SimpleAnimation("Look_down_right", autoplay: false);

  get listControllers =>
      [_fail, _pass, _viewpass, _left, _right, _idle, _success];

  void email() {
    resetLoop();
    _viewpass.isActive = true;
    _pass.isActive = false;
  }

  void resetLoop() {
    _success.isActive = true;
    _success.reset();
    _idle.reset();
  }

  void pass() {
    resetLoop();
    _pass.isActive = true;
    _viewpass.isActive = false;
  }

  void check(String value) {
    _success.isActive = false;
    if (value.length <= 17) {
      _left.isActive = true;
    } else {
      _right.isActive = true;
    }
  }

  void error() {
    resetLoop();
    _fail.isActive = true;
  }
}
