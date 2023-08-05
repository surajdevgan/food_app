class Item
{
 int _item_id;
 String _item_name;
 double _item_rating;
 List<String> _item_tags;
 List<String> _item_prices;
 List<String> _item_sizes;
 String _item_description;
 String _item_image;


 Item(
      this._item_id,
      this._item_name,
      this._item_rating,
      this._item_tags,
      this._item_prices,
      this._item_sizes,
      this._item_description,
      this._item_image);


 int get item_id => _item_id;

  set item_id(int value) {
    _item_id = value;
  }


 String get item_name => _item_name;

  set item_name(String value) {
    _item_name = value;
  }

 double get item_rating => _item_rating;

  set item_rating(double value) {
    _item_rating = value;
  }

 List<String> get item_tags => _item_tags;

  set item_tags(List<String> value) {
    _item_tags = value;
  }

 List<String> get item_prices => _item_prices;

  set item_prices(List<String> value) {
    _item_prices = value;
  }

 List<String> get item_sizes => _item_sizes;

  set item_sizes(List<String> value) {
    _item_sizes = value;
  }

 String get item_description => _item_description;

  set item_description(String value) {
    _item_description = value;
  }

 String get item_image => _item_image;

  set item_image(String value) {
    _item_image = value;
  }


 @override
  String toString() {
    return 'Item{_item_id: $_item_id, _item_name: $_item_name, _item_rating: $_item_rating, _item_tags: $_item_tags, _item_prices: $_item_prices, _item_sizes: $_item_sizes, _item_description: $_item_description, _item_image: $_item_image}';
 }

  factory Item.fromJson(Map<String, dynamic> json) => Item(
   int.parse(json["item_id"]),
   json["item_name"],
   double.parse(json["item_rating"]),
   json["item_tags"].toString().trim().split(","),
   json["item_prices"].toString().trim().split(","),
   json["item_sizes"].toString().trim().split(","),
   json['item_description'],
   json['item_image'],
 );

}
