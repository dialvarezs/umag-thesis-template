# Formato de Tesis para la Universidad de Magallanes (UMAG)

## Descripción

Este repositorio contiene un formato de tesis para la Universidad de Magallanes (UMAG) en LaTeX. El formato se basa en la clase `memoir`, pero utilizando un estilo moderno con fuentes sans y algunos elementos visuales como títulos destacados en colores, breadcrumb en las páginas, entre otros.


## Cómo usar

Se puede crear una copia de este repositorio para tener la estructura básica y luego modificar los archivos del proyecto. El archivo principal es `main.tex`, que incluye los archivos de los capítulos y otros elementos del documento.

### Estructura del proyecto

Este proyecto fue creado con la siguiente estructura de carpetas y archivos:

- `main.tex`: Archivo principal del documento.
- `references.bib`: Archivo con las referencias bibliográficas "generales" en formato BibTeX.
- `umagthesis.cls`: Archivo con la definición de la clase de documento, que incluye la configuración de los estilos y otros elementos del documento, como la portada y la tapa.
- `chapters/`: Carpeta con los capítulos del documento, cada capítulo tiene un archivo `index.tex` que se incluye en `main.tex` para mantener el documento de manera organizada. También es recomendable tener las figuras y referencias (si es que corresponde) en la carpeta del capítulo.
- `frontmatter/`: Carpeta con los archivos de la parte inicial del documento, como los agradecimientos, declaración de autoría, resumen, etc. También se encuentra la definición de acrónimos y glosario.
- `images/`: Imágenes del documento no asociadas a un capítulo en particular (por ejemplo, la imagen de la portada).
- `.cls_resources/`: Carpeta con los archivos de recursos de la clase de documento (fuentes y logos).


### Definiciones de datos del documento

Además de las opciones habituales como `\title`, `\author`, etc., la clase de documento `umagthesis` define comandos adicionales para definir datos del documento:
- `\supervisor{}`: Nombre del supervisor de la tesis.
- `\cosupervisor{}`: Nombre del co-supervisor de la tesis (opcional).
- `\degree{}`: Grado o título que se obtiene con la tesis.
- `\department{}`: Departamento o unidad académica a la que pertenece el autor.
- `\faculty{}`: Facultad a la que pertenece el autor.
- `\university{}`: Universidad a la que pertenece el autor.
- `\degreedate{}`: Fecha de presentación de la tesis.
- `\graduationpurpose{}`: Propósito de la tesis (opcional, por defecto es "Tesis para optar al grado de").
- `\coverimage{}`: Imagen para la tapa del documento (opcional).


### Compilación

Para compilar el documento es necesario utilizar LuaLaTeX (probado con versión 1.17.0, TeX Live 2023), y tener instalados los paquetes necesarios (revisar la primera sección del archivo `umagthesis.cls`).

Recomiendo usar `latexmk` para una compilación más sencilla. Por ejemplo, para compilar el documento se puede usar el siguiente comando:

```bash
latexmk -lualatex main.tex
```

En cuanto a editores, la recomendación es usar Visual Studio Code con la extensión LaTeX Workshop, o TeXstudio. Overleaf también es una buena opción, pero probablemente sea necesario tener una cuenta premium para poder compilar el documento.