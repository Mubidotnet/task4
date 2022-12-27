import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.only(right: 20),
              child: SvgPicture.asset(
                "assets/images/ic_edit.svg",
              ),
            ),
          )
        ],
        title: const Text(
          "Profile",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(child: SingleChildScrollView(child: initWidget())),
    );
  }

  Widget initWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildUserDetails(),
        buildSkills(),
        buildEducationCourses()
      ],
    );
  }

  Widget buildUserDetails() {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(12),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                child: Image.asset(
                  "assets/images/profile_img.png",
                  fit: BoxFit.fill,
                  height: 70,
                  width: 60,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5),
              child: const Text(
                "John Dee",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            const Text(
              "UI/UX Designer",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSkills() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 10, right: 10, top: 50),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircularPercentIndicator(
                radius: 30.0,
                lineWidth: 4.0,
                animation: true,
                percent: 0.8,
                center: const Text(
                  "80.0%",
                  style: TextStyle(
                    fontSize: 11.0,
                    color: Color(0xffFC9B00)
                  ),
                ),
                footer: Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: const Text(
                    "Usability test",
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: const Color(0xffFC9B00),
              ),
              CircularPercentIndicator(
                radius: 30.0,
                lineWidth: 4.0,
                animation: true,
                percent: 0.8,
                center: const Text(
                  "80.0%",
                  style: TextStyle(
                      fontSize: 11.0,
                      color: Color(0xffEC3B6B)
                  ),
                ),
                footer: Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: const Text(
                    "Storyboard",
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: const Color(0xffEC3B6B),
              ),
              CircularPercentIndicator(
                radius: 30.0,
                lineWidth: 4.0,
                animation: true,
                percent: 0.8,
                center: const Text(
                  "80.0%",
                  style: TextStyle(
                      fontSize: 11.0,
                      color: Color(0xffA46BE4)
                  ),
                ),
                footer: Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: const Text(
                    "Prototyping",
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: const Color(0xffA46BE4),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 30),
            child: const Text(
              "See All",
              style: TextStyle(
                  color: Color(0xffAD98C4),
                  fontSize: 16,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildEducationCourses() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20, top: 30),
          child: const Text(
            "New Opportunities",
            style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
          child: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            children: [
              buildCourseListTile(
                  "Senior Developer",
                  "Fanavaran, Taiwan",
                  "assets/images/company_one.png"
              ),
              buildCourseListTile(
                "Flutter Developer",
                "Google, California",
                "assets/images/company_two.png",
              ),
              buildCourseListTile(
                  "Senior Developer",
                  "Fanavaran, Taiwan",
                  "assets/images/company_one.png"
              ),
              buildCourseListTile(
                "Flutter Developer",
                "Google, California",
                "assets/images/company_two.png",
              ),
              buildCourseListTile(
                  "Senior Developer",
                  "Fanavaran, Taiwan",
                  "assets/images/company_one.png"
              ),
              buildCourseListTile(
                "Flutter Developer",
                "Google, California",
                "assets/images/company_two.png",
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget buildCourseListTile(String title, String company, String img) {
    return Container(
      margin: const EdgeInsets.only(bottom: 7, top: 7),
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Color(0xffF8F5F5)
      ),
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
            margin: const EdgeInsets.only(right: 10),
            child: SvgPicture.asset("assets/images/ic_more.svg"),
          )
        ],
      ),
    );
  }
}