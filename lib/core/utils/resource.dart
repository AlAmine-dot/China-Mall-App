class Resource<T> {
  final T? data;
  final String? message;
  final ResourceType type;

  Resource({this.data, this.message, required this.type});

  factory Resource.success(T data) =>
      Resource(data: data, type: ResourceType.success);
  factory Resource.error(String message) =>
      Resource(message: message, type: ResourceType.error);
  factory Resource.loading() => Resource(type: ResourceType.loading);
}

enum ResourceType {
  success,
  error,
  loading,
}
