import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_application_1/components/components.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/models/ecommerce_models.dart';
import 'package:flutter_application_1/providers/providers.dart';
import 'package:flutter_application_1/screens/screens.dart';
import 'package:flutter_application_1/utils/theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/db_services/db_services.dart';

class EcommerceCartPage extends StatefulWidget {
  const EcommerceCartPage({super.key});

  @override
  State<EcommerceCartPage> createState() => EcommerceCartPageState();
}

class EcommerceCartPageState extends State<EcommerceCartPage> {
  final Box<Map<String, dynamic>?> cartBox =
      Hive.box(name: '${AuthServices.getCurrentUser!.uid}cart');
  late CartCountProvider cartProvider;
  late CartPriceProvider cartPriceProvider;

  @override
  void initState() {
    cartProvider = Provider.of<CartCountProvider>(context, listen: false);
    cartPriceProvider = Provider.of<CartPriceProvider>(context, listen: false);

    CartValues cartValues = calculateCartValues(cartBox);
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      cartPriceProvider.settotal = cartValues.subtotal;
      cartPriceProvider.setSubtotal =
          cartValues.subtotal + cartValues.delivery - cartValues.discount;
      cartPriceProvider.setDelivery = cartValues.delivery;
      cartPriceProvider.setDiscount = cartValues.discount;

      log('Total: ${cartPriceProvider.getSubTotal.toString()}');
      log('Subtotal: ${cartPriceProvider.getTotal}');
      log('Delivery:${cartPriceProvider.getDelivery}');
      log('Discount:${cartPriceProvider.getDiscount}');
    });
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
          title: 'Cart',
        ),
        actions: [
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
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Consumer<CartPriceProvider>(builder:
              (BuildContext context, cartPriceProvider, Widget? child) {
           // final productData = EcommerceDbService.getCartProduct();
            //log('show data............${productData}');
            if (cartBox.isNotEmpty) {
              return FutureBuilder<List<CartProductModel>>(
                future: EcommerceDbService.getCartProduct(),
                builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CupertinoActivityIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData ||
                        snapshot.data!.isEmpty) {
                      return const Center(child: Text('No data'));
                    } else if (snapshot.hasData) {
                  return Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.55,
                        width: size.width,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ProductCard(
                              imagePath: snapshot.data![index].image,
                              label: snapshot.data![index].name,
                              price:snapshot.data![index].price.toString(),
                              onTapIncrement: () {
                              snapshot.data![index].quantity++;
                                cartBox.put(snapshot.data![index].id,
                                    snapshot.data![index].toJson());
                  
                                cartProvider.increment();
                                cartPriceProvider.addTotal =
                                    snapshot.data![index].price;
                                cartPriceProvider.addSubTotal =
                                    snapshot.data![index].price;
                                log("Incremented: ${snapshot.data![index].toJson()}");
                              },
                              onTapDecrement: () {
                                if (snapshot.data![index].quantity > 1) {
                                 snapshot.data![index].quantity--;
                                  cartBox.put(snapshot.data![index].id,
                                      snapshot.data![index].toJson());
                                  cartPriceProvider.subtractTotal =
                                     snapshot.data![index].price;
                                  cartPriceProvider.subtractSubTotal =
                                     snapshot.data![index].price;
                                  cartProvider.decrement();
                                  log("Decremented: ${snapshot.data![index].toJson()}");
                                }
                              },
                              onDelete: () {
                                cartBox.delete(snapshot.data![index].id);
                                cartPriceProvider.subtractTotal =
                                    snapshot.data![index].price--;
                                cartProvider
                                    .deleteCount(snapshot.data![index].quantity);
                                log("Deleted: ${snapshot.data![index].toJson()}");
                              },
                              itemCount: snapshot.data![index].quantity.toString(),
                            );
                          },
                        ),
                      ),
                      Container(
                        width: size.width,
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
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
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
                                  count: 50,
                                  width: 1.5,
                                  height: 1,
                                  marginHorizontal: 2),
                            ),
                            CustomCartCalulation(
                              color: AppColors.colorBlue,
                              label: 'Total :',
                              value: cartPriceProvider.getSubTotal.toString(),
                              valueSize: AppFonts.large,
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                                height: size.height * 0.067,
                                width: size.width * 0.9,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 10, right: 10),
                                  child: CustomButton(
                                      buttonText: 'Proceed to Checkout',
                                      size: 18,
                                      fontWeight: FontWeight.w600,
                                      onPressed: () {
                                        Navigator.pushReplacementNamed(context,
                                            AppRoutes.ecommerceCheckoutPage);
                                      }),
                                )),
                          ]),
                        ),
                      ),
                    ],
                  );
                }else{
                   return const Center(child: CupertinoActivityIndicator());
                }
                }
              );
            } else {
              return Column(children: [
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Center(
                    child: SvgPicture.asset(
                      AppImage.emptyCart,
                      width: 185,
                      height: 180,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const LabelText(
                  title: 'Your cart is empty',
                  size: 24,
                  weight: FontWeight.w600,
                  letterSpacing: 0.50,
                ),
                const SizedBox(height: 20),
                const SizedBox(
                  width: 290,
                  child: LabelText(
                    textAlignment: TextAlign.center,
                    title:
                        'You dont have any items added to cart yet. You need to add items to cart before checkout.',
                    size: AppFonts.exmedium,
                    weight: FontWeight.w300,
                    letterSpacing: 1.20,
                  ),
                ),
                const SizedBox(height: 150),
                SizedBox(
                    height: size.height * 0.067,
                    width: size.width * 0.9,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: CustomButton(
                          buttonText: 'View Orders',
                          size: 18,
                          fontWeight: FontWeight.w600,
                          onPressed: () {
                            Navigator.pushNamed(
                                context, AppRoutes.ecommerceOrderPage);
                          }),
                    )),
              ]);
            }
          }),
        ]),
      ),
    );
  }
}
