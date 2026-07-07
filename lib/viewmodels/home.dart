class BannerItem {
  String id;
  String imgUrl;
  BannerItem({required this.id, required this.imgUrl});

  factory BannerItem.fromJSON(Map<String, dynamic> json) {
    return BannerItem(id: json["id"], imgUrl: json["imgUrl"]);
  }
}

// 根据json编写分类列表的class对象和工厂转换函数，将json转换为CategoryItem对象列表
/// 分类列表
class CategoryItem {
  String id;
  String name;
  String picture;
  List<CategoryItem>? children;

  CategoryItem({
    required this.id,
    required this.name,
    required this.picture,
    this.children,
  });

  // 扩展工厂函数，将json转换为CategoryItem对象列表
  factory CategoryItem.fromJson(Map<String, dynamic> json) {
    List<CategoryItem>? childList;
    if (json["children"] != null) {
      final List<dynamic> childJson = json["children"];
      childList = childJson
          .map((e) => CategoryItem.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    return CategoryItem(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      picture: json["picture"] ?? "",
      children: childList,
    );
  }
}

class GoodsItem {
  String id;
  String name;
  String? desc;
  String price;
  String picture;
  int orderNum;

  GoodsItem({
    required this.id,
    required this.name,
    this.desc,
    required this.price,
    required this.picture,
    required this.orderNum,
  });

  factory GoodsItem.fromJson(Map<String, dynamic> json) {
    return GoodsItem(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      desc: json["desc"],
      price: json["price"] ?? "",
      picture: json["picture"] ?? "",
      orderNum: json["orderNum"] ?? 0,
    );
  }
}

class GoodsItems {
  int counts;
  int pageSize;
  int pages;
  int page;
  List<GoodsItem> items;

  GoodsItems({
    required this.counts,
    required this.pageSize,
    required this.pages,
    required this.page,
    required this.items,
  });

  factory GoodsItems.fromJson(Map<String, dynamic> json) {
    final List<dynamic> itemsJson = json["items"] ?? [];
    final List<GoodsItem> items = itemsJson
        .map((e) => GoodsItem.fromJson(e as Map<String, dynamic>))
        .toList();
    return GoodsItems(
      counts: json["counts"] ?? 0,
      pageSize: json["pageSize"] ?? 0,
      pages: json["pages"] ?? 0,
      page: json["page"] ?? 0,
      items: items,
    );
  }
}

class SubType {
  String id;
  String title;
  GoodsItems goodsItems;

  SubType({required this.id, required this.title, required this.goodsItems});

  factory SubType.fromJson(Map<String, dynamic> json) {
    return SubType(
      id: json["id"] ?? "",
      title: json["title"] ?? "",
      goodsItems: GoodsItems.fromJson(
        json["goodsItems"] as Map<String, dynamic>,
      ),
    );
  }
}

class SpecialRecommendResult {
  String id;
  String title;
  List<SubType> subTypes;

  SpecialRecommendResult({
    required this.id,
    required this.title,
    required this.subTypes,
  });

  factory SpecialRecommendResult.fromJson(Map<String, dynamic> json) {
    final List<dynamic> subTypesJson = json["subTypes"] ?? [];
    final List<SubType> subTypes = subTypesJson
        .map((e) => SubType.fromJson(e as Map<String, dynamic>))
        .toList();
    return SpecialRecommendResult(
      id: json["id"] ?? "",
      title: json["title"] ?? "",
      subTypes: subTypes,
    );
  }
}

class GoodDetailItem extends GoodsItem {
  int payCount = 0;

  /// 商品详情项
  GoodDetailItem({
    required super.id,
    required super.name,
    required super.price,
    required super.picture,
    required super.orderNum,
    required this.payCount,
  }) : super(desc: "");
  // 转化方法
  factory GoodDetailItem.formJSON(Map<String, dynamic> json) {
    return GoodDetailItem(
      id: json["id"]?.toString() ?? "",
      name: json["name"]?.toString() ?? "",
      price: json["price"]?.toString() ?? "",
      picture: json["picture"]?.toString() ?? "",
      orderNum: int.tryParse(json["orderNum"]?.toString() ?? "0") ?? 0,
      payCount: int.tryParse(json["payCount"]?.toString() ?? "0") ?? 0,
    );
  }
}

class GoodsDetailsItems {
  int counts;
  int pageSize;
  int pages;
  int page;
  List<GoodDetailItem> items;

  GoodsDetailsItems({
    required this.counts,
    required this.pageSize,
    required this.pages,
    required this.page,
    required this.items,
  });

  factory GoodsDetailsItems.fromJson(Map<String, dynamic> json) {
    final List<dynamic> itemsJson = json["items"] ?? [];
    final List<GoodDetailItem> items = itemsJson
        .map((e) => GoodDetailItem.formJSON(e as Map<String, dynamic>))
        .toList();
    return GoodsDetailsItems(
      counts: json["counts"] ?? 0,
      pageSize: json["pageSize"] ?? 0,
      pages: json["pages"] ?? 0,
      page: json["page"] ?? 0,
      items: items,
    );
  }
}
