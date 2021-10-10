import 'package:get/get.dart';
import 'package:wasthu/Screens/Pages/show-product.dart';

class CartController extends GetxController {
  var _products = {}.obs;

  void addProduct(ShowProduct product) {
    if (_products.containsKey(product)) {
      _products[product] += 1;
    } else {
      _products[product] = 1;
      // this adds a product
    }
  }
}
