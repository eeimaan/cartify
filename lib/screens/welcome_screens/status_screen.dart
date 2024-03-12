
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/db_services/db_services.dart';

late Size size;

class StatusScreen extends StatefulWidget {
  const StatusScreen({Key? key}) : super(key: key);

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //  Navigator.of(context).pushReplacementNamed(AppRoutes.startPage);
      checkUserDetails();
    });
  }

  void checkUserDetails() async {
    if (AuthServices.getCurrentUser != null) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.ecommercePage);
    } else {
      Navigator.of(context).pushReplacementNamed(AppRoutes.startPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return const Scaffold();
  }
}
