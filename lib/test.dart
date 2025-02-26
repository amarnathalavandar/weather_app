@JsonSerializable(genericArgumentFactories: true, createToJson: false)
class ZCTApiResponse<T> {
  final T? data;
  final ApiResponseError? error;

  ZCTApiResponse({this.data, this.error});

  factory ZCTApiResponse.fromJson(Map<String, dynamic> json, T Function(Object?) fromJsonT) {
    print("Raw API Response: $json");  // Add this for debugging
    return _$ZCTApiResponseFromJson(json, fromJsonT);
  }
}
