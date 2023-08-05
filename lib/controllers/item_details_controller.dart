import 'package:get/get.dart';

class ItemDetailsController extends GetxController
{
  RxInt _quantityItem = 1.obs;
  RxInt _sizeItem = 0.obs;
  RxBool _isFavorite = false.obs;
  RxInt _priceItem = 0.obs;


  RxInt get priceItem => _priceItem;

  set priceItem(RxInt value) {
    _priceItem = value;
  }

  RxBool get isFavorite => _isFavorite;

  set isFavorite(RxBool value) {
    _isFavorite = value;
  }

  RxInt get sizeItem => _sizeItem;

  set sizeItem(RxInt value) {
    _sizeItem = value;
  }

  RxInt get quantityItem => _quantityItem;

  set quantityItem(RxInt value) {
    _quantityItem = value;
  }

  @override
  String toString() {
    return 'ItemDetailsController{_quantityItem: $_quantityItem, _sizeItem: $_sizeItem, _isFavorite: $_isFavorite, _priceItem: $_priceItem}';
  }
}