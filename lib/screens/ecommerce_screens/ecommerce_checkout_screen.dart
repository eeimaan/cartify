import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_application_1/components/components.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/db_services/db_services.dart';
import 'package:flutter_application_1/providers/providers.dart';
import 'package:flutter_application_1/screens/screens.dart';
import 'package:flutter_application_1/utils/utils.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:flutter_application_1/models/models.dart';

class EcommerceCheckoutPage extends StatefulWidget {
  const EcommerceCheckoutPage({super.key});

  @override
  State<EcommerceCheckoutPage> createState() => EcommerceCheckoutPageState();
}

class EcommerceCheckoutPageState extends State<EcommerceCheckoutPage> {
  late CartPriceProvider cartPriceProvider;
  late PaymentProvider paymentProvider;
  String address = '';
  final Box<Map<String, dynamic>?> cartBox =
      Hive.box(name: '${AuthServices.getCurrentUser!.uid}cart');
  DateTime date = DateTime.now();
  late AddressProvider addressProvider;
  List<CartProductModel> orderData = [];
  final connectivityResult = Connectivity().checkConnectivity();
  @override
  void initState() {
    paymentProvider = Provider.of<PaymentProvider>(context, listen: false);
    cartPriceProvider = Provider.of<CartPriceProvider>(context, listen: false);
    addressProvider = Provider.of<AddressProvider>(context, listen: false);

    void addressMetod() async {
      String? address = await EcommerceDbService.getDefaultAddress();
      log('Default Address: $address');
      addressProvider.setAddress = address ?? '';
      log('...........addresss${addressProvider.getAddress}');
    }

    addressMetod();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      paymentProvider.clearValues();

      paymentProvider.getPaymentMethod;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
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
              title: 'Checkout',
            ),
            actions: [
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.ecommerceOrderPage);
                },
                child: SvgPicture.asset(
                  AppImage.orderIcon,
                  colorFilter: ColorFilter.mode(
                      ThemeColors.blackWhiteColor(context), BlendMode.srcIn),
                ),
              ),
              const SizedBox(width: 20),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Consumer<PaymentProvider>(builder:
                  (BuildContext context, paymentProvider, Widget? child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const LabelText(
                      title: 'Payment Method',
                      size: 16,
                      weight: FontWeight.w600,
                      letterSpacing: 1,
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: size.width,
                      height: 48,
                      decoration: ShapeDecoration(
                        color: ThemeColors.containerShade(context),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, AppRoutes.ecommercePaymentMethodPage);
                        },
                        child: Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: LabelText(
                                  color: ThemeColors.textColorGrey(context),
                                  size: AppFonts.small,
                                  weight: FontWeight.w500,
                                  title: paymentProvider.getPaymentMethod,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: SvgPicture.asset(
                                AppImage.downArrow,
                                width: 24,
                                height: 24,
                                colorFilter: ColorFilter.mode(
                                    ThemeColors.textColorGrey(context),
                                    BlendMode.srcIn),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const LabelText(
                      title: 'Payment Description',
                      size: 16,
                      weight: FontWeight.w600,
                      letterSpacing: 1,
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: size.width,
                      height: size.height * 0.25,
                      decoration: ShapeDecoration(
                        color: ThemeColors.containerShade(context),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
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
                        // CustomCartCalulation(
                        //     label: 'Price',
                        //     value: cartPriceProvider.getSubTotal.toString()),
                        // const SizedBox(height: 10),
                        // CustomCartCalulation(
                        //   label: 'Payment Methods',
                        //   value: paymentProvider.getPaymentMethod,
                        // ),
                        const SizedBox(height: 10),
                        const Padding(
                          padding: EdgeInsets.only(top: 6, left: 30, right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              DividerList(
                                  count: 50,
                                  width: 1.5,
                                  height: 1,
                                  marginHorizontal: 2),
                            ],
                          ),
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
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LabelText(
                                title: 'Shipping Address',
                                size: 16,
                                weight: FontWeight.w600,
                                letterSpacing: 1,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context,
                                      AppRoutes.ecommerceAddressesPage);
                                },
                                child: SvgPicture.asset(
                                  AppImage.pencil,
                                  width: 24,
                                  height: 24,
                                  colorFilter: const ColorFilter.mode(
                                      AppColors.colorBlue, BlendMode.srcIn),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Consumer<AddressProvider>(builder:
                        (BuildContext context, provider, Widget? child) {
                      return Container(
                          width: size.width,
                          decoration: ShapeDecoration(
                            color: ThemeColors.containerShade(context),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: LabelText(
                              size: AppFonts.small,
                              color: ThemeColors.textColor(context),
                              weight: FontWeight.w500,
                              title: provider.getAddress,
                            ),
                          ));
                    }),
                    SizedBox(height: size.height * 0.2),
                    CustomButton(
                      buttonText: 'Confirm',
                      onPressed: () {
                        List<Map<String, dynamic>?> cartDataList =
                            cartBox.getAll(cartBox.keys);
                        for (var product in cartDataList) {
                          orderData.add(CartProductModel.fromJson(product!));
                        }
                        log("Cart Data: ${orderData[0].id} ");

                        try {
                          EcommerceDbService.orderProduct(
                              data: orderData,
                              context: context,
                              transactionId: paymentProvider.getTransactionId,
                              totalPrice: cartPriceProvider.getTotal.toString(),
                              dateTime: date.toString(),
                              address: address,
                              status: 'Pending');
                          //  Navigator.pop(context);
                        } finally {
                          AppsDialogs.showAppDialog(
                              backgroundColor:
                                  ThemeColors.backgroundColor(context),
                              context: context,
                              content: OrderDialog(
                                onViewOrderPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pushReplacementNamed(
                                      context, AppRoutes.ecommerceOrderPage);
                                },
                                onViewEReceiptPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pushReplacementNamed(
                                      context, AppRoutes.ecommerceEreceiptPage);
                                },
                              ));
                        }
                      },
                    ),
                    const SizedBox(height: 100),
                  ],
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}
