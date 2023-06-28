import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:tcc_frontend/src/core/errors/failure.dart';
import 'package:tcc_frontend/src/modules/profile/data/models/profile_edit_model.dart';
import 'package:tcc_frontend/src/modules/profile/domain/entities/profile_edit_entity.dart';
import 'package:tcc_frontend/src/modules/profile/domain/repositories/i_user_profile_repository.dart';
import 'package:tcc_frontend/src/modules/shared/controllers/i_auth_controller.dart';
import 'package:tcc_frontend/src/modules/user_registration/domain/entities/user_entity.dart';

abstract class IUpdateUserUsecase {
  Future<Either<Failure, void>> call(ProfileEditEntity entity, File? photo);
}

class UpdateUserUsecase extends IUpdateUserUsecase {
  final IUserProfileRepository repository;
  final IAuthController authController;

  UpdateUserUsecase({required this.repository, required this.authController});

  @override
  Future<Either<Failure, void>> call(ProfileEditEntity entity, File? photo) async {
    var copyEntity = entity;
    if (photo != null) {
      final photoUrl = await repository.uploadPhoto(photo);
      final imageId = photoUrl.fold((l) => null, (r) => r.imageId);
      copyEntity = entity.copyWith(photoUrl: imageId);
    } else {
      copyEntity = entity.copyWith(photoUrl: entity.userPhotoName);
    }
    final user = await repository.updateUser(ProfileEditModel.fromEntity(copyEntity));
    user.fold((l) => null, (r) {
      authController.update(UserEntity(
        name: r.name,
        lastName: r.lastName,
        userPhotoUrl: r.photoUrl,
        login: r.login,
      ));
    });

    return user;
  }
}
