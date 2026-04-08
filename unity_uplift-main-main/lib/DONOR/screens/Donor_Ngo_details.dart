import 'package:flutter/material.dart';
import 'package:unity_uplift/NGO/utils/app_colors.dart';
import 'package:unity_uplift/components/custom_btn.dart';

class Donor_ngoDetails extends StatefulWidget {
  @override
  _Donor_ngoDetailsState createState() => _Donor_ngoDetailsState();
}

class _Donor_ngoDetailsState extends State<Donor_ngoDetails>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeInAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_animationController);
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'NGO Details',
          style: TextStyle(color: Colors.white), // Set the text color to white
        ),
      ),
      body: AnimatedBuilder(
        animation: _fadeInAnimation,
        builder: (context, child) {
          return Opacity(
            opacity: _fadeInAnimation.value,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'NGO Name',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor, // Custom color
                    ),
                  ),
                  Text(
                    'JDC Foundation',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.grey[800], // Custom color
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  const Text(
                    'Mission & Objective',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor, // Custom color
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    'Mission and objective description goes here...',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey[800], // Custom color
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  const Text(
                    'About',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor, // Custom color
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus nec maximus nibh. Sed sit amet tincidunt felis. Quisque nec eleifend ex. Curabitur et nisl vitae lacus ullamcorper commodo in non arcu. Phasellus commodo erat ut velit porttitor sollicitudin. Proin tellus lacus, aliquet sit amet eros vel, venenatis vestibulum lacus. Praesent viverra mollis nulla, fringilla bibendum tellus. Praesent erat nulla, dictum ut auctor eget, volutpat in quam. Mauris a eros id mauris elementum auctor',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey[800], // Custom color
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // CustomBtn(
                      //   height: 50,
                      //   width: 40,
                      //   onPressed: () {
                      //     // Navigator.push(
                      //     //   context,
                      //     //   MaterialPageRoute(
                      //     //     builder: (context) => (),
                      //     //   ),
                      //     // );
                      //   },
                      //   text: 'View Details',
                      // ),
                      // CustomBtn(
                      //   height: 50,
                      //   width: 40,
                      //   onPressed: () {
                      //     // Navigator.push(
                      //     //   context,
                      //     //   MaterialPageRoute(
                      //     //     builder: (context) => (),
                      //     //   ),
                      //     // );
                      //   },
                      //   text: 'View Details',
                      // )
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
