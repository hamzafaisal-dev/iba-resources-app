import 'package:file_picker/file_picker.dart';
import 'package:iba_resources_app/models/resource.dart';

abstract class ResourceState {
  const ResourceState([List props = const []]) : super();
}

// initial state
class Resourceinitial extends ResourceState {}

class ResourceEmpty extends ResourceState {}

class ResourcesLoading extends ResourceState {}

class ResourcesLoaded extends ResourceState {
  final List<ResourceModel> resources;

  ResourcesLoaded({required this.resources}) : super([resources]);
}

class ResourcesStreamLoaded extends ResourceState {
  final Stream<List<ResourceModel>> resources;

  ResourcesStreamLoaded({required this.resources}) : super([resources]);
}

class ResourceBookmarkSuccess extends ResourceState {}

class ResourceFilesSelectSuccess extends ResourceState {
  final FilePickerResult? filePickerResult;

  ResourceFilesSelectSuccess(this.filePickerResult);
}

class ResourceFilesUploadSuccess extends ResourceState {}

class ResourceFilesUploadLoading extends ResourceState {}

class ResourceFilesDownloadSuccess extends ResourceState {}

class ResourceFilesDownloadLoading extends ResourceState {}

class ResourceError extends ResourceState {
  final String errorMsg;
  ResourceError({required this.errorMsg});
}
