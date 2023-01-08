import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Addpostscreen extends StatefulWidget {
  const Addpostscreen({super.key});

  @override
  State<Addpostscreen> createState() => _AddpostscreenState();
}

class _AddpostscreenState extends State<Addpostscreen> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text('Add Post'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              TextFormField(
               decoration: InputDecoration(
                hintText: 'Job Title',
                 enabledBorder: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.black,
                ),),
                
               ),
                 ),
                 SizedBox(
                height: 30,
              ),
               TextFormField(
               decoration: InputDecoration(
                
                hintText: 'Job category',
                enabledBorder: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.black,
                ),),
                
               ),
                 ),
                   SizedBox(
                height: 30,
              ),
               TextFormField(
               decoration: InputDecoration(
                hintText: 'Requirments',
                 enabledBorder: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.black,
                ),),
                
               ),
                 ),
                    SizedBox(
                height: 30,
              ),
               TextFormField(
               decoration: InputDecoration(
                hintText: ' Job Timing',
                 enabledBorder: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.black,
                ),),
                
               ),),
                 SizedBox(
                height: 30,
              ),
                 
                  TextFormField(
               decoration: InputDecoration(
                hintText: 'Job Level',
                enabledBorder: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.black,
                ),),
                
               ),
                 ),
                SizedBox(
                height: 30,
              ),
                 TextFormField(
                  maxLines: 10,
                   decoration: InputDecoration(
                hintText: 'Add Description',
               enabledBorder: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.black,
                ),),
                ),
                 ),
            
              Container(
               margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  width: MediaQuery.of(context).size.width,
                  child: MaterialButton(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    color: const Color(0xff7837C2), onPressed: () {  },
                      child: const Text(
                      "Add Post",
                      style: TextStyle(color: Colors.white),
                    ),
                    ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}