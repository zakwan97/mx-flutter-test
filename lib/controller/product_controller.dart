import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mx_flutter_test/model/product_model.dart';
import 'package:mx_flutter_test/services/product_services.dart';

class ProductController extends GetxController {
  ProductServices prodServ = ProductServices();
  RxBool isLoading = true.obs;
  var prodList = <Product>[].obs;
  var searchProdList = <Product>[].obs;
  var filteredProducts = <Product>[].obs;
  var selectedCategory = ''.obs;

  //Search Module
  String id = '';
  var txtSearch = ''.obs;
  late TextEditingController searchController;

  //Assign to API
  @override
  void onInit() {
    super.onInit();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController = TextEditingController();
    super.dispose();
  }

  void settxtsearch(String val) {
    txtSearch.value = val;
    searchProdList.clear();
    filterCollect();
    update();
  }

  void setProducts(List<Product> products) {
    prodList.value = products;
    filteredProducts.value = products;
  }

  void filterByCategory(String category) {
    selectedCategory.value = category;
    if (category.isEmpty) {
      filteredProducts.value = prodList;
    } else {
      filteredProducts.value =
          prodList.where((product) => product.category == category).toList();
    }
  }

  void filterCollect() {
    for (int i = 0; i < prodList.length; i++) {
      if (prodList[i].title!.contains(txtSearch.value) ||
          prodList[i].title!.toLowerCase().contains(txtSearch.value)) {
        searchProdList.add(prodList[i]);
      }
    }
  }

  Future<void> getProductList() async {
    isLoading.value = true;
    prodList.value = await prodServ.getProductList();
    isLoading.value = false;
    update();
  }
}
