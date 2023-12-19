import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:iba_resources_app/core/user/user_repository.dart';
import 'package:iba_resources_app/models/user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc({required this.userRepository}) : super(UserInitial()) {
    on<UserUpdateEvent>((event, emit) {
      _updateUser(event.user, event.name, emit);
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
      userRepository.editProfile(user, userName);
      emit(UserUpdateSuccess());
    } catch (error) {
      emit(UserUpdateError(errorMessage: error.toString()));
    }
  }
}
