import 'package:dio/dio.dart';
import 'package:pks/components/products.dart';

class ApiService {
  final Dio _dio = Dio();


  Future<List<Product>> getProducts() async {
    try {
      final response = await _dio.get('http://192.168.1.5:8080/products'); // Для основы http://192.168.104.176:8080/products
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
  //Добавление товара
  Future<void> createProduct(Product product) async {
    try {
      final response = await _dio.post(
        'http://192.168.1.5:8080/products/create',
        data: product.toJson(),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to create product');
      }
    } catch (e) {
      throw Exception('Error creating product: $e');
    }
  }
  //Обновление товара
  Future<void> updateProduct(int id, Product product) async {
    try {
      final response = await _dio.put(
        'http://192.168.1.5:8080/products/update/$id',
        data: product.toJson(),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to update product');
      }
    } catch (e) {
      throw Exception('Error updating product: $e');
    }
  }
  //Удаление товара
  Future<void> deleteProduct(int id) async {
    try {
      final response = await _dio.delete(
        'http://192.168.1.5:8080/products/delete/$id',
      );
      if (response.statusCode != 204) {
        throw Exception('Failed to delete product');
      }
    } catch (e) {
      throw Exception('Error deleting product: $e');
    }
  }
}