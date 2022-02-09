import 'package:shared_preferences/shared_preferences.dart';
import '../models/app_user.dart';

class UserLocalData {
  static late SharedPreferences? _preferences;
  static Future<void> init() async =>
      _preferences = await SharedPreferences.getInstance();

  static void signout() => _preferences!.clear();

  static const String _uidKey = 'UIDKEY';
  static const String _displayNameKey = 'DISPLAYNAMEKEY';
  static const String _phoneKey = 'PHONEKEY';
  static const String _isAdminKey = 'ISADMINKEY';
  static const String _postKey = 'POSTKEY';

  //s
  // Setters
  //
  static Future<void> setUID(String uid) async =>
      _preferences!.setString(_uidKey, uid);

  static Future<void> setDisplayName(String name) async =>
      _preferences!.setString(_displayNameKey, name);

  static Future<void> setPhone(String phone) async =>
      _preferences!.setString(_phoneKey, phone);
  static Future<void> setIsVerified(bool isAdmin) async =>
      _preferences!.setBool(_isAdminKey, isAdmin);

  static Future<void> setCourse(List<String> course) async =>
      _preferences!.setStringList(_postKey, course);

  //
  // Getters
  //
  static String get getUID => _preferences!.getString(_uidKey) ?? '';
  static String get getName => _preferences!.getString(_displayNameKey) ?? '';
  static String get getPhone => _preferences!.getString(_phoneKey) ?? '';
  static bool get getIsAdmin => _preferences!.getBool(_isAdminKey) ?? false;

  void storeAppUserData({required AppUser appUser}) {
    setUID(appUser.uid);
    setDisplayName(appUser.name);
    setPhone(appUser.phoneNumber);
    setIsVerified(appUser.isAdmin ?? false);
    setCourse(appUser.courses ?? <String>[]);
  }
}
