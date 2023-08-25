import 'package:flutter/material.dart';
import 'package:mobile_clock/model/alarm_model.dart';


alarmBottomSheet(context, AlarmModel model){
  return showModalBottomSheet(context: context, builder: (BuildContext context){
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width,
      //Convert to inkWell
      //Use ElevatedButton if is possible to remove the Circular border.
      child: Column(children: [
        Expanded(
          child: InkWell(onTap: () {},
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(26), topRight: Radius.circular(26),),
            child: const Center(child: Text("View Alarm"),),
          
          ),
        ),
        Expanded(
          child: InkWell(onTap: () async{
            await Navigator.of(context).pushNamed('/editAlarm', arguments: model).then((value) => Navigator.of(context).pop());
          },
            child: const Center(child: Text("Edit Alarm"),),

          
          ),
        ),
        Expanded(
          child: InkWell(onTap: () {},
            child: const Center(child: Text("Delete Alarm"),),
          
          ),
        ),

        /*
        ElevatedButton(
          onPressed: () {},
          
          style: ElevatedButton.styleFrom(minimumSize: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height * 0.1),), 
          child: const Text("Extend info"),),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(minimumSize: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height * 0.1),), 
          child: const Text("Delete Alarm"),),
          */
      ],),
    );

  },);
}