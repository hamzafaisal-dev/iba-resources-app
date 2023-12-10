import 'package:bloc/bloc.dart';
import 'package:iba_resources_app/blocs/resource/resource_bloc/resource_event.dart';
import 'package:iba_resources_app/blocs/resource/resource_bloc/resource_state.dart';
import 'package:iba_resources_app/core/resource/resource_repository/resource_repository.dart';
import 'package:iba_resources_app/models/resource.dart';
import 'package:iba_resources_app/models/user.dart';

class ResourceBloc extends Bloc<ResourceEvent, ResourceState> {
  final ResourceRepository resourceRepository;

  ResourceBloc({required this.resourceRepository}) : super(ResourcesLoading()) {
    on<FetchResources>((event, emit) async {
      await _getAllResources(emit);
    });

    on<BookmarkResourceEvent>((event, emit) async {
      await _bookmarkResource(
          event.user, event.resourceId, event.isBookMarked, emit);
    });

    on<FetchMocNigga>((event, emit) {
      print('Mock nigga');
      return emit(ResourceEmpty());
    });
  }

  Future<void> _getAllResources(Emitter<ResourceState> emit) async {
    emit(ResourcesLoading());
    try {
      final List<ResourceModel> resources =
          await resourceRepository.getAllResources();

      if (resources.isEmpty) {
        return emit(ResourceEmpty());
      }

      emit(ResourcesLoaded(resources: resources));
    } catch (e) {
      emit(ResourceError(errorMsg: e.toString()));
    }
  }

  Future<void> _bookmarkResource(
    UserModel user,
    String resourceId,
    bool isBookMarked,
    Emitter<ResourceState> emit,
  ) async {
    try {
      await resourceRepository.bookmarkResource(resourceId, user, isBookMarked);
      emit(ResourceBookmarkSuccess());
    } catch (e) {
      emit(ResourceError(errorMsg: e.toString()));
    }
  }
}
