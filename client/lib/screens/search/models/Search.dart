class SearchModel {
  final List<dynamic> result;

  SearchModel({required this.result});

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
        result: json['result']);
  }
}