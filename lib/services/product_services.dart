import 'package:dio/dio.dart';
import 'package:mx_flutter_test/constant/url_link.dart';
import 'package:mx_flutter_test/model/product_model.dart';

class ProductServices {
  final Dio dio = Dio();
  final UrlLink urlLink = UrlLink();

  Future getProductList() async {
    try {
      final response = await Dio().get(
        '${urlLink.maintUrl}${urlLink.getProduct}',
        // data: {'id': id},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        if (response.data == null) {
          return null;
        } else {
          List<dynamic> jsonResponse = response.data;
          List<Product> productList =
              jsonResponse.map((item) => Product.fromJson(item)).toList();
          return productList;
        }
      } else {
        throw Exception(
            'Failed to fetch product list request: ${response.statusCode}');
      }
    } on DioError catch (e) {
      if (e.response != null) {
        throw Exception(
            'Error response data: ${e.response?.data}, Error response status: ${e.response?.statusCode}, Error occurred while fetch product list request: ${e.message}');
      } else {
        throw Exception(
            'Error request: ${e.requestOptions}, Error message: ${e.message}, An unknown error occurred: ${e.requestOptions.toString()}');
      }
    } catch (e) {
      throw Exception('An unknown error occurred: ${e.toString()}');
    }
  }
}
