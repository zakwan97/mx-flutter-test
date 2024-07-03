import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mx_flutter_test/constant/color.dart';
import 'package:mx_flutter_test/controller/product_controller.dart';
import 'package:mx_flutter_test/model/product_model.dart';
import 'package:mx_flutter_test/pages/product_search.dart';
import 'package:mx_flutter_test/shared/cart_button_shared.dart';
import 'package:mx_flutter_test/shared/keyboard_unfocus.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final ScrollController _controller = ScrollController();
  ProductController prodCon = Get.put(ProductController());
  String category = "";

  @override
  void initState() {
    super.initState();
    prodCon.getProductList();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardUnfocusFunction(
      child: Scaffold(
          appBar: AppBar(
            actions: const [CardButtonShared()],
          ),
          body: Obx(
            () {
              if (prodCon.isLoading.value) {
                return _buildLoadingScreen();
              } else if (prodCon.prodList.isEmpty) {
                return const Center(
                  child: Text("No items at the moment"),
                );
              } else {
                return Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.symmetric(vertical: 0.5.h),
                        child: const SearchProduct()),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButtonFormField<String>(
                        hint: const Text('Select Category'),
                        value: category,
                        onChanged: (value) {
                          prodCon.filterByCategory(value ?? '');
                        },
                        items: <String>[
                          '',
                          "men's clothing",
                          "women's clothing",
                          "electronics",
                          "jewelery",
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value.isEmpty ? 'All' : value),
                          );
                        }).toList(),
                        decoration: const InputDecoration(
                          fillColor: whiteColor,
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.all(2.1.w),
                          child: Column(
                            children: [
                              GridView.builder(
                                controller: _controller,
                                itemCount: _getListToDisplay().length,
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 20.0,
                                  crossAxisSpacing: 8.0,
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  var prodlist = _getListToDisplay()[index];
                                  return InkWell(
                                    onTap: () async {
                                      Get.toNamed('/product-details',
                                          arguments: prodlist.id);
                                    },
                                    child: Card(
                                      color: Colors.white,
                                      surfaceTintColor: Colors.white,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                bottom: 2.1.w, top: 2.1.w),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadiusDirectional
                                                      .circular(0),
                                              child: Image.network(
                                                prodlist.image ?? '',
                                                fit: BoxFit.fill,
                                                height: 10.h,
                                                width: 20.w,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            prodlist.title ?? 'No Name',
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SmoothStarRating(
                                              allowHalfRating: false,
                                              starCount: 5,
                                              rating:
                                                  prodlist.rating!.rate ?? 0,
                                              size: 20.0,
                                              color: Colors.amber,
                                              borderColor: Colors.amber,
                                              spacing: 0.0),
                                          Text(
                                            'RM${prodlist.price.toString()}',
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          )),
    );
  }

  Widget _buildLoadingScreen() {
    return const Center(
      child: CupertinoActivityIndicator(
        radius: 16.0,
        color: primaryColor,
      ),
    );
  }

  List<Product> _getListToDisplay() {
    if (prodCon.txtSearch.value.isNotEmpty) {
      return prodCon.searchProdList;
    } else if (prodCon.selectedCategory.value.isNotEmpty) {
      return prodCon.filteredProducts;
    } else {
      return prodCon.prodList;
    }
  }
}
