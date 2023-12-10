import 'package:equatable/equatable.dart';
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

class FetchMocNigga extends ResourceEvent {
  const FetchMocNigga() : super();

  @override
  List<Object?> get props => throw UnimplementedError();
}
