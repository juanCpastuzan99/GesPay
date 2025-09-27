# 🔍 Debug: Problema con Guardado de Gastos

## Pasos para Diagnosticar:

### 1. ✅ Verificar Logs en Consola
Ejecuta la app y revisa la consola para ver estos mensajes:
- `"Cargando gastos para usuario: [UID]"`
- `"Documentos encontrados: [NÚMERO]"`
- `"Gastos cargados: [NÚMERO]"`

### 2. ✅ Verificar Firebase Console
1. Ve a [Firebase Console](https://console.firebase.google.com/)
2. Selecciona tu proyecto "gespay-27b63"
3. Ve a "Firestore Database"
4. Verifica que exista la colección "expenses"
5. Revisa si hay documentos guardados

### 3. ✅ Verificar Reglas de Firestore
1. En Firebase Console, ve a "Firestore Database" > "Rules"
2. Asegúrate de que las reglas permitan lectura/escritura para usuarios autenticados
3. Reglas recomendadas:
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /expenses/{expenseId} {
      allow read, write: if request.auth != null 
        && request.auth.uid == resource.data.userId;
      allow create: if request.auth != null 
        && request.auth.uid == request.resource.data.userId;
    }
  }
}
```

### 4. ✅ Verificar Autenticación
- Asegúrate de estar logueado
- Verifica que el UID del usuario sea correcto
- Revisa que no haya errores de autenticación

### 5. ✅ Verificar Conexión a Internet
- Asegúrate de tener conexión a internet
- Verifica que Firebase esté accesible

## Posibles Causas:

1. **Reglas de Firestore muy restrictivas**
2. **Usuario no autenticado correctamente**
3. **Problema de conexión a Firebase**
4. **Error en la estructura de datos**
5. **Problema con el UID del usuario**

## Soluciones:

### Si no aparecen logs:
- Verifica que la app esté ejecutándose
- Revisa la consola de Flutter
- Asegúrate de que Firebase esté inicializado

### Si aparecen errores de permisos:
- Actualiza las reglas de Firestore
- Verifica que el usuario esté autenticado

### Si no se guardan en Firestore:
- Verifica la conexión a internet
- Revisa las reglas de seguridad
- Verifica que el proyecto de Firebase esté correcto
