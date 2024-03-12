import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/providers/providers.dart';
import 'package:provider/provider.dart';

class CustomPaymentContainer extends StatelessWidget {
  final String label;
  final Widget? child;
  final String leadingImage;
  final int index;
  final VoidCallback ontap;
  final Color? color;

  const CustomPaymentContainer({
    Key? key,
    required this.label,
    this.child,
    required this.leadingImage,
    required this.index,
    this.color,
    required this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final iconColor = color ?? (isDarkMode ? Colors.white : Colors.black);
    final containerColor =
        isDarkMode ? AppColors.lightBlack : AppColors.lightwhite;
    final paymentProvider = Provider.of<PaymentProvider>(context);

    return GestureDetector(
      onTap: (){
        ontap();
         paymentProvider.setSelectedPaymentIndex(index);
      },
      child: Container(
        width: 400,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: containerColor,
        ),
        child: Row(
          children: [
            const SizedBox(width: 8),
            Image.asset(
              leadingImage,
              height: 54,
              width: 44,
              color: color,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: iconColor,
                fontSize: AppFonts.exmedium,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            Icon(
              paymentProvider.selectedPaymentIndex == index
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: paymentProvider.selectedPaymentIndex == index
                  ? AppColors.colorBlue
                  : Colors.grey,
              size: 24,
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}
