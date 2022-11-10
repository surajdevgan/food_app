class Item
{
  int? item_id;
  String? item_name;
  double? item_rating;
  List<String>? item_tags;
  double? item_price;
  List<String>? item_size;
  String? item_description;
  String? item_image;

  Item({
    this.item_id,
    this.item_name,
    this.item_rating,
    this.item_tags,
    this.item_price,
    this.item_size,
    this.item_description,
    this.item_image,
  });

  // In " " we have to use the same column name as in Database
  factory Item.fromJson(Map<String, dynamic> json) => Item(
    item_id: int.parse(json["item_id"]),
    item_name: json["item_name"],
    item_rating: double.parse(json["item_rating"]),
    item_tags: json["item_tags"].toString().split(", "),
    item_price: double.parse(json["item_price"]),
    item_size: json["item_size"].toString().split(", "),
    item_description: json['item_description'],
    item_image: json['item_image'],
  );
}