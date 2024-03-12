import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/components.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/db_services/db_services.dart';
import 'package:flutter_application_1/models/models.dart';
import 'package:flutter_application_1/providers/providers.dart';
import 'package:flutter_application_1/screens/screens.dart';
import 'package:flutter_application_1/utils/utils.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class EcommerceReviewPage extends StatefulWidget {
  final String productId;
  const EcommerceReviewPage({super.key, required this.productId});

  @override
  State<EcommerceReviewPage> createState() => _EcommerceReviewPageState();
}

class _EcommerceReviewPageState extends State<EcommerceReviewPage> {
  ValueNotifier<int> selectedIdxNotifier = ValueNotifier<int>(0);
  int selectedIdx = 0;
  double average = 0.0;
  @override
  void initState() {
    log(' id ${widget.productId}');
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
          title: 'Reviews',
        ),
        actions: [
         
          const SizedBox(width: 10),
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
          padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
          child: ValueListenableBuilder<int>(
              valueListenable: selectedIdxNotifier,
              builder: (context, selectedIdx, _) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: size.height * 0.045,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: AppText.reviewsLabels.length,
                        itemBuilder: (context, index) {
                          return CustomReviewContainer(
                            labelText: AppText.reviewsLabels[index],
                            isSelected: selectedIdx == index,
                            onSelect: (isSelected) {
                              selectedIdxNotifier.value =
                                  isSelected ? index : 0;
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    StreamBuilder<List<Reviews>>(
                      stream: EcommerceDbService.getReviews(
                          documentId: widget.productId),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(child: CupertinoActivityIndicator());
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Text('No Reviews available');
                        } else {
                          List<Reviews> filteredReviews = [];
                          if (selectedIdxNotifier.value == 0) {
                            filteredReviews = snapshot.data!;
                          } else {
                            int selectedStars = int.parse(AppText
                                .reviewsLabels[selectedIdxNotifier.value]);
                            filteredReviews = snapshot.data!
                                .where((review) =>
                                    review.starsCount == selectedStars)
                                .toList();
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, bottom: 10),
                                child: LabelText(
                                  title:
                                      '${calculateAverageStarCount(filteredReviews)}(${filteredReviews.length})',
                                  size: 20,
                                  weight: FontWeight.w600,
                                  letterSpacing: 1,
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.8,
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: filteredReviews.length,
                                  itemBuilder: (context, index) {
                                   
                                   
                                    String formattedTime = formatTimestamp(
                                      DateTime.parse(
                                          snapshot.data![index].dateTime!),
                                    );
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: SizedBox(
                                            width: size.width * 1.5,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        CircleAvatar(
                                                          radius: 20,
                                                          backgroundImage:
                                                              NetworkImage(AuthServices
                                                                      .getCurrentUser
                                                                      ?.photoURL ??
                                                                  ''),
                                                        ),
                                                        const SizedBox(
                                                            width: 20),
                                                        LabelText(
                                                          title: AuthServices
                                                                  .getCurrentUser
                                                                  ?.displayName ??
                                                              '',
                                                          size: 16,
                                                          weight:
                                                              FontWeight.w500,
                                                          letterSpacing: 0.20,
                                                        ),
                                                      ],
                                                    ),
                                                    CustomReview(
                                                      labelText: snapshot
                                                          .data![index]
                                                          .starsCount
                                                          .toString(),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 10),
                                                LabelText(
                                                  title:snapshot
                                                          .data![index]
                                                          .review ?? '',
                                                  size: 14,
                                                  weight: FontWeight.w400,
                                                  letterSpacing: 0.70,
                                                ),
                                                const SizedBox(height: 10),
                                                LabelText(
                                                  title: formattedTime,
                                                  color: ThemeColors
                                                      .textColorBlack(context),
                                                  size: 12,
                                                  weight: FontWeight.w500,
                                                  letterSpacing: 0.50,
                                                ),
                                                const SizedBox(height: 10),
                                                const Divider(),
                                                const SizedBox(height: 20),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 500,
                              ),
                            ],
                          );
                        }
                      },
                    )
                  ],
                );
              }),
        ),
      ),
    );
  }
}
