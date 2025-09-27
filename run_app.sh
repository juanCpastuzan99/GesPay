#!/bin/bash

echo "🚀 Gestor de Gastos - Flutter App"
echo "================================="
echo ""
echo "📱 Opciones de ejecución:"
echo "1. Versión Mock (Recomendada - Sin Firebase)"
echo "2. Versión Firebase (Requiere configuración)"
echo ""
read -p "Selecciona una opción (1 o 2): " choice

case $choice in
    1)
        echo ""
        echo "🔧 Ejecutando versión MOCK..."
        echo "📧 Email: test@test.com"
        echo "🔑 Contraseña: 123456"
        echo ""
        flutter run --debug -t lib/main_mock.dart
        ;;
    2)
        echo ""
        echo "🔥 Ejecutando versión FIREBASE..."
        echo "⚠️  Nota: Puede fallar si Firebase no está configurado"
        echo ""
        flutter run --debug
        ;;
    *)
        echo "❌ Opción inválida. Ejecutando versión mock por defecto..."
        flutter run --debug -t lib/main_mock.dart
        ;;
esac
