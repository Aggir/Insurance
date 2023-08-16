class MetaModel {
  int? currentPage;
  int? from;
  int? lastPage;

  MetaModel({
    this.currentPage,
    this.from,
    this.lastPage,
  });

  Map<String, dynamic> toMap() {
    return {
      'current_page': currentPage,
      'from': from,
      'last_page': lastPage,
    };
  }

  factory MetaModel.fromMap(Map<String, dynamic> map) {
    return MetaModel(
      currentPage: map['current_page']?.toInt(),
      from: map['from']?.toInt(),
      lastPage: map['last_page']?.toInt(),
    );
  }

  @override
  String toString() =>
      'MetaModel(currentPage: $currentPage, from: $from, lastPage: $lastPage)';
}
