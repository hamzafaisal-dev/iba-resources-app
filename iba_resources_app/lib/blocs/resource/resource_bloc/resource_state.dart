import 'package:iba_resources_app/models/resource.dart';

abstract class ResourceState {
  const ResourceState([List props = const []]) : super();
}

// initial state
class ResourceEmpty extends ResourceState {}

class ResourcesLoading extends ResourceState {}

class ResourcesLoaded extends ResourceState {
  final List<ResourceModel> resources;

  ResourcesLoaded({required this.resources}) : super([resources]);
}

class ResourceBookmarkSuccess extends ResourceState {}

class ResourceError extends ResourceState {
  final String? errorMsg;
  ResourceError({this.errorMsg});
}
