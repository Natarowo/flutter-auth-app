import 'package:flutter/material.dart';
import '../widgets/app_text_field.dart';
import '../widgets/primary_button.dart';
import '../widgets/social_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscure = true;

  void login() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login exitoso")),
      );
    }
  }

  void googleLogin() async {
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
        content: Text("Acceso exitoso"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

              const SizedBox(height: 10),

              TextFormField(
                controller: passwordController,
                obscureText: obscure,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Campo requerido";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Contraseña",
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscure ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        obscure = !obscure;
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(height: 20),

              PrimaryButton(
                text: "Iniciar sesión",
                onPressed: login,
              ),

              TextButton(
                onPressed: () =>
                    Navigator.pushNamed(context, '/forgot'),
                child: const Text("¿Olvidaste tu contraseña?"),
              ),

              TextButton(
                onPressed: () =>
                    Navigator.pushNamed(context, '/register'),
                child: const Text("Crear cuenta"),
              ),

              const SizedBox(height: 10),

              SocialButton(
                text: "Continuar con Google",
                onPressed: googleLogin,
              ),
            ],
          ),
        ),
      ),
    );
  }
}