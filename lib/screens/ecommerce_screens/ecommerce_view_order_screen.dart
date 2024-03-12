import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/components.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/db_services/db_services.dart';
import 'package:flutter_application_1/models/models.dart';
import 'package:flutter_application_1/providers/providers.dart';
import 'package:flutter_application_1/utils/utils.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'dart:developer';
import 'package:flutter_application_1/screens/screens.dart';

class ViewOrder extends StatefulWidget {
  final List<Orders> orderData;
  final String status;
  const ViewOrder({
    super.key,
    required this.orderData,
    required this.status,
  });

  @override
  State<ViewOrder> createState() => _ViewOrderState();
}

class _ViewOrderState extends State<ViewOrder> {
  late ReviewProvider reviewProvider;
  TextEditingController messageController = TextEditingController();
  TextEditingController searchFieldController = TextEditingController();
  late SearchProvider searchProvider;
  @override
  void initState() {
    searchFieldController.addListener(() {
      searchProvider.setSearchQuery(searchFieldController.text);
    });
    reviewProvider = Provider.of<ReviewProvider>(context, listen: false);
    log('average ${reviewProvider.getReviewCount}');
    log(' order...........${widget.status}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   
    searchProvider = Provider.of<SearchProvider>(context, listen: false);
    return Consumer<SearchProvider>(builder: (context, searchProvider, _) {
      List<Orders> filteredData = searchProvider.isSearchActive
          ? widget.orderData
              .where(
                  (order) => order.name!.contains(searchFieldController.text))
              .toList()
          : widget.orderData;
      return Scaffold(
        appBar: searchProvider.isSearchActive
            ? PreferredSize(
                preferredSize: const Size.fromHeight(60),
                child:
                    SearchAppBar(searchFieldController: searchFieldController),
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const LabelText(
                title: 'Order Details',
                size: AppFonts.exmedium,
                weight: FontWeight.w600,
                letterSpacing: 1,
              ),
              const SizedBox(
                height: 10,
              ),
              searchProvider.isSearchActive && filteredData.isEmpty
                  ? const Center(
                      child: Text('No matching items found'),
                    )
                  : SizedBox(
                      height: size.height * 0.8,
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: filteredData.length,
                          itemBuilder: (context, index) {
                            num? totalPrice =
                                filteredData[index].quantity != null &&
                                        filteredData[index].price != null
                                    ? filteredData[index].quantity! *
                                        filteredData[index].price!
                                    : 0.0;
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomProductItem(
                                imageAsset: filteredData[index].image ?? '',
                                productName: filteredData[index].name ?? '',
                                quantity:
                                    'Qty =${filteredData[index].quantity ?? ' '}',
                                price: totalPrice.toString(),
                                orderStatus: widget.status == 'Pending'
                                    ? 'pending'
                                    : 'complete',
                                trackOrderText: widget.status == 'Pending'
                                    ? 'Track Order'
                                    : 'Review',
                                onTapOrder: () {
                                  widget.status == 'Pending'
                                      ? Navigator.pushNamed(context,
                                          AppRoutes.ecommerceOrderDetailPage,
                                          arguments: {
                                              "image":
                                                  filteredData[index].image,
                                              "name": filteredData[index].name,
                                              'price':
                                                  filteredData[index].price,
                                              'quantity':
                                                  filteredData[index].quantity
                                            })
                                      : AppsDialogs.showAppDialog(
                                          backgroundColor:
                                              ThemeColors.backgroundColor(
                                                  context),
                                          context: context,
                                          content: CustomReviewDialog(
                                            textEditingController:
                                                messageController,
                                            onSubmitted: () {
                                              Reviews review = Reviews(
                                                  starsCount: reviewProvider
                                                      .getReviewCount,
                                                  userUid: AuthServices
                                                      .getCurrentUser?.uid,
                                                  review:
                                                      messageController.text,
                                                  dateTime: DateTime.now()
                                                      .toString());

                                              num reviewCounter = 0;
                                              EcommerceDbService.productReviews(
                                                  reviewsModel: review,
                                                  documentId:
                                                      filteredData[index].id!);

                                              EcommerceDbService
                                                  .updateProductReview(
                                                      review: reviewCounter++,
                                                      documentId:
                                                          filteredData[index]
                                                              .id!);
                                              Navigator.pop(context);
                                              AppsDialogs.showAppDialog(
                                                  backgroundColor: ThemeColors
                                                      .backgroundColor(context),
                                                  context: context,
                                                  content: CustomSuccessDialog(
                                                    message:
                                                        'You have successfully added\na review to product.',
                                                    onViewDetailsPressed: () {
                                                      Navigator
                                                          .pushReplacementNamed(
                                                        context,
                                                        AppRoutes
                                                            .ecommerceReviewPage,
                                                        arguments: {
                                                          'product_id':
                                                              filteredData[
                                                                      index]
                                                                  .id!
                                                        },
                                                      );
                                                    },
                                                    btnText: 'View Details',
                                                  ));
                                              messageController.clear();
                                            },
                                            onCancel: () {
                                              Navigator.pop(context);
                                              messageController.clear();
                                            },
                                          ),
                                        );
                                },
                                orderStatusColor: AppColors.colorDarkBkue,
                              ),
                            );
                          }),
                    ),
            ]),
          ),
        ),
      );
    });
  }
}
