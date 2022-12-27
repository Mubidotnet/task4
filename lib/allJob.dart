import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AllJobsPage extends StatefulWidget {
  @override
  _AllJobsPageState createState() => _AllJobsPageState();
}

class _AllJobsPageState extends State<AllJobsPage> {
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
              )
          ),
        ),
        title: const Text(
          "See All Jobs",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSearch(),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  buildNewOpportunitiesListTile(
                      "Senior Developer",
                      "Fanavaran, Taiwan",
                      "assets/images/company_one.png",
                  ),
                  buildNewOpportunitiesListTile(
                    "Flutter Developer",
                    "Google, California",
                    "assets/images/company_two.png",
                  ),
                  buildNewOpportunitiesListTile(
                      "Senior Developer",
                      "Fanavaran, Taiwan",
                      "assets/images/company_one.png"

                  ),
                  buildNewOpportunitiesListTile(
                    "Flutter Developer",
                    "Google, California",
                    "assets/images/company_two.png",

                  ),
                  buildNewOpportunitiesListTile(
                      "Senior Developer",
                      "Fanavaran, Taiwan",
                      "assets/images/company_one.png"

                  ),
                  buildNewOpportunitiesListTile(
                    "Flutter Developer",
                    "Google, California",
                    "assets/images/company_two.png",

                  ),
                  buildNewOpportunitiesListTile(
                      "Senior Developer",
                      "Fanavaran, Taiwan",
                      "assets/images/company_one.png"

                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildSearch() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Container(
              height: 55,
              padding: const EdgeInsets.only(left: 15, top: 15, bottom: 15),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                color: Color(0xffE8E8E8),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Expanded(
                    flex: 1,
                    child: Icon(
                      Icons.search,
                      size: 25,
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Container(
                      margin: const EdgeInsets.only(left: 5, right: 10),
                      child: Text(
                        'Search for items here',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: GoogleFonts.roboto().fontFamily,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              padding: const EdgeInsets.only(top: 16, bottom: 17),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                color: Colors.black,
              ),
              child: SvgPicture.asset(
                "assets/images/ic_filter.svg",
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildNewOpportunitiesListTile(String title, String company, String img) {
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
            margin: EdgeInsets.only(right: 10),
            child: SvgPicture.asset("assets/images/ic_more.svg"),
          )
        ],
      ),
    );
  }
}