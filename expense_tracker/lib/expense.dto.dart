class ExpenseDto {
  final int id;
  final String category;
  final DateTime date;
  final double amount;

  ExpenseDto(
      {this.id = 0,
      required this.category,
      required this.date,
      required this.amount});

  factory ExpenseDto.fromMap(Map<String, dynamic> map) {
    return ExpenseDto(
      id: map['id'],
      category: map['title'],
      date: map['description'],
      amount: map['amount'],
    );
  }

  toMap() {
    return {
      "id": id,
      "category": category,
      "date": date,
      "amount": amount,
    };
  }

  static List<ExpenseDto> fromList(List values) {
    return values.map((e) => ExpenseDto.fromMap(e)).toList();
  }
}
