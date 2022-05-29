class AppSetting {
  static const String appTitle = 'App Name';

  // UI related
  static const String dateTimeFormat = 'yyyy/MM/dd';
  static const int minPickerYear = 1900;
  static const int dialogContentMaxLine = 3;

  // Firestore
  static const String accountCollection = 'accounts';

  // Network
  static const requestTimeout = 10; //seconds

  // Regex
  static final RegExp emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
}
