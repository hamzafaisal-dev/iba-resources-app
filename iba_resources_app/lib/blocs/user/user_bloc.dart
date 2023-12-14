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
  }

  void _updateUser(UserModel user, String userName, Emitter<UserState> emit) {
    try {
      emit(UserUpdateLoading());
      userRepository.editProfile(user, userName);
      emit(UserUpdateSuccess());
    } catch (error) {
      emit(UserUpdateError(errorMessage: error.toString()));
    }
  }
}
