import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/components.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/utils/theme.dart';

class EcommerceOrderDetailPage extends StatefulWidget{
  final dynamic image;
  final dynamic name;
  final dynamic quantity;
  final dynamic price;
  const EcommerceOrderDetailPage({
    super.key,
    required this.image,
    required this.name,
    required this.quantity,
    required this.price,
  });

  @override
  State<EcommerceOrderDetailPage> createState() =>
      _EcommerceOrderDetailPageState();
}

class _EcommerceOrderDetailPageState extends State<EcommerceOrderDetailPage> {
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
          title: 'My Orders',
        ),
        // actions: [
        //   SvgPicture.asset(
        //     AppImage.seacrhIcon,
        //     width: 20,
        //     height: 20,
        //     colorFilter: ColorFilter.mode(
        //         ThemeColors.blackWhiteColor(context), BlendMode.srcIn),
        //   ),
        //   const SizedBox(width: 20),
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: CustomProductItem(
                  imageAsset: widget.image,
                  productName: widget.name,
                  quantity: 'Qty = ${widget.quantity ?? ' '}',
                  price: widget.price.toString(),
                  orderStatus: 'In-Progress',
                  trackOrderText: 'Track Order',
                  orderStatusColor: AppColors.colorDarkBkue,
                  onTapOrder: () {},
                ),
              ),
              const CustomSize(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Image.asset(AppImage.boxIcon),
                        Image.asset(AppImage.checkCircle)
                      ],
                    ),
                  ),
                  const CustomSize(
                    width: 10,
                  ),
                  Image.asset(
                    AppImage.dashLine,
                    color: AppColors.colorDarkBkue,
                  ),
                  Image.asset(
                    AppImage.dashLine,
                    color: AppColors.colorDarkBkue,
                  ),
                  const CustomSize(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Image.asset(AppImage.cargoIcon),
                        Image.asset(AppImage.checkCircle)
                      ],
                    ),
                  ),
                  const CustomSize(
                    width: 10,
                  ),
                  Image.asset(
                    AppImage.dashLine,
                    color: AppColors.dotedDark,
                  ),
                  Image.asset(
                    AppImage.dashLine,
                    color: AppColors.dotedDark,
                  ),
                  const CustomSize(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Image.asset(AppImage.mensIcon),
                        Image.asset(
                          AppImage.checkCircle,
                          color: AppColors.dotedDark,
                        )
                      ],
                    ),
                  ),
                  const CustomSize(
                    width: 10,
                  ),
                  Image.asset(
                    AppImage.dashLine,
                    color: AppColors.dotedDark,
                  ),
                  Image.asset(
                    AppImage.dashLine,
                    color: AppColors.dotedDark,
                  ),
                  const CustomSize(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Image.asset(AppImage.boxOpen),
                        Image.asset(
                          AppImage.checkCircle,
                          color: AppColors.dotedDark,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const CustomSize(
                height: 30,
              ),
              Align(
                alignment: Alignment.center,
                child: LabelText(
                  title: 'Order In Transit',
                  textAlignment: TextAlign.center,
                  color: ThemeColors.blackWhiteColor(context),
                  size: AppFonts.exmedium,
                  weight: FontWeight.w600,
                ),
              ),
              CustomDivider(
                thickness: 0.5,
                color: ThemeColors.blackWhiteColor(context),
                endIndent: 10,
                indent: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                child: LabelText(
                  title: 'Order Status Details',
                  color: ThemeColors.blackWhiteColor(context),
                  size: AppFonts.large,
                  weight: FontWeight.w700,
                ),
              ),
              _listTile(
                  imagePath: AppImage.dotLines,
                  title: 'Order In Transit - Dec 17',
                  labelColor: ThemeColors.blackWhiteColor(context),
                  subTitle: '32 Manchester Ave. Ringgold, GA 30736',
                  trailingText: '15:20 PM'),
              const CustomSize(
                height: 15,
              ),
              _listTile(
                  imagePath: AppImage.dotLines,
                  imageColor: AppColors.colorDarkBkue,
                  title: 'Order In Transit - Dec 17',
                  labelColor: ThemeColors.blackWhiteColor(context),
                  subTitle: '32 Manchester Ave. Ringgold, GA 30736',
                  trailingText: '15:20 PM'),
              const CustomSize(
                height: 15,
              ),
              _listTile(
                  imagePath: AppImage.dotLines,
                  imageColor: AppColors.colorDarkBkue,
                  title: 'Order In Transit - Dec 17',
                  labelColor: ThemeColors.blackWhiteColor(context),
                  subTitle: '32 Manchester Ave. Ringgold, GA 30736',
                  trailingText: '15:20 PM'),
              const CustomSize(
                height: 15,
              ),
              _listTile(
                  imagePath: AppImage.dotLines,
                  imageColor: AppColors.colorDarkBkue,
                  title: 'Order In Transit - Dec 17',
                  labelColor: ThemeColors.blackWhiteColor(context),
                  subTitle: '32 Manchester Ave. Ringgold, GA 30736',
                  trailingText: '15:20 PM'),
              const CustomSize(
                height: 15,
              ),
              SizedBox(
                height: 60,
                child: ListTile(
                  leading: Column(
                    children: [
                      Image.asset(
                        AppImage.greyBox,
                        color: AppColors.colorDarkBkue,
                        height: 29,
                        width: 29,
                      ),
                    ],
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: LabelText(
                      title: 'Order In Transit - Dec 17',
                      color: ThemeColors.blackWhiteColor(context),
                      size: AppFonts.small,
                      weight: FontWeight.w600,
                      letterSpacing: 0.20,
                    ),
                  ),
                  subtitle: const LabelText(
                    title: '32 Manchester Ave. Ringgold, GA 30736',
                    color: Color(0xFFE0E0E0),
                    size: AppFonts.extraSmall,
                    weight: FontWeight.w400,
                    letterSpacing: 0.20,
                  ),
                  trailing: const LabelText(
                    title: '15:20 PM',
                    color: Color(0xFFE0E0E0),
                    size: AppFonts.extraSmall,
                    weight: FontWeight.w500,
                    letterSpacing: 0.20,
                  ),
                ),
              ),
              const CustomSize(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _listTile(
      {Color? imageColor,
      Color? labelColor,
      String? imagePath,
      String? title,
      String? subTitle,
      String? trailingText}) {
    return ListTile(
      leading: Column(
        children: [
          Image.asset(
            AppImage.greyBox,
            color: imageColor,
            height: 29,
            width: 29,
          ),
          const CustomSize(
            height: 3,
          ),
          Image.asset(AppImage.dotLines, color: AppColors.colorGray),
        ],
      ),
      title: LabelText(
        title: '$title',
        color: labelColor,
        size: AppFonts.small,
        weight: FontWeight.w600,
        letterSpacing: 0.20,
      ),
      subtitle: LabelText(
        title: '$subTitle',
        color: AppColors.colorGray,
        size: AppFonts.extraSmall,
        weight: FontWeight.w400,
        letterSpacing: 0.20,
      ),
      trailing: LabelText(
        title: '$trailingText',
        color: AppColors.colorGray,
        size: AppFonts.extraSmall,
        weight: FontWeight.w500,
        letterSpacing: 0.20,
      ),
    );
  }
}
