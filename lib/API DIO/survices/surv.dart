



import 'package:dio/dio.dart';



class Dioservice{
  var url = "https://jsonplaceholder.typicode.com/posts";

  Future<dynamic> getdata() async{
    Dio dio =Dio();
    return await dio.get(url,options: Options(responseType: ResponseType.json,
        method: 'Get')).then((response){
      return response;
    });
  }
}