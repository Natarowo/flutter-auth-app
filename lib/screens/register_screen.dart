import 'package:flutter/material.dart';
import '../widgets/app_text_field.dart';
import '../widgets/primary_button.dart';
import '../widgets/social_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  void register() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Registro exitoso")),
      );

      Navigator.pop(context);
    }
  }

  void googleRegister() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    await Future.delayed(const Duration(seconds: 2));

    Navigator.pop(context);

    showDialog(
      context: context,
      builder: (_) => const AlertDialog(
        title: Text("Google"),
        content: Text("Registro exitoso"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registro")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              AppTextField(
                label: "Nombre",
                controller: nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Campo requerido";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 10),

              AppTextField(
                label: "Correo",
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Campo requerido";
                  }
                  if (!value.contains("@")) {
                    return "Correo inválido";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 10),

              AppTextField(
                label: "Contraseña",
                controller: passwordController,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return "Mínimo 6 caracteres";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 10),

              AppTextField(
                label: "Confirmar contraseña",
                controller: confirmController,
                obscureText: true,
                validator: (value) {
                  if (value != passwordController.text) {
                    return "Las contraseñas no coinciden";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              PrimaryButton(
                text: "Registrarse",
                onPressed: register,
              ),

              const SizedBox(height: 10),

              SocialButton(
                text: "Registrarse con Google",
                onPressed: googleRegister,
              ),
            ],
          ),
        ),
      ),
    );
  }
}