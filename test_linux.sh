#!/bin/bash

# Script de prueba para verificar la configuración de Linux
# Este script verifica que todo esté configurado correctamente

echo "🧪 Probando configuración de GesPay para Linux..."

# Verificar Flutter
echo "🔍 Verificando Flutter..."
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter no está instalado"
    exit 1
else
    echo "✅ Flutter está instalado"
fi

# Verificar dependencias del sistema
echo "🔍 Verificando dependencias del sistema..."
if ! command -v cmake &> /dev/null; then
    echo "❌ CMake no está instalado"
    echo "💡 Instala con: sudo apt install cmake"
    exit 1
else
    echo "✅ CMake está instalado"
fi

if ! command -v ninja &> /dev/null; then
    echo "❌ Ninja no está instalado"
    echo "💡 Instala con: sudo apt install ninja-build"
    exit 1
else
    echo "✅ Ninja está instalado"
fi

# Verificar configuración de Flutter
echo "🔍 Verificando configuración de Flutter..."
flutter doctor

# Verificar que Linux esté habilitado
echo "🔍 Verificando soporte para Linux..."
if flutter config --list | grep -q "enable-linux-desktop.*true"; then
    echo "✅ Linux desktop está habilitado"
else
    echo "⚠️ Habilitando Linux desktop..."
    flutter config --enable-linux-desktop
fi

# Verificar archivos de configuración
echo "🔍 Verificando archivos de configuración..."
if [ -f "linux/firebase_options.json" ]; then
    echo "✅ firebase_options.json encontrado"
else
    echo "❌ firebase_options.json no encontrado"
    exit 1
fi

if [ -f "lib/config/linux_config.dart" ]; then
    echo "✅ linux_config.dart encontrado"
else
    echo "❌ linux_config.dart no encontrado"
    exit 1
fi

# Verificar dependencias de Flutter
echo "🔍 Verificando dependencias de Flutter..."
flutter pub get

# Verificar que no haya errores de linter
echo "🔍 Verificando código..."
flutter analyze

echo "✅ Todas las verificaciones completadas"
echo "🚀 La aplicación está lista para ejecutarse en Linux"
echo "💡 Usa './run_linux.sh' para ejecutar la aplicación"
