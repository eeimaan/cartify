import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/db_services/db_services.dart';
import 'package:flutter_application_1/models/ecommerce_models.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

class EcommerceDbService {
  static int calculateTotalQuantity(Box cartBox) {
    int totalQuantity = 0;

    for (var key in cartBox.keys) {
      var cartData = CartProductModel.fromJson(cartBox.get(key)!);
      totalQuantity += cartData.quantity;
    }

    return totalQuantity;
  }

  static Stream<List<AdminProductModel>> getEcommerceData() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    CollectionReference collectionReference =
        firestore.collection('admin').doc('ecommerce').collection('products');

    return collectionReference.snapshots().map((querySnapshot) {
      List<AdminProductModel> productList = [];
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        log("...................Data : ${doc.data()}");
        productList.add(
            AdminProductModel.fromJson(doc.data() as Map<String, dynamic>));
      }
      return productList;
    });
  }

  static Future<void> makeFavProduct({
    required String documentId,
  }) async {
    try {
      String? uid = FirebaseAuth.instance.currentUser?.uid;
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      DocumentReference documentref = firestore
          .collection('favourite_products')
          .doc(uid)
          .collection('products')
          .doc(documentId);

      await documentref.set({'item_id': documentId});
      //  log('favdoc$documentId');
    } catch (error) {
      if (error is FirebaseException) {
        log('FirebaseException occurred: $error');
      }
    }
  }

  static Future<List<String>> getFavDoc() async {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    CollectionReference collectionReference = firestore
        .collection('favourite_products')
        .doc(uid)
        .collection('products');

    QuerySnapshot snapshot = await collectionReference.get();
    List<String> docId = [];
    for (QueryDocumentSnapshot document in snapshot.docs) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;

      docId.add(data['item_id']);
    }
    return docId;
  }

  static Future<void> deleteFavProduct(String docId) async {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    DocumentReference docReference = firestore
        .collection('favourite_products')
        .doc(uid)
        .collection('products')
        .doc(docId);

    await docReference.delete();
  }

  static Stream<List<AdminProductModel>> getFavProduct() async* {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    CollectionReference favCollection = firestore
        .collection('favourite_products')
        .doc(uid)
        .collection('products');

    Stream<QuerySnapshot> favSnapshotStream = favCollection.snapshots();

    await for (QuerySnapshot favSnapshot in favSnapshotStream) {
      List<String> docIds = favSnapshot.docs.map((doc) => doc.id).toList();

      List<AdminProductModel> favProducts = [];

      for (String docId in docIds) {
        DocumentSnapshot productDoc = await firestore
            .collection('admin')
            .doc('ecommerce')
            .collection('products')
            .doc(docId)
            .get();

        if (productDoc.exists) {
          AdminProductModel product = AdminProductModel.fromJson(
              productDoc.data() as Map<String, dynamic>);
          favProducts.add(product);
        }
      }

      yield favProducts;
    }
  }

  static Future<void> addUserAddress({
    required String name,
    required String address,
    required bool isDefault,
  }) async {
    try {
      String? uid = FirebaseAuth.instance.currentUser?.uid;
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      CollectionReference reference =
          firestore.collection('user_profiles').doc(uid).collection('address');

      await reference.add({
        'name': name,
        'address': address,
        'default': isDefault,
      });
    } catch (error) {
      if (error is FirebaseException) {
        log('FirebaseException occurred: $error');
      }
    }
  }

  static Stream<QuerySnapshot> getUserAddress() {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    CollectionReference collectionReference =
        firestore.collection('user_profiles').doc(uid).collection('address');

    return collectionReference.snapshots();
  }

  static Future<void> updateUserAddress({
    required String name,
    required String address,
    required String documentId,
    required bool isDefault,
  }) async {
    try {
      String? uid = FirebaseAuth.instance.currentUser?.uid;
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      DocumentReference documentReference = firestore
          .collection('user_profiles')
          .doc(uid)
          .collection('address')
          .doc(documentId);

      await documentReference
          .set({'name': name, 'address': address, 'default': isDefault});
    } catch (error) {
      if (error is FirebaseException) {
        log('FirebaseException occurred: $error');
      }
    }
  }

  static Future<void> updateDefaultAddress({
    required String name,
    required String address,
  }) async {
    try {
      String? uid = FirebaseAuth.instance.currentUser?.uid;
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      QuerySnapshot querySnapshot = await firestore
          .collection('user_profiles')
          .doc(uid)
          .collection('address')
          .where('default', isEqualTo: true)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentReference docReference = querySnapshot.docs[0].reference;

        await docReference.update({'name': name, 'address': address});
      }
    } catch (error) {
      if (error is FirebaseException) {
        log('FirebaseException occurred: $error');
      }
    }
  }

  static Future<void> deleteUserAddress(String docId) async {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    DocumentReference docReference = firestore
        .collection('user_profiles')
        .doc(uid)
        .collection('address')
        .doc(docId);

    await docReference.delete();
  }

  static Future<void> deleteDefaultUserAddress() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('user_profiles')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('address')
        .where('default', isEqualTo: true)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentReference docReference = querySnapshot.docs[0].reference;

      await docReference.delete();
    }
  }

  static Future<String?> getDefaultAddress() async {
    try {
      String? uid = FirebaseAuth.instance.currentUser?.uid;
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      QuerySnapshot querySnapshot = await firestore
          .collection('user_profiles')
          .doc(uid)
          .collection('address')
          .where('default', isEqualTo: true)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first['address'] as String?;
      }
    } catch (error) {
      if (error is FirebaseException) {
        log('FirebaseException occurred: $error');
      }
    }
    return null;
  }

  static Future<void> defaultUserAddress({
    required String documentId,
  }) async {
    try {
      String? uid = FirebaseAuth.instance.currentUser?.uid;
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      CollectionReference addressCollection =
          firestore.collection('user_profiles').doc(uid).collection('address');

      WriteBatch batch = firestore.batch();

      QuerySnapshot allDocuments = await addressCollection.get();
      for (QueryDocumentSnapshot doc in allDocuments.docs) {
        batch.update(doc.reference, {'default': false});
      }

      DocumentReference documentReference = addressCollection.doc(documentId);
      batch.update(documentReference, {'default': true});

      await batch.commit();
    } catch (error) {
      if (error is FirebaseException) {
        log('FirebaseException occurred: $error');
      }
    }
  }

  static Stream<List<Reviews>> getReviews({required documentId}) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    CollectionReference<Map<String, dynamic>> collectionReference = firestore
        .collection('product_reviews')
        .doc(documentId)
        .collection('reviews');

    return collectionReference
        .snapshots()
        .map((QuerySnapshot<Map<String, dynamic>> snapshot) {
      List<Reviews> reviewsList = [];
      for (QueryDocumentSnapshot<Map<String, dynamic>> doc in snapshot.docs) {
        Reviews review = Reviews.fromJson(doc.data());
        reviewsList.add(review);
      }
      return reviewsList;
    });
  }
//  static Stream<Map<String, dynamic>> getReviewStats({required documentId}) {
//     FirebaseFirestore firestore = FirebaseFirestore.instance;

//     CollectionReference<Map<String, dynamic>> collectionReference = firestore
//         .collection('product_reviews')
//         .doc(documentId)
//         .collection('reviews');

//     return collectionReference
//         .snapshots()
//         .map((QuerySnapshot<Map<String, dynamic>> snapshot) {
//       List<Reviews> reviewsList = [];
//       double totalStars = 0;

//       for (QueryDocumentSnapshot<Map<String, dynamic>> doc in snapshot.docs) {
//         Reviews review = Reviews.fromJson(doc.data());
//         reviewsList.add(review);
//         totalStars += review.starsCount!;
//       }

//       int numberOfReviews = reviewsList.length;
//       double averageStars = numberOfReviews > 0 ? totalStars / numberOfReviews : 0.0;

//       return {'numberOfReviews': numberOfReviews, 'averageStars': averageStars};
//     });
//   }
  static Stream<QuerySnapshot<Object?>> productReviews({
    required Reviews reviewsModel,
    required String documentId,
  }) {
    try {
      CollectionReference collectionref = FirebaseFirestore.instance
          .collection('product_reviews')
          .doc(documentId)
          .collection('reviews');

      collectionref.add(reviewsModel.toJson());
      return collectionref.snapshots();
    } catch (error) {
      if (error is FirebaseException) {
        log('FirebaseException occurred: $error');
      }
    }
    return const Stream.empty();
  }

  static Future<void> orderProduct({
    required List<CartProductModel> data,
    required String transactionId,
    required String totalPrice,
    required String dateTime,
    required String address,
    required String status,
    required BuildContext context,
  }) async {
    try {
      String? uid = FirebaseAuth.instance.currentUser?.uid;
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      CollectionReference reference = firestore
          .collection('admin')
          .doc('ecommerce')
          .collection('orders')
          .doc(uid!)
          .collection('orders_detail');

      await reference.add({
        'order_items': data.map((e) => e.toJson()).toList(),
        'transaction_id': transactionId,
        'total_price': totalPrice,
        'date_time': dateTime,
        'address': address,
        'status': status,
        'order_id': const Uuid().v4()
      });
      log('uploaded data ');
    } catch (error) {
      if (error is FirebaseException) {
        log('FirebaseException occurred: $error');
      }
    }
  }

  static Future<List<ProductsModel>> getUserOrders() async {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    List<ProductsModel> orderDataList = [];
    CollectionReference<Map<String, dynamic>> collectionReference = firestore
        .collection('admin')
        .doc('ecommerce')
        .collection('orders')
        .doc(uid!)
        .collection('orders_detail');
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await collectionReference.get();
    log("...................Number of orders : ${querySnapshot.docs.length}");
    if (querySnapshot.docs.isNotEmpty) {
      for (var product in querySnapshot.docs) {
        orderDataList.add(ProductsModel.fromJson(product.data()));
      }
      log("..................orderDataList : $orderDataList");
      return orderDataList;
    } else {
      return orderDataList;
    }
  }

  // static Stream<List<ProductsModel>> getUserOrder() {
  //   String? uid = FirebaseAuth.instance.currentUser?.uid;
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //   List<ProductsModel> orderDataList = [];
  //   return firestore
  //       .collection('admin')
  //       .doc('ecommerce')
  //       .collection(uid!)
  //       .snapshots()
  //       .map((QuerySnapshot querySnapshot) {
  //     log("...................Number of orders : ${querySnapshot.docs.length}");
  //     if (querySnapshot.docs.isNotEmpty) {
  //       for (var product in querySnapshot.docs) {
  //         log("..................Orders : ${product.data() as Map<String, dynamic>}");
  //         orderDataList.add(
  //             ProductsModel.fromJson(product.data() as Map<String, dynamic>));
  //       }

  //       return orderDataList;
  //     } else {
  //       return orderDataList;
  //     }
  //   });
  // }

  static Stream<DocumentSnapshot> getdefaultAddress() {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    DocumentReference documentReference = firestore
        .collection('user_profiles')
        .doc(uid)
        .collection('address')
        .doc('default_address');
    log('delete doc');
    return documentReference.snapshots();
  }

  // static Future<void> userOrder({

  // }) async {
  //   try {
  //     String? uid = FirebaseAuth.instance.currentUser?.uid;
  //     FirebaseFirestore firestore = FirebaseFirestore.instance;

  //     DocumentReference documentReference = firestore
  //         .collection('users')
  //         .doc(uid)
  //         .collection('address')
  //         .doc('default_address');

  //     await documentReference.set({'name': name, 'address': address});
  //   } catch (error) {
  //     if (error is HttpException ||
  //         error is SocketException ||
  //         error is FormatException) {
  //       ErrorHandling.handleErrors(error: error);
  //     } else {
  //       rethrow;
  //     }
  //   }
  // }
  // static Future<QuerySnapshot<Object?>> getCartProductId() async {
  //   String? uid = FirebaseAuth.instance.currentUser?.uid;
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;

  //   CollectionReference collectionReference =
  //       firestore.collection('cart_product').doc(uid).collection('product');

  //   return await collectionReference.get();
  // }

  // static List<ProductModel> getCartProduct() {
  //   final Box<Map<String, dynamic>?> cartBox = Hive.box(name: 'cartbox');
  //   List<ProductModel> productList = [];

  //   for (var key in cartBox.keys) {
  //     var item = cartBox.get(key);
  //     if (item is Map<String, dynamic>) {
  //       ProductModel product = ProductModel.fromJson(item);
  //       productList.add(product);
  //     } else {
  //       log(" key $key: $item");
  //     }
  //   }

  //   return productList;
  // }

  static Future<List<CartProductModel>> getCartProduct() async {
    final Box<Map<String, dynamic>?> cartBox =
        Hive.box(name: '${AuthServices.getCurrentUser!.uid}cart');
    List<CartProductModel> productList = [];

    for (var key in cartBox.keys) {
      var item = cartBox.get(key);

      if (item is Map<String, dynamic>) {
        CartProductModel product = CartProductModel.fromJson(item);

        String productId = product.id;
        String? uid = FirebaseAuth.instance.currentUser?.uid;
        FirebaseFirestore firestore = FirebaseFirestore.instance;

        DocumentReference documentRef = firestore
            .collection('cart_products')
            .doc(uid)
            .collection('product')
            .doc(productId);
        if (key == documentRef.id) {
          DocumentReference adminDocumentRef = firestore
              .collection('admin')
              .doc('ecommerce')
              .collection('products')
              .doc(documentRef.id);
          log('id ..........${documentRef.id}');
         await adminDocumentRef.get().then((DocumentSnapshot documentSnapshot) {
            if (documentSnapshot.exists) {
              Map<String, dynamic> data =
                  documentSnapshot.data() as Map<String, dynamic>;
              log('data..........$data');
              AdminProductModel adminData = AdminProductModel.fromJson(data);

              product.deliveryFee = adminData.deliveryFee;
              product.price = adminData.price;
              product.image = adminData.image;
              product.name = adminData.name;
              product.discount = adminData.discount;
              productList.add(product);
                log('product list data..........$productList');
            } else {
              log('Document does not exist');
            }
          }).catchError((error) {
            log('Error fetching document: $error');
          });
        }
      } else {
        log("key $key: $item");
      }
    }
log ('.........return list$productList');
    return productList;
  }

  static Future<void> saveCartProductId({
    required String productId,
  }) async {
    try {
      String? uid = FirebaseAuth.instance.currentUser?.uid;
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      DocumentReference documentref = firestore
          .collection('cart_products')
          .doc(uid)
          .collection('product')
          .doc(productId);

      await documentref.set({'id': productId});
    } catch (error) {
      if (error is FirebaseException) {
        log('FirebaseException occurred: $error');
      }
    }
  }

  static Future<void> updateProductReview({
    required num review,
    required String documentId,
  }) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      DocumentReference documentReference = firestore
          .collection('admin')
          .doc('ecommerce')
          .collection("products")
          .doc(documentId);

      await documentReference.update({
        'reviews': review,
      });
      log('update $review');
    } catch (error) {
      if (error is FirebaseException) {
        log('FirebaseException occurred: $error');
      }
    }
  }
}

class CartValues {
  final int subtotal;
  final int delivery;
  final int discount;

  CartValues({
    required this.subtotal,
    required this.delivery,
    required this.discount,
  });
}

CartValues calculateCartValues(Box<Map<String, dynamic>?> cartBoxs) {
  int subtotal = 0;
  int delivery = 0;
  double discountPercentage = 0;

  for (var key in cartBoxs.keys) {
    var cartData = CartProductModel.fromJson(cartBoxs.get(key)!);

    int productSubtotal = cartData.price * cartData.quantity;
    int productDelivery = cartData.deliveryFee;
    int productDiscountPercentage = cartData.discount;

    subtotal += productSubtotal;
    delivery += productDelivery;
    discountPercentage += productDiscountPercentage;
  }

  double discountAmount = (subtotal * discountPercentage) / 100;

  return CartValues(
    subtotal: subtotal,
    delivery: delivery,
    discount: discountAmount.toInt(),
  );
}
