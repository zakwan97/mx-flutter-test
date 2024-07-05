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
  var productById = Product().obs;

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
    filterCollect();
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
    filterCollect();
  }

  void filterCollect() {
    searchProdList.clear();
    List<Product> categoryFilteredList = selectedCategory.value.isEmpty
        ? prodList
        : prodList
            .where((product) => product.category == selectedCategory.value)
            .toList();

    for (int i = 0; i < categoryFilteredList.length; i++) {
      if (categoryFilteredList[i].title!.contains(txtSearch.value) ||
          categoryFilteredList[i]
              .title!
              .toLowerCase()
              .contains(txtSearch.value)) {
        searchProdList.add(categoryFilteredList[i]);
      }
    }
    update();
  }

  Future<void> getProductList() async {
    isLoading.value = true;
    prodList.value = await prodServ.getProductList();
    isLoading.value = false;
    update();
  }

  Future<void> getProductById(int id) async {
    final Product? response = await prodServ.getProductbyID(id);
    productById.value = response!;
    update();
  }
}
