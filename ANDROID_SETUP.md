# 📱 GesPay - Configuración para Android

## 📋 Requisitos del Sistema

### Dependencias del Sistema
```bash
# Ubuntu/Debian
sudo apt update
sudo apt install -y openjdk-11-jdk android-tools-adb

# Arch Linux
sudo pacman -S jdk11-openjdk android-tools

# Fedora
sudo dnf install java-11-openjdk-devel android-tools
```

### Flutter
```bash
# Verificar instalación de Flutter
flutter doctor

# Asegurar que Android esté habilitado
flutter config --enable-android
```

### Android Studio
1. **Instalar Android Studio** desde [developer.android.com](https://developer.android.com/studio)
2. **Configurar SDK** - Asegurar que Android SDK esté instalado
3. **Habilitar USB Debugging** en tu dispositivo Android

## 🚀 Ejecución

### Método 1: Script Automático
```bash
# Ejecutar el script de Android
./run_android.sh
```

### Método 2: Comandos Manuales
```bash
# Limpiar build anterior
flutter clean

# Obtener dependencias
flutter pub get

# Ejecutar en Android
flutter run -d android
```

### Método 3: Build de Producción
```bash
# Crear APK de producción
flutter build apk --release

# Instalar APK
flutter install
```

## 🔧 Configuración Específica para Android

### Firebase
- ✅ `google-services.json` configurado
- ✅ Firebase Auth para Android
- ✅ Firestore para Android
- ✅ Configuración automática

### Características
- 📱 Interfaz nativa de Android
- 🔐 Autenticación Firebase
- 💾 Base de datos Firestore
- 📱 Material Design
- 🔄 Responsive design

## 🐛 Solución de Problemas

### Error: "No devices found"
```bash
# Verificar dispositivos conectados
flutter devices

# Verificar ADB
adb devices

# Reiniciar ADB si es necesario
adb kill-server
adb start-server
```

### Error: "USB Debugging not enabled"
1. Ir a **Configuración** > **Acerca del teléfono**
2. Tocar **Número de compilación** 7 veces
3. Ir a **Configuración** > **Opciones de desarrollador**
4. Habilitar **Depuración USB**

### Error: "Google Services not found"
```bash
# Verificar que google-services.json esté en android/app/
ls android/app/google-services.json

# Si no existe, descargarlo desde Firebase Console
```

## 📁 Estructura de Archivos Android

```
android/
├── app/
│   ├── build.gradle          # Configuración de build
│   ├── google-services.json  # Configuración Firebase
│   └── src/main/java/        # Código nativo
├── build.gradle              # Configuración del proyecto
└── gradle/                   # Gradle wrapper
```

## 🎯 Características Específicas para Android

1. **Interfaz Nativa**: Usa Material Design
2. **Firebase Optimizado**: Configuración específica para Android
3. **Performance**: Build optimizado para Android
4. **Compatibilidad**: Funciona en Android 5.0+ (API 21+)

## 🔄 Actualizaciones

Para actualizar la configuración de Android:
```bash
# Regenerar configuración
flutter create --platforms=android .

# Reinstalar dependencias
flutter pub get
```

## 📱 Dispositivos Soportados

- **Android 5.0+** (API 21+)
- **Teléfonos y tablets**
- **Emuladores Android**
- **Dispositivos físicos con USB Debugging**

## 🚀 Comandos Útiles

```bash
# Ver dispositivos conectados
flutter devices

# Ejecutar en dispositivo específico
flutter run -d <device-id>

# Hot reload
r

# Hot restart
R

# Salir
q
```

## 📞 Soporte

Si tienes problemas con la configuración de Android:
1. Verifica que todas las dependencias estén instaladas
2. Ejecuta `flutter doctor` para verificar la configuración
3. Revisa que el dispositivo esté conectado y con USB debugging habilitado
4. Usa el script `run_android.sh` para ejecución automática
