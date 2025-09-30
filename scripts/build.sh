#!/bin/bash

# Script de build para GesPay
# Equivalente a "npm run build" en Nest.js

echo "🔨 Construyendo GesPay..."

# Limpiar build anterior
echo "🧹 Limpiando build anterior..."
flutter clean

# Obtener dependencias
echo "📦 Obteniendo dependencias..."
flutter pub get

# Construir APK
echo "🏗️ Construyendo APK..."
flutter build apk --release

echo "✅ Build completado en build/app/outputs/flutter-apk/"


