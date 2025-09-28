#!/bin/bash

# Script para ejecutar GesPay en Linux
# Este script asegura que la aplicación funcione correctamente en Linux

echo "🚀 Iniciando GesPay para Linux..."

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

# Limpiar build anterior
echo "🧹 Limpiando build anterior..."
flutter clean

# Obtener dependencias
echo "📦 Obteniendo dependencias..."
flutter pub get

# Verificar que las dependencias estén correctas
echo "🔍 Verificando dependencias..."
flutter doctor

# Ejecutar la aplicación en Linux
echo "🎯 Ejecutando GesPay en Linux..."
echo "📱 La aplicación se abrirá en una nueva ventana"
echo "🔧 Si hay problemas, revisa los logs en la terminal"

# Ejecutar con configuración específica para Linux
flutter run -d linux --release

echo "✅ GesPay se ha ejecutado en Linux"
