#!/bin/bash

# Script de prueba para verificar la configuración de Android
# Este script verifica que todo esté configurado correctamente

echo "🧪 Probando configuración de GesPay para Android..."

# Verificar Flutter
echo "🔍 Verificando Flutter..."
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter no está instalado"
    exit 1
else
    echo "✅ Flutter está instalado"
fi

# Verificar configuración de Flutter
echo "🔍 Verificando configuración de Flutter..."
flutter doctor

# Verificar que Android esté habilitado
echo "🔍 Verificando soporte para Android..."
if flutter config --list | grep -q "enable-android.*true"; then
    echo "✅ Android está habilitado"
else
    echo "⚠️ Habilitando Android..."
    flutter config --enable-android
fi

# Verificar dispositivos Android
echo "🔍 Verificando dispositivos Android..."
flutter devices

# Verificar archivos de configuración
echo "🔍 Verificando archivos de configuración..."
if [ -f "android/app/google-services.json" ]; then
    echo "✅ google-services.json encontrado"
else
    echo "❌ google-services.json no encontrado"
    echo "💡 Descarga el archivo desde Firebase Console"
    exit 1
fi

if [ -f "android/app/build.gradle" ]; then
    echo "✅ build.gradle encontrado"
else
    echo "❌ build.gradle no encontrado"
    exit 1
fi

# Verificar dependencias de Flutter
echo "🔍 Verificando dependencias de Flutter..."
flutter pub get

# Verificar que no haya errores de linter
echo "🔍 Verificando código..."
flutter analyze

echo "✅ Todas las verificaciones completadas"
echo "🚀 La aplicación está lista para ejecutarse en Android"
echo "💡 Usa './run_android.sh' para ejecutar la aplicación"
echo "📱 Asegúrate de tener un dispositivo Android conectado o un emulador ejecutándose"
