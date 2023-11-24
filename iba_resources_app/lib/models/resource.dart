class Resource {
  const Resource({
    required this.resourceTitle,
    required this.resourceFiles,
    required this.uploader,
    required this.relevantFields,
    // required this.createdAt,
    // required this.updatedAt,
    required this.isActive,
    required this.isDeleted,
  });

  final String resourceTitle;
  final String uploader;
  final List<dynamic>? resourceFiles;

  final List<dynamic>? relevantFields;

  // final DateTime createdAt;
  // final DateTime updatedAt;
  final bool isActive;
  final bool isDeleted;

  factory Resource.fromJson(Map<String, dynamic> resourceData) {
    return Resource(
      resourceTitle: resourceData['resourceName'],
      resourceFiles: resourceData['files'],
      uploader: resourceData['uploader'],
      relevantFields: resourceData['relevantFields'],
      isActive: resourceData['isActive'],
      isDeleted: resourceData['isDeleted'],
    );
  }
}
