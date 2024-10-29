class Response {
  final dynamic hourly;

  const Response({
    required this.hourly,
  });

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      hourly: json['hourly'],
    );
  }
}
