import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:iba_resources_app/models/resource.dart';
import 'package:iba_resources_app/models/user.dart';

abstract class ResourceEvent extends Equatable {
  const ResourceEvent([List props = const []]) : super();
}

class FetchResources extends ResourceEvent {
  const FetchResources() : super();

  @override
  List<Object?> get props => throw UnimplementedError();
}

class FetchResourcesStream extends ResourceEvent {
  const FetchResourcesStream() : super();

  @override
  List<Object?> get props => throw UnimplementedError();
}

class FetchSearchedResources extends ResourceEvent {
  final String searchedName;

  const FetchSearchedResources(this.searchedName) : super();

  @override
  List<Object?> get props => throw UnimplementedError();
}

class DownloadResourceEvent extends ResourceEvent {
  final List<dynamic> fileDownloadUrls;

  const DownloadResourceEvent({
    required this.fileDownloadUrls,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [fileDownloadUrls];
}

class BookmarkResourceEvent extends ResourceEvent {
  final UserModel user;
  final ResourceModel savedResource;
  final bool isBookMarked;

  const BookmarkResourceEvent({
    required this.user,
    required this.savedResource,
    required this.isBookMarked,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [user, savedResource];
}

class SelectFilesEvent extends ResourceEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class UploadFilesEvent extends ResourceEvent {
  final FilePickerResult pickedFiles;
  final String resourceTitle;
  final String resourceDescription;
  final String resourceType;
  final String teacherName;
  final String courseName;
  final List<String> relevantFields;
  final String semester;
  final String year;
  final UserModel updatedUser;

  const UploadFilesEvent({
    required this.pickedFiles,
    required this.resourceTitle,
    required this.resourceDescription,
    required this.resourceType,
    required this.teacherName,
    required this.courseName,
    required this.relevantFields,
    required this.semester,
    required this.year,
    required this.updatedUser,
  });

  @override
  List<Object?> get props => throw UnimplementedError();
}

class FetchMocNigga extends ResourceEvent {
  const FetchMocNigga() : super();

  @override
  List<Object?> get props => throw UnimplementedError();
}
