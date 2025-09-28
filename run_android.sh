#!/bin/bash

# Script para ejecutar GesPay en Android
# Este script asegura que la aplicación funcione correctamente en Android

echo "🚀 Iniciando GesPay para Android..."

# Verificar que Flutter esté instalado
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter no está instalado. Por favor instala Flutter primero."
    exit 1
fi

# Verificar que estemos en el directorio correcto
if [ ! -f "pubspec.yaml" ]; then
    echo "❌ No se encontró pubspec.yaml. Asegúrate de estar en el directorio del proyecto."
    exit 1
fi

# Verificar dispositivos Android conectados
echo "📱 Verificando dispositivos Android..."
flutter devices

# Limpiar build anterior
echo "🧹 Limpiando build anterior..."
flutter clean

# Obtener dependencias
echo "📦 Obteniendo dependencias..."
flutter pub get

# Verificar configuración de Android
echo "🔍 Verificando configuración de Android..."
if [ -f "android/app/google-services.json" ]; then
    echo "✅ google-services.json encontrado"
else
    echo "❌ google-services.json no encontrado"
    echo "💡 Asegúrate de tener el archivo de configuración de Firebase para Android"
    exit 1
fi

# Ejecutar la aplicación en Android
echo "🎯 Ejecutando GesPay en Android..."
echo "📱 La aplicación se instalará en tu dispositivo Android"
echo "🔧 Si hay problemas, revisa que el dispositivo esté conectado y con USB debugging habilitado"

# Ejecutar con configuración específica para Android
flutter run -d android

echo "✅ GesPay se ha ejecutado en Android"
