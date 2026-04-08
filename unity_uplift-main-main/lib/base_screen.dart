// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class BaseScreen extends StatefulWidget {
//   final Widget child;
//   final Color? bgColor;
//   final Color? appBarColor;
//   final String? title;
//   final bool? resizeToAvoidBottomInset;
//   final IconData? icon;
//   final double? height;
//   final bool? isAppbarVisible;
//   final bool? isBottomBarVisible;
//   final bool? isActionBtnVisible;
//   final bool? isLeadingBtnVisible;
//   final bool? centerIcon;
//   final FontWeight textFontWeight;
//   final Function()? backBtnFun;
//   final bool progressIndicatorVisible;

//   const BaseScreen({
//     super.key,
//     required this.child,
//     this.bgColor,
//     this.title,
//     this.height,
//     this.appBarColor,
//     this.icon,
//     this.isAppbarVisible,
//     this.isBottomBarVisible,
//     this.isActionBtnVisible,
//     this.isLeadingBtnVisible = true,
//     this.resizeToAvoidBottomInset,
//     this.centerIcon,
//     this.textFontWeight = FontWeight.normal,
//     this.backBtnFun,
//     this.progressIndicatorVisible = true,
//   });
//   // static const String routeName = '/BaseScreen';

//   @override
//   State<BaseScreen> createState() => _BaseScreenState();
// }

// class _BaseScreenState extends State<BaseScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context).colorScheme;
//     return WillPopScope(
//       onWillPop: () {
//         // if (isLoading.isTrue) return Future.value(!isLoading.isTrue);
//         if (widget.backBtnFun != null) {
//           widget.backBtnFun!();
//           return Future.value(false);
//         }
//         return Future.value(true);
//       },
//       child: SafeArea(
//         child: Stack(
//           children: [
//             Scaffold(
//               resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
//               backgroundColor:
//                   widget.bgColor ?? Theme.of(context).colorScheme.background,
//               appBar: widget.isAppbarVisible == true
//                   ? AppBar(
//                       leading: widget.isLeadingBtnVisible == true
//                           ? GestureDetector(
//                               onTap: () {
//                                 // if (isLoading.isTrue) return;
//                                 if (widget.backBtnFun != null) {
//                                   widget.backBtnFun!();
//                                   return;
//                                 } else {
//                                   Get.back();
//                                 }
//                               },
//                               child: FittedBox(
//                                 child: Row(
//                                   mainAxisSize: MainAxisSize.max,
//                                   children: [
//                                     Icon(
//                                       Icons.arrow_back_ios,
//                                       color: theme.onBackground,
//                                     ),
//                                     CustomText(
//                                       title: 'back',
//                                       fontWeight: FontWeight.w400,
//                                       size: 12,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             )
//                           : null,
//                       // // leading: BackButton(
//                       // //   onPressed: () {
//                       // //    if (isLoading.isTrue) return;
//                       // //    Get.back();
//                       // //  },
//                       // // ),
//                       // title: Row(
//                       //   mainAxisAlignment: MainAxisAlignment.center,
//                       //   children: [
//                       //     widget.centerIcon == true
//                       //         ? const Icon(
//                       //             Icons.location_on,
//                       //           )
//                       //         : const SizedBox(),
//                       //     CustomText(
//                       //       title: widget.title ?? '',
//                       //       size: 16 ,
//                       //     ),
//                       //   ],
//                       // ),
//                       title: widget.centerIcon == true
//                           ? Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 widget.centerIcon == true
//                                     ? const Icon(
//                                         Icons.location_on,
//                                       )
//                                     : const SizedBox(),
//                                 CustomText(
//                                   title: widget.title ?? '',
//                                   size: 16,
//                                 ),
//                               ],
//                             )
//                           : CustomText(
//                               title: widget.title ?? '',
//                               size: 16,
//                               fontWeight: widget.textFontWeight,
//                             ),
//                       centerTitle: true,
//                       actions: [
//                         widget.isActionBtnVisible == true
//                             ? IconButton(
//                                 onPressed: () {},
//                                 icon: const Icon(Icons.notifications),
//                               )
//                             : const SizedBox(),
//                       ],
//                     )
//                   : null,
//               body: SizedBox(
//                 width: Get.width,
//                 height: Get.height,
//                 child: widget.child,
//               ),
//               drawer: const CustomDrawer(),
//             ),
//             widget.progressIndicatorVisible == true
//                 ? Obx(
//                     () => isLoading.isTrue
//                         ? Container(
//                             height: MediaQuery.of(context).size.height,
//                             width: double.infinity,
//                             color: Colors.grey.withOpacity(.3),
//                             child: Center(
//                               child: CircularProgressIndicator(
//                                 color: theme.onPrimary,
//                               ),
//                             ),
//                           )
//                         : const SizedBox(),
//                   )
//                 : const SizedBox(),
//           ],
//         ),
//       ),
//     );
//   }
// }
