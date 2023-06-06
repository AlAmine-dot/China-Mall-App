import 'dart:convert';
import 'dart:developer';

import 'package:lumia_app/feature_store/data/remote/api/store_api.dart';
import 'package:lumia_app/feature_store/data/remote/dto/product_dto.dart';
import 'package:lumia_app/feature_store/data/remote/dto/product_store_dto.dart';
import 'package:http/http.dart' as http;

import '../../exceptions/store_api_exception.dart';
import '../dto/category_dto.dart';



class StoreApiImpl extends StoreApi{

  @override
  Future<List<String>> getAllCategories() async {
    var url = Uri.parse("${StoreApi.API_BASE_URL}/categories");
    var response = await http.get(url);

    try {
      if(response.statusCode == 200){
        var jsonString = jsonDecode(response.body);
        return categoryDtoFromJson(jsonString);
      }else {
        throw StoreApiException("An unexpected error has occurred in getAllCategories");
      }
    }catch(e, stackTrace){
      log('An error has occured in getAllCategories : $e\n$stackTrace');
      throw StoreApiException("An error has occurred in getAllCategories");
    }

  }

  @override
  Future<ProductStoreDto> getProducts(int limit, int skip) async {
    var url = Uri.parse("${StoreApi.API_BASE_URL}/products?limit=$limit&skip=$skip");
    var response = await http.get(url);

    try {
      if (response.statusCode == 200) {
        var jsonString = jsonDecode(response.body);
        return productStoreDtoFromJson(jsonString);
      } else {
        throw StoreApiException("An unexpected error has occurred in getProducts");
      }
    } catch (e, stackTrace) {
      log('An error has occurred in getProducts: $e\n$stackTrace');
      throw StoreApiException("An error has occurred in getProducts: $e\n$stackTrace");
    }
  }


  @override
  Future<ProductStoreDto> getProductsByCategory(String categoryName, int limit, int skip) async {
    var url = Uri.parse("${StoreApi.API_BASE_URL}/category/$categoryName?limit=$limit&skip=$skip");
    var response = await http.get(url);

    try {
      if (response.statusCode == 200) {
        // var jsonString = jsonDecode(response.body);
        String jsonString = response.body;
        return productStoreDtoFromJson(jsonString);
      } else {
        throw StoreApiException("An unexpected error has occurred in getProductsByCategory for this request : \n"
            "${url}"
        );
      }
    } catch (e, stackTrace) {
      log('An error has occurred in getProductsByCategory: $e\n$stackTrace');
      throw StoreApiException("An error has occurred in getProductsByCategory: $e\n$stackTrace");
    }
  }

  @override
  Future<ProductDto> getSingleProductById(int productId) async {
    var url = Uri.parse("${StoreApi.API_BASE_URL}/products/$productId");
    var response = await http.get(url);

    try {
      if (response.statusCode == 200) {
        var jsonString = jsonDecode(response.body);
        return productDtoFromJson(jsonString);
      } else {
        throw StoreApiException("An unexpected error has occurred in getSingleProductById");
      }
    } catch (e, stackTrace) {
      log('An error has occurred in getSingleProductById: $e\n$stackTrace');
      throw StoreApiException("An error has occurred in getSingleProductById: $e\n$stackTrace");
    }
  }

  @override
  Future<ProductStoreDto> searchProductsByName(String queryString, int limit, int skip) async {
    var url = Uri.parse("${StoreApi.API_BASE_URL}/products/search?q=$queryString&limit=$limit&skip=$skip");
    var response = await http.get(url);

    try {
      if (response.statusCode == 200) {
        var jsonString = jsonDecode(response.body);
        return productStoreDtoFromJson(jsonString);
      } else {
        throw StoreApiException("An unexpected error has occurred in searchProductsByName");
      }
    } catch (e, stackTrace) {
      log('An error has occurred in searchProductsByName: $e\n$stackTrace');
      throw StoreApiException("An error has occurred in searchProductsByName: $e\n$stackTrace");
    }
  }

}