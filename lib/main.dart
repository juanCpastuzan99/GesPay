import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'providers/theme_provider.dart';
import 'providers/firebase_auth_provider.dart';
import 'providers/firestore_expense_provider.dart';
import 'providers/currency_provider.dart';
import 'services/firestore_init_service.dart';
import 'screens/auth/login_screen.dart';
import 'screens/home/improved_home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar Firebase ANTES de crear cualquier provider
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('🔥 Firebase inicializado correctamente');
  } catch (e) {
    print('❌ Error inicializando Firebase: $e');
    print('🔧 Intentando inicialización alternativa...');

    // Intentar inicialización alternativa para Linux
    try {
      await Firebase.initializeApp(
        name: 'gespay-linux',
        options: DefaultFirebaseOptions.linux,
      );
      print('✅ Firebase inicializado con configuración Linux');
    } catch (e2) {
      print('❌ Error en inicialización alternativa: $e2');
      // Continuar sin Firebase si no se puede inicializar
      print('⚠️ Continuando sin Firebase - usando modo offline');
    }
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => FirebaseAuthProvider()),
        ChangeNotifierProvider(create: (_) => FirestoreExpenseProvider()),
        ChangeNotifierProvider(create: (_) => CurrencyProvider()),
      ],
      child:
          Consumer3<
            ThemeProvider,
            FirebaseAuthProvider,
            FirestoreExpenseProvider
          >(
            builder:
                (context, themeProvider, authProvider, expenseProvider, child) {
                  // Manejar cambio de usuario
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _handleUserChange(authProvider, expenseProvider);
                  });

                  return MaterialApp(
                    title: 'GesPay',
                    debugShowCheckedModeBanner: false,
                    theme: themeProvider.lightTheme,
                    darkTheme: themeProvider.darkTheme,
                    themeMode: themeProvider.themeMode,
                    home: authProvider.user != null
                        ? const ImprovedHomeScreen()
                        : const LoginScreen(),
                    routes: {
                      '/login': (context) => const LoginScreen(),
                      '/home': (context) => const ImprovedHomeScreen(),
                    },
                  );
                },
          ),
    );
  }

  void _handleUserChange(
    FirebaseAuthProvider authProvider,
    FirestoreExpenseProvider expenseProvider,
  ) {
    if (authProvider.user != null) {
      // Usuario autenticado - inicializar Firestore
      FirestoreInitService.initializeForUser(expenseProvider);
    } else {
      // Usuario no autenticado - limpiar datos
      FirestoreInitService.clearForUser();
    }
  }
}
