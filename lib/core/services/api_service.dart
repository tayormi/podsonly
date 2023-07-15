import 'package:dio/dio.dart';
import 'package:podsonly/core/services/product_model.dart';

class APIService {
  Future<ProductModel> getItem() async {
    try {
      final dio = Dio();
      final response = await dio.get('https://dummyjson.com/products/1');
      final data = response.data;
      return ProductModel.fromJson(data);
    } catch (e) {
      throw 'Oops! Something went wrong. Contact the developer.';
    }
  }
}
