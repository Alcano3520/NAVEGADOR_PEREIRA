# Navegador Pereira

Navegador web basado en Chromium enfocado en **privacidad, rendimiento y seguridad**.

## 🎯 Objetivos

- **Privacidad**: Sin telemetría, sin rastreo, sin conexiones a servicios de Google
- **Rendimiento**: Optimizado para consumo de RAM y velocidad
- **Seguridad**: Actualizaciones automáticas desde Chromium upstream
- **Transparencia**: Código auditable y documentado

## 🏗️ Arquitectura

```
navegador_pereira/
├── scripts/           # Scripts de automatización
│   ├── sync-chromium.sh    # Sincronización automática
│   ├── build.sh            # Compilación optimizada
│   └── security-audit.sh   # Auditoría de seguridad
├── configs/           # Configuraciones
│   ├── privacy/           # Configs de privacidad
│   ├── performance/       # Optimizaciones
│   └── branding/          # Marca y UI
├── patches/           # Parches personalizados
├── docs/              # Documentación
└── .github/           # CI/CD workflows
```

## 🔒 Características de Privacidad

- ❌ Sin Google SafeBrowsing (usa listas locales)
- ❌ Sin Google DNS
- ❌ Sin sincronización con cuenta Google
- ❌ Sin precarga de DNS
- ❌ Sin precarga de páginas
- ✅ HTTPS-only por defecto
- ✅ Bloqueador de rastreadores integrado
- ✅ Cookies de terceros bloqueadas

## ⚡ Optimizaciones de Rendimiento

- Procesos compartidos para tabs del mismo dominio
- Garbage collection agresivo
- Límites de memoria configurables
- Cache optimizado

## 🔐 Seguridad

### Actualizaciones Automáticas
```bash
# Sincronización semanal automática vía CI/CD
./scripts/sync-chromium.sh
```

### Política de Parches
- **Críticos**: < 24 horas
- **Altos**: < 7 días
- **Medios/Bajos**: Con release regular

## 📋 Requisitos

### Para compilar:
- **OS**: Windows 10/11, Linux, macOS
- **RAM**: 16GB mínimo (32GB recomendado)
- **Disco**: 100GB+ espacio libre
- **CPU**: 8+ cores recomendado
- **Tiempo**: 2-4 horas primera compilación

### Herramientas:
- Python 3.8+
- Git
- Visual Studio 2022 (Windows) / GCC/Clang (Linux/Mac)
- depot_tools (Google)

## 🚀 Inicio Rápido

### 1. Clonar y preparar
```bash
git clone https://github.com/tu-usuario/navegador_pereira.git
cd navegador_pereira
./scripts/setup.sh
```

### 2. Sincronizar Chromium
```bash
./scripts/sync-chromium.sh
```

### 3. Aplicar configuraciones
```bash
./scripts/apply-configs.sh
```

### 4. Compilar
```bash
./scripts/build.sh
```

## 📚 Documentación

- [Guía de Compilación](docs/BUILD.md)
- [Configuración de Privacidad](docs/PRIVACY.md)
- [Optimizaciones de Rendimiento](docs/PERFORMANCE.md)
- [Política de Seguridad](docs/SECURITY.md)
- [Contribuir](docs/CONTRIBUTING.md)

## ⚠️ Advertencias Importantes

1. **Mantenimiento Activo Requerido**: Este proyecto requiere actualizaciones regulares
2. **No para producción inicial**: Primero domina el proceso de build y actualización
3. **Responsabilidad**: Tú eres responsable de mantener tu navegador seguro

## 🤝 Contribuir

Ver [CONTRIBUTING.md](docs/CONTRIBUTING.md)

## 📄 Licencia

BSD-3-Clause (misma que Chromium)

## 🔗 Enlaces

- [Chromium Source](https://chromium.googlesource.com/chromium/src/)
- [Chromium Security Updates](https://chromereleases.googleblog.com/)
- [Ungoogled Chromium](https://github.com/ungoogled-software/ungoogled-chromium) (inspiración)
