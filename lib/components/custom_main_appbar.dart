import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/components.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/providers/providers.dart';
import 'package:flutter_application_1/utils/utils.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  final String greetings;

  final Widget leading;
  final Color? backgroundColor;
  final List<Widget>? actions;

  const AppBarCustom({
    Key? key,
    this.backgroundColor,
    required this.greetings,
    required this.leading,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      forceMaterialTransparency: true,
      leading: leading,
      titleSpacing: 0,
      title: Text(
        greetings,
        style: const TextStyle(
          fontSize: AppFonts.medium,
          color: AppColors.colorDarkBkue,
        ),
      ),
      actions: actions,
      backgroundColor: backgroundColor,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  final TextEditingController searchFieldController;
  // final VoidCallback onRemoveTap;
  const SearchAppBar({
    Key? key,
    required this.searchFieldController,
  }) : super(key: key);

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

late SearchProvider searchProvider;

class _SearchAppBarState extends State<SearchAppBar> {
  @override
  void initState() {
    searchProvider = Provider.of<SearchProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return AppBar(
      forceMaterialTransparency: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        color: ThemeColors.blackWhiteColor(context),
        onPressed: () {
          searchProvider.toggleSearch();
        },
      ),
      titleSpacing: 0,
      title: TextFieldWidget(
        height: 40,
        maxLines: 8,
        controller: widget.searchFieldController,
        hintText: AppText.searchHintText,
        isDarkMode: isDarkMode,

        // suffixIcon: widget.searchFieldController.text.isNotEmpty
        //     ? const Icon(Icons.remove, size: 10)
        //     : null,
        // suffixIcon: const Icon(Icons.remove, size: 10),
        // onsuffixTap:  Widget.onRemoveTap,
      ),
      actions: [
        const SizedBox(width: 10),
        SvgPicture.asset(
          AppImage.seacrhIcon,
          colorFilter: ColorFilter.mode(
              ThemeColors.blackWhiteColor(context), BlendMode.srcIn),
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}
