import 'package:shared_value/shared_value.dart';

final SharedValue<bool> is_logged_in = SharedValue(
  value: true, // initial value
  key: "is_logged_in", // disk storage key for shared_preferences
);

final SharedValue<String> access_token = SharedValue(
  value: "xvxsghdwqeyfgfsvfsrssjdrys", // initial value
  key: "access_token", // disk storage key for shared_preferences
);

final SharedValue<String> user_id = SharedValue(
  value: '1', // initial value
  key: "user_id", // disk storage key for shared_preferences
);

final SharedValue<String> country_id = SharedValue(
  value:"1", // initial value
  key: "country_id", // disk storage key for shared_preferences
);

final SharedValue<String> vendor_id = SharedValue(
  value:"60", // initial value
  key: "vendor_id", // disk storage key for shared_preferences
);

final SharedValue<String> avatar_original = SharedValue(
  value: "assets/profile.png", // initial value
  key: "avatar_original", // disk storage key for shared_preferences
);

final SharedValue<String> user_name = SharedValue(
  value: "test user", // initial value
  key: "user_name", // disk storage key for shared_preferences
);

final SharedValue<String> user_email = SharedValue(
  value: "asd@yahoo.com", // initial value
  key: "user_email", // disk storage key for shared_preferences
);

final SharedValue<String> user_phone = SharedValue(
  value: "01045765432", // initial value
  key: "user_phone", // disk storage key for shared_preferences
);

final SharedValue<String> app_language = SharedValue(
  value:"en",// "sa", // initial value
  key: "app_language", // disk storage key for shared_preferences
);

final SharedValue<String> app_mobile_language = SharedValue(
  value: "en",//"ar", // initial value
  key: "app_mobile_language", // disk storage key for shared_preferences
);

final SharedValue<bool> app_language_rtl = SharedValue(
  value: false, // initial value
  key: "app_language_rtl", // disk storage key for shared_preferences
);