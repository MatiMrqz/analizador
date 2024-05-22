# Analizador Sintáctico y Semántico
Este proyecto es un analizador sintáctico y semántico diseñado utilizando las herramientas Flex y Bison. El analizador procesa archivos de texto y verifica su conformidad con una gramática específica. La sintaxis que reconoce se basa en una definición de reglas para `FILE-AND-SORT` y `ASSIGN-CLAUSE`.

## Especificaciones Sintácticas
### FILE-AND-SORT
```
FILE-AND-SORT ::= ([VALUE-OF-CLAUSE ]| [ DATA-RECORDS-CLAUSE ]| [ LINAGE-CLAUSE ]| [ RECORDING-MODE-CLAUSE ]| [ASSIGN-CLAUSE])
```
### ASSIGN-CLAUSE
```
ASSIGN-CLAUSE ::= 'ASSIGN' [ 'TO'] { (ASSIGNMENT-NAME | LITERAL )}+
```
### Tabla de Lexemas
|Token  |Valor  |
|-------|-------|
|ASSIGN |ASSIGN|
|TO    | TO  |
| VALUE_OF_CLAUSE|value_of|
|DATA_RECORDS_CLAUSE|data_records|
|LINAGE_CLAUSE|linage_clause|
|RECORDING_MODE_CLAUSE|recording_mode|
|ASSIGNMENT_NAME|assignment_name|
|LITERAL|literal|

# Estructura del Proyecto
El proyecto está organizado en los siguientes archivos:

- `lexico.l`: Archivo de definición de Flex para el análisis léxico.
- `sintactico.y`: Archivo de definición de Bison para el análisis sintáctico.
- `tokens.h`: Definiciones de tokens compartidas entre Flex y Bison.
- `EspeSintacticas.txt`: Reglas semánticas asignadas para la realización del ejercicio
- `tests/cadenas_ejemplo.txt`: Casos de prueba. 2 cadenas válidas + 2 inválidas.
- `tests/ejecutable`: Ejecutable (compilado para posix no windows)
- `tests/input.txt`: Archivo de entrada para ejecutable. **Colocar en este archivo la cadena a testear.**
- `README.md`: Este archivo.

# Requisitos
Para compilar y ejecutar el proyecto, necesitas tener instalados Flex y Bison. Puedes instalarlos en una distribución de Linux basada en Debian con el siguiente comando:

```sh
sudo apt-get install flex bison
```
# Compilación
Para compilar el proyecto, sigue los siguientes pasos:

1. Clona el repositorio:
```sh
git clone https://github.com/usuario/analizador.git
cd analizador
```
2. Prepara los archivos de compilación:
```sh
### Armado de Parser con Bison
bison -d sintactico.y
### Armado de Scanner con Flex
flex lexico.l
```
3. Compilar el ejecutable a partir de los archivos generados:
```sh
# POSIX
gcc -o ejecutable sintactico.tab.c lex.yy.c -ll
# Windows
gcc -o ejecutable sintactico.tab.c lex.yy.c -lfl -lm
```
# Uso
Para ejecutar el analizador sobre un archivo de entrada
1. Editar el archivo `input.txt`con la cadena a analizar
2. Correr `ejecutable` y ver resultados por salida de consola

# Contribución
Si deseas contribuir al proyecto, por favor sigue los siguientes pasos:

- Haz un fork del repositorio.
- Crea una rama con una nueva característica (git checkout -b feature/nueva-caracteristica).
- Realiza los cambios y haz commits (git commit -am 'Agrega nueva característica').
- Envía tus cambios al repositorio (git push origin feature/nueva-caracteristica).
- Abre un Pull Request.

# Licencia
Este proyecto está bajo la Licencia MIT. Consulta el archivo LICENSE para más detalles.
