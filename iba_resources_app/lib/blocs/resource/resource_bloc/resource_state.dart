part of 'resource_bloc.dart';

abstract class ResourceState {
  const ResourceState([List props = const []]) : super();
}

// initial state
class ResourceEmpty extends ResourceState {}

class ResourcesLoading extends ResourceState {}

class ResourcesLoaded extends ResourceState {
  final List<Resource> resources;

  ResourcesLoaded({required this.resources}) : super([resources]);
}

class ResourceError extends ResourceState {
  final String? errorMsg;
  ResourceError({this.errorMsg});
}
