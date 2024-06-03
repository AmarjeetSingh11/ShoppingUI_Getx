import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ProductController extends GetxController {
  RxBool isLoading = true.obs;
  RxList<ProductList> productData = <ProductList>[].obs;
  List<ProductList> cardItem = <ProductList>[].obs;

  addtoCard(ProductList item){
    cardItem.add(item);
  }

  double get totalPrice => cardItem.fold(0, (sum, item) => sum + item.price!.toDouble());
  int get count => cardItem.length;


  @override
  void onInit() {
    super.onInit();
    fetchProduct();
  }

  fetchProduct() async {
    try {
      var response = await http.get(Uri.parse('https://fakestoreapi.com/products'));
      if (response.body.isEmpty) {
        isLoading(true);
        Get.snackbar("No Product", "In this API Response No Data");
      } else {
        List<ProductList> productList = productListFromJson(response.body);
        productData.value = productList;
        isLoading(false);
      }
    } catch (e) {
      isLoading(false);
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
