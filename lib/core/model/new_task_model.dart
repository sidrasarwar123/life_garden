import 'task_category.dart';

class NewTaskModel {
  final String name;
  final TaskCategory? category;
  final DateTime date;
  final String? notes;
  final int estimatedCoins;

  const NewTaskModel({
    this.name = '',
    this.category,
    required this.date,
    this.notes,
    this.estimatedCoins = 50,
  });

  NewTaskModel copyWith({
    String? name,
    TaskCategory? category,
    DateTime? date,
    String? notes,
    int? estimatedCoins,
  }) {
    return NewTaskModel(
      name: name ?? this.name,
      category: category ?? this.category,
      date: date ?? this.date,
      notes: notes ?? this.notes,
      estimatedCoins: estimatedCoins ?? this.estimatedCoins,
    );
  }
}
