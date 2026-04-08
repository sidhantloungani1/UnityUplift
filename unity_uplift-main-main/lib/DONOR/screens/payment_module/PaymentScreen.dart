import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unity_uplift/components/custom_btn.dart';
import 'package:unity_uplift/controllers/payment_controller.dart';

import '../../../NGO/utils/app_colors.dart';
import 'payment_report_screen.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? _selectedPaymentMethod;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactNumberController =
      TextEditingController();
  final TextEditingController _paymentAmountController =
      TextEditingController();
  final TextEditingController _cardHolderNameController =
      TextEditingController();
  final TextEditingController _accountNumberController =
      TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'payment',
          style: TextStyle(color: Colors.white), // Set the text color to white
        ),
        backgroundColor: const Color(0xFF4350AF),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Image.asset(
                'assets/images/Bankcardlogo.png',
                width: 700,
                height: 200,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Select Payment Method',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _selectedPaymentMethod,
              onChanged: (String? value) {
                setState(() {
                  _selectedPaymentMethod = value;
                });
              },
              items: ['stripe', 'Bank Card'].map((String method) {
                return DropdownMenuItem<String>(
                  value: method,
                  child: Row(
                    children: [
                      if (method == 'stripe') ...[
                        Image.asset(
                          'assets/images/easypaisa_logo.png',
                          width: 20,
                          height: 20,
                        ),
                        const SizedBox(width: 10),
                      ],
                      // if (method == 'JazzCash') ...[
                      //   Image.asset(
                      //     'assets/images/jazzcash_logo.png',
                      //     width: 20,
                      //     height: 20,
                      //   ),
                      //   const SizedBox(width: 10),
                      // ],
                      if (method == 'Bank Card') ...[
                        Image.asset(
                          'assets/images/bank_logo.png',
                          width: 20,
                          height: 20,
                        ),
                        const SizedBox(width: 10),
                      ],
                      Text(method),
                    ],
                  ),
                );
              }).toList(),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              ),
            ),
            const SizedBox(height: 20),
            if (_selectedPaymentMethod == 'stripe') ...[
              _buildPaymentDetailsBox(),
            ],
            if (_selectedPaymentMethod == 'Bank Card') ...[
              _buildBankCardPaymentDetailsBox(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentDetailsBox() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Payment Details',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: _nameController,
          decoration: InputDecoration(
            labelText: 'Name',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: _contactNumberController,
          decoration: InputDecoration(
            labelText: 'Contact Number',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: _paymentAmountController,
          decoration: InputDecoration(
            labelText: 'Payment Amount',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () async {
            if (_paymentAmountController.text.isEmpty) {
              Get.snackbar(
                "Error",
                "Enter amount please",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: AppColors.primaryColor,
                // colorText: AppConst.ant.appTextColor,
              );
            } else {
              await PaymentController.instance
                  .makePayment(_paymentAmountController.text);
            }
            // Navigator.push(
            //   context,
            //   PageRouteBuilder(
            //     pageBuilder: (_, __, ___) {
            //       if (_selectedPaymentMethod == 'Bank Card') {
            //         return PaymentReportScreen(
            //           paymentMethod: _selectedPaymentMethod!,
            //           cardHolderName: _cardHolderNameController.text,
            //           accountNumber: _accountNumberController.text,
            //           date: _dateController.text,
            //           cvv: _cvvController.text,
            //         );
            //       } else {
            //         return PaymentReportScreen(
            //           paymentMethod: _selectedPaymentMethod!,
            //           name: _nameController.text,
            //           contactNumber: _contactNumberController.text,
            //           paymentAmount:
            //               double.parse(_paymentAmountController.text),
            //         );
            //       }
            //     },
            //     transitionsBuilder:
            //         (context, animation, secondaryAnimation, child) {
            //       return SlideTransition(
            //         position: Tween<Offset>(
            //           begin: const Offset(1.0, 0.0),
            //           end: Offset.zero,
            //         ).animate(animation),
            //         child: FadeTransition(
            //           opacity: animation,
            //           child: child,
            //         ),
            //       );
            //     },
            //   ),
            // );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4350AF),
            padding: const EdgeInsets.symmetric(vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: const Text(
            'Confirm Payment',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildBankCardPaymentDetailsBox() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Payment Details',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: _cardHolderNameController,
          decoration: InputDecoration(
            labelText: 'Cardholder Name',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: _accountNumberController,
          decoration: InputDecoration(
            labelText: 'Account Number',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Validity date',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.normal,
          ),
          textAlign: TextAlign.start,
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Container(
              height: 50,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(6)),
                border: Border.all(color: const Color.fromARGB(255, 0, 0, 0)),
              ),
              child: GestureDetector(
                onTap: () => _selectDate(context),
                child: Row(children: [
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.calendar_today,
                      color: Colors.grey, // Adjust the color as needed
                    ),
                  ),
                  Text(
                    "${selectedDate.toLocal()}".split(' ')[0],
                    style: const TextStyle(fontSize: 16),
                  ),
                ]),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextFormField(
                controller: _cvvController,
                decoration: InputDecoration(
                  labelText: 'CVV',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => PaymentReportScreen(
                  paymentMethod: _selectedPaymentMethod!,
                  cardHolderName: _cardHolderNameController.text,
                  accountNumber: _accountNumberController.text,
                  date: _dateController.text,
                  cvv: _cvvController.text,
                ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(1.0, 0.0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
                  );
                },
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4350AF),
            padding: const EdgeInsets.symmetric(vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: const Text(
            'Confirm Payment',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
