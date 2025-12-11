# Preguntas Frecuentes (FAQ)

## General

### ¿Por qué crear tu propio navegador?

**Ventajas:**
- **Control total** sobre privacidad y seguridad
- **Sin telemetría** ni rastreo de Google
- **Transparencia** - sabes exactamente qué código ejecutas
- **Aprendizaje** - entiendes cómo funcionan los navegadores
- **Personalización** - modifica según tus necesidades

**Desventajas:**
- **Mantenimiento** - debes actualizar regularmente
- **Recursos** - requiere tiempo y hardware potente
- **Complejidad** - curva de aprendizaje técnica

### ¿Es seguro?

**Sí, SI:**
- Mantienes actualizaciones regulares (crítico)
- Usas scripts de sincronización automática
- No modificas código de seguridad core
- Monitoras CVEs en Chromium

**No, SI:**
- No actualizas por meses
- Modificas sandbox o código de seguridad
- Ignoras parches críticos

### ¿Cuánto tiempo requiere mantenerlo?

- **Setup inicial:** 1 día (5-6 horas automatizadas)
- **Actualizaciones semanales:** 10 minutos (revisar reports)
- **Recompilación mensual:** 1-2 horas (automatizable)
- **Parches críticos:** Inmediato (< 24 horas)

## Compilación

### ¿Por qué tarda tanto la primera compilación?

Chromium es ENORME:
- ~25 millones líneas de código
- 3500+ archivos .cc
- Motor JavaScript V8 completo
- Motor de renderizado Blink
- Implementación completa de APIs web

Primera compilación compila TODO desde cero.

### ¿Puedo acelerar la compilación?

**Sí:**

1. **Más cores de CPU:**
```bash
ninja -C out/Release chrome -j 16  # Usa 16 cores
```

2. **Usar ccache (Linux/Mac):**
```bash
sudo apt install ccache
export PATH="/usr/lib/ccache:$PATH"
```

3. **Build incremental:**
```bash
# Solo recompila archivos modificados
ninja -C out/Release chrome
```

4. **SSD en lugar de HDD** (2-3x más rápido)

5. **Más RAM:**
- 16GB: ~4 horas
- 32GB: ~2 horas
- 64GB: ~1 hora

### ¿Qué es depot_tools?

Conjunto de herramientas de Google para compilar Chromium:
- `gclient` - gestor de dependencias
- `gn` - generador de builds
- `ninja` - sistema de compilación
- Scripts auxiliares

### ¿Puedo compilar en una Raspberry Pi?

Técnicamente sí, pero NO es práctico:
- Tomaría 24-48 horas
- Requiere swap extenso
- Posible agotamiento de SD card

**Alternativa:** Cross-compile en PC potente

## Privacidad

### ¿Realmente no envía datos a Google?

**Bloqueado en código:**
- Telemetría deshabilitada en `disable-google-services.gn`
- Dominios bloqueados en `blocked-domains.txt`
- Sin API keys de Google

**Puedes verificar:**
```bash
# Monitorear tráfico de red
mitmproxy -p 8080
./chrome --proxy-server="127.0.0.1:8080"
```

No deberías ver conexiones a:
- clients*.google.com
- analytics.google.com
- safebrowsing.google.com

### ¿Es mejor que Brave/Firefox para privacidad?

**Depende:**

**Ventajas sobre Brave/Firefox:**
- Control total del código
- Sin telemetría propia del navegador
- Auditabilidad completa

**Desventajas:**
- Sin equipo de seguridad dedicado
- Actualizaciones manuales
- Requiere conocimiento técnico

**Recomendación:** Para usuarios promedio, usa Brave o Firefox configurado. Para usuarios técnicos que valoran control absoluto, Navegador Pereira.

### ¿Qué pasa con las extensiones?

**Funcionan normalmente:**
- Chrome Web Store accesible
- Extensiones de terceros compatibles
- API de extensiones sin modificar

**Recomendadas:**
- uBlock Origin
- Privacy Badger
- Bitwarden
- HTTPS Everywhere

## Seguridad

### ¿Qué pasa si hay una vulnerabilidad 0-day?

**Proceso:**

1. Google parchea Chromium upstream
2. Nuestro CI/CD detecta parche (workflow semanal)
3. Se crea issue automáticamente
4. Sincronizas: `./scripts/sync-chromium.sh`
5. Recompilas: `./scripts/build.sh`
6. Distribuyes actualización

**Tiempo objetivo:** < 24 horas para CVEs críticos

### ¿Es el sandbox igual de seguro que Chrome?

**Sí**, porque:
- No modificamos código de sandbox
- Usamos configuración de seguridad estándar
- Mismo proceso de aislamiento

**Verificar:**
```bash
./chrome --sandbox-check
# Debería mostrar: "Sandbox is enabled"
```

### ¿Puedo usar esto en producción en mi empresa?

**Consideraciones:**

**Pros:**
- Control sobre código
- Sin dependencia de Google
- Personalización corporativa

**Contras:**
- Requiere equipo DevOps dedicado
- Responsabilidad de actualizaciones
- Soporte técnico propio

**Recomendación:** Solo si tienes:
- Equipo de seguridad
- Proceso de actualización automatizado
- Presupuesto para mantenimiento

## Rendimiento

### ¿Consume menos RAM que Chrome?

**Generalmente NO**, porque:
- Mismo motor Chromium
- Mismo modelo de procesos
- Mismas optimizaciones

**Puedes optimizar:**
```gn
# En args.gn
enable_background_mode = false  # Sin procesos en background
```

### ¿Es más rápido que Chrome?

**Similar**, porque:
- Mismo motor V8
- Mismo Blink
- Mismas optimizaciones

**Posible ventaja:**
- Sin telemetría = menos overhead
- Sin servicios Google = menos conexiones
- Builds optimizados localmente

### ¿Funciona con todas las páginas web?

**Sí, excepto:**
- Servicios que requieren cuenta Google (obvio)
- Algunos DRM pueden fallar (ajustable)

**Probado y funcional:**
- ✅ YouTube
- ✅ Netflix (con Widevine)
- ✅ Spotify Web
- ✅ Office 365
- ✅ Gmail (web)
- ✅ Facebook, Twitter, etc.

## Compatibilidad

### ¿Puedo importar mis datos de Chrome?

**Sí:**

1. En Chrome: Exportar marcadores
2. En Navegador Pereira: Importar marcadores
3. Contraseñas: Usa gestor externo (Bitwarden)

### ¿Funciona en ARM (M1/M2 Mac, ARM Windows)?

**Sí, pero:**
- Requiere compilación específica para ARM
- En `args.gn`: `target_cpu = "arm64"`
- Primera compilación más lenta

### ¿Puedo sincronizar entre dispositivos?

**Sin Google Sync, pero puedes:**

1. **Servidor propio:** Firefox Sync Server modificado
2. **Extensiones:** Bitwarden, Xmarks
3. **Manual:** Exportar/importar marcadores
4. **Git:** Sincronizar perfil vía Git

## Actualización

### ¿Cada cuánto debo actualizar?

**Recomendado:**
- **Verificar:** Semanal (automático con CI/CD)
- **Recompilar:** Mensual
- **Crítico:** Inmediato cuando hay CVE crítico

### ¿Puedo automatizar completamente las actualizaciones?

**Sí, con GitHub Actions:**

1. Sync semanal automático
2. Detección de parches de seguridad
3. Build automático (opcional)
4. Notificación vía issue

Ver: `.github/workflows/auto-sync-chromium.yml`

### ¿Qué pasa si me salto actualizaciones por 6 meses?

**Peligroso:**
- Acumulación de vulnerabilidades
- Posible incompatibilidad de código
- Conflictos de merge complejos

**Nunca dejes pasar más de 1 mes sin actualizar.**

## Desarrollo

### ¿Puedo contribuir al proyecto?

**¡Sí! Contribuciones bienvenidas:**
- Mejoras de documentación
- Nuevas configuraciones de privacidad
- Scripts de automatización
- Reportes de bugs
- Traducciones

### ¿Puedo hacer un fork para mi uso?

**Absolutamente:**
- Licencia BSD permite forks
- Modifica según necesites
- Comparte mejoras (opcional)

### ¿Cómo reporto un bug?

1. Verifica que es específico de Navegador Pereira (no de Chromium)
2. Abre issue en GitHub
3. Incluye:
   - Versión de Chromium base
   - Sistema operativo
   - Pasos para reproducir
   - Logs relevantes

## Misceláneos

### ¿Funciona con VPN/Tor?

**Sí:**
- VPN: Sin problemas
- Tor: Mejor usar Tor Browser oficial
- Proxy: Configurable

### ¿Puedo distribuir binarios compilados?

**Sí, pero:**
- Cumple licencia BSD
- Incluye aviso de copyright
- Proporciona código fuente
- No uses marca "Chrome" o "Chromium"

### ¿Hay versión portable?

**Sí:**
- Windows: Copia carpeta `out/Release`
- Linux: Empaqueta con dependencias
- macOS: .app bundle es portable

### ¿Dónde pido ayuda?

1. **Documentación:** `docs/`
2. **Issues GitHub:** Problemas específicos del proyecto
3. **Chromium Docs:** Problemas de compilación general
4. **Stack Overflow:** Preguntas técnicas de Chromium

---

**¿Tu pregunta no está aquí?**

Abre un issue: https://github.com/TU-USUARIO/navegador_pereira/issues

---

**Última actualización:** 2025-12-10
