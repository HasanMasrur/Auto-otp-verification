import 'package:auto_opt_varifacation/screen/constantdata/constantdata.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class ApiProvider {
  final Dio dio = Dio(BaseOptions(
    baseUrl: ConstantData.BASE_URL,
    connectTimeout: 50000,
    receiveTimeout: 3000,
  ));

  Future<Either<DioError, Response>> login(
      {String? url, Map<String, dynamic>? authdata}) async {
    print(authdata);
    return await Task(() => dio.post(
          url!,
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
