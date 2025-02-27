import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'ahmed_state.dart';

class AhmedCubit extends Cubit<AhmedState> {
  AhmedCubit() : super(AhmedInitial());
}
