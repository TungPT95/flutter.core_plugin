abstract class JsonConverterFactory {
  T fromJson<T>(dynamic json);

  dynamic toJson<T>(T object);
}
