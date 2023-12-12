import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
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
          event.user, event.savedResource, event.isBookMarked, emit);
    });

    on<SelectFilesEvent>((event, emit) async {
      await _selectFiles(emit);
    });

    on<UploadFilesEvent>((event, emit) async {
      await _uploadResource(
        event.pickedFiles,
        event.resourceTitle,
        event.resourceDescription,
        event.resourceType,
        event.teacherName,
        event.courseName,
        event.relevantFields,
        event.semester,
        event.year,
        emit,
      );
    });

    on<FetchMocNigga>((event, emit) {
      print('Mock nigga');
      // return emit(ResourceEmpty());
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
    ResourceModel savedResource,
    bool isBookMarked,
    Emitter<ResourceState> emit,
  ) async {
    try {
      await resourceRepository.bookmarkResource(
          savedResource, user, isBookMarked);
      emit(ResourceBookmarkSuccess());
    } catch (e) {
      emit(ResourceError(errorMsg: e.toString()));
    }
  }

  Future<void> _selectFiles(Emitter<ResourceState> emit) async {
    try {
      FilePickerResult? filePickerResult =
          await resourceRepository.selectFiles();

      if (filePickerResult == null || filePickerResult.files.isEmpty) {
        emit(ResourceError(errorMsg: 'Something went wrong. Please try again'));
      }

      emit(ResourceFilesSelectSuccess(filePickerResult));
    } catch (error) {
      emit(ResourceError(errorMsg: error.toString()));
    }
  }

  Future<void> _uploadResource(
    FilePickerResult pickedFiles,
    String resourceTitle,
    String resourceDescription,
    String resourceType,
    String teacherName,
    String courseName,
    List<String> relevantFields,
    String semester,
    String year,
    Emitter<ResourceState> emit,
  ) async {
    try {
      emit(ResourceFilesUploadLoading());

      await resourceRepository.uploadResource(
        pickedFiles,
        resourceTitle,
        resourceDescription,
        resourceType,
        teacherName,
        courseName,
        relevantFields,
        semester,
        year,
      );

      emit(ResourceFilesUploadSuccess());
    } catch (error) {
      emit(ResourceError(errorMsg: error.toString()));
    }
  }
}
