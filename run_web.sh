#!/bin/bash

echo "🌐 Ejecutando aplicación en Web (Firebase compatible)"
echo "=================================================="
echo ""
echo "📱 Opciones:"
echo "1. Versión Híbrida (Firebase + Mock)"
echo "2. Versión Mock (Solo Mock)"
echo "3. Versión Firebase (Solo Firebase)"
echo ""
read -p "Selecciona una opción (1, 2 o 3): " choice

case $choice in
    1)
        echo ""
        echo "🔧 Ejecutando versión HÍBRIDA en web..."
        echo "📧 Email: test@test.com"
        echo "🔑 Contraseña: 123456"
        echo ""
        flutter run -d chrome -t lib/main_hybrid.dart
        ;;
    2)
        echo ""
        echo "🔧 Ejecutando versión MOCK en web..."
        echo "📧 Email: test@test.com"
        echo "🔑 Contraseña: 123456"
        echo ""
        flutter run -d chrome -t lib/main_mock.dart
        ;;
    3)
        echo ""
        echo "🔥 Ejecutando versión FIREBASE en web..."
        echo "📧 Email: test@test.com"
        echo "🔑 Contraseña: 123456"
        echo ""
        flutter run -d chrome
        ;;
    *)
        echo "❌ Opción inválida. Ejecutando versión híbrida por defecto..."
        flutter run -d chrome -t lib/main_hybrid.dart
        ;;
esac
