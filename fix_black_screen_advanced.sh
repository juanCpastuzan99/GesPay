#!/bin/bash

# Script avanzado para solucionar pantalla negra en Android
# Incluye múltiples soluciones y verificaciones

echo "🔧 Solucionando pantalla negra en Android - Versión Avanzada..."

# 1. Limpiar completamente el proyecto
echo "🧹 Limpiando proyecto completamente..."
flutter clean
rm -rf build/
rm -rf .dart_tool/
flutter pub get

# 2. Verificar configuración de Android
echo "🔍 Verificando configuración de Android..."
flutter doctor -v

# 3. Verificar que el emulador esté funcionando
echo "📱 Verificando emuladores..."
flutter devices

# 4. Si no hay emulador, iniciar uno
if ! flutter devices | grep -q "emulator"; then
    echo "🚀 Iniciando emulador Pixel_5..."
    flutter emulators --launch Pixel_5
    echo "⏳ Esperando a que el emulador se inicie (30 segundos)..."
    sleep 30
fi

# 5. Verificar que el emulador esté listo
echo "🔍 Verificando que el emulador esté listo..."
flutter devices

# 6. Configuraciones adicionales para evitar pantalla negra
echo "⚙️ Aplicando configuraciones adicionales..."

# Crear archivo de configuración temporal
cat > android/app/src/main/res/values/styles.xml << 'EOF'
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <style name="LaunchTheme" parent="@android:style/Theme.Light.NoTitleBar">
        <item name="android:windowBackground">@android:color/white</item>
        <item name="android:windowNoTitle">true</item>
        <item name="android:windowFullscreen">false</item>
        <item name="android:windowIsTranslucent">false</item>
    </style>
    <style name="NormalTheme" parent="@android:style/Theme.Light.NoTitleBar">
        <item name="android:windowBackground">@android:color/white</item>
    </style>
</resources>
EOF

# 7. Ejecutar con configuraciones optimizadas
echo "🎯 Ejecutando aplicación con configuraciones optimizadas..."
flutter run -d android \
    --verbose \
    --enable-software-rendering \
    --no-sound-null-safety \
    --dart-define=FLUTTER_WEB_USE_SKIA=true

echo "✅ Script completado"
echo ""
echo "💡 Si aún tienes pantalla negra, prueba estas soluciones adicionales:"
echo "   1. Reinicia el emulador completamente"
echo "   2. Verifica que no haya errores en la consola"
echo "   3. Prueba con un emulador diferente"
echo "   4. Verifica la configuración de Firebase"
echo "   5. Revisa los logs de Android Studio"


