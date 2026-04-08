import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unity_uplift/DONOR/screens/donor_dashboard.dart';
import 'package:unity_uplift/NGO/screens/dashboard/dashboard_org.dart';
import 'package:unity_uplift/NGO/screens/welcome.dart';
import 'package:unity_uplift/NGO/screens/welcome_screen.dart';
import 'package:unity_uplift/components/custom_btn.dart';
import 'package:unity_uplift/controllers/payment_controller.dart';

import 'DONOR/screens/Donor_Welcome.dart';

class dashboard extends StatelessWidget {
  const dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(PaymentController());
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: theme.primary,
          ),
          onPressed: () {
            Get.to(welcomescreen());
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildPictureSlider(),
          const SizedBox(height: 50),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(
                height: 40,
              ),
              CustomBtn(
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  var email = prefs.getString('email_Donor');
                  print(email);
                  if (email == null) {
                    Get.to(const Donor_welcome());
                  } else {
                    Get.to(donor_DrawerWidget());
                  }
                },
                height: 100,
                width: 300.0,
                text: 'DONOR',
              ),
              const SizedBox(
                height: 40,
              ),
              CustomBtn(
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  var email = prefs.getString('email_NGO');
                  print(email);
                  if (email == null) {
                    Get.to(const Welcome());
                  } else {
                    Get.to(dashboard_NGO());
                  }
                },
                height: 100,
                width: 300.0,
                text: 'NGO ',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPictureSlider() {
    return CarouselSlider(
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
      items: [
        'assets/images/image1.jpg',
        'assets/images/image2.jpg',
        'assets/images/image3.jpg',
      ].map((imageUrl) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: const BoxDecoration(
                color: Colors.grey,
              ),
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
