import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_application_1/components/components.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/db_services/auth_services.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/providers/providers.dart';
import 'package:flutter_application_1/utils/utils.dart';
import 'package:provider/provider.dart';
bool isToggleOn = false;
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late ImagePickerProvider imagePickerProvider;
  final ValueNotifier<bool> showIndicator = ValueNotifier<bool>(false);
  final ValueNotifier<bool> profileIndicator = ValueNotifier<bool>(false);
  final ValueNotifier<String> imagePathNotifier = ValueNotifier<String>('');

  @override
  void initState() {
    AuthServices.fetchCurrentUserDetails();

    super.initState();
    imagePickerProvider =
        Provider.of<ImagePickerProvider>(context, listen: false);
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      imagePathNotifier.value = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Navigator.of(context).pop();
           
          },
        ),
        title: const LabelText(
          weight: FontWeight.w600,
          size: AppFonts.extraLarge,
          letterSpacing: 0.50,
          title: AppText.profileTitle,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.colorDarkBkue,
                    width: 1,
                  ),
                ),
                padding: const EdgeInsets.all(5),
                child: ClipOval(
                  child: ValueListenableBuilder<String>(
                    valueListenable: imagePathNotifier,
                    builder: (context, imagePath, child) {
                      return SizedBox(
                        child: (imagePath.isEmpty &&
                                AuthServices.getCurrentUser?.photoURL == null)
                            ? const CircleAvatar(
                                backgroundImage: AssetImage(AppImage.profile),
                              )
                            : imagePath.isNotEmpty
                                ? Image.file(
                                    File(imagePath),
                                    fit: BoxFit.fitWidth,
                                    height: 152,
                                  )
                                : CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      AuthServices.getCurrentUser?.photoURL ??
                                          '',
                                    ),
                                  ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 5),
              ElevatedButton(
                  onPressed: () async {
                    AppsDialogs.showAppDialog(
                      backgroundColor: ThemeColors.backgroundColor(context),
                      context: context,
                      content: ImagePickDialog(
                        onGallery: () async {
                          imagePathNotifier.value =
                              (await AppImagePicker.getImageFromGallery())!;

                          if (imagePathNotifier.value.isNotEmpty) {
                            try {
                              await AuthServices.updateProfileImage(
                                File(imagePathNotifier.value),
                              );
                              imagePickerProvider.setPath =
                                  AuthServices.getCurrentUser?.photoURL ?? '';
                            } catch (e) {
                              log('Error updating profile image: $e');
                            } finally {
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                            }
                          }
                        },
                        onCamera: () async {
                          imagePathNotifier.value =
                              (await AppImagePicker.getImageFromCamera())!;
                          imagePickerProvider.setPath = imagePathNotifier.value;
                          if (imagePathNotifier.value.isNotEmpty) {
                            try {
                              await AuthServices.updateProfileImage(
                                File(imagePathNotifier.value),
                              );
                              imagePickerProvider.setPath =
                                  AuthServices.getCurrentUser?.photoURL ?? '';
                            } catch (e) {
                              log('Error updating profile image: $e');
                            } finally {
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                            }
                          }
                        },
                      ),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      ThemeColors.buttonColor(context),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                  child: const Text(AppText.editProfileButton)),
                    const SizedBox(height: 80),
              ListTile(
                  title: const Text(
                    AppText.notifications,
                    style: TextStyle(fontSize: AppFonts.medium),
                  ),
                  trailing: Transform.scale(
                    scale: 0.7,
                    child: CupertinoSwitch(
                      value: true,
                      onChanged: (value) {},
                      activeColor: AppColors.colorDarkBkue,
                      trackColor: AppColors.colorDarkBkue.withOpacity(0.5),
                    ),
                  )),
              const CustomDivider(color: Colors.grey),
            GestureDetector(
              onTap: () async {},
              child: ListTile(
                title: Text(
                  AppText.darkTheme,
                  style: TextStyle(
                    fontSize: AppFonts.exmedium,
                    color: ThemeColors.blackWhiteColor(context),
                  ),
                ),
                trailing: SizedBox(
                  child: Consumer<ThemeManager>(
                    builder: (context, themeManager, _) {
                      log('......................${themeManager.isDarkMode}');
                      return GestureDetector(
                        onTap: () async {
                          themeManager.toggleTheme();
                          isToggleOn = !isToggleOn;
                          pref.setBool('isToggleOn', isToggleOn);
                          //  log('$isToggleOn');
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: 45.0,
                          height: 25.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: themeManager.isDarkMode
                                ? AppColors.lightGray
                                : AppColors.lightwhite,
                          ),
                          child: Stack(
                            children: [
                              if (themeManager.isDarkMode)
                                const Positioned(
                                  left: 6.0,
                                  child:
                                      Icon(Icons.circle, color: Colors.yellow),
                                ),
                              if (!themeManager.isDarkMode)
                                Positioned(
                                  right: 6.0,
                                  top: 2,
                                  child: Transform.rotate(
                                    angle: 5.641592,
                                    child: const Icon(Icons.nightlight_round,
                                        color: Colors.black),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            
              const CustomDivider(color: Colors.grey),
              GestureDetector(
                onTapUp: (details) async {
                  showIndicator.value = true;

                  await AuthServices.signOutfirebase(context);

                  showIndicator.value = false;
                },
                child: ValueListenableBuilder(
                  valueListenable: showIndicator,
                  builder: (BuildContext context, bool value, Widget? child) {
                    return value
                        ? const CupertinoActivityIndicator()
                        : const ProfileListTile(
                            title: AppText.logOut,
                          );
                  },
                ),
              ),
              const CustomDivider(color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
