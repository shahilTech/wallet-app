class CategoryModel {
  int? categoryId;
  final String categoryName;

  CategoryModel({
    required this.categoryName,
    this.categoryId,
  });

  static CategoryModel fromMap(Map<String, Object?> map) {
    final id = map['category_id'] as int;
    final name = map['category_name'] as String;

    return CategoryModel(
      categoryName: name,
      categoryId: id,
    );
  }
}
