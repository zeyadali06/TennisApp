import 'package:tennis_app/Features/AuthFeature/Data/Models/UserModel.dart';

class ConstantNames {
  static const String usersDataCollection = 'usersDataCollection';
  static const String locationsCollection = 'locationsCollection';
  static const String fullNameField = 'Full Name';
  static const String emailField = 'Email';
  static const String uidField = 'UID';
  static const String locationsField = 'locationsField';
  static const String defaultLocationField = 'defaultLocationField';
  static const String longitudeField = 'longitudeField';
  static const String latitudeField = 'latitudeField';
  static const String placeField = 'placemarkField';
  static const String apiKey = "API_KEY";
  static const String baseURL = "https://api.weatherapi.com/v1/";
  static UserModel userModel = UserModel();
}
