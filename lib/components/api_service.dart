import 'package:dio/dio.dart';
import 'package:pks/components/products.dart';

class ApiService {
  final Dio _dio = Dio();


  Future<List<Product>> getProducts() async {
    try {
      final response = await _dio.get('http://192.168.104.108:8080/products');
      if (response.statusCode == 200) {
        List<Product> products = (response.data as List)
            .map((product) => Product.fromJson(product))
            .toList();
        return products;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }
}