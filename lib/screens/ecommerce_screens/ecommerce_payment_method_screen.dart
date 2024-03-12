import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/components.dart';
import 'package:flutter_application_1/components/custom_payment_row.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/providers/providers.dart';
import 'package:flutter_application_1/utils/stripe.dart';
import 'package:flutter_application_1/utils/theme.dart';
import 'package:provider/provider.dart';

class EcommercePaymentMethodPage extends StatefulWidget {
  const EcommercePaymentMethodPage({super.key});

  @override
  State<EcommercePaymentMethodPage> createState() =>
      _EcommercePaymentMethodPageState();
}

class _EcommercePaymentMethodPageState
    extends State<EcommercePaymentMethodPage> {
  late CartPriceProvider cartPriceProvider;
  late PaymentProvider paymentProvider;
  bool isCheckOperation = false;
  late Map<String, dynamic> paymentResult;
  @override
  void initState() {
    cartPriceProvider = Provider.of<CartPriceProvider>(context, listen: false);
    paymentProvider = Provider.of<PaymentProvider>(context, listen: false);
    log('${cartPriceProvider.getSubTotal}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: ThemeColors.blackWhiteColor(context),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: LabelText(
          color: ThemeColors.blackWhiteColor(context),
          size: AppFonts.extraLarge,
          weight: FontWeight.w600,
          letterSpacing: 1,
          title: 'Add a Payment Method',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const LabelText(
              title: 'Select Payment Method',
              size: AppFonts.exmedium,
              weight: FontWeight.w600,
              letterSpacing: 1,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomPaymentContainer(
              label: "PayPal",
              leadingImage: AppImage.paypalIcon,
              index: 1,
              ontap: () {
                paymentProvider.setPaymentMethod = 'PayPal';
                Navigator.pop(context);
              },
            ),
            const SizedBox(
              height: 10,
            ),
            CustomPaymentContainer(
              label: "Stripe",
              leadingImage: AppImage.stripeIcon,
              index: 3,
              ontap: () async {
                if (!isCheckOperation) {
                  isCheckOperation = true;

                  paymentResult = await makePayment(
                    amount: cartPriceProvider.getSubTotal.toString(),
                  );

                  paymentProvider.setPaymentMethod = 'Stripe';
                  paymentProvider.setDateTime = paymentResult['date'];
                  paymentProvider.setTransactionId =
                      paymentResult['transaction_id'];
                  paymentProvider.setStatus = paymentResult['status'];

                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);

                  isCheckOperation = false;
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
