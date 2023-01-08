import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
     body:ListView(),
    );

  }
  PreferredSizeWidget appBar(){
    return AppBar(
      title: Text('Notification Screen'),
    );
  }
  Widget listView(){
    return ListView.separated(itemBuilder: (context,index){
      return ListViewItem(index);
    }, separatorBuilder: (context,index){
      return Divider(height: 0,); },itemCount: 5);
  }
  Widget ListViewItem(int index){
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 13,vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            prefixIcon(),
            Expanded(
              child: Container(
                        margin: EdgeInsets.only(left: 10),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    message(index),
                    timeAndDate(index),
            
                  ],
                ),
              ),
            ),
          ],
        ),
      );
  }
  Widget prefixIcon(){
    return Container(
      height: 50,
      width: 50,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey.shade300,
      ),
      child: Icon(Icons.notifications,
      size:25 ,
      color: Colors.grey.shade700,),
    );
  }
  Widget message(int index){
    double textSize = 14;
    return Container(
      child: RichText(
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          text: 'Message',
          style: TextStyle(
            fontSize: textSize,
            color: Colors.black,
            fontWeight: FontWeight.bold
          ),
          children: [
            TextSpan(
              text: 'message Description',
              style: TextStyle(fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
Widget timeAndDate(int index){
  return Container(
    margin: EdgeInsets.only(top: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('12-1-2023',
        style: TextStyle(fontSize: 10
        ),
        ),  
         Text('22-1-2023',
        style: TextStyle(fontSize: 10
        ),
        ),  
      ]),
  );
}