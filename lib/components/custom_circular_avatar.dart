import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/db_services/db_services.dart';
import 'package:flutter_application_1/providers/providers.dart';
import 'package:provider/provider.dart';

class CustomProfileAvatar extends StatefulWidget {
  const CustomProfileAvatar({Key? key}) : super(key: key);

  @override
  State<CustomProfileAvatar> createState() => _CustomProfileAvatarState();
}

class _CustomProfileAvatarState extends State<CustomProfileAvatar> {
  late ImagePickerProvider imagePickerProvider;

  @override
  void initState() {
    super.initState();
    imagePickerProvider =
        Provider.of<ImagePickerProvider>(context, listen: false);
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      imagePickerProvider.setPath =
          AuthServices.getCurrentUser?.photoURL ?? AppImage.profile;
      log('......image${imagePickerProvider.path}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Consumer<ImagePickerProvider>(
        builder: (context, provider, child) {
          bool hasData = provider.path.startsWith('http');
          return Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: hasData
                      ? NetworkImage(provider.path) as ImageProvider<Object>
                      : const AssetImage(AppImage.profile),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
