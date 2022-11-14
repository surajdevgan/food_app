import 'package:get/get.dart';

class ItemDetailsController extends GetxController
{
  RxInt _quantityItem = 1.obs;
  RxInt _sizeItem = 0.obs;
  RxBool _isFavorite = false.obs;



  RxInt get quantityItem => _quantityItem;

  set quantityItem(RxInt value) {
    _quantityItem = value;
  }

  RxInt get sizeItem => _sizeItem;

  set sizeItem(RxInt value) {
    _sizeItem = value;
  }

  RxBool get isFavorite => _isFavorite;

  set isFavorite(RxBool value) {
    _isFavorite = value;
  }


  @override
  String toString() {
    return 'ItemDetailsController{_quantityItem: $_quantityItem, _sizeItem: $_sizeItem, _isFavorite: $_isFavorite}';
  }


}