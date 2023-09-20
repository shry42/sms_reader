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

double? extractAmountFromEcomExpress(String message) {
  final keyword = 'Rs.';
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

// extract ammount from canara
double? extractAmountFromCanaraUpi(String message) {
  final keyword = 'Rs.';
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

// extract amount from sbi
double? extractAmountFromSbiUpi(String message) {
  final keyword = 'debited by ';
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
    double? orderEcomExpress;
    List<dynamic> upiAmount = [];
    double? upiTransaction;
    for (var message in messages) {
      if (message.body!.toLowerCase().contains('mutual fund') &&
          message.body!.toLowerCase().contains('sip') &&
          message.body!.toLowerCase().contains('rs.')) {
        sip = extractAmountFromSip(message.body.toString());
        print(message.body.toString());
      }
    }

    // Ecom express
    for (var message in messages) {
      if (message.body!.toLowerCase().contains('ecom express') &&
          message.body!.toLowerCase().contains('order') &&
          message.body!.toLowerCase().contains('rs')) {
        orderEcomExpress =
            extractAmountFromEcomExpress(message.body.toString());
        print(message.body.toString());
      }
    }

    // upi transactions Canara
    final currentDate = DateTime.now();
    final lastMonthStartDate =
        DateTime(currentDate.year, currentDate.month - 1, 1);
    for (var message in messages) {
      if (message.body!.toLowerCase().contains('bank') &&
          (message.date != null && message.date!.isAfter(lastMonthStartDate)) &&
          message.body!.toLowerCase().contains('paid') &&
          message.body!.toLowerCase().contains('upi')) {
        if (message.body!.toLowerCase().contains('canara')) {
          upiAmount.add(extractAmountFromCanaraUpi(message.body.toString()));
        }

        print(message.body.toString());
      }
    }
  // extract amount from sbi
    for (var message in messages) {
      if ((message.date != null && message.date!.isAfter(lastMonthStartDate)) &&
          message.body!.toLowerCase().contains('debited') &&
          message.body!.toLowerCase().contains('upi')) {
        if (message.body!.toLowerCase().contains('sbi')) {
          upiAmount.add(extractAmountFromSbiUpi(message.body.toString()));
        }

        print(message.body.toString());
      }
    }
    for (int i = 0; i < upiAmount.length; i++) {
      if (upiAmount[i] != null) {
        upiTransaction = (upiTransaction != null)
            ? upiTransaction + upiAmount[i]
            : upiAmount[i];
      }
    }
    // UPI Transactions
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
          Visibility(
            visible: orderEcomExpress != null,
            child: ListTile(
              title: Text('Ecom Express'),
              subtitle: Text(
                  'Amount: ₹${orderEcomExpress?.toStringAsFixed(2) ?? "N/A"}'),
              leading: Icon(Icons.monetization_on_outlined),
            ),
          ),
          // Visibility(
          //   visible: upiTransaction != null,
          //   child: ListTile(
          //     title: Text('Upi Transaction'),
          //     subtitle: Text(
          //         'Amount: ₹${upiTransaction?.toStringAsFixed(2) ?? "N/A"}'),
          //     leading: Icon(Icons.monetization_on_outlined),
          //   ),
          // ),
          Visibility(
            visible: upiTransaction != null,
            child: ListTile(
              title: Text('Upi Transaction'),
              subtitle: Text(
                  'Amount: ₹${upiTransaction?.toStringAsFixed(2) ?? "N/A"}'),
              leading: Icon(Icons.monetization_on_outlined),
            ),
          ),
        ],
      ),
    );
  }
}
