import 'package:flutter_ecom_admin/models/models.dart';
import 'package:flutter_ecom_admin/services/database_service.dart';
import 'package:get/get.dart';

class OrderStatsController extends GetxController{
  final DatabaseService database = DatabaseService();

  var stats = Future.value(<OrderStats>[]).obs;

  @override
  void onInit(){
    stats.value = database.getOrderStats();
    super.onInit();
  }
}