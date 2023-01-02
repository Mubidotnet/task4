import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fyp/allJob.dart';
import 'package:fyp/jobseeker.dart';
import 'package:fyp/profilePage.dart';
import 'package:fyp/searchjobs.dart';
import 'package:fyp/signin.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fyp/allJob.dart';
import 'package:fyp/profilePage.dart';
import 'package:fyp/jobseeker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? name;
  String? email;
  String? firstChar;
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

  //call function to get user data
  Future<void> getUserData() async {
    //get current user id
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    String uid = user.uid;

    //fetch user data from firebase
    DocumentSnapshot userData =
        await Firestore.instance.collection('users').document(uid).get();
    // this.name = userData.data['fname'] + " " + userData.data['lname'];
    // this.email = userData.data['email'];
    // this.firstChar = userData.data['fname'].substring(0, 1).toUpperCase();
    // String firstChar = text.substring(0, 1).toUpperCase();
    //print user data
    String fname = "";
    String lname = "";

    for (var entry in userData.data.entries) {
      print(entry.key);
      print(entry.value);

      if (entry.key == "email") {
        setState(() {
          email = entry.value;
        });
      }
      if (entry.key == "first_name") {
        setState(() {
          fname = entry.value;
        });
      }
      if (entry.key == "last_name") {
        setState(() {
          lname = entry.value;
        });
      }
    }
    setState(() {
      name = fname + " " + lname;
    });
    setState(() {
      firstChar = fname.substring(0, 1).toUpperCase() +
          lname.substring(0, 1).toUpperCase();
    });
    // print();
  }

  @override
  void initState() {
    getUserData();
    print("initState Called");
    super.initState();
  }

  Future<void> signOutUser() async {
    //sign out user
    await FirebaseAuth.instance.signOut();

    //navigate to login screen
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => MyLogin()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(
          "Find a perfect job",
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AllJobsPage(),
            ));
                // showSearch(context: context, delegate: jobsearch());
              })
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(name.toString()),
              accountEmail: Text(email.toString()),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  firstChar.toString(),
                  style: TextStyle(fontSize: 25.0),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Profile"),
              onTap: null,
              trailing: Icon(Icons.arrow_forward_ios_rounded),
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text("Notification"),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
            ),
            ListTile(
              leading: Icon(Icons.contact_page),
              title: Text("Contact Us"),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logut"),
              onTap: () {
                signOutUser();
              },
              trailing: Icon(Icons.arrow_forward_ios_rounded),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: initWidget(),
        ),
      ),
    );
  }

  Widget initWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildProfileComponent(),
        //buildSearch(),
        buildCategories(),
        buildPopularCompanies(),
        buildNewOpportunity()
      ],
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

  Widget buildProfileComponent() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ProfilePage()));
      },
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(6)),
            border: Border.all(color: Colors.grey.shade400)),
        child: Stack(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.all(12),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  child: Image.asset(
                    "assets/images/profile_img.png",
                    fit: BoxFit.fill,
                    height: 60,
                    width: 50,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 15),
                    child: const Text(
                      "John Dee",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: const Text(
                      "UI/UX Designer",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            right: 20,
            bottom: 1,
            top: 1,
            child: SvgPicture.asset(
              "assets/images/ic_message.svg",
            ),
          )
        ]),
      ),
    );
  }

  // Widget buildSearch() {
  //   return Container(
  //     child: Padding(
  //       padding: const EdgeInsets.all(.0),
  //       child: Padding(
  //         padding: const EdgeInsets.all(20.0),
  //         child: Column(
  //           children: [
  //             TextField(

  //               // onChanged: (value) => _runFilter(value),
  //               decoration: InputDecoration(
  //                 contentPadding: const EdgeInsets.symmetric(
  //                     vertical: 10.0, horizontal: 15),
  //                 hintText: "Search",

  //                suffixIcon: const Icon(Icons.search

  //                ),
  //                  //prefix: Icon(Icons.search),

  //                 border: OutlineInputBorder(
  //                   borderRadius: BorderRadius.circular(20.0),
  //                   borderSide: const BorderSide(),

  //                 ),
  //               ),

  //                      ),

  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget buildCategories() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 35),
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          categoryListTile("Applied Jobs"),
          categoryListTile("Recommended Jobs"),
          categoryListTile("Saved Jobs"),
        ],
      ),
    );
  }

  Widget categoryListTile(String title) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(right: 10),
      decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xffF8F5F5),
              Color(0xffEEE8F3),
            ],
          ),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget buildPopularCompanies() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 35),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Popular Company",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "See All",
                style: TextStyle(
                    color: Color(0xffAD98C4),
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Container(
            height: 190,
            margin: const EdgeInsets.only(top: 10),
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [
                buildPopularCompaniesListTile(
                    "assets/images/ic_google.svg",
                    "\$50K-\$90K",
                    "Senior product Designer",
                    "Google. California"),
                buildPopularCompaniesListTile(
                    "assets/images/ic_amazon.svg",
                    "\$70K-\$100K",
                    "Senior product Designer",
                    "Amazone. California")
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildPopularCompaniesListTile(
      String logo, String salary, String jobTitle, String loc) {
    return Container(
      width: 300,
      margin: const EdgeInsets.only(right: 10),
      decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff7837C2),
              Color(0xff3C1C61),
            ],
          ),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20, top: 20),
                child: SvgPicture.asset(logo),
              ),
              Container(
                margin: const EdgeInsets.only(top: 12, left: 20),
                child: Text(
                  jobTitle,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5, left: 20),
                child: Text(
                  loc,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 15, left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(right: 10),
                      decoration: const BoxDecoration(
                          color: Color(0xffB392D8),
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: const Center(
                        child: Text(
                          "Full Time",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(right: 10),
                      decoration: const BoxDecoration(
                          color: Color(0xffB392D8),
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: const Center(
                        child: Text(
                          "Remote",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            right: 1,
            bottom: 1,
            top: 1,
            child: Container(
              margin: const EdgeInsets.only(top: 30, right: 20),
              child: Text(
                salary,
                style: const TextStyle(color: Colors.white, fontSize: 17),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildNewOpportunity() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 35),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "New Opportunities",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AllJobsPage(),
                      ));
                },
                child: const Text(
                  "See All",
                  style: TextStyle(
                      color: Color(0xffAD98C4),
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Container(
            height: 190,
            margin: const EdgeInsets.only(top: 10),
            child: FutureBuilder(
                future: display(),
                builder: (ctx, snapshot) {
                  return listView();
                }),
          )
        ],
      ),
    );
  }

  Widget buildNewOpportunitiesListTile(
      String title, String company, String img) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => JobDetailsPage()));
      },
      child: Container(
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
      ),
    );
  }
}
// class jobsearch extends SearchDelegate<jobs>{
//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     // TODO: implement buildActions
//     return[IconButton( icon: Icon(Icons.clear), onPressed: () {  
//       query="";
//       },)];
//   }

//   @override
//   Widget? buildLeading(BuildContext context) {
//     // TODO: implement buildLeading
//     return IconButton(onPressed:(){
//       var result = null;
//       close(context, result);
//     }, icon: Icon(Icons.arrow_back),);
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     // TODO: implement buildResults
//     throw UnimplementedError();
//   }

//   @override
//   // Widget buildSuggestions(BuildContext context) {
//   //   // TODO: implement buildSuggestions
//   //   final mylist = loadjobs();

//   //   return ListView.builder(
//   //     itemCount: mylist.length,
//   //     itemBuilder: (context, index){
//   //       final jobs listitem = mylist[index];
//   //       return ListTile(title:
//   //        Column(
//   //         crossAxisAlignment: CrossAxisAlignment.start,
//   //          children: <Widget>[
//   //            Text(listitem.title),
//   //            Text(listitem.categogry)
//   //          ],
//   //        ),);
//   //     });
//   // }
  
// }