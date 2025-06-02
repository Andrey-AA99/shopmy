import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shopmy/data/repositories/authentication/authentication_repository.dart';

import '../../../features/shop/models/order_model.dart';

class OrderRepository extends GetxController{
  static OrderRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<OrderModel>> fetchUserOrders() async {
    try{
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if(userId.isEmpty) throw 'Не найдено информации о пользователе';
      final result = await _db.collection('Users').doc(userId).collection('Orders').get();
      return result.docs.map((documentSnapshot)=> OrderModel.fromSnapshot(documentSnapshot)).toList();
    }catch(e){
      throw 'Что то пошло не так при получении информации о заказах';
    }
  }

  Future<void> saveOrder(OrderModel order, String userId) async {
    try{
      await _db.collection('Users').doc(userId).collection('Orders').add(order.toJson());
    }catch(e){
      throw 'Что-то пошло не так при сохранении заказа';
    }
  }
}