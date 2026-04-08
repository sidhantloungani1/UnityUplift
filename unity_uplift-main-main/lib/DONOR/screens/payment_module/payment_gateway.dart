import 'package:flutter/material.dart';

import 'paymentscreen.dart'; // Import the payment screen file

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String selectedOption = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Methods'),
        backgroundColor: const Color(0xFF4350AF),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Select Your Option',
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /* ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => StudentScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedOption == 'Student'
                        ? const Color(0xFF4350AF)
                        : Colors.white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: const BorderSide(
                        color: Color(0xFF4350AF),
                      ),
                    ),
                  ),
                 child: Text(
                    'Student',
                    style: TextStyle(
                      color: selectedOption == 'Student'
                          ? Colors.white
                          : const Color(0xFF4350AF),
                    ),
                  ),
                ),*/
                const SizedBox(width: 10), // Add some space between buttons
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PaymentScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedOption == 'NGO'
                        ? const Color(0xFF4350AF)
                        : Colors.white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: const BorderSide(
                        color: Color(0xFF4350AF),
                      ),
                    ),
                  ),
                  child: Text(
                    'NGO',
                    style: TextStyle(
                      color: selectedOption == 'NGO'
                          ? Colors.white
                          : const Color(0xFF4350AF),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
