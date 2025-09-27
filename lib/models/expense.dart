import 'package:uuid/uuid.dart';

class Expense {
  final String id;
  final String title;
  final double amount;
  final String category;
  final DateTime date;
  final String? description;
  final String userId;

  Expense({
    String? id,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
    this.description,
    required this.userId,
  }) : id = id ?? const Uuid().v4();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'category': category,
      'date': date.toIso8601String(),
      'description': description,
      'userId': userId,
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      amount: (map['amount'] ?? 0.0).toDouble(),
      category: map['category'] ?? '',
      date: DateTime.parse(map['date'] ?? DateTime.now().toIso8601String()),
      description: map['description'],
      userId: map['userId'] ?? '',
    );
  }

  Expense copyWith({
    String? title,
    double? amount,
    String? category,
    DateTime? date,
    String? description,
    String? userId,
  }) {
    return Expense(
      id: id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      date: date ?? this.date,
      description: description ?? this.description,
      userId: userId ?? this.userId,
    );
  }
}
