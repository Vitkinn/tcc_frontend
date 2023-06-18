import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tcc_frontend/src/modules/shared/components/app_banner.dart';
import 'package:tcc_frontend/src/modules/shared/components/save_cancel_buttons.dart';
import 'package:tcc_frontend/src/modules/shared/widgets/return_button.dart';

class RegisterPhotoPage extends StatefulWidget {
  const RegisterPhotoPage({super.key});

  @override
  State<RegisterPhotoPage> createState() => _RegisterPhotoPageState();
}

class _RegisterPhotoPageState extends State<RegisterPhotoPage> {
  final String _profilePictureUrl = 'lib/assets/images/user_icon.png';
  String? _selectedOption;

  List<String> _options = [
    '---',
    'Masculino',
    'Feminino',
    'Prefiro não definir',
  ];

  void advance() {
    Modular.to.navigate('/register_password');
  }

  void cancel() {
    Modular.to.navigate('/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Column(
                      children: [
                        ReturnButton(onTap: cancel),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: AppBanner(
                    title:
                        'Por favor, agora selecione uma foto para o seu perfil e defina o seu sexo.',
                    titleSize: 18,
                    titleHexColor: '808080',
                  ),
                ),
                const SizedBox(height: 50),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 75,
                      backgroundImage: AssetImage(_profilePictureUrl),
                      backgroundColor: Colors.grey,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(75),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.camera_alt),
                        color: Colors.white,
                        onPressed: () {
                          // Lógica para trocar a foto
                          // Implemente a lógica de seleção de imagem aqui
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration:
                        BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                    child: DropdownButtonFormField(
                      value: _selectedOption,
                      isExpanded: true,
                      decoration: InputDecoration(
                          hintText: 'Selecione o seu sexo',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
                      items: _options.map((String option) {
                        return DropdownMenuItem(
                          value: option,
                          child: Text(option),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedOption = newValue;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
          height: 150,
          child: SaveCancelButtons(saveText: 'Avançar', onSaveTap: advance, onCancelTap: cancel)),
    );
  }
}
