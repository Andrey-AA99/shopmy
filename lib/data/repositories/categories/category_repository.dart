import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shopmy/data/repositories/products/product_repository.dart';
import 'package:shopmy/features/shop/models/category_model.dart';
import 'package:shopmy/features/shop/models/product_model.dart';
import 'package:shopmy/utils/popops/loaders.dart';

import '../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';

class CategoryRepository extends GetxController{
  static CategoryRepository get instance => Get.find();


  final _db = FirebaseFirestore.instance;

  Future<List<CategoryModel>> getAllCategories() async {
    try{
      final snapshot = await _db.collection('Categories').get();
      final list = snapshot.docs.map((document)=> CategoryModel.fromSnapshot(document)).toList();

      return list;

    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } catch (e) {
      throw 'Что-то пошло не так. Попробуйте позже';
    }
  }

  Future<List<CategoryModel>> getSubCategories(String categoryId) async {
    try{
      final snapshot = await _db.collection('Categories').where('ParentId',isEqualTo: categoryId).get();
      final result = snapshot.docs.map((e)=> CategoryModel.fromSnapshot(e)).toList();
      return result;

    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } catch (e) {
      throw 'Что-то пошло не так. Попробуйте позже';
    }
  }

  Future<List<ProductModel>> getCategoryProducts({required String categoryId,int limit = 4}) async {
    try{
      final products = await ProductRepository.instance.getProductsForCategory(categoryId: categoryId,limit: limit);
      return products;
    }catch(e){
      TLoaders.errorSnackBar(title: 'Ой ошибка',message: e.toString());
      return [];
    }
  }




}