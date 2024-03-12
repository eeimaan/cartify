import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/db_services/db_services.dart';
import 'package:flutter_application_1/utils/utils.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';

Future<Map<String, dynamic>> makePayment({
  required String amount,
}) async {
  try {
    Map<String, dynamic> paymentIntent =
        await createPaymentIntent((int.parse(amount) * 100).toString(), 'usd');

    var gPay = const PaymentSheetGooglePay(
        merchantCountryCode: 'US', testEnv: true, currencyCode: "usd");

    log(paymentIntent.toString());

    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        googlePay: gPay,
        paymentIntentClientSecret: paymentIntent['client_secret'].toString(),
        style: ThemeMode.light,
        merchantDisplayName: AuthServices.getCurrentUser?.displayName ?? '',
      ),
    );

    await presentPaymentSheet();

   
    log('Transaction ID: ${paymentIntent["id"]}');

    String date = formatOrderDate(DateTime.now().toString());
    return {
      'status': 'Paid',
      'transaction_id': paymentIntent['id'],
      'date': date
    };
  } catch (err) {
    log('Error in makePayment: $err');

    throw Exception(err.toString());
  }
}

Future<void> displayPaymentSheet() async {
  try {
    await Stripe.instance.presentPaymentSheet();
  } catch (e) {
    log('$e');
  }
}

Future<void> presentPaymentSheet() async {
  try {
    await displayPaymentSheet();
  } catch (e) {
    log('$e');
  }
}

Future<Map<String, dynamic>> createPaymentIntent(
    String amount, String currency) async {
  try {
    Map<String, dynamic> body = {
      'amount': amount,
      'currency': currency,
    };

    Map<String, String> header = {
      'Authorization': 'Bearer ${AppText.stripeSecretKey}',
      'Content-Type': AppText.stripeContentType
    };

    var response = await http.post(
      Uri.parse(AppText.stripeAPIURLIntent),
      headers: header,
      body: body,
    );

    Map<String, dynamic> jsonResponse = json.decode(response.body);

    log('Payment Intent Response: $jsonResponse');

    log('Payment Status: ${jsonResponse["status"]}');

    return jsonResponse;
  } catch (err) {
    log('Error in createPaymentIntent: $err');
    throw Exception(err.toString());
  }
}
