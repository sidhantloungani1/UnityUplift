import 'package:flutter/material.dart';

class PaymentReportScreen extends StatelessWidget {
  final String paymentMethod;
  final String? cardHolderName;
  final String? accountNumber;
  final String? cvv;
  final String? date;
  final String? name;
  final String? contactNumber;
  final double? paymentAmount;

  const PaymentReportScreen({
    required this.paymentMethod,
    this.cardHolderName,
    this.accountNumber,
    this.cvv,
    this.date,
    this.name,
    this.contactNumber,
    this.paymentAmount,
  });

  Widget _buildPaymentDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Payment Report',
          style: TextStyle(color: Colors.white), // Set the text color to white
        ),
        backgroundColor: const Color(0xFF4350AF),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Payment Processed Successfully!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Your Payment Details:',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            if (paymentMethod == 'Bank Card') ...[
              _buildPaymentDetailRow('Cardholder Name', cardHolderName ?? ''),
              _buildPaymentDetailRow('Account Number', accountNumber ?? ''),
              _buildPaymentDetailRow('CVV', cvv ?? ''),
              _buildPaymentDetailRow('Date', date ?? ''),
            ] else ...[
              _buildPaymentDetailRow('Name', name ?? ''),
              _buildPaymentDetailRow('Contact Number', contactNumber ?? ''),
              _buildPaymentDetailRow('Payment Amount', '\$$paymentAmount'),
            ],
          ],
        ),
      ),
    );
  }
}
