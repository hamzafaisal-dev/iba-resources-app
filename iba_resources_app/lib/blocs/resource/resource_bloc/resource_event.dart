part of 'resource_bloc.dart';

abstract class ResourceEvent extends Equatable {
  const ResourceEvent([List props = const []]) : super();
}

class FetchResources extends ResourceEvent {
  const FetchResources() : super();

  @override
  List<Object?> get props => throw UnimplementedError();
}

class FetchMocNigga extends ResourceEvent {
  const FetchMocNigga() : super();

  @override
  List<Object?> get props => throw UnimplementedError();
}
