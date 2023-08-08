import 'dart:async';

import 'package:database/utils/Database_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpenseController extends GetxController {
  RxString imgPath = "".obs;
  Uint8List? byte;
  RxList<Map> TransactionList = <Map>[].obs;
  RxString inClick = "".obs;
  RxString onclick = "".obs;
  RxString dropDown = "Income".obs;
  RxInt Income = 0.obs;
  RxInt Expense = 0.obs;
  RxInt total = 0.obs;

  // categories
  RxList categories = [
    "Salary",
    "Food an Dining",
    "Shopping",
    "Travelling",
    "Entertainment",
    "Medical",
    "Personal Care",
    "Education",
    "Bills and Utilities",
    "Investments",
    "Rent",
    "Taxes",
    "Insurance",
    "Gifts and Donation",
    "Coupans",
    "Sold items"
  ].obs;

  void changeCategory(String category) {
    inClick.value = category;
  }

  // Date Time
  var currentDateFrom = DateTime.now();
  var From = DateTime.now();
  RxInt fromDay = 0.obs;
  RxInt fromMonth = 0.obs;
  RxInt fromYear = 0.obs;

  void inch1() {
    currentDateTo = DateTime.now();
    currentDateFrom = DateTime.now();
    changeFromDate(currentDateFrom);
    changeToDate(currentDateTo);
  }

  void changeFromDate(From) {
    currentDateFrom = From;
    fromDay.value = currentDateFrom.day;
    fromMonth.value = currentDateFrom.month;
    fromYear.value = currentDateFrom.year;
    update();
  }

  var currentDateTo = DateTime.now();
  var To = DateTime.now();
  RxInt toDay = 0.obs;
  RxInt toMonth = 0.obs;
  RxInt toYear = 0.obs;

  void changeToDate(To) {
    currentDateTo = To;
    toDay.value = currentDateTo.day;
    toMonth.value = currentDateTo.month;
    toYear.value = currentDateTo.year;
    update();
  }

  RxInt day = 0.obs;
  RxInt mon = 0.obs;
  RxInt year = 0.obs;
  RxInt hour = 0.obs;
  RxInt minute = 0.obs;

  // Time
  var currentDate = DateTime.now();
  var date = DateTime.now();
  TimeOfDay currentTime = TimeOfDay.now();
  TimeOfDay time = TimeOfDay.now();

  void inch() {
    currentDate = DateTime.now();
    changeDate(currentDate);
  }

  void changeDate(date) {
    currentDate = date;
    day.value = currentDate.day;
    mon.value = currentDate.month;
    year.value = currentDate.year;
    update();
  }

  void changeTime(time) {
    currentTime = time;
    hour.value = currentTime.hour;
    minute.value = currentTime.minute;
    update();
  }

  RxList dataList = [].obs;

  Future<void> loadDB() async {
    dataList.value = await DB_helper.db_helper.readDB();
  }

  Future<void> getcate(String category) async {
    dataList.value = await DB_helper.db_helper.filter_cate(cate: category);
  }

  Future<void> filterRead({statusCode}) async {
    dataList.value = await DB_helper.db_helper.filterReadDB(statusCode);
  }

  Future<void> sumexpense(String status) async {
    Expense.value = await DB_helper.db_helper.getTotal(status);
  }

  Future<void> sumincome(String status) async {
    Income.value = await DB_helper.db_helper.getTotal(status);
  }
}
