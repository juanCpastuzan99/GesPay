import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DebugProvider extends ChangeNotifier {
  List<String> _debugMessages = [];
  bool _isFirebaseConnected = false;
  bool _isAuthConnected = false;
  bool _isFirestoreConnected = false;
  String? _currentUserId;
  String? _error;

  List<String> get debugMessages => _debugMessages;
  bool get isFirebaseConnected => _isFirebaseConnected;
  bool get isAuthConnected => _isAuthConnected;
  bool get isFirestoreConnected => _isFirestoreConnected;
  String? get currentUserId => _currentUserId;
  String? get error => _error;

  void addDebugMessage(String message) {
    _debugMessages.add('${DateTime.now().toString().substring(11, 19)}: $message');
    if (_debugMessages.length > 50) {
      _debugMessages.removeAt(0);
    }
    notifyListeners();
  }

  Future<void> testFirebaseConnection() async {
    addDebugMessage('🔍 Iniciando test de conexión Firebase...');
    
    try {
      // Test Firebase Core
      final apps = Firebase.apps;
      addDebugMessage('📱 Apps Firebase disponibles: ${apps.length}');
      
      if (apps.isNotEmpty) {
        _isFirebaseConnected = true;
        addDebugMessage('✅ Firebase Core conectado');
        
        // Test Firebase Auth
        try {
          final auth = FirebaseAuth.instance;
          final user = auth.currentUser;
          _currentUserId = user?.uid;
          _isAuthConnected = true;
          addDebugMessage('✅ Firebase Auth conectado - Usuario: ${user?.email ?? "No autenticado"}');
        } catch (e) {
          _isAuthConnected = false;
          addDebugMessage('❌ Error Firebase Auth: $e');
        }
        
        // Test Firestore
        try {
          final firestore = FirebaseFirestore.instance;
          await firestore.collection('test').limit(1).get();
          _isFirestoreConnected = true;
          addDebugMessage('✅ Firestore conectado');
        } catch (e) {
          _isFirestoreConnected = false;
          addDebugMessage('❌ Error Firestore: $e');
        }
        
      } else {
        _isFirebaseConnected = false;
        addDebugMessage('❌ No hay apps Firebase inicializadas');
      }
      
    } catch (e) {
      _error = e.toString();
      addDebugMessage('❌ Error general: $e');
    }
    
    notifyListeners();
  }

  Future<void> testGoogleSignIn() async {
    addDebugMessage('🔍 Probando Google Sign-In...');
    
    try {
      final auth = FirebaseAuth.instance;
      final user = auth.currentUser;
      
      if (user != null) {
        addDebugMessage('✅ Usuario ya autenticado: ${user.email}');
        addDebugMessage('📋 Provider: ${user.providerData.map((p) => p.providerId).join(", ")}');
        addDebugMessage('🆔 UID: ${user.uid}');
        addDebugMessage('📅 Último login: ${user.metadata.lastSignInTime}');
      } else {
        addDebugMessage('ℹ️ No hay usuario autenticado');
      }
      
    } catch (e) {
      addDebugMessage('❌ Error Google Sign-In: $e');
    }
    
    notifyListeners();
  }

  Future<void> testFirestoreOperations() async {
    addDebugMessage('🔍 Probando operaciones Firestore...');
    
    try {
      final firestore = FirebaseFirestore.instance;
      final auth = FirebaseAuth.instance;
      final user = auth.currentUser;
      
      if (user == null) {
        addDebugMessage('❌ No hay usuario autenticado para probar Firestore');
        return;
      }
      
      // Test de lectura
      addDebugMessage('📖 Probando lectura de gastos...');
      final expensesQuery = await firestore
          .collection('expenses')
          .where('userId', isEqualTo: user.uid)
          .limit(1)
          .get();
      
      addDebugMessage('✅ Lectura exitosa - ${expensesQuery.docs.length} gastos encontrados');
      
      // Test de escritura
      addDebugMessage('✍️ Probando escritura...');
      await firestore.collection('debug_test').add({
        'test': true,
        'timestamp': FieldValue.serverTimestamp(),
        'userId': user.uid,
      });
      
      addDebugMessage('✅ Escritura exitosa');
      
      // Limpiar test
      final testDocs = await firestore
          .collection('debug_test')
          .where('userId', isEqualTo: user.uid)
          .get();
      
      for (var doc in testDocs.docs) {
        await doc.reference.delete();
      }
      
      addDebugMessage('🧹 Test cleanup completado');
      
    } catch (e) {
      addDebugMessage('❌ Error operaciones Firestore: $e');
    }
    
    notifyListeners();
  }

  void clearDebugMessages() {
    _debugMessages.clear();
    notifyListeners();
  }

  void reset() {
    _debugMessages.clear();
    _isFirebaseConnected = false;
    _isAuthConnected = false;
    _isFirestoreConnected = false;
    _currentUserId = null;
    _error = null;
    notifyListeners();
  }
}
