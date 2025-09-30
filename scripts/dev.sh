#!/bin/bash

# Script de desarrollo para GesPay
# Equivalente a "npm run dev" en Nest.js

echo "🚀 Iniciando GesPay en modo desarrollo..."

# Verificar que el emulador esté corriendo
if ! flutter devices | grep -q "emulator"; then
    echo "📱 Iniciando emulador Android..."
    flutter emulators --launch Pixel_5
    sleep 10
fi

# Ejecutar en modo desarrollo con hot reload
echo "🔥 Ejecutando con Hot Reload..."
flutter run --hot --debug

echo "✅ Desarrollo iniciado. Presiona 'r' para Hot Reload, 'R' para Hot Restart"


