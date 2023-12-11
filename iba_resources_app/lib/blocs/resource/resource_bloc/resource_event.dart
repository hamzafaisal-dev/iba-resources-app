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

class BookmarkResourceEvent extends ResourceEvent {
  final UserModel user;
  final String resourceId;
  final bool isBookMarked;

  const BookmarkResourceEvent({
    required this.user,
    required this.resourceId,
    required this.isBookMarked,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [user, resourceId];
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
  });

  @override
  List<Object?> get props => throw UnimplementedError();
}

class FetchMocNigga extends ResourceEvent {
  const FetchMocNigga() : super();

  @override
  List<Object?> get props => throw UnimplementedError();
}
