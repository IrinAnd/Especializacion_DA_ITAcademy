# De la noticia al dato: la cocaína decomisada y notificada en Europa, 2015 a 2024

Crecimiento, concentración y cambio en el Mar del Norte. Trabajo de fin de curso de Analista de Datos (IT Academy). Python y Power BI se desarrollaron en paralelo y los resultados de uno se contrastaron con el otro. La metodología completa está en el informe de 06_informe.

Qué ha cambiado en la cocaína decomisada en Europa entre 2015 y 2024: cuánto ha crecido, dónde se concentra y si en 2024 se ha desplazado desde los grandes puertos del Mar del Norte. Las cifras son decomisos notificados a UNODC por los países, y no miden consumo ni tráfico real.

Preguntas encadenadas del proyecto:

1. Evolución. Cuánto ha aumentado la cocaína decomisada y si el aumento es propio de la cocaína.
2. Distribución. Si se reparte o se concentra en pocos países.
3. Peso del Mar del Norte. Si en 2024 cambia el peso de Bélgica, Países Bajos y Alemania.
4. Contexto. Si el CPI, el gasto en protección social o el riesgo de pobreza acompañan a la evolución.

Las hipótesis se formularon después de una primera exploración de los datos y se enuncian en cada paso del análisis.

Mar del Norte es una agrupación de países, no un puerto: Bélgica, Países Bajos y Alemania, que tienen los tres mayores puertos de la UE por mercancías (Róterdam, Amberes-Brujas y Hamburgo, 2024, según Eurostat).

## Resultados principales

Todas las cifras son decomisos notificados. Tablas y celdas de origen en la columna Notebook.

| Hipótesis | Resultado | Notebook y sección |
|---|---|---|
| H1. La cocaína crece más que el cannabis de control | Se confirma. La cocaína pasa de 85,5 t en 2015 a 447,3 t en 2023 y 365,8 t en 2024 (por 4,28 entre 2015 y 2024). El cannabis pasa de 1.056,9 a 873,5 t (índice 83). La proporción cannabis entre cocaína baja de 12,4 a 2,4 | 04, Cuánto ha crecido |
| H2. Se concentra en pocos países | Se confirma. En 2024, España (124,7 t), Francia (53,5 t) y Bélgica (45,5 t) reúnen el 61,1 % y los diez primeros países el 96,9 % | 04, Dónde se concentra |
| H3. El Mar del Norte pierde peso en 2024 | Se confirma la caída. Pasa de 225,2 a 106,9 t entre 2023 y 2024 (118,3 t menos) y su peso del 50,35 % al 29,22 %. El resto del panel pasa de 222,1 a 258,9 t. Los datos no permiten decir a dónde se desplaza el tráfico | 04, Mar del Norte en 2024 |
| H3.1. Qué ocurre dentro del Mar del Norte | Bélgica explica unas 78 de las 118 t de bajada. Los días con más de 1 t pasan de 27 a 13. Solo en Bélgica IDS cubre casi todo 7.1 (87 % en 2023 y 98 % en 2024), por eso el detalle se analiza solo allí | 05, Dónde se puede usar IDS y Tamaño de los decomisos en Bélgica |
| H3.2. El contexto acompaña a la cocaína | No se confirma. En España, Francia y Bélgica la cocaína se multiplica por 5,7, 4,9 y 2,6 entre 2015 y 2024, mientras CPI, gasto social y riesgo de pobreza cambian poco y sin patrón común | 04, Contexto en los tres países con más cocaína en 2024 |

Contexto de los tres países con más cocaína en 2024, comparados consigo mismos (2015 a 2024; riesgo de pobreza desde 2016):

| País | Cocaína (t) | CPI | Gasto social (% PIB) | Riesgo de pobreza (%) |
|---|---|---|---|---|
| España | 22,0 a 124,7 | 58 a 56 | 24,5 a 25,6 | 28,8 a 25,8 |
| Francia | 10,9 a 53,5 | 70 a 67 | 34,0 a 34,4 | 18,7 a 20,5 |
| Bélgica | 17,5 a 45,5 | 77 a 69 | 29,9 a 30,2 | 22,2 a 18,3 |

Cada país se compara consigo mismo y no se calculan correlaciones. Todo se interpreta como asociación, no como causalidad.

## Pipeline del proyecto

| Notebook | Qué hace | Salida |
|---|---|---|
| 00_normalizar_ids | Limpia y normaliza los decomisos individuales de UNODC IDS | 02_datos/silver |
| 01_normalizar_unodc_71 | Normaliza la tabla anual Annex 7.1 del World Drug Report 2026 | 02_datos/silver |
| 02_normalizar_contexto | Une CPI, gasto en protección social y riesgo de pobreza en formato largo | 02_datos/silver |
| 03_modelo_final | Construye las tablas del modelo de Power BI y comprueba las claves | 02_datos/gold |
| 04_analisis_exploratorio | Panel de países, crecimiento, concentración, Mar del Norte, EUDA y contexto de los tres países con más cocaína | 04_graficos |
| 05_diferencias_2023_2024 | Variación de 2024 y tamaño de los decomisos en Bélgica | 04_graficos |

Reglas principales:

- 7.1 e IDS no se suman. 7.1 da los totales anuales e IDS el detalle y la frecuencia de reporting.
- La cifra anual por país es el total notificado y, si no existe, la suma del detalle. Las filas con cantidad cero o negativa se dejan fuera.
- La cobertura de IDS sobre 7.1 es el cociente entre las toneladas de IDS y las de 7.1 en el mismo país y año. En el conjunto de Europa va del 19 % en 2017 al 60 % en 2023.
- Para comparar años se usa un panel fijo de 30 países con cocaína notificada todos los años de 2015 a 2024.
- El cannabis es el grupo de control, con 29 países y sin Türkiye.
- La frecuencia de reporting de IDS son los meses con decomisos entre 186: alta, 80 % o más; media, de 50 a 79 %; baja, de 20 a 49 %; muy baja, menos del 20 %. Son categorías propuestas en el análisis (variable UMBRALES del notebook 03): 13 países con frecuencia alta, 13 media, 7 baja, 10 muy baja y 4 sin datos.

## Informe de Power BI

Nueve páginas. La metodología no está en el informe de Power BI: consta solo en el informe escrito.

| Página | Título | Contenido |
|---|---|---|
| Portada | De la noticia al dato: la cocaína decomisada y notificada en Europa, 2015 a 2024 | Pregunta, noticia de partida y dato de los Mossos d'Esquadra |
| Glosario | Glosario | Términos de contexto y términos estadísticos |
| 1 | Fiabilidad de las fuentes | Frecuencia de reporting de IDS, 7.1 frente a IDS y IDS frente a EUDA en puertos |
| 2 | Crecimiento | Toneladas por año, índice base 2015 de cocaína y cannabis |
| 3 | Dónde se concentra | Cuota de cada país en 2024 |
| 4 | Mar del Norte | Peso del Mar del Norte, variación por país entre 2023 y 2024 |
| 5 | Bélgica | Tamaño de los decomisos de IDS y cobertura frente a 7.1 |
| 6 | Contexto | Tabla de los tres países con más cocaína en 2024 (cocaína, CPI, gasto social y riesgo de pobreza) y evolución de cada indicador |
| Conclusión | Conclusión | Crecimiento (por 4,28), concentración y peso del Mar del Norte en 2024 |

## Tablas del modelo

Archivos CSV en 02_datos/gold, generados por el notebook 03.

| Archivo | Filas | Contenido |
|---|---|---|
| fact_decomiso_anual.csv | 3.070 | Kilos anuales por país y grupo de droga de 7.1 |
| fact_decomiso_dia.csv | 106.391 | Kilos de IDS por día, país y grupo de droga |
| fact_contexto.csv | 1.331 | CPI, gasto en protección social y riesgo de pobreza por país y año |
| dim_pais.csv | 47 | Países de Europa, grupo geográfico, panel y frecuencia de reporting de IDS |
| dim_fecha.csv | 5.844 | Calendario de 2011 a 2026 |
| puertos_cocaina_ids.csv | 456 | Cocaína de IDS por puerto, usada solo en Python |

Las tablas de hechos se relacionan con las dimensiones por país y por fecha. Los datos anuales y de contexto usan el 31 de diciembre como fecha.

## Fuentes

Los archivos originales no se incluyen en el repositorio. Se descargan en 00_fuentes con los nombres de la tabla. Los decomisos de los Mossos d'Esquadra (tiroteos) se introdujeron a mano desde la fuente de prensa y solo se usan en la portada de Power BI.

| Nombre original | Nombre en el proyecto | Fuente y enlace de descarga |
|---|---|---|
| 7.1_Drug_seizures_2015-2024.xlsx | 00_fuentes/unodc_wdr2026_anexo_7_1_decomisos_anuales/7.1_Drug_seizures_2015-2024.xlsx | UNODC, World Drug Report 2026, Annex 7.1. https://data.unodc.org/wdr2026 |
| ver nombre en el proyecto | 00_fuentes/unodc_ids_decomisos_individuales/unodc_ids_parte_1.xlsx a unodc_ids_parte_7.xlsx | UNODC, Individual Drug Seizures, Drugs Monitoring Platform. https://dmp.unodc.org/downloadIDS |
| CPI2025_Results.xlsx | 00_fuentes/transparency_international_cpi_2025/CPI2025_Results.xlsx | Transparency International, Corruption Perceptions Index 2025. https://www.transparency.org/en/cpi/2025 |
| No consta el nombre original | 00_fuentes/eurostat_gasto_proteccion_social/Eurostat_Gasto_en_Protección_social.xlsx | Eurostat, tps00098. https://ec.europa.eu/eurostat/databrowser/view/tps00098/default/table |
| No consta el nombre original | 00_fuentes/eurostat_riesgo_pobreza_exclusion/EurostatPersons_at_risk_of_poverty_or_social_exclusion_by_age_and_sext.xlsx | Eurostat, ilc_peps01n. https://ec.europa.eu/eurostat/databrowser/view/ilc_peps01n/default/table |
| No consta el nombre original | informes_pdf/ | EUDA y WCO, Seaports: monitoring the EU's floodgates for illicit drugs (2025); EUDA, European Drug Report 2026. https://www.euda.europa.eu/data/stats2026_en. Informe de puertos: https://www.euda.europa.eu/system/files/documents/2025-06/seaports-monitoring-the-eus-floodgates-for-illicit-drugs.pdf |
| Prensa | No se descarga | AFP y swissinfo (9 de enero de 2025), decomisos en Amberes, datos de aduanas. https://www.swissinfo.ch/spa/los-decomisos-de-coca%C3%ADna-en-el-puerto-de-amberes-se-reducen-m%C3%A1s-de-la-mitad-por-los-controles-reforzados-en-am%C3%A9rica-latina/88697822 |
| Prensa | No se descarga | Brombacher, Fares y Scaturro, Global Initiative (17 de noviembre de 2025). https://globalinitiative.net/analysis/what-the-declining-amount-of-cocaine-seized-in-western-europe-doesnt-tell-us/ |
| Prensa | No se descarga | Pardillo, Onda Cero (10 de junio de 2026). https://www.ondacero.es/noticias/sociedad/dos-clanes-drogas-ajuste-cuentas-estarian-detras-muerte-hombre-tiro-cabeza-barcelona_202606106a29ade50d35a17610a2dc69.html |
| Prensa | No se descarga | Rubio, El Mundo (11 de junio de 2026). https://www.elmundo.es/cataluna/2026/06/11/6a2af1b1fdddff0c748b45a6.html |
| Prensa y datos a mano | No se descarga | Guillem RS, El Caso (15 de septiembre de 2026), tiroteos en Cataluña, introducidos a mano. https://elcaso.elnacional.cat/es/noticias/datos-confirman-percepcion-se-disparan-45-tiroteos-en-catalunya-en-2026_1695286102.html |
| No se descarga | No aplica | Eurostat, Maritime transport of goods, annual data, usada para definir el Mar del Norte. https://ec.europa.eu/eurostat/statistics-explained/index.php?title=Maritime_transport_of_goods_-_annual_data |

## Estructura del repositorio

```
Proyecto/
├── 00_fuentes/             archivos originales y PDF de informes (informes_pdf)
├── 01_notebooks/           notebooks 00 a 05
├── 02_datos/
│   ├── silver/             tablas normalizadas y registros de cada paso
│   └── gold/               tablas del modelo de Power BI
├── 03_powerbi/             proyecto .pbix, PDF exportado y  medidas DAX
├── 04_graficos/            figuras de los notebooks 04 y 05
├── 05_presentacion/         ppt, presentación de la defensa
├── 06_informe/             informe de 4 páginas en Word y PDF
└── README.md
```

## Cómo reproducirlo

1. Descargar los archivos de la tabla de fuentes en 00_fuentes.
2. Ejecutar los notebooks de 01_notebooks por orden, del 00 al 05. Las rutas son relativas a la carpeta del proyecto.
3. Abrir el archivo .pbix de 03_powerbi y actualizar las rutas a 02_datos/gold.

Librerías de Python: pandas, numpy, matplotlib, scipy y openpyxl.

## Límites

- Los decomisos notificados dependen del control y de lo que informa cada país.
- IDS es voluntario y recoge solo una parte de los decomisos. La cobertura es desigual: alta en Bélgica, parcial en Alemania y sin decomisos de cocaína de Países Bajos en 2023 y 2024.
- El salto de IDS en 2018 (de 27 a 102 t, frente a un 33 % más en 7.1) apunta a un cambio en lo que se notifica, por eso IDS no se usa para comparar años.
- Con estos datos no se puede separar más tráfico de más control.
- Los kilos por país no se ajustan por población ni por tamaño.
- Los datos muestran la caída de 2024 en el Mar del Norte y no permiten explicarla.

Irina Andrade, Analista de Datos, IT Academy, 2026.
