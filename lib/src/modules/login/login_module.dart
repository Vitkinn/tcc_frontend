import 'package:flutter_modular/flutter_modular.dart';
import 'package:tcc_frontend/src/modules/login/data/datasource/i_user_datasource.dart';
import 'package:tcc_frontend/src/modules/login/data/datasource/remote/user_datasource.dart';
import 'package:tcc_frontend/src/modules/login/data/repositories/login_repository.dart';
import 'package:tcc_frontend/src/modules/login/domain/repositories/i_login_repository.dart';
import 'package:tcc_frontend/src/modules/login/domain/usecases/login_usecase.dart';
import 'package:tcc_frontend/src/modules/login/presentation/controllers/login_controller.dart';
import 'package:tcc_frontend/src/modules/login/presentation/pages/login_page.dart';

class LoginModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton<ILoginDatasource>(
            (i) => LoginDatasource(restClient: i.get())),
        Bind.lazySingleton<ILoginRepository>(
            (i) => LoginRepository(datasource: i.get())),
        Bind.lazySingleton<ILoginUsecase>(
            (i) => LoginUsecase(repository: i.get(), authController: i.get())),
        Bind.lazySingleton<LoginController>(
            (i) => LoginController(loginUsecase: i.get())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const LoginPage()),
      ];
}
