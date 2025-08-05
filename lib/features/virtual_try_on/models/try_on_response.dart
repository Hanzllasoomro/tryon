class TryOnResponse {
  final String? id;
  final String? error;

  TryOnResponse({this.id, this.error});

  factory TryOnResponse.fromJson(Map<String, dynamic> json) {
    return TryOnResponse(
      id: json['id'],
      error: json['error'],
    );
  }
}
