import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onCancelPressed;
  final VoidCallback onDeletePressed;


  const CustomDialog({super.key, 
    required this.title,
    required this.content,
    required this.onCancelPressed,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: const TextStyle(fontSize: 18),
      ),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: onCancelPressed,
          child: const Text(
            'Cancel',
            style: TextStyle(fontSize: 14),
          ),
        ),
        TextButton(
          onPressed: onDeletePressed,
          child: const Text(
            'Delete',
            style: TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }
}


//  showDialog(
//                                         context: context,
//                                         builder: (BuildContext context) {
//                                           return AlertDialog(
//                                             title: Text(
//                                               "Delete Vehicle",
//                                               style: TextStyle(fontSize: 18.sp),
//                                             ),
//                                             content: Text('Delete Vehicle'),
//                                             actions: [
//                                               TextButton(
//                                                 onPressed: () {
//                                                   Get.back();
//                                                 },
//                                                 child: Text(
//                                                   'Cancel',
//                                                   style: TextStyle(
//                                                       fontSize: 14.sp),
//                                                 ),
//                                               ),
//                                               TextButton(
//                                                 onPressed: () async {
//                                                   await controller
//                                                       .deleteVehicle(index);
//                                                 },
//                                                 child: Text(
//                                                   'Delete',
//                                                   style: TextStyle(
//                                                       fontSize: 14.sp),
//                                                 ),
//                                               ),
//                                             ],
//                                           );
//                                         },
//                                       );
//                                     },