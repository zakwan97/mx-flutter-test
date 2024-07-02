import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mx_flutter_test/controller/product_controller.dart';
import 'package:sizer/sizer.dart';

class SearchProduct extends StatelessWidget {
  const SearchProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(builder: (prod) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 4.2.w),
        height: 48,
        child: CupertinoSearchTextField(
          borderRadius: BorderRadius.circular(16),
          placeholder: 'Search Product',
          controller: prod.searchController,
          onChanged: (val) {
            prod.settxtsearch(val);
          },
        ),
      );
    });
  }
}
