import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:tcc_frontend/src/modules/user_registration/domain/entities/user_entity.dart';

import '../../../../core/errors/failure.dart';
import '../../data/models/user_model.dart';
import '../repositories/i_user_repository.dart';

abstract class ICreateUserUsecase {
  Future<Either<Failure, Unit>> call(UserEntity entity, File? photo);
}

class CreateUserUsecase extends ICreateUserUsecase {
  late final IUserRepository repository;

  CreateUserUsecase({required this.repository});

  @override
  Future<Either<Failure, Unit>> call(UserEntity entity, File? photo) async {
    var copyEntity = entity;
    if (photo != null) {
      final photoUrl = await repository.uploadPhoto(photo);
      final imageId = photoUrl.fold((l) => null, (r) => r.imageId);
      copyEntity = entity.copyWith(userPhotoUrl: imageId);
    }
    return await repository.createUser(UserModel.fromEntity(copyEntity));
  }
}
