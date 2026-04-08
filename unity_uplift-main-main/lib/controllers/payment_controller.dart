import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:unity_uplift/model/stripe_payment_model.dart';
import 'package:unity_uplift/utils/app-constant.dart';

class PaymentController extends GetxController {
  static final instance = Get.find<PaymentController>();
  RxBool isLoading = false.obs;
  Map<String, dynamic>? paymentIntentData;
  StripePaymentModel? stripePaymentModel;

  Future<void> makePayment(String amount) async {
    try {
      //STEP 1: Create Payment Intent
      stripePaymentModel = await createPaymentIntent('$amount', 'PKR');
      print(" data ${stripePaymentModel!.clientSecret}");

      //STEP 2: Initialize Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: stripePaymentModel!
                      .clientSecret, //Gotten from payment intent
                  style: ThemeMode.light,
                  merchantDisplayName: 'Unity'))
          .then((value) {});

      //STEP 3: Display Payment sheet
      await displayPaymentSheet();
    } catch (err) {
      throw Exception(err);
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        //Clear paymentIntent variable after successful payment
        stripePaymentModel = null;
      }).onError((error, stackTrace) {
        throw Exception(error);
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
    } catch (e) {
      print('$e');
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
      };

      //Make post request to Stripe
      var response = await Dio().post(
        'https://api.stripe.com/v1/payment_intents',
        data: body,
        options: Options(validateStatus: (status) => true, headers: {
          'Authorization': 'Bearer ${AppConstant.stripeSecretKey}',
          'Content-Type': 'application/x-www-form-urlencoded'
        }),
      );
      print("Response = ${response.data}");
      var jsonData = StripePaymentModel.fromJson(response.data);
      return jsonData;
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount) * 100);
    return a.toString();
  }
}
