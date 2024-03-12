import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_application_1/components/components.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/db_services/db_services.dart';
import 'package:flutter_application_1/models/models.dart';
import 'package:flutter_application_1/providers/providers.dart';
import 'package:flutter_application_1/screens/screens.dart';
import 'package:flutter_application_1/utils/utils.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class EcommerceProductPage extends StatefulWidget {
  final AdminProductModel productData;
  const EcommerceProductPage({super.key, required this.productData});

  @override
  State<EcommerceProductPage> createState() => _EcommerceProductPageState();
}

class _EcommerceProductPageState extends State<EcommerceProductPage> {
  bool isCheckOperation = false;
  late FavProvider favProvider;
  late ReviewProvider reviewProvider;
  late CounterProvider countervalue;
  final Box<Map<String, dynamic>?> cartBox =
      Hive.box(name: '${AuthServices.getCurrentUser!.uid}cart');
  late CartCountProvider cartProvider;

  @override
  void initState() {
    super.initState();
    reviewProvider = Provider.of<ReviewProvider>(context, listen: false);
    favProvider = Provider.of<FavProvider>(context, listen: false);
    countervalue = Provider.of<CounterProvider>(context, listen: false);
    cartProvider = Provider.of<CartCountProvider>(context, listen: false);
    EcommerceDbService.getFavDoc().then((docs) {
      favProvider.setFavIds = docs;
    });

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      favProvider.clearfavList();
      countervalue.clear();
      log('clear value ${favProvider.getfavLists.length}');
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
          title: 'Product Details',
        ),
        actions: [
         
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.ecommerceCartPage);
                  },
                  child: SvgPicture.asset(
                    AppImage.addCartIcon,
                    height: 25,
                    colorFilter: ColorFilter.mode(
                      ThemeColors.blackWhiteColor(context),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: Consumer<CartCountProvider>(
                    builder: (BuildContext context, provider, Widget? child) {
                  return Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: LabelText(
                      title: provider.getCount.toString(),
                      color: AppColors.colorWhite,
                      size: 10,
                    ),
                  );
                }),
              ),
            ],
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: size.width,
              height: size.height * 0.32,
              child: ClipPath(
                clipper: CustomRoundedClipper(
                  bottomLeftRadius: 130.0,
                  bottomRightRadius: 130.0,
                  topLeftRadius: 0.0,
                  topRightRadius: 0.0,
                ),
                child: Image.network(
                  widget.productData.image,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 20),
                  child: LabelText(
                    title: widget.productData.code,
                    size: 14,
                    weight: FontWeight.w500,
                    letterSpacing: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 250,
                            child: LabelText(
                              title: widget.productData.name,
                              size: AppFonts.xxLarge,
                              weight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            child: Consumer<CounterProvider>(builder:
                                (BuildContext context, counter, Widget? child) {
                              return Row(
                                children: [
                                  Container(
                                    width: 30,
                                    height: 30,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.shadeDarkGreen,
                                    ),
                                    child: Center(
                                      child: GestureDetector(
                                        onTap: () {
                                          counter.decrement();
                                        },
                                        child: const Icon(
                                          Icons.remove,
                                          color: AppColors.colorWhite,
                                          size: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 30,
                                    height: 30,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: LabelText(
                                        size: 14,
                                        weight: FontWeight.w500,
                                        letterSpacing: 0.50,
                                        title: '${countervalue.count}',
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 30,
                                    height: 30,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.green,
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        counter.increment();
                                      },
                                      child: const Icon(
                                        Icons.add,
                                        color: AppColors.colorWhite,
                                        size: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          SvgPicture.asset(
                            AppImage.priceTag,
                            height: 20,
                            width: 20,
                            colorFilter: const ColorFilter.mode(
                                AppColors.colorBlue, BlendMode.srcIn),
                          ),
                          const SizedBox(width: 8),
                          LabelText(
                            color: AppColors.colorBlue,
                            size: 20,
                            weight: FontWeight.w500,
                            letterSpacing: 0.50,
                            title: widget.productData.price.toString(),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Container(
                            width: size.width * 0.25,
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            decoration: ShapeDecoration(
                              color: AppColors.lightBlack,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7)),
                            ),
                            child: Center(
                              child: LabelText(
                                title:
                                    "${widget.productData.soldCount.toString()} Sold",
                                color: AppColors.colorWhite,
                                size: 14,
                                weight: FontWeight.w500,
                                letterSpacing: 0.50,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          SvgPicture.asset(
                            AppImage.starIcon,
                            height: 20,
                            width: 20,
                            colorFilter: const ColorFilter.mode(
                                Colors.green, BlendMode.srcIn),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.ecommerceReviewPage,
                                arguments: {
                                  'product_id': widget.productData.id
                                },
                              );
                            },
                            child: SizedBox(
                              child: StreamBuilder<List<Reviews>>(
                                stream: EcommerceDbService.getReviews(
                                    documentId: widget.productData.id),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CupertinoActivityIndicator();
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else if (!snapshot.hasData ||
                                      snapshot.data == null) {
                                    return const Text('');
                                  }

                                  List<Reviews> allReviews = snapshot.data!;
                                  double averageStarCount =
                                      calculateAverageStarCount(allReviews);

                                  return LabelText(
                                    title:
                                        '${averageStarCount.toStringAsFixed(1)} (${allReviews.length})',
                                    size: 20,
                                    weight: FontWeight.w600,
                                    letterSpacing: 1,
                                  );
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        width: size.width * 0.95,
                        child: LabelText(
                          title: widget.productData.description,
                          size: AppFonts.small,
                          weight: FontWeight.w400,
                          letterSpacing: 0.50,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          Expanded(
                            flex: 6,
                            child: SizedBox(
                                height: size.height * 0.067,
                                width: size.width * 0.7,
                                child: CustomButton(
                                    buttonText: 'Add to Cart',
                                    onPressed: () {
                                      final cartBox = Hive.box(
                                          name:
                                             '${AuthServices.getCurrentUser!.uid}cart');
                                      cartProvider.setCount =
                                          countervalue.count;
                                      EcommerceDbService.saveCartProductId(
                                          productId: widget.productData.id);
                                      if (cartBox
                                          .containsKey(widget.productData.id)) {
                                        var cartData =
                                            CartProductModel.fromJson(cartBox
                                                .get(widget.productData.id));
                                        cartData.quantity += countervalue.count;
                                        cartBox.put(widget.productData.id,
                                            cartData.toJson());

                                        for (var key in cartBox.keys) {
                                          var cartData =
                                              CartProductModel.fromJson(
                                                  cartBox.get(key));
                                          log('Key: $key, Cart Data: $cartData');
                                        }

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            backgroundColor:
                                                AppColors.colorDarkBkue,
                                            content: LabelText(
                                              title:
                                                  'You have successfully added product to your cart.',
                                              size: AppFonts.exmedium,
                                              color: AppColors.colorWhite,
                                            ),
                                          ),
                                        );
                                      } else {
                                        var cartData = CartProductModel(
                                          image: widget.productData.image,
                                          name: widget.productData.name,
                                          price: widget.productData.price,
                                          quantity: countervalue.count,
                                          discount: widget.productData.discount,
                                          deliveryFee:
                                              widget.productData.deliveryFee,
                                          id: widget.productData.id,
                                        );
                                        cartBox.put(widget.productData.id,
                                            cartData.toJson());

                                        for (var key in cartBox.keys) {
                                          var cartData =
                                              CartProductModel.fromJson(
                                                  cartBox.get(key));
                                          log('Key: $key, cart Data: $cartData');
                                        }

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            backgroundColor:
                                                AppColors.colorDarkBkue,
                                            content: LabelText(
                                              title:
                                                  'You have successfully added product to your cart.',
                                              size: AppFonts.exmedium,
                                            ),
                                          ),
                                        );
                                      }
                                    })),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              child: Consumer<FavProvider>(
                                builder: (BuildContext context, provider,
                                    Widget? child) {
                                  return GestureDetector(
                                    onTap: () async {
                                      if (!isCheckOperation) {
                                        isCheckOperation = true;
                                        if (!provider.getfavLists
                                            .contains(widget.productData.id)) {
                                          provider.setFavIds = [
                                            widget.productData.id
                                          ];
                                          EcommerceDbService.makeFavProduct(
                                              documentId:
                                                  widget.productData.id);
                                          log('${provider.getfavLists.length}');
                                          isCheckOperation = false;
                                        } else {
                                          provider.removefavList(
                                              widget.productData.id);
                                          EcommerceDbService.deleteFavProduct(
                                              widget.productData.id);
                                          log('${provider.getfavLists.length}');
                                          isCheckOperation = false;
                                        }
                                      }
                                    },
                                    child: Container(
                                      height: size.height * 0.065,
                                      width: size.width * 0.04,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        border: Border.all(
                                          width: 1.0,
                                          color: ThemeColors.textColorBlack(
                                              context),
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: SvgPicture.asset(
                                          provider.getfavLists.contains(
                                                  widget.productData.id)
                                              ? AppImage.likeHeart
                                              : AppImage.heart,
                                          colorFilter: ColorFilter.mode(
                                            provider.getfavLists.contains(
                                                    widget.productData.id)
                                                ? AppColors.colorDarkBkue
                                                : ThemeColors.textColorBlack(
                                                    context),
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
