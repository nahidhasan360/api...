import 'package:loginsignup/utils/congfig.dart';

class ApiEndpoints{
  static const String appUrl = "${AppConfig.basUrL}/api";
static Uri auth = Uri.parse("$appUrl/login");

}