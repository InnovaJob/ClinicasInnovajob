import 'package:flutter/material.dart';
import '../home/home_screen.dart';
import '../onboarding/onboarding_screen.dart' show AnimatedBackground;
import 'register_screen.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _rememberMe = false;

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
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Fondo animado
          const AnimatedBackground(),

          // Contenido
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Container(
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Logo o icono
                      Icon(
                        Icons.medical_services,
                        size: 64,
                        color: _whiteColor,
                      ),
                      const SizedBox(height: 24),

                      // Título
                      Text(
                        'Clínica Médica',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: _whiteColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),

                      // Subtítulo
                      Text(
                        'Inicia sesión para continuar',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: _whiteColor.withOpacity(0.8),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),

                      // Botones de inicio de sesión social
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildSocialLoginButton(
                            icon: 'assets/icons/google.png',
                            fallbackIcon: Icons.g_mobiledata,
                            label: 'Google',
                            onPressed: () => _loginWithSocial(() => const HomeScreen()),
                          ),
                          _buildSocialLoginButton(
                            icon: 'assets/icons/apple.png',
                            fallbackIcon: Icons.apple,
                            label: 'Apple',
                            onPressed: () => _loginWithSocial(() => const HomeScreen()),
                          ),
                          _buildSocialLoginButton(
                            icon: 'assets/icons/facebook.png',
                            fallbackIcon: Icons.facebook,
                            label: 'Facebook',
                            onPressed: () => _loginWithSocial(() => const HomeScreen()),
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
                              'O inicia sesión con',
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

                      // Campo de email
                      TextFormField(
                        controller: _emailController,
                        decoration: _inputDecoration.copyWith(
                          labelText: 'Correo electrónico',
                          hintText: 'ejemplo@correo.com',
                          prefixIcon: Icon(Icons.email_outlined, color: _whiteColorWithOpacity),
                        ),
                        style: TextStyle(color: _whiteColor),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Campo de contraseña
                      TextFormField(
                        controller: _passwordController,
                        decoration: _inputDecoration.copyWith(
                          labelText: 'Contraseña',
                          hintText: 'Ingresa tu contraseña',
                          prefixIcon: Icon(Icons.lock_outline, color: _whiteColorWithOpacity),
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
                        obscureText: !_isPasswordVisible,
                        validator: (value) {
                          return null;
                        },
                      ),
                      const SizedBox(height: 8),

                      // Opciones adicionales
                      Row(
                        children: [
                          // Checkbox "Recordarme"
                          Theme(
                            data: ThemeData(
                              unselectedWidgetColor: _whiteColorWithOpacity,
                            ),
                            child: Checkbox(
                              value: _rememberMe,
                              checkColor: Colors.black,
                              activeColor: _whiteColor,
                              onChanged: (value) {
                                setState(() {
                                  _rememberMe = value ?? false;
                                });
                              },
                            ),
                          ),
                          Text('Recordarme', style: TextStyle(color: _whiteColor)),
                          const Spacer(),
                          // Olvidé mi contraseña
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const ForgotPasswordScreen(),
                                ),
                              );
                            },
                            child: Text(
                              '¿Olvidaste tu contraseña?',
                              style: TextStyle(color: _whiteColor),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Botón de inicio de sesión
                      ElevatedButton(
                        onPressed: () {
                          // Navegamos directamente a Home sin validar
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                          );
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
                          'Iniciar Sesión',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Opción para registrarse
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('¿No tienes una cuenta?', style: TextStyle(color: _whiteColor)),
                          TextButton(
                            onPressed: () {
                              // Navegar a pantalla de registro
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const RegisterScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'Regístrate',
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

  // Método para optimizar la navegación con inicio de sesión social
  void _loginWithSocial(Widget Function() destinationBuilder) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => destinationBuilder(),
      ),
    );
  }

  Widget _buildSocialLoginButton({
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
