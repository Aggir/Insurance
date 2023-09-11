import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:insurance_app/app/di/dependency_injection.dart';
import 'package:insurance_app/app/enums/status_enum.dart';
import 'package:insurance_app/domain/usecases/get_companies_count_usecase.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  init() async {
    emit(state.copyWith(fetchCompaniesCountStatus: Status.loading));
    initGetCompaniesCount();
    (await instance<GetCompaniesCountUsecase>().execute(null)).fold(
      (failure) => emit(
        state.copyWith(
          fetchCompaniesCountStatus: Status.failure,
          fetchCompaniesCountErrorMessage: failure.message,
        ),
      ),
      (count) => emit(
        state.copyWith(
          fetchCompaniesCountStatus: Status.success,
          companiesCount: count,
        ),
      ),
    );
  }
}
