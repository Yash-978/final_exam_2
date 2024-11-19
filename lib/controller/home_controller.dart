import 'package:final_exam_2/modal/modal.dart';
import 'package:final_exam_2/service/database_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var txtTitle = TextEditingController();
  var txtAmount = TextEditingController();
  var txtDate = TextEditingController();
  var txtCategory = TextEditingController();

  // List<ExpanseModal> expanseList = <ExpanseModal>[].obs;
  List expanseList = [];

  Future<void> initDatabase() async {
    await DbHelper.dbHelper.createDatabase();
  }

  void clearField() {
    txtAmount.clear();
    txtCategory.clear();
    txtTitle.clear();
    txtDate.clear();
  }

  Future<List<Map<String, Object?>>> readDataDatabase() async {
    return expanseList = await DbHelper.dbHelper.readData();
  }

  List<ExpanseModal> searchListCategory = [];
  List searchList = [];
  String search = '';

  void getSearch(String value) {
    search = value;
    getCategoryExpense();
  }

  Future<List<Map<String, Object?>>> getCategoryExpense() async {
    return searchList = await DbHelper.dbHelper.searchByCategory(search);
  }

  HomeController() {
    initDatabase();
  }
}

