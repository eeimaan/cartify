// ignore_for_file: public_member_api_docs, sort_constructors_first
class CartProductModel {
  String image;
  String name;
  int price;
  int quantity;
  int discount;
  int deliveryFee;
  String id;

  CartProductModel({
    required this.image,
    required this.name,
    required this.price,
    required this.quantity,
    required this.discount,
    required this.deliveryFee,
    required this.id,
  });

  factory CartProductModel.fromJson(Map<String, dynamic> json) {
    return CartProductModel(
        image: json['image'],
        name: json['name'],
        price: json['price'],
        quantity: json['quantity'],
        discount: json['discount'],
        deliveryFee: json['delivery_fee'],
        id: json['id']);
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'name': name,
      'price': price,
      'quantity': quantity,
      'discount': discount,
      'id': id,
      'delivery_fee': deliveryFee
    };
  }

  @override
  String toString() {
    return 'ProductModel{image: $image, id: $id, name: $name, price: $price, quantity: $quantity , discount: $discount, delivery_fee: $deliveryFee}';
  }
}

class ProductsModel {
  String? dateTime;
  String? transactionId;
  String? orderId;
  String? address;
  String? totalPrice;
  List<Orders>? orders;
  String? status;

  ProductsModel(
      {this.dateTime,
      this.orderId,
      this.transactionId,
      this.address,
      this.totalPrice,
      this.orders,
      this.status});

  ProductsModel.fromJson(Map<String, dynamic> json) {
    dateTime = json['date_time'];
    transactionId = json['transaction_id'];
    address = json['address'];
    orderId = json['order_id'];
    totalPrice = json['total_price'];
    if (json['order_items'] != null) {
      orders = <Orders>[];
      json['order_items'].forEach((v) {
        orders!.add(Orders.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date_time'] = dateTime;
    data['transaction_id'] = transactionId;
    data['address'] = address;
    data['order_id'] = orderId;
    data['total_price'] = totalPrice;
    if (orders != null) {
      data['order_items'] = orders!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    return data;
  }
}

class Orders {
  int? deliveryFee;
  String? image;
  int? quantity;
  int? price;
  String? name;
  int? discount;
  String? id;

  Orders(
      {this.deliveryFee,
      this.image,
      this.quantity,
      this.price,
      this.name,
      this.discount,
      this.id});

  Orders.fromJson(Map<String, dynamic> json) {
    deliveryFee = json['delivery_fee'];
    image = json['image'];
    quantity = json['quantity'];
    price = json['price'];
    name = json['name'];
    discount = json['discount'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['delivery_fee'] = deliveryFee;
    data['image'] = image;
    data['quantity'] = quantity;
    data['price'] = price;
    data['name'] = name;
    data['discount'] = discount;
    data['id'] = id;
    return data;
  }
}

class Reviews {
  num? starsCount;
  String? userUid;
  String? review;
  String? dateTime;

  Reviews({
    required this.starsCount,
    required this.userUid,
    required this.review,
    required this.dateTime,
  });

  Reviews.fromJson(Map<String, dynamic> json) {
    starsCount = json['stars_count'];
    userUid = json['user_id'];

    review = json['review_message'];
    dateTime = json['date_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['stars_count'] = starsCount;
    data['user_id'] = userUid;

    data['review_message'] = review;
    data['date_time'] = dateTime;

    return data;
  }
}

class AdminProductModel {
  String image;
  String code;
  String name;
  int price;
  int discount;
  int deliveryFee;
  String id;
  String category;
  int soldCount;
  String description;

  AdminProductModel({
    required this.image,
    required this.code,
    required this.name,
    required this.price,
    required this.discount,
    required this.deliveryFee,
    required this.id,
    required this.category,
    required this.soldCount,
    required this.description,
  });

  factory AdminProductModel.fromJson(Map<String, dynamic> json) {
    return AdminProductModel(
      image: json['image_url'],
      name: json['title'],
      code: json['product_code'],
      price: json['price'],
      discount: json['discount'],
      deliveryFee: json['delivery_charges'],
      id: json['id'],
      category: json['category'],
      soldCount: json['sold_count'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image_url': image,
      'title': name,
      'product_code': code,
      'price': price,
      'discount': discount,
      'id': id,
      'delivery_charges': deliveryFee,
      'category': category,
      'sold_count': soldCount,
      'description': description,
    };
  }
}
