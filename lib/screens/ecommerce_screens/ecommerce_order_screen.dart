import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/components.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/db_services/db_services.dart';
import 'package:flutter_application_1/models/ecommerce_models.dart';
import 'package:flutter_application_1/providers/providers.dart';
import 'package:flutter_application_1/screens/screens.dart';
import 'package:flutter_application_1/utils/utils.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class EcommerceOrderPage extends StatefulWidget {
  const EcommerceOrderPage({super.key});

  @override
  State<EcommerceOrderPage> createState() => EcommerceOrderPageState();
}

class EcommerceOrderPageState extends State<EcommerceOrderPage>
    with SingleTickerProviderStateMixin {
  late SearchProvider searchProvider;
  final TextEditingController searchActiveController = TextEditingController();

  final TextEditingController searchPastController = TextEditingController();
  late final TabController _tabController = TabController(
    vsync: this,
    length: 2,
  );
  int _activeIndex = 0;

  @override
  void initState() {
    _tabController.addListener(() {
      setState(() {
        _activeIndex = _tabController.index;
        log('........................activeIndex: $_activeIndex');
      });
    });
    searchProvider = Provider.of<SearchProvider>(context, listen: false);
    searchActiveController.addListener(() {
      searchProvider.setSearchQuery(searchActiveController.text);
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProvider>(builder: (context, searchProvider, _) {
      return Scaffold(
        appBar: searchProvider.isSearchActive
            ? PreferredSize(
                preferredSize: const Size.fromHeight(60),
                child: SearchAppBar(
                  searchFieldController: _activeIndex == 0
                      ? searchActiveController
                      : searchPastController,
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
                    title: 'My Orders',
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
                    const SizedBox(width: 20),
                  ],
                ),
              ),
        body: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PreferredSize(
                preferredSize: const Size.fromHeight(56),
                child: TabBar(
                    overlayColor: MaterialStateProperty.resolveWith((states) => Colors.transparent),
                    
                    controller: _tabController,
                    indicatorColor: ThemeColors.blackWhiteColor(context),
                    dividerColor: AppColors.colorGray,
                    unselectedLabelColor: ThemeColors.textColorGrey(context),
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelPadding: const EdgeInsets.symmetric(vertical: 10),
                    labelColor: ThemeColors.blackWhiteColor(context),
                    labelStyle: const TextStyle(
                        fontSize: AppFonts.exmedium,
                        fontWeight: FontWeight.w500),
                    tabs: const [Text('Active'), Text('Past')]),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    ActiveOrders(
                      searchFieldText: searchActiveController.text,
                    ),
                    PastOrders(
                      searchFieldText: searchPastController.text,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class ActiveOrders extends StatefulWidget {
  final String searchFieldText;
  const ActiveOrders({Key? key, required this.searchFieldText})
      : super(key: key);

  @override
  State<ActiveOrders> createState() => _ActiveOrdersState();
}

class _ActiveOrdersState extends State<ActiveOrders> {
  late SearchProvider searchProvider;
  @override
  Widget build(BuildContext context) {
    searchProvider = Provider.of<SearchProvider>(context, listen: false);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const LabelText(
              title: 'Active Order Details',
              size: AppFonts.exmedium,
              weight: FontWeight.w600,
              letterSpacing: 1,
            ),
            const SizedBox(
              height: 20,
            ),
            FutureBuilder<List<ProductsModel>>(
              future: EcommerceDbService.getUserOrders(),
              builder: (context, snapshot) {
                log("..............SnapShot : ${snapshot.data}");
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CupertinoActivityIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('No Products available'),
                  );
                } else {
                  List<ProductsModel> filteredData = searchProvider
                          .isSearchActive
                      ? snapshot.data!
                          .where((order) =>
                              order.orderId!.contains(widget.searchFieldText) ||
                              order.totalPrice!
                                  .contains(widget.searchFieldText) ||
                              order.dateTime!.contains(widget.searchFieldText))
                          .toList()
                      : snapshot.data!;

                  return Column(
                    children: [
                      searchProvider.isSearchActive && filteredData.isEmpty
                          ? const Center(
                              child: Text('No matching items found'),
                            )
                          : SizedBox(
                              height: size.height,
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: filteredData.length,
                                itemBuilder: (context, index) {
                                  return filteredData[index].status == "Pending"
                                      ? Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: ShapeDecoration(
                                              color: ThemeColors.containerShade(
                                                  context),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 20),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      const LabelText(
                                                        size: AppFonts.medium,
                                                        weight: FontWeight.w600,
                                                        letterSpacing: 0.50,
                                                        title: 'Order ID: ',
                                                      ),
                                                      LabelText(
                                                        size: AppFonts.medium,
                                                        weight: FontWeight.w300,
                                                        letterSpacing: 0.50,
                                                        title:
                                                            filteredData[index]
                                                                    .orderId
                                                                    ?.substring(
                                                                        0, 5) ??
                                                                '',
                                                      ),
                                                    ],
                                                  ),
                                                  LabelText(
                                                    size: AppFonts.exmedium,
                                                    weight: FontWeight.w300,
                                                    letterSpacing: 0.50,
                                                    title:
                                                        'Total Price: ${filteredData[index].totalPrice ?? ''}',
                                                  ),
                                                  LabelText(
                                                    size: AppFonts.exmedium,
                                                    weight: FontWeight.w300,
                                                    letterSpacing: 0.50,
                                                    title:
                                                        'Date: ${formatOrderDate(filteredData[index].dateTime ?? '')}',
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        flex: 2,
                                                        child: CustomOrder(
                                                          labelText: 'Pending',
                                                          color: const Color(
                                                              0x19EA5660),
                                                          labelColor:
                                                              ThemeColors
                                                                  .textColor(
                                                                      context),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 2,
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            Navigator.pushNamed(
                                                                context,
                                                                AppRoutes
                                                                    .viewOrder,
                                                                arguments: {
                                                                  "products":
                                                                      filteredData[
                                                                              index]
                                                                          .orders,
                                                                  "status":
                                                                      "Pending",
                                                                });
                                                          },
                                                          child:
                                                              const CustomOrder(
                                                            labelText:
                                                                'View Order',
                                                            color: AppColors
                                                                .colorDarkBkue,
                                                            labelColor:
                                                                AppColors
                                                                    .colorWhite,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      : const SizedBox();
                                },
                              ),
                            ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PastOrders extends StatefulWidget {
  final String searchFieldText;
  const PastOrders({super.key, required this.searchFieldText});

  @override
  State<PastOrders> createState() => _PastOrdersState();
}

class _PastOrdersState extends State<PastOrders> {
  late SearchProvider searchProvider;
  @override
  Widget build(BuildContext context) {
    searchProvider = Provider.of<SearchProvider>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(
            height: 20,
          ),
          const LabelText(
            title: 'Past Order Details',
            size: AppFonts.exmedium,
            weight: FontWeight.w600,
            letterSpacing: 1,
          ),
          const SizedBox(
            height: 20,
          ),
          FutureBuilder<List<ProductsModel>>(
            future: EcommerceDbService.getUserOrders(),
            builder: (context, snapshot) {
              log("..............SnapShot : ${snapshot.data}");
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CupertinoActivityIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                return const Center(
                  child: Text('No Products available'),
                );
              } else if (snapshot.hasData) {
                List<ProductsModel> filteredData = searchProvider.isSearchActive
                    ? snapshot.data!
                        .where((order) =>
                            order.orderId!.contains(widget.searchFieldText))
                        .where((order) =>
                            order.totalPrice!.contains(widget.searchFieldText))
                        .toList()
                    : snapshot.data!;
                return Column(
                  children: [
                    searchProvider.isSearchActive && filteredData.isEmpty
                        ? const Center(
                            child: Text('No matching items found'),
                          )
                        : SizedBox(
                            height: size.height * 0.7,
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: filteredData.length,
                              itemBuilder: (context, index) {
                                /// List<Orders>? orderData = snapshot.data?[index].orders;

                                return filteredData[index].status == "Complete"
                                    ? Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: ShapeDecoration(
                                            color: ThemeColors.containerShade(
                                                context),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 20),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    const LabelText(
                                                      size: AppFonts.medium,
                                                      weight: FontWeight.w600,
                                                      letterSpacing: 0.50,
                                                      title: 'Order ID: ',
                                                    ),
                                                    LabelText(
                                                      size: AppFonts.medium,
                                                      weight: FontWeight.w300,
                                                      letterSpacing: 0.50,
                                                      title: filteredData[index]
                                                              .orderId
                                                              ?.substring(
                                                                  0, 5) ??
                                                          '',
                                                    ),
                                                  ],
                                                ),
                                                LabelText(
                                                  size: AppFonts.exmedium,
                                                  weight: FontWeight.w300,
                                                  letterSpacing: 0.50,
                                                  title:
                                                      'Total Price: ${filteredData[index].totalPrice ?? ''}',
                                                ),
                                                LabelText(
                                                  size: AppFonts.exmedium,
                                                  weight: FontWeight.w300,
                                                  letterSpacing: 0.50,
                                                  title:
                                                      'Date: ${formatOrderDate(filteredData[index].dateTime ?? '')}',
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      flex: 3,
                                                      child: CustomOrder(
                                                        labelText: 'Complete',
                                                        color: const Color(
                                                            0x19EA5660),
                                                        labelColor: ThemeColors
                                                            .textColor(context),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Expanded(
                                                      flex: 3,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          Navigator.pushNamed(
                                                              context,
                                                              AppRoutes
                                                                  .viewOrder,
                                                              arguments: {
                                                                "products":
                                                                    filteredData[
                                                                            index]
                                                                        .orders,
                                                                "status":
                                                                    "Complete",
                                                              });
                                                        },
                                                        child:
                                                            const CustomOrder(
                                                          labelText:
                                                              'View Order',
                                                          color: AppColors
                                                              .colorDarkBkue,
                                                          labelColor: AppColors
                                                              .colorWhite,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    : const SizedBox();
                              },
                            ),
                          ),
                  ],
                );
              } else {
                return const Center(
                  child: CupertinoActivityIndicator(),
                );
              }
            },
          ),
        ]),
      ),
    );
  }
}
