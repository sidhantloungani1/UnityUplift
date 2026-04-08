
// import 'package:flutter/material.dart';
// import 'custom_btn.dart';

// class CustomBottomSheet extends StatelessWidget {
//   const CustomBottomSheet(
//       {super.key,
//       required this.widget,
//       required this.headTxt,
//       required this.press,
//       required this.btnTxt,
//       required this.isHeadingVisible,
//       this.btnBgColor,
//       this.btnBorderColor,
//       this.btnTextColor,
//       this.wantTwoButtons,
//       this.secondBtnBgColor,
//       this.secondBtnBorderColor,
//       this.secondBtnTextColor,
//       this.secondBtnTxt,
//       this.secondPress,
//       this.height,
//       this.lightModeClr});
//   final Widget widget;
//   final String headTxt;
//   final String btnTxt;
//   final VoidCallback press;
//   final bool isHeadingVisible;
//   final Color? btnBgColor;
//   final Color? lightModeClr;
//   final Color? btnBorderColor;
//   final Color? btnTextColor;
//   final Color? secondBtnBgColor;
//   final Color? secondBtnBorderColor;
//   final Color? secondBtnTextColor;
//   final String? secondBtnTxt;
//   final VoidCallback? secondPress;
//   final bool? wantTwoButtons;
//   final double? height;

//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment.bottomCenter,
//       child: Container(
//         height: height ?? 300,
//         width: double.infinity,
//         decoration: BoxDecoration(
//           // color: adaptiveTheme.mode.isLight
//           //     ? lightModeClr ?? const Color(0xffFFF9C4)
//           //     : const Color(0xff263238),
//           borderRadius: const BorderRadius.only(
//             topLeft: Radius.circular(30),
//             topRight: Radius.circular(30),
//           ),
//         ),
//         child: Container(
//           margin: EdgeInsets.all(17 ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               isHeadingVisible == true
//                   ? Text(
//                       headTxt,
//                       style:
//                           TextStyle(color: Colors.black, fontSize: 20 ),
//                     )
//                   : const SizedBox(),
//               Expanded(child: widget),
//               wantTwoButtons == true
//                   ? Row(
//                       children: [
//                         Expanded(
//                           child: CustomBtn(
//                             onPressed: press,
//                             text: btnTxt,
//                             textColor: btnTextColor,
//                             color: btnBgColor,
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         Expanded(
//                           child: CustomBtn(
//                             onPressed: secondPress,
//                             title: secondBtnTxt,
//                             textColor: secondBtnTextColor,
//                             bgColor: secondBtnBgColor,
//                             borderColor: secondBtnBorderColor,
//                             textSize: 15 ,
//                           ),
//                         )
//                       ],
//                     )
//                   : CustomBtn(
//                       onTap: press,
//                       title: btnTxt,
//                       textColor: btnTextColor,
//                       bgColor: btnBgColor,
//                       borderColor: btnBorderColor,
//                     )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
