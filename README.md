[https://github.com/MatiMrqz/analizador](https://github.com/MatiMrqz/analizador)

# Analizador Sintáctico y Semántico
Este proyecto es un analizador sintáctico y semántico diseñado utilizando las herramientas Flex y Bison. El analizador procesa archivos de texto y verifica su conformidad con una gramática específica. La sintaxis que reconoce se basa en una definición de reglas para `STMT` y `COMMAND`.

## Especificaciones Sintácticas
### STMT (AXIOMA)
```
STMT ::= LHS = COMMAND [do ['|'[BLOCK_VAR]'|'] COMPSTMT end]
```
### COMMAND
```
COMMAND ::= OPERATION CALL_ARGS | super CALL_ARGS
```

# Estructura del Proyecto
El proyecto está organizado en los siguientes archivos:

- `lexico.l`: Archivo de definición de Flex para el análisis léxico.
- `sintactico.y`: Archivo de definición de Bison para el análisis sintáctico.
- `tokens.h`: Definiciones de tokens compartidas entre Flex y Bison.
- `EspeSintacticas.md`: Reglas semánticas asignadas para la realización del ejercicio
- `tests/CadX_OK`: Casos de prueba. Cadena válida: Archivo de input + Salida de analizador
- `tests/CadX_ERROR`: Casos de prueba. Cadena inválida: Archivo de input + Salida de analizador
- `analizador`: Ejecutable
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
1. Editar el archivo `input.txt` con la cadena a analizar
2. Correr `./analizador input.txt` y ver resultados por salida de consola. Tambien es posible ejecutar los archivos de test de la carpeta mediante el comando `./analizador tests/CadX_ESTADO/input.txt` donde _X_ es la cadena a testear y _ESTADO_ puede ser ERROR u OK.

# Tests
## MODO DE PRUEBA AUTOMÁTICO
Para testear el analizador ejecutar los archivos .bat incluídos en la carpeta:
- ejecutar_cadena1OK.bat
  Inicializa el analizador con el archivo tests/Cad1_OK/input.txt como entrada.
- ejecutar_cadena2OK.bat
  Inicializa el analizador con el archivo tests/Cad2_OK/input.txt como entrada.
- ejecutar_cadena1ERROR.bat
  Inicializa el analizador con el archivo tests/Cad1_ERROR/input.txt como entrada.
- ejecutar_cadena2ERROR.bat
  Inicializa el analizador con el archivo tests/Cad2_ERROR/input.txt como entrada.

## MODO DE PRUEBA MANUAL
Desde un terminal abrir el siguiente ejecutable colocando como argumento de entrada la ubicación del archivo a testear. Ej:
analizador.exe .input.txt

# Contribución
Si deseas contribuir al proyecto, por favor sigue los siguientes pasos:

- Haz un fork del repositorio.
- Crea una rama con una nueva característica (git checkout -b feature/nueva-caracteristica).
- Realiza los cambios y haz commits (git commit -am 'Agrega nueva característica').
- Envía tus cambios al repositorio (git push origin feature/nueva-caracteristica).
- Abre un Pull Request.

# Licencia
Este proyecto está bajo la Licencia MIT. Consulta el archivo LICENSE para más detalles.
