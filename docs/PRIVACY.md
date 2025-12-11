# Guía de Privacidad - Navegador Pereira

## 🎯 Filosofía de Privacidad

**Principio fundamental:** Ningún dato del usuario debe salir de su máquina sin consentimiento explícito.

## 🚫 Servicios Google Deshabilitados

### Telemetría y Rastreo

| Servicio | Estado | Archivo de Config |
|----------|--------|-------------------|
| Google Analytics | ❌ Bloqueado | blocked-domains.txt |
| Crash Reporting | ❌ Deshabilitado | disable-google-services.gn |
| Usage Statistics | ❌ Deshabilitado | default-preferences.json |
| RLZ Tracking | ❌ Bloqueado | blocked-domains.txt |

### Funcionalidades en la Nube

| Servicio | Estado | Alternativa |
|----------|--------|-------------|
| Google Sync | ❌ Deshabilitado | Sync local/propio servidor |
| Google DNS | ❌ Bloqueado | DNS del sistema |
| Google SafeBrowsing | ❌ Deshabilitado | Listas locales |
| Google Translate | ❌ Deshabilitado | Extensiones de terceros |
| Google Geolocation | ❌ Bloqueado | Permisos manuales |

### Búsqueda y Sugerencias

| Función | Estado | Configuración |
|---------|--------|---------------|
| Sugerencias de búsqueda | ❌ Deshabilitado | `enable_omnibox_suggest = false` |
| Autocompletado remoto | ❌ Deshabilitado | Preferencias |
| Precarga de páginas | ❌ Deshabilitado | `network_prediction_options = 2` |
| DNS Prefetch | ❌ Deshabilitado | `dns_prefetching.enabled = false` |

## ✅ Configuraciones de Privacidad Activas

### Cookies y Almacenamiento

```json
{
  "block_third_party_cookies": true,
  "block_all_third_party_cookies": true
}
```

**Efecto:**
- Cookies de terceros bloqueadas por defecto
- Solo sitios visitados directamente pueden guardar cookies
- Previene rastreo entre sitios

### Do Not Track (DNT)

```json
{
  "enable_do_not_track": true
}
```

**Efecto:**
- Envía header DNT:1 en todas las peticiones
- Solicita a sitios no rastrear

### Referrers

```json
{
  "enable_referrers": false
}
```

**Efecto:**
- No envía header Referer
- Sitios no sabrán de dónde vienes

### Permisos por Defecto

Todos los permisos sensibles **denegados** por defecto:

```json
{
  "geolocation": 2,          // Bloquear
  "notifications": 2,        // Bloquear
  "media_stream": 2,         // Bloquear (cámara/mic)
  "media_stream_mic": 2,     // Bloquear
  "media_stream_camera": 2,  // Bloquear
  "automatic_downloads": 2,  // Bloquear
  "midi_sysex": 2,          // Bloquear
  "push_messaging": 2       // Bloquear
}
```

El usuario debe **aprobar explícitamente** cada permiso.

## 🔍 Auditoría de Conexiones

### Verificar Conexiones de Red

```bash
# Linux/Mac
lsof -i -n -P | grep chrome

# Windows (PowerShell)
netstat -ano | findstr "chrome"
```

### Conexiones Esperadas

**Permitidas:**
- Sitios web que visitas directamente
- Servicios de actualización (opcional, puedes deshabilitarlo)

**Bloqueadas (ver blocked-domains.txt):**
- clients*.google.com
- safebrowsing.google.com
- analytics.google.com
- doubleclick.net
- googleadservices.com

### Herramienta de Análisis

Usa `mitmproxy` para ver todo el tráfico:

```bash
# Instalar mitmproxy
pip install mitmproxy

# Ejecutar proxy
mitmproxy -p 8080

# Ejecutar navegador con proxy
./chromium/src/out/Release/chrome --proxy-server="127.0.0.1:8080"
```

## 🛡️ Hardening Adicional

### 1. Deshabilitar WebRTC IP Leak

WebRTC puede filtrar tu IP real incluso con VPN.

**En configs/privacy/disable-google-services.gn:**
```gn
rtc_use_h264 = false
```

**Alternativa:** Extensión "WebRTC Leak Prevent"

### 2. HTTPS Forzado

Configuración activa en `default-preferences.json`:
```json
{
  "ssl": {
    "version_min": "tls1.2"
  }
}
```

**Efecto:**
- Solo acepta TLS 1.2 o superior
- Bloquea sitios con TLS 1.0/1.1 inseguro

### 3. Sin Autofill

```json
{
  "autofill": {
    "enabled": false,
    "profile_enabled": false,
    "credit_card_enabled": false
  }
}
```

**Efecto:**
- No guarda contraseñas localmente
- No guarda información de tarjetas
- No autocompletacredenciales

### 4. Gestor de Contraseñas Externo

Recomendaciones:
- **Bitwarden** (código abierto)
- **KeePassXC** (local)
- **pass** (línea de comandos)

## 📊 Comparación con Otros Navegadores

| Característica | Chrome | Firefox | Brave | Navegador Pereira |
|----------------|--------|---------|-------|-------------------|
| Telemetría Google | ✅ Sí | ❌ No | ❌ No | ❌ **No** |
| Cookies 3rd party | ⚠️ Permitidas | ⚠️ Algunas | ❌ Bloqueadas | ❌ **Bloqueadas** |
| DNS Prefetch | ✅ Sí | ⚠️ Opcional | ❌ No | ❌ **No** |
| SafeBrowsing Google | ✅ Sí | ⚠️ Opcional | ❌ No | ❌ **No** |
| Código abierto | ✅ Sí | ✅ Sí | ✅ Sí | ✅ **Sí** |
| Actualizaciones auto | ✅ Sí | ✅ Sí | ✅ Sí | ⚠️ **Manual** |

## ⚙️ Configuración Avanzada

### Flags Recomendados (chrome://flags)

Accede a `chrome://flags` y configura:

```
#enable-parallel-downloading
Estado: Enabled
Efecto: Descargas más rápidas

#smooth-scrolling
Estado: Enabled
Efecto: Scroll suave

#enable-quic
Estado: Enabled
Efecto: HTTP/3 para sitios compatibles

#enable-webrtc-hide-local-ips-with-mdns
Estado: Enabled
Efecto: Oculta IP local en WebRTC
```

### Política de Extensiones

**Instalar solo desde:**
1. Chrome Web Store (verificar permisos)
2. Código fuente auditado
3. Extensiones de confianza

**Extensiones recomendadas:**
- **uBlock Origin**: Bloqueador de anuncios/rastreadores
- **Privacy Badger**: Anti-rastreo inteligente
- **HTTPS Everywhere**: Fuerza HTTPS
- **Decentraleyes**: CDN local
- **ClearURLs**: Limpia parámetros de rastreo en URLs

## 📱 Sincronización Privada (Opcional)

Si necesitas sincronización entre dispositivos:

### Opción 1: Servidor Propio

Usa **Bitwarden** o **Firefox Sync Server** (compatible con Chromium modificado)

### Opción 2: Exportación Manual

```bash
# Exportar marcadores
chromium/src/out/Release/chrome --export-bookmarks

# Importar en otro dispositivo
chromium/src/out/Release/chrome --import-bookmarks
```

## 🔒 Almacenamiento Local

### Ubicación de Datos del Usuario

**Windows:**
```
C:\Users\[USUARIO]\AppData\Local\Navegador Pereira\User Data
```

**Linux:**
```
~/.config/navegador-pereira
```

**macOS:**
```
~/Library/Application Support/Navegador Pereira
```

### Limpiar Datos

```bash
# Linux/Mac
rm -rf ~/.config/navegador-pereira

# Windows (PowerShell)
Remove-Item -Recurse -Force "$env:LOCALAPPDATA\Navegador Pereira"
```

## 📝 Verificar Configuraciones

### Script de Verificación

```bash
# Crear script verify-privacy.sh
#!/bin/bash

echo "Verificando configuraciones de privacidad..."

PREFS="$HOME/.config/navegador-pereira/Default/Preferences"

if [ ! -f "$PREFS" ]; then
    echo "❌ Archivo de preferencias no encontrado"
    exit 1
fi

# Verificar configuraciones clave
grep -q '"block_third_party_cookies":true' "$PREFS" && echo "✅ Cookies de terceros bloqueadas" || echo "❌ Cookies de terceros NO bloqueadas"

grep -q '"enabled":false' "$PREFS" | grep -A2 safebrowsing && echo "✅ SafeBrowsing deshabilitado" || echo "❌ SafeBrowsing activo"

grep -q '"enable_do_not_track":true' "$PREFS" && echo "✅ Do Not Track activo" || echo "❌ Do Not Track inactivo"

echo "Verificación completada"
```

## 🌐 Motores de Búsqueda Privados

Navegador Pereira no incluye Google como buscador por defecto.

**Recomendados:**
1. **DuckDuckGo** - Sin rastreo, buenos resultados
2. **Startpage** - Resultados de Google sin rastreo
3. **Searx** - Metabuscador de código abierto
4. **Brave Search** - Sin rastreo, índice propio

**Configurar en:**
`chrome://settings/searchEngines`

## 📚 Recursos Adicionales

- [Privacytools.io](https://www.privacytools.io/)
- [Electronic Frontier Foundation](https://www.eff.org/issues/privacy)
- [Ungoogled Chromium](https://github.com/ungoogled-software/ungoogled-chromium) - Inspiración

---

**Próxima actualización:** Trimestral
**Última revisión:** 2025-12-10
