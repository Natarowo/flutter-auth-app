import 'package:flutter/material.dart';
import '../widgets/app_text_field.dart';
import '../widgets/primary_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState
    extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  void sendLink() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Correo enviado")),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Recuperar contraseña")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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

              const SizedBox(height: 20),

              PrimaryButton(
                text: "Enviar enlace",
                onPressed: sendLink,
              ),
            ],
          ),
        ),
      ),
    );
  }
}