class UriBuilder {
  final List<String> _path = [];
  final Map<String, dynamic> _query = {}; // keep original datatypes

  /// Add a path segment always
  UriBuilder add(String segment) {
    if (segment.isNotEmpty) {
      _path.add(segment);
    }
    return this;
  }

  /// Add a path segment only if [condition] is true
  UriBuilder addIf(bool condition, String segment) {
    if (condition && segment.isNotEmpty) {
      _path.add(segment);
    }
    return this;
  }

  /// Add a query parameter (keep datatype, skip null)
  UriBuilder addQuery(String key, dynamic value) {
    if (value == null) return this;
    _query[key] = value; // keep original type
    return this;
  }

  /// Add a query parameter only if [condition] is true
  UriBuilder addQueryIf(bool condition, String key, dynamic value) {
    if (condition && value != null) {
      _query[key] = value; // keep original type
    }
    return this;
  }

  /// Build final URL as String
  String build() {
    final uri = Uri(
      pathSegments: _path,
      queryParameters: _query.isNotEmpty
          ? _query.map((key, value) => MapEntry(key, value.toString()))
          : null,
    );
    return '/$uri';
  }

  @override
  String toString() => build();
}
