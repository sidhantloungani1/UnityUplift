import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:student/screens/ApplicationStatus.dart';
import 'package:student/screens/apply.dart';

import 'ScholarshipPrograms.dart';
import 'drawer_widget.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // _getScholarshipList();
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            //  Navigator.of(context).pop();
          },
        ),
      ),
      endDrawer: studentDrawerWidget(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 40,
          ),
          SizedBox(
            height: 200,
            child: CarouselSlider(
              items: [
                Image.asset(
                  'assets/images/slider1.jpg',
                  fit: BoxFit.cover,
                  width: width * 0.8,
                ),
                Image.asset(
                  'assets/images/slider2.jpg',
                  fit: BoxFit.cover,
                  width: width * 0.8,
                ),
                Image.asset(
                  'assets/images/slider3.jpg',
                  fit: BoxFit.cover,
                  width: width * 0.8,
                ),
              ],
              options: CarouselOptions(
                height: 300.0,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 10,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 500),
                viewportFraction: 1,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCircularIconButton(Icons.school),
                _buildCircularIconButton(Icons.library_books),
                _buildCircularIconButton(Icons.account_balance),
                _buildCircularIconButton(Icons.local_library),
              ],  
            ),
          ),
          const SizedBox(height: 40),
          Expanded(
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomProgramsContainer(
                      onTap: () {
                        /* Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ScholarshipProgramsScreen(),
                          ),
                        );*/
                        Get.to(ScholarshipProgramsScreen());
                        // Get.to(SearchCarPage());
                      },
                      image: 'assets/images/slide1.png',
                      text: 'Scholarship Program',
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomProgramsContainer(
                      onTap: () {
                        /*   Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const ApplyForScholarshipPage(),
                          ),
                        );*/
                        Get.to(ApplyForScholarshipPage());
                      },
                      image: 'assets/images/slide2.png',
                      text: 'Apply for Scholarship',
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomProgramsContainer(
                      onTap: () {
                        /*  Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ApplicationStatusScreen(),
                          ),
                        );*/
                        Get.to(ApplicationStatusScreen());
                      },
                      image: 'assets/images/slider2.jpg',
                      text: 'Application Status',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircularIconButton(IconData icon) {
    return ClipOval(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 153, 1).withOpacity(0.8),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(icon, size: 30),
            color: Colors.white,
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}

class CustomProgramsContainer extends StatelessWidget {
  CustomProgramsContainer(
      {required this.image, required this.text, required this.onTap});
  final String image;
  final String text;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 25, 24, 24).withOpacity(0.6),
              offset: const Offset(0, 1),
            ),
          ],
          image: DecorationImage(
            opacity: 0.6,
            fit: BoxFit.cover,
            image: AssetImage(
              image,
            ),
          ),
        ),
        height: 100,
        width: width * 0.8,
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.black38,
              // border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(2), // kyak arna ha wapis bata
            ),
            child: Text(
              text,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
