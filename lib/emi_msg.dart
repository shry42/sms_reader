import 'package:flutter/material.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';

double? extractAmountFromPnbEMi(String message) {
  final keyword = 'your installment amount of Rs. ';
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

double? extractAmountFromTataCapitalEMi(String message) {
  final keyword = 'an amount of INR. ';
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

double? extractAmountFromPiramal(String message) {
  final keyword = 'Instalment of Rs ';
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

double? extractAmountFromPchfl(String message) {
  final keyword = 'installment of Rs. ';
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

double? extractAmountFromIdfc(String message) {
  final keyword = 'EMI of ';
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

class EmiMsg extends StatelessWidget {
  const EmiMsg({super.key, required this.messages});
  final List<SmsMessage> messages;

  @override
  Widget build(BuildContext context) {
    double? emiPnb;
    double? emitataCapital;
    double? emiPiramal;
    double? emiPchfl;
    double? emiIdfc;
    double? totalEmi;

    for (var message in messages) {
      if (message.body!.toLowerCase().contains('pnb') &&
          message.body!.toLowerCase().contains('installment') &&
          message.body!.toLowerCase().contains('due')) {
        emiPnb = extractAmountFromPnbEMi(message.body.toString())!;
        print(message.body.toString());
      }
    }
    for (var message in messages) {
      if (message.body!.toLowerCase().contains('tata capital') &&
          message.body!.toLowerCase().contains('maintain sufficient balance') &&
          message.body!.toLowerCase().contains('amount of')) {
        emitataCapital =
            extractAmountFromTataCapitalEMi(message.body.toString())!;
        print(message.body.toString());
      }
    }
    for (var message in messages) {
      if (message.body!.toLowerCase().contains('piramal') &&
          message.body!.toLowerCase().contains('sufficient') &&
          message.body!.toLowerCase().contains('due for loan account')) {
        emiPiramal = extractAmountFromPiramal(message.body.toString())!;
        print(message.body.toString());
      }
    }
    for (var message in messages) {
      if (message.body!.toLowerCase().contains('pchfl') &&
          message.body!.toLowerCase().contains('sufficient') &&
          message.body!.toLowerCase().contains('due')) {
        emiPchfl = extractAmountFromPchfl(message.body.toString())!;
        print(message.body.toString());
      }
    }
    for (var message in messages) {
      if (message.body!.toLowerCase().contains('idfc') &&
          message.body!.toLowerCase().contains('funded') &&
          message.body!.toLowerCase().contains('due')) {
        emiIdfc = extractAmountFromIdfc(message.body.toString())!;
        print(message.body.toString());
      }
    }
    totalEmi = emiIdfc! + emiPchfl! + emiPiramal! + emiPnb! + emitataCapital!;

    return Scaffold(
        appBar: AppBar(
          title: Text('EMI Data'),
        ),
        body: Column(
          children: [
            Visibility(
              visible: emiPnb != null,
              child: ListTile(
                title: Text('PNB EMI'),
                subtitle:
                    Text('Amount: ₹${emiPnb?.toStringAsFixed(2) ?? "N/A"}'),
                leading: Icon(Icons.monetization_on_outlined),
              ),
            ),
            Visibility(
              visible: emitataCapital != null,
              child: ListTile(
                title: Text('Tata Capital EMI'),
                subtitle: Text(
                    'Amount: ₹${emitataCapital?.toStringAsFixed(2) ?? "N/A"}'),
                leading: Icon(Icons.monetization_on_outlined),
              ),
            ),
            Visibility(
              visible: emiPiramal != null,
              child: ListTile(
                title: Text('Piramal Capital'),
                subtitle:
                    Text('Amount: ₹${emiPiramal?.toStringAsFixed(2) ?? "N/A"}'),
                leading: Icon(Icons.monetization_on_outlined),
              ),
            ),
            Visibility(
              visible: emiPchfl != null,
              child: ListTile(
                title: Text('Piramal Capital & Housing Finance'),
                subtitle:
                    Text('Amount: ₹${emiPchfl?.toStringAsFixed(2) ?? "N/A"}'),
                leading: Icon(Icons.monetization_on_outlined),
              ),
            ),
            Visibility(
              visible: emiIdfc != null,
              child: ListTile(
                title: Text('IDFC'),
                subtitle:
                    Text('Amount: ₹${emiIdfc?.toStringAsFixed(2) ?? "N/A"}'),
                leading: Icon(Icons.monetization_on_outlined),
              ),
            ),
            Visibility(
              visible: emiIdfc != null,
              child: ListTile(
                title: Text('Total Emi to be paid'),
                subtitle:
                    Text('Amount: ₹${totalEmi?.toStringAsFixed(2) ?? "N/A"}'),
                leading: Icon(Icons.monetization_on_outlined),
              ),
            ),
          ],
        ));
  }
}
