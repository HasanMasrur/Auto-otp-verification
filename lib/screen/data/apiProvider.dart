import 'package:auto_opt_varifacation/screen/constantdata/constantdata.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class ApiProvider {
  final Dio dio = Dio(BaseOptions(
    baseUrl: ConstantData.BASE_URL,
    connectTimeout: 50000,
    receiveTimeout: 3000,
  ));

  Future<Either<DioError, Response>> login({phone_no, app_key}) async {
    final Map<String, dynamic> authdata = {
      'phone': phone_no,
      'app_key': app_key
    };
    print('----------------authdata: ');
    print(authdata);
    return await Task(() => dio.post(
          '${ConstantData.SIGNUP_OTP}',
          data: authdata,
        )).attempt().run().then((either) {
      return either.fold((l) {
        return Left(l as DioError);
      }, (r) {
        print('---------------- ');
        print(r);
        return Right(r);
      });
    });
  }
}
