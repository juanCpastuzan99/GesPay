# 🔥 GesPay - Gestión Inteligente de Gastos

<div align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter">
  <img src="https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black" alt="Firebase">
  <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart">
  <img src="https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=white" alt="Android">
  <img src="https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black" alt="Linux">
</div>

<div align="center">
  <h3>📱 Una aplicación moderna para gestionar tus gastos de forma inteligente</h3>
  <p>Desarrollada con Flutter y Firebase Authentication</p>
</div>

---

## 🚀 Características Principales

### ✨ **Autenticación Segura**
- 🔐 **Firebase Authentication** integrado
- 👤 **Registro y Login** con validación completa
- 🔒 **Gestión de sesiones** automática
- 🛡️ **Manejo de errores** robusto

### 💰 **Gestión de Gastos**
- ➕ **Crear gastos** con categorías personalizadas
- ✏️ **Editar gastos** existentes
- 🗑️ **Eliminar gastos** con confirmación
- 📊 **Estadísticas** en tiempo real
- 💳 **Balance** automático (Ingresos - Gastos)

### 🎨 **Interfaz Moderna**
- 🌈 **Gradientes** y animaciones fluidas
- 🌙 **Tema claro/oscuro** automático
- 📱 **Diseño responsive** para todos los dispositivos
- ⚡ **Navegación intuitiva**
- 🎯 **UX optimizada** con validaciones en tiempo real

### 🔧 **Tecnologías**
- **Flutter** - Framework multiplataforma
- **Firebase** - Autenticación y base de datos
- **Provider** - Gestión de estado
- **Material Design** - Componentes modernos

---

## 📸 Capturas de Pantalla

<div align="center">
  <img src="assets/images/screenshot1.png" alt="Login Screen" width="200">
  <img src="assets/images/screenshot2.png" alt="Home Screen" width="200">
  <img src="assets/images/screenshot3.png" alt="Add Expense" width="200">
</div>

---

## 🛠️ Instalación y Configuración

### **Prerrequisitos**
- Flutter SDK (>=3.29.0)
- Dart SDK (>=3.9.0)
- Android Studio / VS Code
- Cuenta de Firebase

### **1. Clonar el repositorio**
```bash
git clone https://github.com/tu-usuario/flutter_aplication.git
cd flutter_aplication
```

### **2. Instalar dependencias**
```bash
flutter pub get
```

### **3. Configurar Firebase**
1. Crear proyecto en [Firebase Console](https://console.firebase.google.com/)
2. Habilitar Authentication
3. Descargar `google-services.json` (Android)
4. Colocar en `android/app/`

### **4. Ejecutar la aplicación**
```bash
# Android
flutter run

# Linux
flutter run -d linux

# Web
flutter run -d web
```

---

## 🧪 Credenciales de Prueba

### **Login Exitoso:**
```
Email: test@test.com
Contraseña: 123456
```

### **Registro Exitoso:**
```
Email: cualquier@email.com (excepto test@test.com)
Contraseña: cualquier contraseña (mínimo 6 caracteres)
```

---

## 📁 Estructura del Proyecto

```
lib/
├── 📱 screens/
│   ├── auth/
│   │   ├── login_screen.dart
│   │   └── register_screen.dart
│   ├── home/
│   │   └── improved_home_screen.dart
│   └── expense/
│       ├── add_expense_screen.dart
│       ├── edit_expense_screen.dart
│       └── expense_list_screen.dart
├── 🔧 providers/
│   ├── firebase_auth_provider.dart
│   ├── mock_expense_provider.dart
│   └── theme_provider.dart
├── 📊 models/
│   ├── user.dart
│   └── expense.dart
├── 🎨 widgets/
└── 🚀 main.dart
```

---

## 🚀 Funcionalidades Detalladas

### **🔐 Sistema de Autenticación**
- ✅ **Registro** con validación de email
- ✅ **Login** con credenciales seguras
- ✅ **Logout** automático
- ✅ **Persistencia** de sesión
- ✅ **Manejo de errores** con mensajes claros

### **💰 Gestión de Gastos**
- ✅ **CRUD completo** (Crear, Leer, Actualizar, Eliminar)
- ✅ **Categorías** personalizables
- ✅ **Fechas** con validación
- ✅ **Montos** con formato de moneda
- ✅ **Descripciones** detalladas

### **📊 Dashboard Inteligente**
- ✅ **Resumen financiero** en tiempo real
- ✅ **Gráficos** de gastos por categoría
- ✅ **Balance** automático
- ✅ **Estadísticas** mensuales

---

## 🎨 Personalización

### **Temas Disponibles**
- 🌞 **Tema Claro** - Diseño limpio y moderno
- 🌙 **Tema Oscuro** - Perfecto para uso nocturno
- 🔄 **Cambio automático** según preferencias del sistema

### **Colores Principales**
```dart
Primary: #667eea (Azul gradiente)
Secondary: #764ba2 (Púrpura gradiente)
Accent: #FFCA28 (Amarillo Firebase)
```

---

## 🧪 Testing

### **Ejecutar tests**
```bash
flutter test
```

### **Análisis de código**
```bash
flutter analyze
```

### **Formateo de código**
```bash
dart format .
```

---

## 📦 Scripts Útiles

### **Ejecutar en diferentes plataformas**
```bash
# Android
./run_app.sh

# Linux
flutter run -d linux

# Web
./run_web.sh

# Modo mock (sin Firebase)
./run_mock.sh
```

---

## 🤝 Contribuir

1. **Fork** el proyecto
2. **Crear** una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. **Commit** tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. **Push** a la rama (`git push origin feature/AmazingFeature`)
5. **Abrir** un Pull Request

---

## 📝 Changelog

### **v1.0.0** - 🎉 Lanzamiento Inicial
- ✅ Sistema de autenticación completo
- ✅ Gestión de gastos CRUD
- ✅ Interfaz moderna con gradientes
- ✅ Temas claro/oscuro
- ✅ Soporte multiplataforma

---

## 🐛 Reportar Bugs

Si encuentras algún bug, por favor:
1. **Verifica** que no esté reportado en [Issues](../../issues)
2. **Crea** un nuevo issue con:
   - Descripción detallada
   - Pasos para reproducir
   - Capturas de pantalla
   - Información del dispositivo

---

## 📄 Licencia

Este proyecto está bajo la Licencia MIT. Ver el archivo [LICENSE](LICENSE) para más detalles.

---

## 👨‍💻 Autor

**Juan** - [@pastuzan99juan](https://github.com/pastuzan99juan)

---

## 🙏 Agradecimientos

- **Flutter Team** por el framework increíble
- **Firebase** por los servicios backend
- **Material Design** por los componentes
- **Comunidad Flutter** por el apoyo constante

---

<div align="center">
  <p>Hecho con ❤️ usando Flutter</p>
  <p>⭐ Si te gusta el proyecto, ¡dale una estrella!</p>
</div>