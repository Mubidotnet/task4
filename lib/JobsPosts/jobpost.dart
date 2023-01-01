import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class jobPost extends StatefulWidget {
  const jobPost({super.key});

  @override
  State<jobPost> createState() => _jobPostState();
}

class _jobPostState extends State<jobPost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       
        title: Text('Job Post'),
        leading: BackButton(color: Colors.white),
        actions: [
          
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){

      } ,
       child: Icon(Icons.add),
       ),
    );
  }
}