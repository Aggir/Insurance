import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:insurance_app/app/di/dependency_injection.dart';
import 'package:insurance_app/domain/entities/branch.dart';
import 'package:insurance_app/domain/entities/city.dart';
import 'package:insurance_app/domain/usecases/get_cities_usecase.dart';
import 'package:insurance_app/domain/usecases/get_company_branches_usecase.dart';

import '../../../app/enums/status_enum.dart';

part 'company_branches_state.dart';

class CompanyBranchesCubit extends Cubit<CompanyBranchesState> {
  CompanyBranchesCubit() : super(const CompanyBranchesState());

  fetchCities() async {
    emit(state.copyWith(fetchCitiesStatus: Status.loading));
    initGetCities();
    (await instance<GetCitiesUsecase>().execute(null)).fold(
      (failure) => emit(state.copyWith(
          fetchCitiesStatus: Status.failure,
          fetchCitiesErrorMessage: failure.message)),
      (cities) => emit(state.copyWith(
        fetchCitiesStatus: Status.success,
        cities: cities,
      )),
    );
  }

  fetchCompanyBranches(int companyId) async {
    emit(state.copyWith(fetchBranchesStatus: Status.loading));
    initGetCompanyBranches();
    (await instance<GetCompanyBranchesUsecase>().execute(companyId)).fold(
      (failure) => emit(state.copyWith(
          fetchBranchesStatus: Status.failure,
          fetchBranchesErrorMessage: failure.message)),
      (branches) => emit(state.copyWith(
        fetchBranchesStatus: Status.success,
        branches: branches,
      )),
    );
  }
}
