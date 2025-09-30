#!/bin/bash

echo "🔍 Iniciando test de debug con Google..."
echo "=================================="

# Verificar que Flutter esté instalado
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter no está instalado"
    exit 1
fi

echo "✅ Flutter encontrado: $(flutter --version | head -n 1)"

# Verificar que estemos en el directorio correcto
if [ ! -f "pubspec.yaml" ]; then
    echo "❌ No se encontró pubspec.yaml. Ejecuta desde el directorio del proyecto."
    exit 1
fi

echo "✅ Directorio del proyecto encontrado"

# Limpiar y obtener dependencias
echo "🧹 Limpiando proyecto..."
flutter clean
flutter pub get

echo "📦 Dependencias actualizadas"

# Verificar configuración de Firebase
echo "🔧 Verificando configuración de Firebase..."
if [ -f "lib/firebase_options.dart" ]; then
    echo "✅ firebase_options.dart encontrado"
else
    echo "❌ firebase_options.dart no encontrado"
    exit 1
fi

if [ -f "android/app/google-services.json" ]; then
    echo "✅ google-services.json encontrado"
else
    echo "❌ google-services.json no encontrado"
fi

# Ejecutar la aplicación en modo debug
echo "🚀 Iniciando aplicación en modo debug..."
echo "=================================="
echo "📱 La aplicación se abrirá con debug habilitado"
echo "🔍 Usa el botón 'Debug con Google' para probar la conexión"
echo "=================================="

flutter run --debug
