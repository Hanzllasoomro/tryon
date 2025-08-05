class TryOnStatusResponse {
  final String id;
  final String status;
  final List<String> output;
  final String? error;

  TryOnStatusResponse({
    required this.id,
    required this.status,
    required this.output,
    this.error,
  });

  factory TryOnStatusResponse.fromJson(Map<String, dynamic> json) {
    return TryOnStatusResponse(
      id: json['id'],
      status: json['status'],
      output: List<String>.from(json['output'] ?? []),
      error: json['error'],
    );
  }
}
