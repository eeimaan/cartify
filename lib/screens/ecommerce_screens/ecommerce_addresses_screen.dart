import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_application_1/components/components.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/db_services/db_services.dart';
import 'package:flutter_application_1/providers/address_provider.dart';
import 'package:flutter_application_1/providers/providers.dart';
import 'package:flutter_application_1/screens/screens.dart';
import 'package:flutter_application_1/utils/utils.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class EcommerceAddressesPage extends StatefulWidget {
  const EcommerceAddressesPage({super.key});

  @override
  State<EcommerceAddressesPage> createState() => _EcommerceAddressesPageState();
}

class _EcommerceAddressesPageState extends State<EcommerceAddressesPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  late AddressProvider addressProvider;
  ValueNotifier<bool> isDefaultNotifier = ValueNotifier<bool>(true);
  void addressMetod() async {
    String? address = await EcommerceDbService.getDefaultAddress();
    log('Default Address: $address');
    addressProvider.setAddress = address ?? '';
    log('...........addresss${addressProvider.getAddress}');
  }

  @override
  initState() {
    addressProvider = Provider.of<AddressProvider>(context, listen: false);

    addressMetod();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      log('...........addresss${addressProvider.getAddress}');
    });

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
          title: 'Addresses',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const LabelText(
                  title: 'Your Addresses',
                  size: AppFonts.exmedium,
                  weight: FontWeight.w700,
                  letterSpacing: 0.32,
                ),
                GestureDetector(
                  onTap: () {
                    AppsDialogs.showAppDialog(
                        backgroundColor: ThemeColors.backgroundColor(context),
                        context: context,
                        content: CustomDialog(
                          isOpenFromNutrition: false,
                          nameController: _nameController,
                          addressController: _addressController,
                          onSave: () async {
                            await EcommerceDbService.addUserAddress(
                                name: _nameController.text,
                                address: _addressController.text,
                                isDefault: false);
                            WidgetsBinding.instance
                                .addPostFrameCallback((timeStamp) {
                              Navigator.pop(context);
                            });
                          },
                        ));
                    _nameController.clear();
                    _addressController.clear();
                  },
                  child: Container(
                    width: size.width * 0.3,
                    height: size.height * 0.039,
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    decoration: ShapeDecoration(
                      color: AppColors.colorBlue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          color: AppColors.colorWhite,
                          size: 14,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        LabelText(
                          title: 'Add Address',
                          size: 10,
                          color: AppColors.colorWhite,
                          weight: FontWeight.w500,
                          letterSpacing: 0.50,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: LabelText(
                title: 'Default:',
                size: AppFonts.exmedium,
                weight: FontWeight.w600,
                letterSpacing: 0.32,
              ),
            ),
            Center(
              child: StreamBuilder<QuerySnapshot>(
                  stream: EcommerceDbService.getUserAddress(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CupertinoActivityIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData ||
                        snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text('No address available'));
                    } else if (snapshot.hasData) {
                      isDefaultNotifier.value = !isDefaultNotifier.value;

                      return Column(
                        children: [
                          Container(
                            width: size.width,
                            height: size.height * 0.18,
                            decoration: ShapeDecoration(
                              color: ThemeColors.containerShade(context),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                 side: const BorderSide(
                          color: AppColors.greenish,
                          width: 0.4,
                        ),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 12, top: 20, bottom: 12, right: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.asset(AppImage.location,
                                              width: 24,
                                              height: 24,
                                              color: AppColors.colorBlue),
                                          SizedBox(
                                            width: size.width * 0.01,
                                          ),
                                          Consumer<AddressProvider>(builder:
                                              (BuildContext context, provider,
                                                  Widget? child) { 
                                                     provider.clear;
                                            return SizedBox(
                                              width: size.width * 0.45,
                                              child: LabelText(
                                                  size: AppFonts.small,
                                                  color: ThemeColors.textColor(
                                                      context),
                                                  weight: FontWeight.w500,
                                                  title: provider.getAddress),
                                            );
                                          })
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              AppsDialogs.showAppDialog(
                                                  backgroundColor: ThemeColors
                                                      .backgroundColor(context),
                                                  context: context,
                                                  content: CustomDialog(
                                                    isOpenFromNutrition: false,
                                                    nameController:
                                                        _nameController,
                                                    addressController:
                                                        _addressController,
                                                    onSave: () async {
                                                      await EcommerceDbService
                                                          .updateDefaultAddress(
                                                              name:
                                                                  _nameController
                                                                      .text,
                                                              address:
                                                                  _addressController
                                                                      .text);
                                                      addressProvider
                                                              .setAddress =
                                                          _addressController
                                                              .text;
                                                      WidgetsBinding.instance
                                                          .addPostFrameCallback(
                                                              (timeStamp) {
                                                        Navigator.pop(context);
                                                      });
                                                    },
                                                  ));
                                              _nameController.clear();
                                              _addressController.clear();
                                            },
                                            child: Container(
                                              width: 40,
                                              height: 32,
                                              padding: const EdgeInsets.all(10),
                                              decoration: ShapeDecoration(
                                                color: const Color(0xFFCAF99C),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                              child: SvgPicture.asset(
                                                AppImage.pencil,
                                                width: 24,
                                                height: 24,
                                                colorFilter:
                                                    const ColorFilter.mode(
                                                        AppColors.darkBlack,
                                                        BlendMode.srcIn),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          GestureDetector(
                                            onTap: () {
                                              EcommerceDbService
                                                  .deleteDefaultUserAddress();
                                              addressProvider.clear();
                                            },
                                            child: Container(
                                              width: 40,
                                              height: 32,
                                              padding: const EdgeInsets.all(10),
                                              decoration: ShapeDecoration(
                                                color: AppColors.colorDarkBkue,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                              child: SvgPicture.asset(
                                                AppImage.delete,
                                                width: 24,
                                                height: 24,
                                                colorFilter:
                                                    const ColorFilter.mode(
                                                        Colors.white,
                                                        BlendMode.srcIn),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              child: LabelText(
                                title: 'Other Addresses',
                                size: 16,
                                weight: FontWeight.w500,
                                letterSpacing: 0.50,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.58,
                            child: ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ValueListenableBuilder(
                                  valueListenable: isDefaultNotifier,
                                  builder: (BuildContext context,
                                      bool isDefault, Widget? child) {
                                    return Column(
                                      children: [
                                        AddressCard(
                                          name: snapshot.data!.docs[index]
                                              ['name'],
                                          address: snapshot.data!.docs[index]
                                              ['address'],
                                          buttonText: 'Set as default',
                                          onEdit: () {
                                            AppsDialogs.showAppDialog(
                                              backgroundColor:
                                                  ThemeColors.backgroundColor(
                                                      context),
                                              context: context,
                                              content: CustomDialog(
                                                isOpenFromNutrition: false,
                                                nameController: _nameController,
                                                onSave: () async {
                                                  await EcommerceDbService
                                                      .updateUserAddress(
                                                    name: _nameController.text,
                                                    address:
                                                        _addressController.text,
                                                    documentId: snapshot
                                                        .data!.docs[index].id
                                                        .toString(),
                                                    isDefault: isDefault,
                                                  );
                                                  WidgetsBinding.instance
                                                      .addPostFrameCallback(
                                                          (timeStamp) {
                                                    Navigator.pop(context);
                                                  });
                                                },
                                                addressController:
                                                    _addressController,
                                              ),
                                            );
                                            _nameController.clear();
                                            _addressController.clear();
                                          },
                                          onDelete: () {
                                            EcommerceDbService
                                                .deleteUserAddress(
                                              snapshot.data!.docs[index].id
                                                  .toString(),
                                            );
                                          },
                                          onDefault: () {
                                            addressMetod();
                                            log('........${isDefaultNotifier.value}');
                                            EcommerceDbService
                                                .defaultUserAddress(
                                              documentId: snapshot
                                                  .data!.docs[index].id
                                                  .toString(),
                                              // isDefault:
                                              //     isDefaultNotifier.value,
                                            );
                                          },
                                        ),
                                        const SizedBox(height: 20),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    } else {
                      return const CupertinoActivityIndicator();
                    }
                  }),
            ),
          ]),
        ),
      ),
    );
  }
}
