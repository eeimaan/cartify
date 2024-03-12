import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/components.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/db_services/db_services.dart';
import 'package:flutter_application_1/models/models.dart';
import 'package:flutter_application_1/providers/providers.dart';
import 'package:flutter_application_1/screens/screens.dart';
import 'package:flutter_application_1/utils/utils.dart';
import 'package:provider/provider.dart';

class EcommerceEreceiptPage extends StatefulWidget {
  const EcommerceEreceiptPage({super.key});

  @override
  State<EcommerceEreceiptPage> createState() => EcommerceEreceiptPageState();
}

class EcommerceEreceiptPageState extends State<EcommerceEreceiptPage> {
  late PaymentProvider paymentProvider;
  late CartPriceProvider cartPriceProvider;
  @override
  void initState() {
    paymentProvider = Provider.of<PaymentProvider>(context, listen: false);
    cartPriceProvider = Provider.of<CartPriceProvider>(context, listen: false);
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
          letterSpacing: 0.50,
          title: 'E-Receipt',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const LabelText(
              title: 'Order Details',
              size: AppFonts.exmedium,
              weight: FontWeight.w600,
              letterSpacing: 1,
            ),
            const SizedBox(height: 20),
            FutureBuilder<List<CartProductModel>>(
                future: EcommerceDbService.getCartProduct(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CupertinoActivityIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No data'));
                  } else if (snapshot.hasData) {
                    return SizedBox(
                      height: size.height * 0.3,
                      width: size.width,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: OrderProductCard(
                                imagePath: snapshot.data![index].image,
                                label: snapshot.data![index].name,
                                price: snapshot.data![index].price.toString(),
                                qty: snapshot.data![index].quantity),
                          );
                        },
                      ),
                    );
                  } else {
                    return const Center(child: CupertinoActivityIndicator());
                  }
                }),
            const SizedBox(height: 20),
            Container(
              width: size.width,
              height: size.height * 0.34,
              decoration: ShapeDecoration(
                color: ThemeColors.containerShade(context),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: ThemeColors.borderPurple(context),
                    width: 0.5,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(children: [
                  CustomCartCalulation(
                    label: 'Subtotal :',
                    value: cartPriceProvider.getTotal.toString(),
                  ),
                  const SizedBox(height: 10),
                  CustomCartCalulation(
                    label: 'Delivery Fee :',
                    value: cartPriceProvider.getDelivery.toString(),
                  ),
                  const SizedBox(height: 10),
                  CustomCartCalulation(
                    label: 'Discount :',
                    value: cartPriceProvider.getDiscount.toString(),
                  ),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: DividerList(
                        count: 50, width: 1.5, height: 1, marginHorizontal: 2),
                  ),
                  CustomCartCalulation(
                    color: AppColors.colorBlue,
                    label: 'Total :',
                    value: cartPriceProvider.getSubTotal.toString(),
                    valueSize: AppFonts.large,
                  ),
                  const SizedBox(height: 20),
                ]),
              ),
            ),
            const SizedBox(height: 20),
            Consumer<PaymentProvider>(builder:
                (BuildContext context, paymentProvider, Widget? child) {
              return Container(
                width: size.width,
                height: size.height * 0.3,
                decoration: ShapeDecoration(
                  color: ThemeColors.containerShade(context),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: ThemeColors.borderPurple(context),
                      width: 0.5,
                    ),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x19FFFFFF),
                      blurRadius: 10,
                      offset: Offset(0, 0),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Column(children: [
                  CustomCartCalulation(
                    label: 'Date',
                    value: paymentProvider.getDateTime,
                  ),
                  const SizedBox(height: 10),
                  CustomCartCalulation(
                      label: 'Transaction ID',
                      value: paymentProvider.getTransactionId),
                  const SizedBox(height: 10),
                  CustomCartCalulation(
                    label: 'Payment Methods',
                    value: paymentProvider.getPaymentMethod,
                  ),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.only(top: 6, left: 20, right: 20),
                    child: DividerList(
                        count: 50, width: 1.5, height: 1, marginHorizontal: 2),
                  ),
                  CustomCartCalulation(
                    color: paymentProvider.getStatus == 'Paid'
                        ? Colors.green
                        : AppColors.colorDarkBkue,
                    label: 'Status',
                    value: paymentProvider.getStatus,
                    valueSize: AppFonts.large,
                  ),
                ]),
              );
            }),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                generatePDF(
                    paymentProvider.getDateTime,
                    paymentProvider.getTransactionId,
                    paymentProvider.getPaymentMethod,
                    cartPriceProvider.getSubTotal,
                    cartPriceProvider.getDelivery,
                    cartPriceProvider.getDiscount,
                    cartPriceProvider.getTotal);
              },
              child: ShareProgressButton(
                  borderRadius: BorderRadius.circular(10),
                  label: 'Share E-Receipt',
                  textColor: ThemeColors.blackWhiteColor(context),
                  iconColor: ThemeColors.blackWhiteColor(context),
                  buttonColor: const Color(0xFFD8D8D8),
                  imagePath: AppImage.send),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                downloadPDF(
                    paymentProvider.getDateTime,
                    paymentProvider.getTransactionId,
                    paymentProvider.getPaymentMethod,
                    cartPriceProvider.getSubTotal,
                    cartPriceProvider.getDelivery,
                    cartPriceProvider.getDiscount,
                    cartPriceProvider.getTotal);
              },
              child: ShareProgressButton(
                  borderRadius: BorderRadius.circular(10),
                  label: 'Download E-Receipt',
                  imagePath: AppImage.download),
            ),
            const SizedBox(height: 20),
          ]),
        ),
      ),
    );
  }
}
