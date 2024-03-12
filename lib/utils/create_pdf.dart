import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_application_1/db_services/ecommerce_db_services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/constants/constants.dart';
import 'package:flutter_application_1/db_services/db_services.dart';
import 'package:flutter_application_1/models/ecommerce_models.dart';
// ignore: library_prefixes
import 'package:pdf/widgets.dart' as pdfLib;
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/widgets.dart' as pw;

Future<Uint8List> loadImageAsUint8List(String imagePath) async {
  ByteData data = await rootBundle.load(imagePath);
  return data.buffer.asUint8List();
}

Future<Uint8List> generatePDF(
  dynamic date,
  dynamic transactionId,
  dynamic paymentMethod,
  dynamic subTotal,
  dynamic deliveryFee,
  dynamic discount,
  dynamic total,
) async {
  final pdf = pw.Document();
  final List<CartProductModel> productData =
      await EcommerceDbService.getCartProduct();
  List<pw.Widget> listViewChildren = [];

  for (int index = 0; index < productData.length; index++) {
    http.Response response =
        await http.get(Uri.parse(productData[index].image));
    Uint8List imageData = response.bodyBytes;

    final image = pw.MemoryImage(imageData);

    listViewChildren.add(
      pw.Container(
          child: pw.Column(children: [
        pw.Row(
          children: [
            pw.Image(image, width: 100, height: 100),
            pw.SizedBox(width: 20),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'Product:  ${productData[index].name}',
                  style: const pw.TextStyle(
                    fontSize: AppFonts.exmedium,
                    letterSpacing: 1,
                  ),
                ),
                pw.Text(
                  'Quantity:  ${productData[index].quantity}',
                  style: const pw.TextStyle(
                    fontSize: AppFonts.exmedium,
                    letterSpacing: 1,
                  ),
                ),
                pw.Text(
                  'Price:  \$${productData[index].price.toString()}',
                  style: const pw.TextStyle(
                    fontSize: AppFonts.exmedium,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ],
        ),
        pw.SizedBox(height: 20),
      ])),
    );
  }

  final imageBytes = await loadImageAsUint8List(AppImage.appIcon);

  pdf.addPage(pw.MultiPage(
      build: (context) => [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Container(
                  alignment: pw.Alignment.topRight,
                  height: 70,
                 
                  child: pw.Image(pw.MemoryImage(imageBytes)),
                ),
                pw.SizedBox(height: 10),
                pw.Container(
                  alignment: pw.Alignment.topRight,
                  child: pw.Text(
                    'Cartify',
                    style: const pw.TextStyle(
                      fontSize: AppFonts.small,
                    ),
                  ),
                ),
                pw.SizedBox(height: 20),
                pw.Container(
                  alignment: pw.Alignment.center,
                  child: pw.Text(
                    'Transaction Successful',
                    style: pw.TextStyle(
                      fontWeight: pdfLib.FontWeight.bold,
                      fontSize: AppFonts.xxLarge,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Container(
                  alignment: pw.Alignment.center,
                  child: pw.Text(
                    'Date:  $date',
                    style: const pw.TextStyle(
                      fontSize: AppFonts.exmedium,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                pw.Container(
                  alignment: pw.Alignment.center,
                  child: pw.Text(
                    'Transaction id:  $transactionId',
                    style: const pw.TextStyle(
                      fontSize: AppFonts.exmedium,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                pw.SizedBox(height: 20),
                pw.Text(
                  'Product Details',
                  style: pw.TextStyle(
                    fontSize: AppFonts.exmedium,
                    fontWeight: pdfLib.FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                pw.SizedBox(height: 20),
                pw.Container(
                  child: pw.ListView(children: listViewChildren),
                ),
                pw.SizedBox(height: 20),
                pw.Text(
                  'Payment Details',
                  style: pw.TextStyle(
                    fontSize: AppFonts.exmedium,
                    fontWeight: pdfLib.FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Container(
                  child: pw.Padding(
                    padding: const pw.EdgeInsets.all(10),
                    child: pw.Column(
                      children: [
                        pw.SizedBox(height: 10),
                        CustomCartCalulations(
                          label: 'Payment method:',
                          value: paymentMethod,
                        ),
                        pw.SizedBox(height: 10),
                        CustomCartCalulations(
                          label: 'Sub total:',
                          value: subTotal.toString(),
                        ),
                        pw.SizedBox(height: 10),
                        CustomCartCalulations(
                          label: 'Delivery fee:',
                          value: deliveryFee.toString(),
                        ),
                        pw.SizedBox(height: 10),
                        CustomCartCalulations(
                          label: 'Discount:',
                          value: discount.toString(),
                        ),
                        pw.SizedBox(height: 10),
                        pw.Divider(),
                        CustomCartCalulations(
                          label: 'Total:',
                          value: total.toString(),
                          valueSize: AppFonts.large,
                        ),
                        pw.SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                pw.SizedBox(height: 20),
              ],
            )
          ]));

  final directory = await getTemporaryDirectory();
  final path = '${directory.path}/receipt.pdf';

  final file = File(path);
  await file.writeAsBytes(await pdf.save());

  OpenFile.open(file.path);

  return await file.readAsBytes();
}

Future<void> downloadPDF(
  date,
  transactionId,
  paymentMethod,
  subTotal,
  deliveryFee,
  discount,
  total,
) async {
  final Uint8List pdfData = await generatePDF(
    date,
    transactionId,
    paymentMethod,
    subTotal,
    deliveryFee,
    discount,
    total,
  );

  var status = await Permission.storage.request();
  if (status.isGranted) {
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
    if (selectedDirectory != null) {
      final file = File(
          "$selectedDirectory/${DateTime.now().millisecondsSinceEpoch}.pdf");
      await file.writeAsBytes(pdfData);
    }
  } else {
    log('permission deined');
  }
}

class CustomCartCalulations extends pdfLib.StatelessWidget {
  final String label;
  final String value;
  final double valueSize;

  CustomCartCalulations(
      {required this.label,
      required this.value,
      this.valueSize = AppFonts.small});

  @override
  pdfLib.Widget build(pdfLib.Context context) {
    return pdfLib.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pdfLib.Text(label),
        pdfLib.Text(
          value,
          style: pdfLib.TextStyle(
            fontSize: valueSize,
          ),
        ),
      ],
    );
  }
}
