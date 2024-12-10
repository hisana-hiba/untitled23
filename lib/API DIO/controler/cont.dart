
import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';


import '../model/mode.dart';
import '../survices/surv.dart';

class Datacontroller extends GetxController{

  void onInit(){
    fetchData();
    isInternetConnected();
    super.onInit();
  }



  RxList<Dio> datas= RxList();
  RxBool isLoading = true.obs;
  RxBool isListDown = false.obs;
  RxBool isNetConnected = true.obs;


  var scrollController = ItemScrollController();

  void isInternetConnected()async{
    isNetConnected.value = await InternetConnectionChecker().hasConnection;
  }
  fetchData()async{
    isNetConnected();
    isLoading.value = true;
    var response = await Dioservice().getdata();
    if(response.statusCode==200){
      response.data.forEach((data){
        datas.add(Dio.fromJson(data));
      });
      isLoading.value = false;
    }
  }
  scrollToDown(){
    scrollController.scrollTo(index: datas.length, duration:const Duration(seconds : 4),
        curve: Curves.bounceInOut
    );
    isListDown.value =  true;
  }
  scrollToUp(){
    scrollController.scrollTo(index: 0, duration: Duration(seconds: 4,),
        curve: Curves.slowMiddle);
    isListDown.value=false;
  }






}