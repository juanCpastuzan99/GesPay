# 🚀 Instrucciones de Ejecución

## 🎯 Ejecución Rápida (Recomendada)

### Script Interactivo
```bash
./run_app.sh
```
- Selecciona opción 1 para versión Mock (sin Firebase)
- Selecciona opción 2 para versión Firebase

## 📱 Ejecutar con Datos Mock (Recomendado)

### Opción 1: Script Automático
```bash
./run_mock.sh
```

### Opción 2: Comando Manual
```bash
flutter run --debug -t lib/main_mock.dart
```

### 🔑 Datos de Prueba
- **Email**: `test@test.com`
- **Contraseña**: `123456`

## 🔥 Ejecutar con Firebase (Si está configurado)

```bash
flutter run --debug
```

## 📋 Características Implementadas

### ✅ Autenticación
- Login/Registro con validación
- Interfaz moderna con gradientes
- Manejo de errores

### ✅ Gestión de Gastos
- Agregar ingresos y gastos
- Categorización automática
- Validación de montos (acepta espacios: "150 000")
- Editar y eliminar transacciones

### ✅ Dashboard
- Resumen financiero
- Gráficos de categorías
- Lista de transacciones recientes
- Toggle de tema claro/oscuro

### ✅ UI/UX
- Diseño moderno con Material Design 3
- Gradientes y sombras
- Animaciones suaves
- Responsive design

## 🛠️ Solución de Problemas

### Error de Firebase en Linux
Si ves errores de Firebase, usa la versión mock:
```bash
./run_mock.sh
```

### Hot Reload
- Presiona `r` para hot reload
- Presiona `R` para hot restart
- Presiona `q` para salir

## 📁 Estructura del Proyecto

```
lib/
├── main.dart              # Versión con Firebase
├── main_mock.dart         # Versión con datos mock
├── models/
│   └── expense.dart       # Modelo de datos
├── providers/
│   ├── theme_provider.dart
│   ├── auth_provider.dart
│   ├── expense_provider.dart
│   ├── mock_auth_provider.dart
│   └── mock_expense_provider.dart
├── screens/
│   ├── auth/
│   │   ├── login_screen.dart
│   │   └── register_screen.dart
│   ├── home/
│   │   └── improved_home_screen.dart
│   └── expense/
│       ├── add_expense_screen.dart
│       ├── expense_list_screen.dart
│       └── edit_expense_screen.dart
└── firebase_options.dart
```

## 🎯 Próximos Pasos

1. **Probar la aplicación** con datos mock
2. **Configurar Firebase** para persistencia real
3. **Agregar más funcionalidades** según necesidades
4. **Optimizar UI/UX** basado en feedback

## 📞 Soporte

Si tienes problemas:
1. Verifica que Flutter esté instalado correctamente
2. Ejecuta `flutter doctor` para diagnosticar
3. Usa la versión mock si Firebase falla
4. Revisa los logs en la consola
