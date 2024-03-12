import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/components.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/models/ecommerce_models.dart';
import 'package:flutter_application_1/providers/providers.dart';
import 'package:flutter_application_1/screens/screens.dart';
import 'package:flutter_application_1/utils/theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/db_services/db_services.dart';
import 'package:provider/provider.dart';

class EcommerceFavoritePage extends StatefulWidget {
  const EcommerceFavoritePage({super.key});

  @override
  State<EcommerceFavoritePage> createState() => _EcommerceFavoritePageState();
}

class _EcommerceFavoritePageState extends State<EcommerceFavoritePage> {
  late CartCountProvider cartProvider;
  late SearchProvider searchProvider;
  final TextEditingController searchFieldController = TextEditingController();

  @override
  void initState() {
    cartProvider = Provider.of<CartCountProvider>(context, listen: false);
    searchProvider = Provider.of<SearchProvider>(context, listen: false);
    searchFieldController.addListener(() {
      searchProvider.setSearchQuery(searchFieldController.text);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProvider>(builder: (context, searchProvider, _) {
      return Scaffold(
        appBar: searchProvider.isSearchActive
            ? PreferredSize(
                preferredSize: const Size.fromHeight(60),
                child: SearchAppBar(
                  searchFieldController: searchFieldController,
                ),
              )
            : PreferredSize(
                preferredSize: const Size.fromHeight(60),
                child: AppBar(
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
                    title: 'Favorite',
                  ),
                  actions: [
                    GestureDetector(
                      onTap: () {
                        searchProvider.toggleSearch();
                      },
                      child: SvgPicture.asset(
                        AppImage.seacrhIcon,
                        colorFilter: ColorFilter.mode(
                            ThemeColors.blackWhiteColor(context),
                            BlendMode.srcIn),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.ecommerceCartPage);
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
                          child: Consumer<CartCountProvider>(builder:
                              (BuildContext context, provider, Widget? child) {
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
              ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 10, top: 10),
          child: SingleChildScrollView(
            child: Column(children: [
              const Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: LabelText(
                      title: 'Favorite Products',
                      size: 16,
                      weight: FontWeight.w700,
                      letterSpacing: 0.50,
                    ),
                  ),
                  SizedBox(
                    width: 100,
                  ),

                  // Expanded(
                  //   flex: 3,
                  //   child: Container(
                  //     width: size.width * 0.25,
                  //     height: size.height * 0.035,
                  //     padding: const EdgeInsets.symmetric(vertical: 6),
                  //     decoration: ShapeDecoration(
                  //       color: ThemeColors.containerShade(context),
                  //       shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(7)),
                  //     ),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         SvgPicture.asset(
                  //           AppImage.filterIcon,
                  //           width: 24,
                  //           height: 24,
                  //           colorFilter: ColorFilter.mode(
                  //               ThemeColors.blackWhiteColor(context),
                  //               BlendMode.srcIn),
                  //         ),
                  //         const SizedBox(
                  //           width: 5,
                  //         ),
                  //         const LabelText(
                  //           title: 'Filter',
                  //           size: 10,
                  //           weight: FontWeight.w500,
                  //           letterSpacing: 0.50,
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
               
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: size.height,
                child: StreamBuilder<List<AdminProductModel>>(
                  stream: EcommerceDbService.getFavProduct(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CupertinoActivityIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.data == null ||
                        snapshot.data!.isEmpty) {
                      return const Center(child: Text('No Products available'));
                    } else if (snapshot.hasData) {
                      List<AdminProductModel> filteredData = snapshot.data!
                          .where((favouriteCollection) => favouriteCollection
                              .name
                              .contains(searchFieldController.text))
                          .toList();
                      return Column(
                        children: [
                          searchProvider.isSearchActive && filteredData.isEmpty
                              ? const Padding(
                                  padding: EdgeInsets.only(top: 50),
                                  child: Center(
                                    child: Text('No matching items found'),
                                  ),
                                )
                              : Expanded(
                                  flex: 9,
                                  child: GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: (21) / (28),
                                    ),
                                    itemCount: filteredData.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(
                                            context,
                                            AppRoutes.ecommerceProductPage,
                                            arguments: filteredData[index],
                                          );
                                        },
                                        child: CustomEcommerceContainer(
                                          imagePath: filteredData[index].image,
                                          label: filteredData[index].name,
                                          price: filteredData[index]
                                              .price
                                              .toString(),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                        ],
                      );
                    } else {
                      return const Center(child: CupertinoActivityIndicator());
                    }
                  },
                ),
              ),
            ]),
          ),
        ),
      );
    });
  }
}
