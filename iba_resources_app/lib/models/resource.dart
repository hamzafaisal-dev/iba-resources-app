class Resource {
  const Resource({
    required this.resourceTitle,
    required this.uploader,
    required this.relevantFields,
    required this.createdAt,
    required this.updatedAt,
    required this.isActive,
    required this.isDeleted,
  });

  final String resourceTitle;
  final String uploader;
  final List? relevantFields;

  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isActive;
  final bool isDeleted;
}
