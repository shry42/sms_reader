import 'package:flutter/material.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:seel_sms_reader/main.dart';

double? extractAmountFromHdfc(String message) {
  final keyword = 'Total Due:Rs.';
  final startIndex = message.indexOf(keyword);

  if (startIndex != -1) {
    final remainingText = message.substring(startIndex + keyword.length);
    final endIndex = remainingText.indexOf('.');

    if (endIndex != -1) {
      final balanceText = remainingText.substring(0, endIndex);
      final cleanedText = balanceText.replaceAll(',', '');
      return double.tryParse(cleanedText);
    }
  }

  return null;
}

double? extractAmountFromAxis(String message) {
  final keyword = 'Total Amount Due INR  Dr. ';
  final startIndex = message.indexOf(keyword);

  if (startIndex != -1) {
    final remainingText = message.substring(startIndex + keyword.length);
    final endIndex = remainingText.indexOf(',');

    if (endIndex != -1) {
      final balanceText = remainingText.substring(0, endIndex);
      final cleanedText = balanceText.replaceAll(',', '');
      return double.tryParse(cleanedText);
    }
  }

  return null;
}

class CreditCard extends StatelessWidget {
  const CreditCard({super.key, required this.messages});
  final List<SmsMessage> messages;

  @override
  Widget build(BuildContext context) {
    double? hdfcCreditCard;
    double? axisCreditCard;

    for (var message in messages) {
      if (message.body!.toLowerCase().contains('hdfcp') &&
          message.body!.toLowerCase().contains('credit card') &&
          message.body!.toLowerCase().contains('due')) {
        hdfcCreditCard = extractAmountFromHdfc(message.body.toString());
        print(message.body.toString());
      }
    }

    for (var message in messages) {
      if (message.body!.toLowerCase().contains('axis') &&
          message.body!.toLowerCase().contains('credit card') &&
          message.body!.toLowerCase().contains('due')) {
        axisCreditCard = extractAmountFromAxis(message.body.toString());
        print(message.body.toString());
      }
    }

    double totalCreditCard = hdfcCreditCard! + axisCreditCard!;
    return Scaffold(
      appBar: AppBar(
        title: Text('Credit Card'),
      ),
      body: Column(
        children: [
          Visibility(
            visible: hdfcCreditCard != null,
            child: ListTile(
              title: Text('Hdfc Credit card Payment '),
              subtitle: Text(
                  'Amount: ₹${hdfcCreditCard?.toStringAsFixed(2) ?? "N/A"}'),
              leading: Icon(Icons.monetization_on_outlined),
            ),
          ),
          Visibility(
            visible: axisCreditCard != null,
            child: ListTile(
              title: Text('Axis Credit card Payment '),
              subtitle: Text(
                  'Amount: ₹${axisCreditCard?.toStringAsFixed(2) ?? "N/A"}'),
              leading: Icon(Icons.monetization_on_outlined),
            ),
          ),
          Visibility(
            visible: totalCreditCard != null,
            child: ListTile(
              title: Text('total Credit card Payment '),
              subtitle: Text(
                  'Amount: ₹${totalCreditCard?.toStringAsFixed(2) ?? "N/A"}'),
              leading: Icon(Icons.monetization_on_outlined),
            ),
          ),
        ],
      ),
    );
  }
}
