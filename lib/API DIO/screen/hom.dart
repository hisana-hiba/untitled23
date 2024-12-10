
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../controler/cont.dart';


void main(){
  runApp(GetMaterialApp(home: screen(),));
}
class screen extends StatefulWidget {
  const screen({super.key});

  @override
  State<screen> createState() => _screenState();
}

class _screenState extends State<screen> {
  Datacontroller controller = Get.put(Datacontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold
      (
      floatingActionButton: Obx(()=> controller.isNetConnected.value ? FloatingActionButton(onPressed: (){
        controller.isListDown.value
            ? controller.scrollToDown()
            : controller.scrollToUp();
      },
        child: FaIcon(controller.isListDown.value? FontAwesomeIcons.arrowUp
            :FontAwesomeIcons.arrowDown),): Container()),



      body: Obx(()=>
          SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: controller.isNetConnected.value == true
                  ? (controller.isLoading.value
                  ? const Center(
                  child: CircularProgressIndicator(

                  )
              )
                  : getData())
                  : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    MaterialButton(onPressed: ()async {
                      if(await InternetConnectionChecker().hasConnection== true){
                        controller.fetchData();
                      }else{
                        SnackBar(content: ScaffoldMessenger(child: Text("error")),);
                      }
                    })

                  ],
                ),

              )
          ),

      ),
    );
  }
  RefreshIndicator getData(){
    return RefreshIndicator(child: ScrollablePositionedList.builder(
        itemCount: controller.datas.length,
        itemBuilder: (context,index) {
          var data=controller.datas[index];
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.grey,
                child: Text(data.id.toString()),
              ),
              title: Text(data.title),
              subtitle: Text(data.body),
            ),
          );
        }), onRefresh: (){
      return controller.fetchData();
    });
  }
}
