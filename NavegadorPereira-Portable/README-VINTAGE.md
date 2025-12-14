# 🎨 Navegador Pereira - Edición Vintage Oscuro

![Tema Vintage](https://img.shields.io/badge/Tema-Vintage%20Oscuro-d4a574?style=for-the-badge)
![Estado](https://img.shields.io/badge/Estado-Funcionando-82b67f?style=for-the-badge)

---

## ✨ Vista Previa

**Logo Animado:**
```
    ██████╗ ███████╗██████╗ ███████╗██╗██████╗  █████╗
    ██╔══██╗██╔════╝██╔══██╗██╔════╝██║██╔══██╗██╔══██╗
    ██████╔╝█████╗  ██████╔╝█████╗  ██║██████╔╝███████║
    ██╔═══╝ ██╔══╝  ██╔══██╗██╔══╝  ██║██╔══██╗██╔══██║
    ██║     ███████╗██║  ██║███████╗██║██║  ██║██║  ██║
    ╚═╝     ╚══════╝╚═╝  ╚═╝╚══════╝╚═╝╚═╝  ╚═╝╚═╝  ╚═╝
```

---

## 🎯 Características del Tema

### 🌙 **Tema Oscuro Automático**
- Modo oscuro forzado en TODO el navegador
- Paleta vintage: marrones, dorados, cremas
- Estilo retro terminal/art deco
- Sin mensaje de "API Keys de Google"

### 🖼️ **Nueva Pestaña Personalizada**
```
╔════════════════════════════════════════╗
║                                        ║
║            P E R E I R A               ║
║     Navegador Privado y Seguro        ║
║                                        ║
║    [    Buscar en DuckDuckGo...    ]  ║
║                                        ║
║  🔍 DuckDuckGo  📦 GitHub  ⚙️ Config  ║
║                                        ║
╚════════════════════════════════════════╝
```

### 🎨 **Paleta de Colores**
| Color | Hex | Uso |
|-------|-----|-----|
| 🖤 Negro Vintage | `#1a1a1a` | Fondo principal |
| 🤎 Marrón Oscuro | `#2d2020` | Degradado |
| ⚫ Gris Carbón | `#2d2d2d` | Superficies |
| 📦 Gris Medio | `#4a4a4a` | Bordes |
| 📜 Crema Vintage | `#e8d4b0` | Texto principal |
| ✨ Dorado Antiguo | `#d4a574` | Acentos |
| 🌟 Crema Claro | `#f5e6d3` | Highlights |

### 🎭 **Efectos Visuales**
- ⚡ Logo con efecto **glow** dorado animado
- 📺 Efecto **scanline** retro (línea que se mueve)
- 🎨 Decoraciones **art deco** en esquinas
- 📜 Scrollbars personalizados vintage
- 🎯 Sombras estilo retro
- 💫 Transiciones suaves

---

## 🚀 Usar el Tema

### **Ejecución Normal**
```batch
# El tema se activa AUTOMÁTICAMENTE
Pereira.bat
```

### **Flags Activos**
```bash
--force-dark-mode                    # Fuerza modo oscuro
--enable-features=WebUIDarkMode      # UI oscura
--enable-features=WebContentsForceDark # Contenido oscuro
--bwsi                               # Suprime mensaje API
--simulate-outdated-no-au            # Sin warnings
--disable-logging                    # Sin logs
```

---

## 📁 Archivos del Tema

```
config/
├── tema-vintage.css        # Estilos CSS del tema
├── nueva-pestana.html      # Página inicio personalizada
├── preferences.json        # Config tema oscuro
└── flags.txt              # Flags de Chromium

chromium/
└── master_preferences     # Suprime mensajes primera vez
```

---

## 🎨 Personalizar

### **Cambiar Colores**

Edita `config/tema-vintage.css`:

```css
:root {
  --vintage-bg: #1a1a1a;        /* Tu color de fondo */
  --vintage-accent: #d4a574;    /* Tu color de acento */
  --vintage-text: #e8d4b0;      /* Tu color de texto */
}
```

### **Modificar Nueva Pestaña**

Edita `config/nueva-pestana.html`:

```html
<!-- Cambiar logo -->
<div class="logo-text">TU NOMBRE</div>

<!-- Cambiar buscador -->
<input placeholder="Tu texto aquí..." />
```

### **Desactivar Tema Oscuro**

Edita `config/flags.txt` y comenta:

```bash
# --force-dark-mode
# --enable-features=WebUIDarkMode
```

---

## ✅ Solución: Mensaje API Keys

### **❌ ANTES:**
```
⚠️ Faltan las claves de API de Google.
   Se inhabilitarán algunas funciones de Chromium.
```

### **✅ AHORA:**
```
(Sin mensajes de advertencia)
Navegador listo para usar
```

### **Cómo se solucionó:**

1. **Flag de simulación:**
   ```
   --simulate-outdated-no-au="Tue, 31 Dec 2099 23:59:59 GMT"
   ```

2. **Modo invitado:**
   ```
   --bwsi
   ```

3. **Sin logging:**
   ```
   --disable-logging
   --disable-breakpad
   ```

4. **Configuración inicial:**
   ```
   chromium/master_preferences
   ```

---

## 🌐 Página de Inicio Vintage

### **Características:**

- ✨ Logo "PEREIRA" animado con glow dorado
- 🔍 Buscador DuckDuckGo integrado
- 📱 Enlaces rápidos personalizables
- 🎨 Decoraciones art deco en esquinas
- 📺 Efecto scanline retro
- 🌙 Fondo degradado vintage

### **Para usarla:**

**Opción 1:** Extensión New Tab Override
```
1. Instala desde Chrome Web Store
2. URL: file:///C:/ruta/config/nueva-pestana.html
```

**Opción 2:** Configuración manual
```
1. chrome://settings
2. Al iniciar → Abrir página específica
3. Añadir: file:///C:/ruta/config/nueva-pestana.html
```

---

## 🎭 Inspiración del Diseño

**Estilo:** Terminal Retro + Art Deco + Años 20-30

**Influencias:**
- 🖥️ Terminales antiguas de computadora
- 🏛️ Diseño art deco
- ⚙️ Estética vintage/steampunk
- 📜 Paleta sepia/marrón

---

## 📸 Capturas del Tema

### **Nueva Pestaña:**
- Logo "PEREIRA" dorado brillante
- Fondo degradado oscuro
- Decoraciones en esquinas
- Efecto scanline animado

### **Interfaz del Navegador:**
- UI completamente oscura
- Botones estilo retro
- Scrollbars vintage
- Menús con borde art deco

### **Páginas Web:**
- Forzado a modo oscuro
- Colores invertidos automáticamente
- Mejor legibilidad nocturna

---

## 🔧 Solución de Problemas

### **El tema no se aplica:**
```bash
1. Verifica que ejecutas Pereira.bat
2. Reinicia el navegador completamente
3. Limpia cache: chrome://settings/clearBrowserData
```

### **Nueva pestaña no aparece:**
```bash
1. Verifica la ruta del archivo HTML
2. Usa ruta absoluta completa
3. Prueba con extensión New Tab Override
```

### **Colores no cambian:**
```bash
1. Verifica flags en config/flags.txt
2. Asegúrate de tener --force-dark-mode
3. Reinicia el navegador
```

---

## 📋 Checklist de Instalación

- [x] Chromium descargado
- [x] Tema vintage configurado
- [x] Mensaje API keys suprimido
- [x] Nueva pestaña personalizada
- [x] Flags de modo oscuro activos
- [x] Master preferences creado
- [x] Paleta de colores vintage
- [x] Efectos visuales retro

---

## 🎁 Extras Incluidos

- 📜 **tema-vintage.css** - Estilos completos
- 🌐 **nueva-pestana.html** - Página inicio HTML/CSS/JS
- 📝 **TEMA-VINTAGE.txt** - Documentación completa
- ⚙️ **master_preferences** - Config primera ejecución
- 🚀 **Pereira.bat** - Launcher con todos los flags

---

## 📊 Comparación

| Característica | Chrome Normal | Pereira Vintage |
|----------------|---------------|-----------------|
| **Tema** | Claro/Oscuro básico | Vintage oscuro personalizado |
| **Nueva pestaña** | Google estándar | Página personalizada retro |
| **Colores** | Grises/Azules | Marrones/Dorados vintage |
| **Mensaje API** | ⚠️ Aparece | ✅ Suprimido |
| **Estilo** | Moderno | Retro/Art Deco |
| **Animaciones** | Básicas | Glow, scanline, efectos |

---

## 🌟 Resumen

**Navegador Pereira Edición Vintage Oscuro** es un navegador Chromium completamente personalizado con:

✅ Tema oscuro vintage automático
✅ Sin mensaje de API keys de Google
✅ Página de inicio retro personalizada
✅ Logo animado con efectos
✅ Paleta de colores art deco
✅ Experiencia visual única
✅ 100% privacidad y seguridad
✅ Portable y listo para usar

---

<div align="center">

**🎨 NAVEGADOR PEREIRA**
**EDICIÓN VINTAGE OSCURO**

*Privacidad · Seguridad · Estilo Retro*

[GitHub](https://github.com/Alcano3520/NAVEGADOR_PEREIRA) • [Docs](../docs/) • [Issues](https://github.com/Alcano3520/NAVEGADOR_PEREIRA/issues)

**v1.0 Vintage** • 2025

</div>
