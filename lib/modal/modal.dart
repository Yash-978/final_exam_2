class ExpanseModal {
  String? title, amount, category,date;
  // DateTime? date;


  ExpanseModal({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  });

  factory ExpanseModal.fromJson(Map m1) {
    return ExpanseModal(
      title: m1['title'],
      amount: m1['amount'],
      date: m1['date'],
      category: m1['category'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'amount': amount,
      'category': category,
      'date': date,
    };
  }
}
