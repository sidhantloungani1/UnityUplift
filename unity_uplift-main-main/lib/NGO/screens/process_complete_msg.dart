import 'package:flutter/material.dart';
import 'package:unity_uplift/NGO/screens/dashboard/dashboard_org.dart';
import 'package:unity_uplift/components/custom_btn.dart';

class process_complete extends StatefulWidget {
  const process_complete({super.key});

  @override
  State<process_complete> createState() => _process_completeState();
}

class _process_completeState extends State<process_complete> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.account_circle),
              onPressed: () {
                // Handle profile icon click
              },
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/completeprocess.png"),
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'Your application is in process you will be notified',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              CustomBtn(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const dashboard_NGO(),
                    ),
                  );
                },
                height: 50,
                width: 100.0,
                text: 'Done',
              ),
            ],
          ),
        ));
  }
}
