class ProductData {
  final String imagePath;
  final String label;
  final String price;

  ProductData({
    required this.imagePath,
    required this.label,
    required this.price,
  });
}

class ReviewItem {
  final String imagePath;
  final String name;
  final int rating;
  final String description;
  final String likeImagePath;
  final int likes;
  final String date;

  ReviewItem({
    required this.imagePath,
    required this.name,
    required this.rating,
    required this.description,
    required this.likeImagePath,
    required this.likes,
    required this.date,
  });
}
