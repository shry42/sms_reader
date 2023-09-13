import 'package:flutter/material.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';

// Mutual Fund SIP
double? extractAmountFromSip(String message) {
  final keyword = 'for Rs. ';
  final startIndex = message.indexOf(keyword);

  if (startIndex != -1) {
    final remainingText = message.substring(startIndex + keyword.length);
    final endIndex = remainingText.indexOf(' ');

    if (endIndex != -1) {
      final balanceText = remainingText.substring(0, endIndex);
      final cleanedText = balanceText.replaceAll(',', '');
      return double.tryParse(cleanedText);
    }
  }

  return null;
}

class OtherTransactions extends StatelessWidget {
  const OtherTransactions({super.key, required this.messages});
  final List<SmsMessage> messages;

  @override
  Widget build(BuildContext context) {
    double? sip;
    for (var message in messages) {
      if (message.body!.toLowerCase().contains('mutual fund') &&
          message.body!.toLowerCase().contains('sip') &&
          message.body!.toLowerCase().contains('rs.')) {
        sip = extractAmountFromSip(message.body.toString());
        print(message.body.toString());
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Others'),
      ),
      body: Column(
        children: [
          Visibility(
            visible: sip != null,
            child: ListTile(
              title: Text('SIP '),
              subtitle: Text('Amount: ₹${sip?.toStringAsFixed(2) ?? "N/A"}'),
              leading: Icon(Icons.monetization_on_outlined),
            ),
          ),
        ],
      ),
    );
  }
}
