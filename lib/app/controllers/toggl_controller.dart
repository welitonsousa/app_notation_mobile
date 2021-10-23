import 'package:app_notation_mobile/app/controllers/controller_theme.dart';
import 'package:rive/rive.dart';

class TogglController {
  static final _active = SimpleAnimation("day_idle", autoplay: !ControllerTheme.instance.isDark);
  static final _desactive = SimpleAnimation("night_idle", autoplay: ControllerTheme.instance.isDark);

  get listControllers => [_desactive, _active];

  void changeValue() async {
    if (!ControllerTheme.instance.isDark) {
      _desactive.isActive = false;
      _active.isActive = true;
      _active.reset();
    } else {
      _active.isActive = false;
      _desactive.isActive = true;
      _desactive.reset();
    }
  }
}
