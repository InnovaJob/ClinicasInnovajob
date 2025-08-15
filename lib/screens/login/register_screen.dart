import 'package:flutter/material.dart';
import '../home/home_screen.dart';
import '../onboarding/onboarding_screen.dart' show AnimatedBackground;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  // Definir estilos comunes para reutilizar
  final _whiteColor = Colors.white;
  final _whiteColorWithOpacity = Colors.white.withOpacity(0.7);

  // Optimización de decoraciones reutilizables
  late final InputDecoration _inputDecoration;

  @override
  void initState() {
    super.initState();
    _inputDecoration = InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: _whiteColorWithOpacity),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: _whiteColorWithOpacity),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: _whiteColor),
      ),
      labelStyle: TextStyle(color: _whiteColor),
      hintStyle: TextStyle(color: _whiteColorWithOpacity),
      filled: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      // Fondo animado igual que splash y login
      body: Stack(
        children: [
          const AnimatedBackground(),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Container(
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                constraints: const BoxConstraints(maxWidth: 400),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Título
                      Text(
                        'Crear cuenta',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: _whiteColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),

                      // Subtítulo
                      Text(
                        'Regístrate para comenzar',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: _whiteColor.withOpacity(0.8),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),

                      // Botones de registro social
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildSocialRegisterButton(
                            icon: 'assets/icons/google.png',
                            fallbackIcon: Icons.g_mobiledata,
                            label: 'Google',
                            onPressed: () => _registerWithSocial(() => const HomeScreen()),
                          ),
                          _buildSocialRegisterButton(
                            icon: 'assets/icons/apple.png',
                            fallbackIcon: Icons.apple,
                            label: 'Apple',
                            onPressed: () => _registerWithSocial(() => const HomeScreen()),
                          ),
                          _buildSocialRegisterButton(
                            icon: 'assets/icons/facebook.png',
                            fallbackIcon: Icons.facebook,
                            label: 'Facebook',
                            onPressed: () => _registerWithSocial(() => const HomeScreen()),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Separador
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: _whiteColor.withOpacity(0.5),
                              thickness: 1,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              'O regístrate con',
                              style: TextStyle(
                                color: _whiteColor.withOpacity(0.8),
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: _whiteColor.withOpacity(0.5),
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Campo nombre completo
                      TextFormField(
                        decoration: _inputDecoration.copyWith(
                          labelText: 'Nombre completo',
                          hintText: 'Ingresa tu nombre completo',
                          prefixIcon: Icon(Icons.person, color: _whiteColorWithOpacity),
                        ),
                        style: TextStyle(color: _whiteColor),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Introduce tu nombre';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Campo correo electrónico
                      TextFormField(
                        decoration: _inputDecoration.copyWith(
                          labelText: 'Correo electrónico',
                          hintText: 'ejemplo@correo.com',
                          prefixIcon: Icon(Icons.email, color: _whiteColorWithOpacity),
                        ),
                        style: TextStyle(color: _whiteColor),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Introduce tu correo';
                          }
                          bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                          ).hasMatch(value);
                          if (!emailValid) {
                            return 'Introduce un correo válido';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Campo contraseña
                      TextFormField(
                        obscureText: !_isPasswordVisible,
                        decoration: _inputDecoration.copyWith(
                          labelText: 'Contraseña',
                          hintText: 'Ingresa tu contraseña',
                          prefixIcon: Icon(Icons.lock, color: _whiteColorWithOpacity),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                              color: _whiteColorWithOpacity,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                        ),
                        style: TextStyle(color: _whiteColor),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Introduce una contraseña';
                          }
                          if (value.length < 6) {
                            return 'La contraseña debe tener al menos 6 caracteres';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),

                      // Botón de registro
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            // Aquí iría la lógica de registro real
                            // Por ahora, navega al HomeScreen
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: _whiteColor,
                          foregroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Registrarse',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Opción para iniciar sesión
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('¿Ya tienes cuenta?', style: TextStyle(color: _whiteColor)),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Inicia sesión',
                              style: TextStyle(
                                color: _whiteColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Método para optimizar la navegación con registro social
  void _registerWithSocial(Widget Function() destinationBuilder) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => destinationBuilder(),
      ),
    );
  }

  Widget _buildSocialRegisterButton({
    required String icon,
    required IconData fallbackIcon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(50),
          child: Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              color: _whiteColor,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Center(
              child: _buildSocialIcon(icon, fallbackIcon),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: _whiteColor,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialIcon(String assetPath, IconData fallbackIcon) {
    // Precache de imágenes para mejorar rendimiento
    final primaryColor = Theme.of(context).primaryColor;

    try {
      return Image.asset(
        assetPath,
        width: 30,
        height: 30,
        errorBuilder: (context, error, stackTrace) {
          return Icon(
            fallbackIcon,
            color: primaryColor,
            size: 30,
          );
        },
      );
    } catch (e) {
      return Icon(
        fallbackIcon,
        color: primaryColor,
        size: 30,
      );
    }
  }
}