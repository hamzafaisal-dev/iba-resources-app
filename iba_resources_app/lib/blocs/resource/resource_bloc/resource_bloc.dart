import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:iba_resources_app/core/resource/resource_repository/resource_repository.dart';
import 'package:iba_resources_app/models/resource.dart';

part 'resource_event.dart';
part 'resource_state.dart';

class ResourceBloc extends Bloc<ResourceEvent, ResourceState> {
  final ResourceRepository resourceRepository;

  ResourceBloc({required this.resourceRepository}) : super(ResourcesLoading()) {
    on<FetchResources>((event, emit) async {
      await _getAllResources(emit);
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
}
