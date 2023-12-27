import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:iba_resources_app/blocs/auth/auth_bloc.dart';
import 'package:iba_resources_app/blocs/resource/resource_bloc/resource_event.dart';
import 'package:iba_resources_app/blocs/resource/resource_bloc/resource_state.dart';
import 'package:iba_resources_app/core/resource/resource_repository/resource_repository.dart';
import 'package:iba_resources_app/models/resource.dart';
import 'package:iba_resources_app/models/user.dart';

class ResourceBloc extends Bloc<ResourceEvent, ResourceState> {
  final ResourceRepository resourceRepository;
  final AuthBloc authBloc;

  ResourceBloc({required this.resourceRepository, required this.authBloc})
      : super(ResourceEmpty()) {
    on<FetchResources>((event, emit) async {
      await _getAllResources(emit);
    });

    on<FetchResourcesStream>((event, emit) async {
      emit(ResourcesLoading());
      Stream<List<ResourceModel>> resourcesStream =
          resourceRepository.getAllResourcesStream();
      emit(ResourcesStreamLoaded(resources: resourcesStream));
    });

    on<FetchSearchedResources>((event, emit) async {
      _getSearchedResources(event.searchedName, emit);
    });

    on<FetchFilteredResources>((event, emit) async {
      _getFilteredResources(event.filters, emit);
    });

    on<DownloadResourceEvent>((event, emit) async {
      await _downloadResource(event.fileDownloadUrls, emit);
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
        event.updatedUser,
        emit,
      );
    });

    on<DeleteResourceEvent>((event, emit) async {
      await _deleteResource(event.resourceId, event.user, emit);
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

  void _getSearchedResources(String searchedName, Emitter<ResourceState> emit) {
    emit(ResourcesLoading());
    try {
      emit(ResourcesLoading());
      Stream<List<ResourceModel>> resourcesStream =
          resourceRepository.getSearchedResources(searchedName);

      emit(ResourcesStreamLoaded(resources: resourcesStream));
    } catch (e) {
      emit(ResourceError(errorMsg: e.toString()));
    }
  }

  void _getFilteredResources(
      Map<String, dynamic> filters, Emitter<ResourceState> emit) {
    emit(ResourcesLoading());
    try {
      final Stream<List<ResourceModel>> resources =
          resourceRepository.getFilteredResources(filters);

      emit(ResourcesStreamLoaded(resources: resources));
    } catch (e) {
      emit(ResourceError(errorMsg: e.toString()));
    }
  }

  Future<void> _downloadResource(
    List<dynamic> fileDownloadUrls,
    Emitter<ResourceState> emit,
  ) async {
    try {
      emit(ResourceFilesDownloadLoading());

      await resourceRepository.downloadResource(fileDownloadUrls);
      emit(ResourceFilesDownloadSuccess());
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
      // final userUpdatedSavedResources = user.savedResources!.add(savedResource);

      List<ResourceModel>? usersSavedResources = user.savedResources ?? [];

      // have to toggle isBookMarked bec previous value is being passed in, lazy state or something
      isBookMarked = !isBookMarked;

      print('resource in resource network: $savedResource');

      if (isBookMarked) {
        // add savedResource to the list if not already present
        if (!usersSavedResources.contains(savedResource)) {
          usersSavedResources.add(savedResource);
        }
      } else {
        // remove savedResource from the list
        usersSavedResources.remove(savedResource);
      }

      final updatedUser = user.copyWith(savedResources: usersSavedResources);

      await resourceRepository.bookmarkResource(
          savedResource, updatedUser, isBookMarked);
      emit(ResourceBookmarkSuccess());
      authBloc.add(AuthStateUpdatedEvent(updatedUser));
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
    UserModel updatedUser,
    Emitter<ResourceState> emit,
  ) async {
    try {
      emit(ResourceFilesUploadLoading());

      UserModel newUpdatedUser = await resourceRepository.uploadResource(
        pickedFiles,
        resourceTitle,
        resourceDescription,
        resourceType,
        teacherName,
        courseName,
        relevantFields,
        semester,
        year,
        updatedUser,
      );

      emit(ResourceFilesUploadSuccess());
      print('updated user after resource upload');
      print(updatedUser);
      authBloc.add(AuthStateUpdatedEvent(newUpdatedUser));
    } catch (error) {
      emit(ResourceError(errorMsg: error.toString()));
    }
  }

  Future<void> _deleteResource(
      String resourceId, UserModel user, Emitter<ResourceState> emit) async {
    try {
      emit(ResourcesLoading());
      UserModel updatedUser =
          await resourceRepository.deleteResource(resourceId, user);
      emit(ResourceBookmarkSuccess());
      authBloc.add(AuthStateUpdatedEvent(updatedUser));
    } catch (error) {
      emit(ResourceError(errorMsg: error.toString()));
    }
  }
}
