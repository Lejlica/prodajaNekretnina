class PagedResult<T> {
  final List<T> result;
  final int? count;

  PagedResult({required this.result, required this.count});

  factory PagedResult.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) fromJsonItem,
  ) {
    return PagedResult<T>(
      result: List<T>.from(json['result'].map(fromJsonItem)),
      count: json['count'],
    );
  }
}
