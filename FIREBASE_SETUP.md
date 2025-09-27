# 🔥 Configuración de Firebase

Esta guía te ayudará a configurar Firebase para tu aplicación de gestión de gastos.

## 📋 Pasos para Configurar Firebase

### 1. Crear Proyecto en Firebase Console

1. Ve a [Firebase Console](https://console.firebase.google.com/)
2. Haz clic en "Crear un proyecto"
3. Ingresa el nombre del proyecto: `mi-gestor-gastos`
4. Acepta los términos y condiciones
5. Selecciona "Crear proyecto"

### 2. Configurar Authentication

1. En el panel lateral, haz clic en "Authentication"
2. Ve a la pestaña "Sign-in method"
3. Habilita "Email/Password"
4. Guarda los cambios

### 3. Configurar Firestore Database

1. En el panel lateral, haz clic en "Firestore Database"
2. Haz clic en "Crear base de datos"
3. Selecciona "Iniciar en modo de prueba" (para desarrollo)
4. Elige la ubicación más cercana a tu región
5. Haz clic en "Habilitar"

### 4. Configurar Reglas de Seguridad de Firestore

En la pestaña "Reglas" de Firestore, reemplaza las reglas con:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Reglas para la colección de gastos
    match /expenses/{expenseId} {
      allow read, write: if request.auth != null && request.auth.uid == resource.data.userId;
      allow create: if request.auth != null && request.auth.uid == request.resource.data.userId;
    }
  }
}
```

### 5. Agregar Aplicación Android

1. En la página principal del proyecto, haz clic en el ícono de Android
2. Ingresa el nombre del paquete: `com.example.flutter_aplication`
3. Descarga el archivo `google-services.json`
4. Coloca el archivo en `android/app/google-services.json`

### 6. Agregar Aplicación iOS

1. Haz clic en el ícono de iOS
2. Ingresa el ID del paquete: `com.example.flutterAplication`
3. Descarga el archivo `GoogleService-Info.plist`
4. Coloca el archivo en `ios/Runner/GoogleService-Info.plist`

### 7. Actualizar firebase_options.dart

Reemplaza el contenido de `lib/firebase_options.dart` con las claves de tu proyecto:

```dart
// Ejemplo de configuración (reemplaza con tus valores reales)
static const FirebaseOptions android = FirebaseOptions(
  apiKey: 'AIzaSyXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX',
  appId: '1:123456789:android:abcdef123456789',
  messagingSenderId: '123456789',
  projectId: 'mi-gestor-gastos',
  storageBucket: 'mi-gestor-gastos.appspot.com',
);

static const FirebaseOptions ios = FirebaseOptions(
  apiKey: 'AIzaSyXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX',
  appId: '1:123456789:ios:abcdef123456789',
  messagingSenderId: '123456789',
  projectId: 'mi-gestor-gastos',
  storageBucket: 'mi-gestor-gastos.appspot.com',
  iosBundleId: 'com.example.flutterAplication',
);
```

## 🔧 Configuración Adicional

### Agregar Dependencias de Firebase en Android

En `android/app/build.gradle`, asegúrate de tener:

```gradle
apply plugin: 'com.google.gms.google-services'

dependencies {
    implementation platform('com.google.firebase:firebase-bom:32.7.0')
    implementation 'com.google.firebase:firebase-analytics'
}
```

### Configurar iOS

En `ios/Runner/Info.plist`, agrega:

```xml
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleURLName</key>
        <string>REVERSED_CLIENT_ID</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>YOUR_REVERSED_CLIENT_ID</string>
        </array>
    </dict>
</array>
```

## 🧪 Probar la Configuración

1. Ejecuta `flutter pub get`
2. Ejecuta `flutter run`
3. Intenta crear una cuenta en la aplicación
4. Verifica que los datos se guarden en Firestore

## 🚨 Solución de Problemas

### Error: "No Firebase App '[DEFAULT]' has been created"

- Asegúrate de que `Firebase.initializeApp()` se ejecute antes de usar cualquier servicio de Firebase
- Verifica que `firebase_options.dart` tenga las claves correctas

### Error: "Permission denied"

- Verifica las reglas de seguridad de Firestore
- Asegúrate de que el usuario esté autenticado

### Error: "Network request failed"

- Verifica tu conexión a internet
- Asegúrate de que las reglas de Firestore permitan las operaciones

## 📚 Recursos Adicionales

- [Documentación oficial de Firebase](https://firebase.google.com/docs)
- [Guía de FlutterFire](https://firebase.flutter.dev/)
- [Reglas de seguridad de Firestore](https://firebase.google.com/docs/firestore/security/get-started)

---

**¡Una vez configurado, tu aplicación estará lista para usar Firebase!** 🚀
