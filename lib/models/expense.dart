import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
enum Category {food, travel, leisure, work, shopping, insurance,education,}
final formatter = DateFormat.yMd();

const categoryIcons = {
  Category.food:Icons.lunch_dining,
  Category.travel:Icons.flight_takeoff,
  Category.leisure:Icons.movie,
  Category.work:Icons.work,
  Category.shopping:Icons.shop,
  Category.insurance:Icons.money,
  Category.education:Icons.history_edu,
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }): id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formatterDate {
    return formatter.format(date);

  }



}