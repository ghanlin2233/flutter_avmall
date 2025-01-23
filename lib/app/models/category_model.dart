class CategoryModel {
  CategoryModel({
    required this.result,
  });
  late final List<CategoryItemModel> result;

  CategoryModel.fromJson(Map<String, dynamic> json) {
    result = List.from(json['result'])
        .map((e) => CategoryItemModel.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['result'] = result.map((e) => e.toJson()).toList();
    return data;
  }
}

class CategoryItemModel {
  CategoryItemModel({
    required this.id,
    required this.title,
    required this.status,
    required this.pic,
    required this.pid,
    required this.sort,
    required this.isBest,
    required this.goProduct,
    required this.productId,
  });
  late final String id;
  late final String title;
  late final int? status;
  late final String pic;
  late final String pid;
  late final int? sort;
  late final int? isBest;
  late final int? goProduct;
  late final String? productId;

  CategoryItemModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    status = json['status'];
    pic = json['pic'];
    pid = json['pid'];
    if (json['sort'] is String) {
      sort = int.tryParse(json['sort']) ?? 0;
    } else if (json['sort'] is int) {
      sort = json['sort'];
    } else {
      sort = 0;
    }
    isBest = json['is_best'];
    goProduct = json['go_product'];
    productId = json['product_id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = id;
    data['title'] = title;
    data['status'] = status;
    data['pic'] = pic;
    data['pid'] = pid;
    data['sort'] = sort;
    data['is_best'] = isBest;
    data['go_product'] = goProduct;
    data['product_id'] = productId;
    return data;
  }
}
