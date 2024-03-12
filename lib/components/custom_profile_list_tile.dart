import 'package:flutter/material.dart';
import '../constants/constants.dart';

class ProfileListTile extends StatelessWidget {
  final String title;
  final IconData? iconData;

  const ProfileListTile({
    Key? key,
    required this.title,
    this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white : Colors.black;

    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 20, bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: AppFonts.exmedium,
                color: title == 'Log Out' ? AppColors.colorDarkBkue : textColor,
              ),
            ),
          ),
          GestureDetector(
            child: Icon(
              iconData,
              color: textColor,
              size: 16,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}
