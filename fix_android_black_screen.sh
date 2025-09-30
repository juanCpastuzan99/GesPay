#!/bin/bash

# Script para solucionar pantalla negra en Android Studio
# Este script resuelve los problemas más comunes

echo "🔧 Solucionando pantalla negra en Android Studio..."

# 1. Limpiar cache de Flutter
echo "🧹 Limpiando cache de Flutter..."
flutter clean
flutter pub get

# 2. Verificar configuración
echo "🔍 Verificando configuración..."
flutter doctor -v

# 3. Verificar dispositivos
echo "📱 Verificando dispositivos..."
flutter devices

# 4. Si no hay dispositivos, iniciar emulador
if ! flutter devices | grep -q "android"; then
    echo "🚀 Iniciando emulador..."
    flutter emulators --launch Pixel_5
    sleep 10  # Esperar a que el emulador se inicie
fi

# 5. Verificar que el emulador esté funcionando
echo "⏳ Esperando a que el emulador esté listo..."
sleep 5

# 6. Ejecutar la aplicación
echo "🎯 Ejecutando aplicación..."
flutter run -d android --verbose

echo "✅ Script completado"
echo "💡 Si aún tienes pantalla negra, revisa:"
echo "   - Que el emulador esté completamente iniciado"
echo "   - Que no haya errores en la consola"
echo "   - Que la aplicación se esté compilando correctamente"


