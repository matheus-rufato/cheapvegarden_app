import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

import 'logging_interceptor.dart';

class Webclient {
  final Client client = InterceptedClient.build(
    interceptors: [
      LoggingInterceptor(),
    ],
  );
  // static const String baseUrl = "https://cheapvegarden.herokuapp.com/";
  // static const String baseUrl = "http://192.168.40.33:9000/";
  static const String baseUrl = "http://192.168.0.104:9000/";
  // static const String baseUrl = "http://192.168.0.18:9000/";
}
