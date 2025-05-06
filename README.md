# Proyecto de Análisis de Datos de un Gimnasio – SQL + Power BI

Este proyecto representa una solución integral de Business Intelligence (BI) para un gimnasio en Córdoba, Argentina, abarcando desde la construcción de una base de datos en SQL Server hasta el diseño de dashboards interactivos en Power BI.

## Estructura del proyecto

El análisis se construyó a partir de datos que reflejan operaciones del gimnasio durante el año 2024, incluyendo:

- **Socios:** inscripción, edad, sexo, sucursal.
- **Planes contratados:** información mensual y tipo de plan.
- **Asistencia diaria:** visitas por fecha y sucursal.
- **Productos vendidos:** ventas adicionales.
- **Personal y sucursales:** ubicación y recursos humanos.

## SQL Server – Modelado de datos

- Creación y población de múltiples tablas relacionales.
- Simulación de inscripciones y asistencias mensuales con variaciones estacionales.
- Generación de datos realistas entre enero y diciembre de 2024.
- Claves primarias y foráneas correctamente estructuradas.

## Power BI – Visualización e insights

- Importación de la base de datos desde SQL Server.
- Creación de una **tabla calendario** para análisis temporal.
- Relaciones entre tablas y medidas DAX personalizadas.
- Visualizaciones dinámicas y filtros interactivos.

### Principales indicadores (KPIs) desarrollados:

- Cantidad de socios por mes y por sede.
- Ingresos mensuales por tipo de plan.
- Porcentaje de crecimiento de socios.
- Asistencia mensual por sucursal.
- Distribución demográfica por edad y sexo.
- Proyecciones futuras de asistencia y crecimiento.

## Objetivo del análisis

El objetivo principal fue brindar al dueño del gimnasio una herramienta visual para:
- Tomar decisiones estratégicas basadas en datos reales.
- Identificar patrones de comportamiento de los socios.
- Optimizar horarios, recursos humanos y campañas de marketing.
- Prepararse para los meses de mayor demanda (octubre a febrero).

## Herramientas utilizadas

- SQL Server Management Studio
- Power BI Desktop
- Lenguaje DAX

---

Este proyecto refleja un flujo completo de trabajo como analista de datos, desde la generación y limpieza de datos hasta el modelado y análisis visual, aplicado a un contexto empresarial realista.
