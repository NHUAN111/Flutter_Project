class CategoryModel {
  final int categoryId;
  final String categoryName;
  final String categoryImg;
  final int categoryStatus;

  CategoryModel({
    required this.categoryId,
    required this.categoryName,
    required this.categoryImg,
    required this.categoryStatus,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      categoryId: json['category_id'],
      categoryName: json['category_name'],
      categoryImg: json['category_img'],
      categoryStatus: json['category_status'],
    );
  }
}
