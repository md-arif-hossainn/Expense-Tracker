import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
enum Category { food, travel, leisure, work, shopping, insurance, education }
final formatter = DateFormat.yMd();

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
  Category.shopping: Icons.shop,
  Category.insurance: Icons.money,
  Category.education: Icons.history_edu,
};

class ExpenseModel {
  late final int? id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  ExpenseModel({
    this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  });

  // Convert to JSON
  Map<String, Object?> toJson() => {
    'id': id,
    'title': title,
    'amount': amount,
    'date': date.toIso8601String(),
    'category': category.toString().split('.').last,
  };

  // Create from JSON
  factory ExpenseModel.fromJson(Map<String, Object?> json) => ExpenseModel(
    id: json['id'] as int?,
    title: json['title'] as String,
    amount: json['amount'] as double,
    date: DateTime.parse(json['date'] as String),
    category: Category.values.firstWhere(
          (e) => e.toString().split('.').last == json['category'],
      orElse: () => Category.food, // Default value in case of unknown category
    ),
  );

  // Copy with modifications
  ExpenseModel copy({
    int? id,
    String? title,
    double? amount,
    DateTime? date,
    Category? category,
  }) => ExpenseModel(
    id: id ?? this.id,
    title: title ?? this.title,
    amount: amount ?? this.amount,
    date: date ?? this.date,
    category: category ?? this.category,
  );
}


class ExpenseFields {
  static const String tableName = 'expense';
  static const String id = 'id';
  static const String title = 'title';
  static const String amount = 'amount';
  static const String date = 'date';
  static const String category = 'category';

  static const String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  static const String textType = 'TEXT NOT NULL';
  static const String realType = 'REAL NOT NULL';

  static const List<String> values = [
    id,
    title,
    amount,
    date,
    category
  ];
}



class ExpenseBucket {

  ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  ExpenseBucket.forCategory(List<ExpenseModel> allExpenses, this.category)
    : expenses = allExpenses
                     .where((expense) => expense.category == category).toList();

  final Category category;
  final List<ExpenseModel> expenses;

  double get totalExpenses {
    double sum = 0;
    for(final expense in expenses){
      sum += expense.amount;
    }
    return sum;
  }

}