import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/components.dart';
import 'package:flutter_application_1/components/custom_circular_avatar.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/db_services/db_services.dart';
import 'package:flutter_application_1/models/models.dart';
import 'package:flutter_application_1/providers/providers.dart';
import 'package:flutter_application_1/screens/screens.dart';
import 'package:flutter_application_1/utils/theme.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class EcommercePage extends StatefulWidget {
  const EcommercePage({super.key});

  @override
  State<EcommercePage> createState() => _EcommercePageState();
}

class _EcommercePageState extends State<EcommercePage> {
  int selectedIdx = 1;
  late CartCountProvider cartProvider;
  ValueNotifier<int> selectedIdxNotifier = ValueNotifier<int>(1);
  final Box<Map<String, dynamic>?> cartBox =
      Hive.box(name: '${AuthServices.getCurrentUser!.uid}cart');
  @override
  void initState() {
    cartProvider = Provider.of<CartCountProvider>(context, listen: false);
    int totalQuantity = 0;
    EcommerceDbService.getEcommerceData().listen((productList) {
      for (AdminProductModel product in productList) {
        log(product.toString());
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      cartProvider.clear();

      totalQuantity = EcommerceDbService.calculateTotalQuantity(cartBox);

      cartProvider.count = totalQuantity;
      log('....total $totalQuantity');
      log('....provider ${cartProvider.getCount}');
      EcommerceDbService.getFavProduct();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarCustom(
          greetings: 'Hello,',
          // name: greetUser(),
         leading: GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.showProfile,
              );
            },
            child: const CustomProfileAvatar()),
          actions: [
            // SvgPicture.asset(
            //   AppImage.seacrhIcon,
            //   colorFilter: ColorFilter.mode(
            //       ThemeColors.blackWhiteColor(context), BlendMode.srcIn),
            // ),
            // const SizedBox(width: 10),
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
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  width: size.width * 2.2,
                  height: size.height * 0.18,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage(AppImage.ecommernce),
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          flex: 5,
                          child: LabelText(
                            title: 'Favorite Products',
                            size: 16,
                            weight: FontWeight.w700,
                            letterSpacing: 0.50,
                          ),
                        ),
                        const SizedBox(
                          width: 100,
                        ),
                        Expanded(
                          flex: 3,
                          child: CustomViewContainer(
                            labelText: 'View More',
                            isSelected: false,
                            onSelect: (f) {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.ecommerceFavoritePage,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    StreamBuilder<List<AdminProductModel>>(
                      stream: EcommerceDbService.getFavProduct(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CupertinoActivityIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('Error: ${snapshot.error}'),
                          );
                        } else if (snapshot.data == null ||
                            snapshot.data!.isEmpty) {
                          return SizedBox(
                            height: size.height * 0.25,
                            child: const Center(
                              child: Text('No Favorite Products available'),
                            ),
                          );
                        } else {
                          return SizedBox(
                            height: size.height * 0.28,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                AdminProductModel product =
                                    snapshot.data![index];

                                return GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      AppRoutes.ecommerceProductPage,
                                      arguments: product,
                                    );
                                  },
                                  child: CustomEcommerceContainer(
                                    width: size.width * 0.43,
                                    imagePath: product.image,
                                    label: product.name,
                                    price: product.price.toString(),
                                  ),
                                );
                              },
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: size.height * 0.035,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: AppText.ecommerceLabels.length,
                        itemBuilder: (context, index) {
                          return ValueListenableBuilder<int>(
                            valueListenable: selectedIdxNotifier,
                            builder: (context, value, child) {
                              return CustomViewContainer(
                                labelText: AppText.ecommerceLabels[index],
                                isSelected: value == index,
                                onSelect: (isSelected) {
                                  selectedIdxNotifier.value =
                                      isSelected ? index : -1;
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ValueListenableBuilder<int>(
                                valueListenable: selectedIdxNotifier,
                                builder: (context, selectedIdx, child) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      LabelText(
                                        title: AppText
                                            .ecommerceLabels[selectedIdx],
                                        color: ThemeColors.blackWhiteColor(
                                            context),
                                        size: 16,
                                        weight: FontWeight.w700,
                                        letterSpacing: 0.50,
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 150,
                        ),
                        Expanded(
                          flex: 2,
                          child: GestureDetector(
                            onTap: () {
                              log('.......ontap.....');
                            },
                            child: ValueListenableBuilder<int>(
                              valueListenable: selectedIdxNotifier,
                              builder: (context, selectedDropdownIdx, child) {
                                return Column(
                                  children: [
                                    Container(
                                      width: size.width * 0.25,
                                      height: 24,
                                      decoration: ShapeDecoration(
                                        color:
                                            ThemeColors.containerShade(context),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          DropdownButton(
                                            icon: SvgPicture.asset(
                                              AppImage.filterIcon,
                                              colorFilter: ColorFilter.mode(
                                                ThemeColors.blackWhiteColor(
                                                    context),
                                                BlendMode.srcIn,
                                              ),
                                            ),
                                            hint: const LabelText(
                                              title: 'Filter',
                                              size: 10,
                                              weight: FontWeight.w500,
                                              letterSpacing: 0.50,
                                            ),
                                            borderRadius: BorderRadius.circular(20),
                                            menuMaxHeight: 300,
                                            underline: const SizedBox(),
                                            alignment: Alignment.center,
                                            items: AppText.ecommerceLabels
                                                .map<DropdownMenuItem<String>>(
                                              (String item) {
                                                return DropdownMenuItem(
                                                  alignment: Alignment.center,
                                                  enabled: true,
                                                  value: item,
                                                  child: Center(
                                                      child: LabelText(
                                                          title: item,
                                                            size: 10,
                                              weight: FontWeight.w500,
                                             )),
                                                );
                                              },
                                            ).toList(),
                                            onChanged: (selectedItem) {
                                              selectedIdxNotifier.value =
                                                  AppText.ecommerceLabels
                                                      .indexOf(selectedItem!);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    StreamBuilder<List<AdminProductModel>>(
                      stream: EcommerceDbService.getEcommerceData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CupertinoActivityIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('Error: ${snapshot.error}'),
                          );
                        } else if (snapshot.data == null ||
                            snapshot.data!.isEmpty) {
                          return SizedBox(
                            height: size.height * 0.25,
                            child: const Center(
                              child: Text('No Products available'),
                            ),
                          );
                        } else if (snapshot.hasData) {
                          return ValueListenableBuilder<int>(
                            valueListenable: selectedIdxNotifier,
                            builder: (context, selectedIdx, child) {
                              List<AdminProductModel> filteredProducts = [];
                              log("snapshot.data!................${snapshot.data!}");
                              if (selectedIdx >= 1 &&
                                  selectedIdx <
                                      AppText.ecommerceLabels.length) {
                                filteredProducts = snapshot.data!
                                    .where((product) =>
                                        product.category ==
                                        AppText.ecommerceLabels[selectedIdx])
                                    .toList();
                              } else {
                                filteredProducts = snapshot.data!;
                              }

                              return SizedBox(
                                height: size.height * 0.3,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: filteredProducts.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          AppRoutes.ecommerceProductPage,
                                          arguments: filteredProducts[index],
                                        );
                                      },
                                      child: CustomEcommerceContainer(
                                        width: size.width * 0.43,
                                        imagePath:
                                            filteredProducts[index].image,
                                        label: filteredProducts[index].name,
                                        price: filteredProducts[index]
                                            .price
                                            .toString(),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          );
                        }

                        return const CupertinoActivityIndicator();
                      },
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
