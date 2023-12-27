import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:iba_resources_app/blocs/auth/auth_bloc.dart';
import 'package:iba_resources_app/core/user/user_repository.dart';
import 'package:iba_resources_app/models/resource.dart';
import 'package:iba_resources_app/models/user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  final AuthBloc authBloc;

  UserBloc({required this.userRepository, required this.authBloc})
      : super(UserInitial()) {
    on<UserUpdateEvent>((event, emit) {
      _updateUser(event.user, event.name, emit);
    });

    on<UserToggleLikeEvent>((event, emit) async {
      await _toggleUserLikes(event.user, event.resource, emit);
    });

    on<UserToggleDislikeEvent>((event, emit) async {
      await _toggleUserDislikes(event.user, event.resource, emit);
    });

    on<FetchUser>((event, emit) async {
      await _fetchUser(event.userId, emit);
    });
  }

  Future<void> _fetchUser(String userId, Emitter<UserState> emit) async {
    try {
      emit(UserLoadingState());
      UserModel currentUser = await userRepository.fetchCurrentUser(userId);
      emit(UserLoaded(currentUser));
    } catch (error) {
      emit(UserUpdateError(errorMessage: error.toString()));
    }
  }

  void _updateUser(UserModel user, String userName, Emitter<UserState> emit) {
    try {
      emit(UserLoadingState());
      userRepository.editProfile(user);
      emit(UserUpdateSuccess());
      authBloc.add(AuthStateUpdatedEvent(user));
    } catch (error) {
      emit(UserUpdateError(errorMessage: error.toString()));
    }
  }

  Future<void> _toggleUserLikes(
      UserModel user, ResourceModel resource, Emitter<UserState> emit) async {
    try {
      // emit(UserLoadingState());
      List<int> resourceLikesAndDislikes =
          await userRepository.toggleResourceLike(user, resource);

      if (resourceLikesAndDislikes.isEmpty) {
        return emit(UserUpdateError(errorMessage: 'Something went wrong'));
      }

      emit(ResourceLikedState(
          resourceLikesAndDislikes: resourceLikesAndDislikes));

      authBloc.add(AuthStateUpdatedEvent(user));
    } catch (error) {
      emit(UserUpdateError(errorMessage: error.toString()));
    }
  }

  Future<void> _toggleUserDislikes(
      UserModel user, ResourceModel resource, Emitter<UserState> emit) async {
    try {
      // emit(UserLoadingState());

      List<int> resourceLikesAndDislikes =
          await userRepository.toggleResourceDisLike(user, resource);

      if (resourceLikesAndDislikes.isEmpty) {
        emit(UserUpdateError(errorMessage: 'Something went wrong'));
      }

      emit(ResourceDisikedState(
          resourceLikesAndDislikes: resourceLikesAndDislikes));

      authBloc.add(AuthStateUpdatedEvent(user));
    } catch (error) {
      emit(UserUpdateError(errorMessage: error.toString()));
    }
  }
}
