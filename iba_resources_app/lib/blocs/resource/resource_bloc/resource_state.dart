import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:iba_resources_app/models/resource.dart';

abstract class ResourceState extends Equatable {
  const ResourceState([List props = const []]) : super();
}

// initial state
class Resourceinitial extends ResourceState {
  @override
  List<Object?> get props => [];
}

class ResourceEmpty extends ResourceState {
  @override
  List<Object?> get props => [];
}

class ResourcesLoading extends ResourceState {
  @override
  List<Object?> get props => [];
}

class ResourcesLoaded extends ResourceState {
  final List<ResourceModel> resources;

  ResourcesLoaded({required this.resources}) : super([resources]);

  @override
  List<Object?> get props => [resources];
}

class ResourcesStreamLoaded extends ResourceState {
  final Stream<List<ResourceModel>> resources;

  ResourcesStreamLoaded({required this.resources}) : super([resources]);

  @override
  List<Object?> get props => [resources];
}

class ResourceBookmarkSuccess extends ResourceState {
  @override
  List<Object?> get props => [];
}

class ResourceFilesSelectSuccess extends ResourceState {
  final FilePickerResult? filePickerResult;

  ResourceFilesSelectSuccess(this.filePickerResult);

  @override
  List<Object?> get props => [filePickerResult];
}

class ResourceFilesUploadSuccess extends ResourceState {
  @override
  List<Object?> get props => [];
}

class ResourceFilesUploadLoading extends ResourceState {
  @override
  List<Object?> get props => [];
}

class ResourceFilesDownloadSuccess extends ResourceState {
  @override
  List<Object?> get props => [];
}

class ResourceFilesDownloadLoading extends ResourceState {
  @override
  List<Object?> get props => [];
}

class ResourceError extends ResourceState {
  final String errorMsg;
  const ResourceError({required this.errorMsg});

  @override
  List<Object?> get props => [errorMsg];
}
