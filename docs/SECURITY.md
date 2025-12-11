# Política de Seguridad - Navegador Pereira

## 🎯 Objetivo

Mantener un navegador **seguro, actualizado y sin vulnerabilidades conocidas** mediante actualizaciones automáticas desde Chromium upstream.

## 🔄 Proceso de Actualización

### Sincronización Automática

El navegador se sincroniza automáticamente con Chromium cada **lunes a las 3 AM UTC** mediante GitHub Actions.

```yaml
Frecuencia: Semanal
Método: GitHub Actions workflow
Script: .github/workflows/auto-sync-chromium.yml
```

### Detección de Parches de Seguridad

El sistema detecta automáticamente:
- Commits con palabra clave "Security"
- Referencias a CVEs (CVE-YYYY-NNNNN)
- Commits marcados como "vulnerability fix"

### Notificaciones

Cuando se detectan parches de seguridad:
1. ✅ Se crea automáticamente un **GitHub Issue**
2. ✅ Se genera un **reporte de auditoría**
3. ✅ Se notifica en el workflow

## ⚡ Tiempo de Respuesta

| Severidad | Tiempo Objetivo | Acción |
|-----------|----------------|--------|
| **Crítica** | < 24 horas | Build y release inmediato |
| **Alta** | < 7 días | Build en próximo ciclo |
| **Media** | < 14 días | Build regular |
| **Baja** | < 30 días | Con siguiente release |

## 🔍 Auditoría Manual

### Ejecutar Auditoría Local

```bash
# Últimos 7 días
./scripts/security-audit.sh 7

# Últimos 30 días
./scripts/security-audit.sh 30
```

### Revisar Commits Recientes

```bash
cd chromium/src

# Ver commits de seguridad
git log --grep="Security" --grep="CVE" --oneline -20

# Ver detalles de un commit específico
git show <commit-hash>
```

## 🛡️ Características de Seguridad Implementadas

### 1. Sin Conexiones a Google

**Bloqueado:**
- ❌ Google SafeBrowsing (usa listas locales)
- ❌ Google DNS
- ❌ Telemetría y crash reporting
- ❌ Update check a servidores Google
- ❌ Geolocalización de Google

**Archivo:** `configs/privacy/blocked-domains.txt`

### 2. Configuraciones Hardened

```json
{
  "safebrowsing": {
    "enabled": false,
    "enhanced": false
  },
  "ssl": {
    "version_min": "tls1.2"
  },
  "enable_do_not_track": true,
  "block_all_third_party_cookies": true
}
```

**Archivo:** `configs/privacy/default-preferences.json`

### 3. Sandboxing

Chromium sandbox habilitado por defecto:
- Procesos renderer aislados
- Procesos GPU aislados
- Procesos de red aislados

### 4. HTTPS-Only

Configurado para forzar HTTPS cuando está disponible.

## 📋 Checklist de Actualización de Seguridad

Cuando se detecta un parche de seguridad crítico:

- [ ] Revisar el issue auto-generado
- [ ] Leer detalles del CVE en chromium.org
- [ ] Evaluar impacto en navegadores personalizados
- [ ] Ejecutar `./scripts/sync-chromium.sh`
- [ ] Ejecutar `./scripts/security-audit.sh`
- [ ] Revisar conflictos de merge (si los hay)
- [ ] Ejecutar `./scripts/build.sh`
- [ ] Probar el build resultante
- [ ] Crear tag de versión
- [ ] Distribuir actualización

## 🚨 Reportar Vulnerabilidades

### Vulnerabilidades en Chromium

Reportar directamente a Google:
https://bugs.chromium.org/p/chromium/issues/entry?template=Security+Bug

### Vulnerabilidades en Navegador Pereira

Si encuentras una vulnerabilidad específica de nuestras modificaciones:

1. **NO** crear issue público
2. Enviar email a: [TU-EMAIL-DE-SEGURIDAD]
3. Incluir:
   - Descripción detallada
   - Pasos para reproducir
   - Impacto potencial
   - Proof of concept (si es posible)

## 🔐 Mejores Prácticas para Usuarios

### Mantente Actualizado

```bash
# Verificar versión actual
./chromium/src/out/Release/chrome --version

# Actualizar
./scripts/sync-chromium.sh
./scripts/build.sh
```

### Configuraciones Recomendadas

1. **Habilitar actualizaciones automáticas** (cuando estén disponibles)
2. **No deshabilitar sandbox** bajo ninguna circunstancia
3. **Mantener extensiones al mínimo**
4. **Revisar permisos de sitios** regularmente

### Extensiones de Seguridad Recomendadas

- uBlock Origin (bloqueador de contenido)
- HTTPS Everywhere (forzar HTTPS)
- Privacy Badger (anti-rastreo)

## 📊 Métricas de Seguridad

### Objetivo Mensual

- Latencia promedio de parche: < 7 días
- Vulnerabilidades críticas sin parchear: 0
- Tasa de actualización exitosa: > 95%

### Monitoreo

Ver issues con etiqueta `security`:
```
https://github.com/TU-USUARIO/navegador_pereira/labels/security
```

## 🔗 Referencias

- [Chromium Security Releases](https://chromereleases.googleblog.com/)
- [Chromium Security FAQ](https://www.chromium.org/Home/chromium-security/security-faq/)
- [CVE Database](https://cve.mitre.org/)
- [NVD - National Vulnerability Database](https://nvd.nist.gov/)

## 📅 Historial de Actualizaciones

Ver releases: https://github.com/TU-USUARIO/navegador_pereira/releases

---

**Última actualización:** 2025-12-10
**Próxima revisión:** 2026-01-10
