

class Cart{

  int _cart_id;
  int _user_id;
  int _item_id;
  int _item_quantity;
  String _item_size;
  double _item_total_price;

  String _item_name;
  double _item_rating;
  List<String> _item_tags;
  List<String> _item_prices;
  List<String> _item_sizes;
  String _item_description;
  String _item_image;


  Cart(
      this._cart_id,
      this._user_id,
      this._item_id,
      this._item_quantity,
      this._item_size,
      this._item_total_price,
      this._item_name,
      this._item_rating,
      this._item_tags,
      this._item_prices,
      this._item_sizes,
      this._item_description,
      this._item_image);


  int get cart_id => _cart_id;

  set cart_id(int value) {
    _cart_id = value;
  }


  int get user_id => _user_id;

  set user_id(int value) {
    _user_id = value;
  }

  int get item_id => _item_id;

  set item_id(int value) {
    _item_id = value;
  }

  int get item_quantity => _item_quantity;

  set item_quantity(int value) {
    _item_quantity = value;
  }

  String get item_size => _item_size;

  set item_size(String value) {
    _item_size = value;
  }

  double get item_total_price => _item_total_price;

  set item_total_price(double value) {
    _item_total_price = value;
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
    return 'Cart{_cart_id: $_cart_id, _user_id: $_user_id, _item_id: $_item_id, _item_quantity: $_item_quantity, _item_size: $_item_size, _item_total_price: $_item_total_price, _item_name: $_item_name, _item_rating: $_item_rating, _item_tags: $_item_tags, _item_prices: $_item_prices, _item_sizes: $_item_sizes, _item_description: $_item_description, _item_image: $_item_image}';
  }

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
    int.parse(json["cart_id"]),
    int.parse(json["user_id"]),
    int.parse(json["item_id"]),
    int.parse(json["item_quantity"]),
    json["item_size"],
    double.parse(json["item_total_price"]),
    json["item_name"],
    double.parse(json["item_rating"]),
    json["item_tags"].toString().split(", "),
    json["item_prices"].toString().trim().split(","),
    json["item_sizes"].toString().trim().split(","),
    json['item_description'],
    json['item_image'],
  );

}