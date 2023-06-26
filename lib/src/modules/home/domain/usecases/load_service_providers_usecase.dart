import 'package:dartz/dartz.dart';
import 'package:tcc_frontend/src/core/errors/failure.dart';
import 'package:tcc_frontend/src/modules/home/data/models/service_provider_list_model.dart';
import 'package:tcc_frontend/src/modules/home/domain/repositories/i_home_page_repository.dart';
import 'package:tcc_frontend/src/modules/shared/models/filter/filter_entity.dart';

abstract class ILoadServiceProviderUsecase {
  Future<Either<Failure, List<ServiceProviderModel>>> call(FilterEntity filter);
}

class LoadServiceProviderUsecase extends ILoadServiceProviderUsecase {
  final IHomePageRepository repository;

  LoadServiceProviderUsecase({
    required this.repository,
  });

  @override
  Future<Either<Failure, List<ServiceProviderModel>>> call(FilterEntity filter) async {
    return repository.findServiceProfiles(filter);
  }
}