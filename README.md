# Laboratorio: Instrucciones Mixtas en NASM (x86)

* **Estudiante:** Juan Carlos Barajas Quintero 
* **Curso:** Arquitectura de Computadores - Unidad 6  
* **Institución:** Universidad Francisco de Paula Santander

## 1. Descripción del Proyecto
Este proyecto consiste en el desarrollo de un programa en lenguaje ensamblador **NASM** para arquitectura **x86** (formato .COM) que integra las cuatro categorías fundamentales de instrucciones del procesador. El programa ha sido diseñado para ejecutarse en un entorno **DOSBox** y ser verificado mediante la herramienta **DEBUG.COM**.
### Entorno de Trabajo
Para el cumplimiento de los objetivos, se utilizó el siguiente software y versiones:
*   **Emulador:** DOSBox 0.74+.
*   **Ensamblador:** NASM versión 2.14+.
*   **Control de Versiones:** Git para la gestión del repositorio.
*   **Editor de Texto:** VS code para la escritura de los archivos .asm.

## 2. Descripción de los Bloques de Código
El programa se divide en cuatro bloques lógicos, cada uno demostrando una funcionalidad específica del procesador:

*   **Bloque 1: Transferencia de datos:** Se encarga de mover información entre registros y memoria. Se utilizan instrucciones `MOV` para copias directas, `LEA` para cargar direcciones efectivas (punteros), `XCHG` para intercambiar contenidos y la pila (`PUSH`/`POP`) para el almacenamiento temporal de datos.
*   **Bloque 2: Operaciones aritméticas:** Realiza cálculos matemáticos básicos. Incluye sumas (`ADD`), restas (`SUB`), incrementos (`INC`) y decrementos (`DEC`). También implementa operaciones de multiplicación (`MUL`) y división (`DIV`), las cuales afectan registros específicos y el registro de estados (flags).
*   **Bloque 3: Operaciones lógicas:** Manipulación de bits individuales. Se emplean máscaras con `AND` y `OR`, inversión selectiva con `XOR` y verificaciones de bits con `TEST`. Además, incluye desplazamientos binarios (`SHL`/`SHR`) que funcionan como multiplicaciones o divisiones rápidas por potencias de 2.
*   **Bloque 4: Control de flujo:** Implementa la lógica de decisión y repetición. Utiliza comparaciones (`CMP`) y saltos condicionales (`JG`, `JE`) para estructuras de control tipo *if-else*, además de un bucle iterativo controlado por el registro `CX` mediante la instrucción `LOOP`.

## 3. Registros y Flags Observados (DEBUG)
De acuerdo con el trazado realizado en **DEBUG**, se registraron los siguientes estados más importantes:

| Instrucción | Registro AX (Hex) | Flags Relevantes | Descripción del Estado |
| :--- | :--- | :--- | :--- |
| `MOV AX, [valor_a]` | `002D` | `PL ZR NA PE NC` | Carga el valor 45 (2Dh). |
| `ADD AX, [valor_b]` | **`0039`** | `PL NZ AC PE NC` | AX=57. Flag **NZ** (No Zero) activo. |
| `XOR AX, AX` | `0000` | `PL ZR NA PE NC` | Limpia el registro AX. Flag **ZR** activo. |
| **Fin Bucle Suma** | **`000F`** | `PL NZ NA PE NC` | Resultado de la suma 1 a 5 (15 dec). |
| **Fin Bucle Factorial**| **`0078`** | `PL NZ NA PE NC` | AX = 120 (Checkpoint 3). |

## 4. Variante Factorial (5!) - Checkpoint 3
En cumplimiento con el **Checkpoint 3**, se modificó la lógica del bucle para calcular el factorial de 5 ($5! = 120$).

*   **Lógica inicial:** Se ajustó `AX = 1` (identidad multiplicativa) y `CX = 5` (contador).
*   **Modificación:** Se reemplazó la instrucción `ADD` por **`MUL bx`**, multiplicando el acumulador por el valor creciente de `BX` en cada iteración.

## 5. Comparativa Técnica: LOOP vs. DEC/JNZ
Se documenta la diferencia técnica entre el uso de la instrucción dedicada de bucle y la alternativa manual:

| Característica | Instrucción `LOOP` | Alternativa `DEC` + `JNZ` |
| :--- | :--- | :--- |
| **Funcionamiento** | Decrementa `CX` y salta si no es cero en un solo paso. | Requiere dos instrucciones separadas para decrementar y saltar. |
| **Registro** | Limitada obligatoriamente al registro `CX`. | Flexible. Permite usar cualquier registro como contador. |
| **Rendimiento** | Más lenta en arquitecturas modernas por su complejidad. | Generalmente más rápida debido a la optimización del pipeline. |
| **Preferencia** | Preferible en bucles cortos por simplicidad y legibilidad. | Preferible cuando `CX` está ocupado o se busca optimización. |

## 6. Instrucciones de Compilación y Ejecución
Para compilar el programa utilizando **NASM**, ejecute el siguiente comando en la consola de **DOSBox** (nombre del .com debe limitarse a 8 caracteres para ejecutarlo correctamente en DOSBox):

```bash
nasm -f bin lab6_instrucciones.asm -o lab6_ins.com
```

Para depurar y observar el comportamiento de los registros:
```bash
debug lab6_ins.com
-t  (para ejecutar paso a paso)
```
