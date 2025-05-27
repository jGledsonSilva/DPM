// Strings em Inglês
import 'app_strings_interface.dart';

class EnUsAppStrings implements AppStrings {
  @override
  String get welcomeMessage => "Welcome to DPM App!";

  @override
  String get appTitle => "DPM App";

  @override
  String get welcomeTagline =>
      "Manage your projects efficiently and collaboratively.";

  @override
  String get getStartedButton => "Get Started";

  @override
  String get alreadyHaveAccountButton => "I already have an account";
}
