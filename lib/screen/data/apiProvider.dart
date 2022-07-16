import 'package:auto_opt_varifacation/screen/constantdata/constantdata.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class ApiProvider {
  final Dio dio = Dio(BaseOptions(
    baseUrl: ConstantData.apiUrl,
    connectTimeout: 50000,
    receiveTimeout: 3000,
    // headers: {
    //   "X-Authorization" : "1y8eGr8r75OOp2D4aMtbsDe6RJbONQL6iIOdH67COieqflQUBu52xTMFgBa6VJdE"
    // }
  ));
  login({phone_no, app_key}) async {
    final Map<String, dynamic> authdata = {
      'phone': phone_no,
      'app_key': app_key
    };
    return await Task(() => dio.post(
          '/user-api/v1/ride?',
          data: authdata,
        )).attempt().run().then((either) {
      return either.fold((l) {
        return Left(l as DioError);
      }, (r) {
        return Right(r);
      });
    });
  }
}
