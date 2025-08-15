import 'package:flutter/material.dart';
import '../onboarding/onboarding_screen.dart' show AnimatedBackground;

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;
  bool _emailSent = false;

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
    super.dispose();
  }

  void _handleResetPassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simular envío de correo (aquí iría la lógica real)
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isLoading = false;
        _emailSent = true;
      });
    }
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
                constraints: const BoxConstraints(maxWidth: 400),
                child: _emailSent ? _buildSuccessMessage() : _buildForm(primaryColor),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm(Color primaryColor) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Ícono
          Icon(
            Icons.lock_reset,
            size: 64,
            color: _whiteColor,
          ),
          const SizedBox(height: 24),

          // Título
          Text(
            '¿Olvidaste tu contraseña?',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: _whiteColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),

          // Descripción
          Text(
            'Introduce tu correo electrónico y te enviaremos instrucciones para restablecer tu contraseña.',
            style: TextStyle(
              color: _whiteColor.withOpacity(0.8),
              fontSize: 14,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),

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
              if (value == null || value.isEmpty) {
                return 'Por favor, introduce tu correo electrónico';
              }
              bool emailValid = RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
              ).hasMatch(value);
              if (!emailValid) {
                return 'Introduce un correo electrónico válido';
              }
              return null;
            },
          ),
          const SizedBox(height: 32),

          // Botón para enviar
          ElevatedButton(
            onPressed: _isLoading ? null : _handleResetPassword,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: _whiteColor,
              foregroundColor: primaryColor,
              disabledBackgroundColor: _whiteColor.withOpacity(0.6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: _isLoading
                ? SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                    ),
                  )
                : const Text(
                    'Enviar instrucciones',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
          const SizedBox(height: 24),

          // Volver a iniciar sesión
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('¿Recordaste tu contraseña?', style: TextStyle(color: _whiteColor)),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Iniciar sesión',
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
    );
  }

  Widget _buildSuccessMessage() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Ícono
        Icon(
          Icons.check_circle_outline,
          size: 80,
          color: _whiteColor,
        ),
        const SizedBox(height: 24),

        // Título
        Text(
          '¡Correo enviado!',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: _whiteColor,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),

        // Mensaje
        Text(
          'Hemos enviado las instrucciones para restablecer tu contraseña a ${_emailController.text}',
          style: TextStyle(
            color: _whiteColor.withOpacity(0.8),
            fontSize: 14,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),

        // Instrucción adicional
        Text(
          'Si no encuentras el correo, revisa tu bandeja de spam.',
          style: TextStyle(
            color: _whiteColor.withOpacity(0.7),
            fontSize: 13,
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),

        // Botón para volver a iniciar sesión
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
            backgroundColor: _whiteColor,
            foregroundColor: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'Volver al inicio de sesión',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

