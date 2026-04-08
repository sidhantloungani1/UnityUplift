import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unity_uplift/NGO/screens/donor_list.dart';
import 'package:unity_uplift/NGO/screens/global_request.dart';
import 'package:unity_uplift/NGO/screens/scholarshiplist.dart';
import 'package:unity_uplift/components/custom_btn.dart';

class dashboard_NGO extends StatelessWidget {
  const dashboard_NGO({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            //  Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Dashboard',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: theme.primary,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 200,
              child: CarouselSlider(
                items: [
                  Image.asset(
                    'assets/images/pic1.jpg',
                    fit: BoxFit.cover,
                    width: width * 0.8,
                  ),
                  Image.asset(
                    'assets/images/pic2.jpg',
                    fit: BoxFit.cover,
                    width: width * 0.8,
                  ),
                  Image.asset(
                    'assets/images/pic3.jpg',
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
                  autoPlayAnimationDuration: const Duration(milliseconds: 200),
                  viewportFraction: 1,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomProgramsContainer(
                    onTap: () {
                      Get.to(ApplicantRequest());
                      // Get.to(SearchCarPage());
                    },
                    image: 'assets/images/image1.jpg',
                    text: 'Global Request',
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // CustomBtn(
                  //   onPressed: () {
                  //     Get.to(ApplicantRequest());
                  //   },
                  //   height: 80,
                  //   width: 450.0,
                  //   isDoubleWidget: true,
                  //   widget: const Row(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: [
                  //       Icon(
                  //         Icons.remove_from_queue,
                  //         size: 40,
                  //       ),
                  //       SizedBox(
                  //         width: 20,
                  //       ),
                  //       Text(
                  //         "Global Request",
                  //         style: TextStyle(fontSize: 22),
                  //       )
                  //     ],
                  //   ),
                  //   // text: 'Global Request',
                  // ),
                  const SizedBox(height: 10.0),

                  CustomProgramsContainer(
                    onTap: () {
                      Get.to(ScholarshipList());
                      // Get.to(SearchCarPage());
                    },
                    image: 'assets/images/image2.jpg',
                    text: 'Scholarship Program',
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // CustomBtn(
                  //   onPressed: () {
                  //     /*Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => const ScholarshipList(),
                  //       ),
                  //     );*/
                  //     Get.to(ScholarshipList());
                  //   },
                  //   height: 80,
                  //   width: 450.0,
                  //   isDoubleWidget: true,
                  //   widget: const Row(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: [
                  //       Icon(
                  //         Icons.school_sharp,
                  //         size: 40,
                  //       ),
                  //       SizedBox(
                  //         width: 20,
                  //       ),
                  //       Text(
                  //         "Scholarship Program",
                  //         style: TextStyle(fontSize: 22),
                  //       )
                  //     ],
                  //   ),
                  // ),

                  CustomProgramsContainer(
                    onTap: () {
                      Get.to(DonorsScreen());
                      // Get.to(SearchCarPage());
                    },
                    image: 'assets/images/image3.jpg',
                    text: 'Donation',
                  ),
                  // CustomBtn(
                  //   onPressed: () {
                  //     Get.to(DonorsScreen());
                  //   },
                  //   height: 80,
                  //   width: 450.0,
                  //   isDoubleWidget: true,
                  //   widget: const Row(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: [
                  //       Icon(
                  //         Icons.attach_money,
                  //         size: 40,
                  //       ),
                  //       SizedBox(
                  //         width: 20,
                  //       ),
                  //       Text(
                  //         "Donation",
                  //         style: TextStyle(fontSize: 22),
                  //       )
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Welcome to Unity Uplift!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10.0),
            const Text(
              'Your platform for making a difference.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildCircularIconButton(IconData icon) {
  return ClipOval(
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 13, 39, 155).withOpacity(0.8),
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
