# 🐧 GesPay - Configuración para Linux

## 📋 Requisitos del Sistema

### Dependencias del Sistema
```bash
# Ubuntu/Debian
sudo apt update
sudo apt install -y cmake ninja-build libgtk-3-dev libblkid-dev liblzma-dev

# Arch Linux
sudo pacman -S cmake ninja gtk3

# Fedora
sudo dnf install cmake ninja-build gtk3-devel
```

### Flutter
```bash
# Verificar instalación de Flutter
flutter doctor

# Asegurar que Linux esté habilitado
flutter config --enable-linux-desktop
```

## 🚀 Ejecución

### Método 1: Script Automático
```bash
# Ejecutar el script de Linux
./run_linux.sh
```

### Método 2: Comandos Manuales
```bash
# Limpiar build anterior
flutter clean

# Obtener dependencias
flutter pub get

# Ejecutar en Linux
flutter run -d linux
```

### Método 3: Build de Producción
```bash
# Crear build de producción
flutter build linux --release

# Ejecutar el ejecutable
./build/linux/x64/release/bundle/flutter_aplication
```

## 🔧 Configuración Específica para Linux

### Firebase
- ✅ Configuración automática para Linux
- ✅ Fallback a configuración web si es necesario
- ✅ Manejo de errores específico para Linux

### Características
- 🖥️ Interfaz nativa de Linux
- 🔐 Autenticación Firebase
- 💾 Base de datos Firestore
- 📱 Responsive design

## 🐛 Solución de Problemas

### Error: "No se pudo inicializar Firebase"
```bash
# Verificar configuración de Firebase
cat linux/firebase_options.json

# Reinstalar dependencias
flutter clean
flutter pub get
```

### Error: "GTK no encontrado"
```bash
# Instalar GTK3
sudo apt install libgtk-3-dev
```

### Error: "CMake no encontrado"
```bash
# Instalar CMake
sudo apt install cmake
```

## 📁 Estructura de Archivos Linux

```
linux/
├── CMakeLists.txt          # Configuración de build
├── firebase_options.json   # Configuración Firebase
├── runner/                 # Código nativo
└── flutter/               # Archivos Flutter
```

## 🎯 Características Específicas para Linux

1. **Interfaz Nativa**: Usa GTK3 para una experiencia nativa
2. **Firebase Optimizado**: Configuración específica para Linux
3. **Performance**: Build optimizado para Linux
4. **Compatibilidad**: Funciona en todas las distribuciones principales

## 🔄 Actualizaciones

Para actualizar la configuración de Linux:
```bash
# Regenerar configuración
flutter create --platforms=linux .

# Reinstalar dependencias
flutter pub get
```

## 📞 Soporte

Si tienes problemas con la configuración de Linux:
1. Verifica que todas las dependencias estén instaladas
2. Ejecuta `flutter doctor` para verificar la configuración
3. Revisa los logs en la terminal
4. Usa el script `run_linux.sh` para ejecución automática
