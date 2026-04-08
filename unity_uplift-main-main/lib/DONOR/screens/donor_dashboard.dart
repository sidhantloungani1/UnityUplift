import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unity_uplift/DONOR/screens/Donor_Ngos_List.dart';
import 'package:unity_uplift/DONOR/screens/payment_module/student.dart';
import 'package:unity_uplift/components/custom_btn.dart';

class donor_DrawerWidget extends StatefulWidget {
  const donor_DrawerWidget({super.key});

  @override
  donor_DrawerWidgetState createState() => donor_DrawerWidgetState();
}

class donor_DrawerWidgetState extends State<donor_DrawerWidget> {
  late String sellerImage;

  @override
  void initState() {
    loadData();

    // TODO: implement initState
    super.initState();
  }

  loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      sellerImage = prefs.getString('sellerImage_donor')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dashboard',
          style: TextStyle(color: Colors.white), // Set the text color to white
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            //  Navigator.of(context).pop();
          },
        ),
        backgroundColor: const Color.fromARGB(255, 62, 82, 145),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Container(
                  //     decoration: const BoxDecoration(
                  //   image: DecorationImage(
                  //     image: AssetImage('assets/images/image5.jpg'),
                  //     fit: BoxFit.contain,
                  //   ),
                  // )
                  //     /*child: CircleAvatar(
                  //     radius: 40,
                  //     backgroundColor: Colors.white,
                  //     backgroundImage: NetworkImage(
                  //       sellerImage,
                  //     ),
                  //   ),*/
                  //     ),

                  CustomProgramsContainer(
                    onTap: () {
                      Get.to(StudentScreen());
                      // Get.to(SearchCarPage());
                    },
                    image: 'assets/images/image3.jpg',
                    text: 'Sponsor student',
                  ),
                  // CustomBtn(
                  //   onPressed: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => StudentScreen(),
                  //       ),
                  //     );
                  //   },
                  //   height: 120,
                  //   width: 450.0,
                  //   text: 'Sponsor student',
                  // ),
                  const SizedBox(height: 20.0),
                  CustomProgramsContainer(
                    onTap: () {
                      Get.to(Donor_ngolist());
                      // Get.to(SearchCarPage());
                    },
                    image: 'assets/images/image1.jpg',
                    text: 'Gereral Funds',
                  ),

                  // CustomBtn(
                  //   onPressed: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => Donor_ngolist(),
                  //       ),
                  //     );
                  //   },
                  //   height: 120,
                  //   width: 450.0,
                  //   text: 'Gereral Funds',
                  // ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Welcome to Unity Uplift!',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 10.0),
            const Text(
              'Your platform for making a difference.',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 39, 39, 39),
              ),
            ),
          ],
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
        height: 120,
        width: width * 1.0,
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
