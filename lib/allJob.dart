import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fyp/searchjobs.dart';
import 'package:google_fonts/google_fonts.dart';

import 'jobseeker.dart';

class AllJobsPage extends StatefulWidget {
  @override
  _AllJobsPageState createState() => _AllJobsPageState();
}

class _AllJobsPageState extends State<AllJobsPage> {
  List<jobs> listjobs = [];
  List<jobs> listSearchJobs = [];

  Future<void> display() async {
    listjobs = [];
    try {
      final List<jobs> loadedProduct = [];
      var userData = await Firestore.instance
          .collection('jobs')
          .where("status", isEqualTo: "open")
          .getDocuments();
      userData.documents.forEach((element) {
        String title = "";
        String company = "";
        String company_logo = "";
        String city = "";
        int timeStamp = 0;
        element.data.forEach((key, value) {
          if (key == "title") {
            title = value;
          }
          if (key == "company") {
            company = value;
          }
          if (key == "company_logo") {
            company_logo = value;
          }
          if (key == "city") {
            city = value;
          }
          if (key == "timestamp") {
            // print(value.toString());
            timeStamp = int.parse(value.toString());
          }
        });
        listjobs.add(jobs(
            title: title,
            company: company,
            company_logo: company_logo,
            city: city,
            timeStamp: timeStamp));
      });
      // listjobs.addAll(loadedProduct);
      listjobs.sort((a, b) => b.timeStamp.compareTo(a.timeStamp));

      print(loadedProduct);
      // }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      // display();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.only(left: 35),
          child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: SvgPicture.asset(
                "assets/images/ic_back.svg",
                width: 10,
                height: 10,
              )),
        ),
        title: const Text(
          "See All Jobs",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: FutureBuilder(
          future: display(),
          builder: (ctx, snapshot) {
            return listView();
          }),
    );
  }

  Widget listView() {
    return ListView.separated(
        itemBuilder: (context, index) {
          return ListViewItem(listjobs[index]);
        },
        separatorBuilder: (context, index) {
          return Divider(
            height: 0,
          );
        },
        itemCount: listjobs.length);
  }

  Widget ListViewItem(jobs notification) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => JobDetailsPage(),
            ));
      },
      child: buildNewOpportunitiesListTile(
        notification.title,
        notification.company + ", " + notification.city,
        "assets/images/company_one.png",
      ),
    );
  }

  Widget buildSearch() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: (String value) {
          // code to perform search
        },
        decoration: InputDecoration(
            hintText: 'Search...',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)))),
      ),
    );
  }

  Widget buildNewOpportunitiesListTile(
      String title, String company, String img) {
    return Container(
      margin: const EdgeInsets.only(bottom: 7, top: 7),
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Color(0xffF8F5F5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Image.asset(
                img,
                height: 35,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 15),
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15),
                    child: Text(
                      company,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(right: 10),
            child: SvgPicture.asset("assets/images/ic_more.svg"),
          )
        ],
      ),
    );
  }
}
