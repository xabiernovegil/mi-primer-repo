!/bin/bash
# ============================================================
# CALCULADORA BÁSICA
# Autor: Javier Novegil
# Fecha: Septiembre 2026
# Descripción: Calculadora interactiva con las 4 operaciones
# básicas, validación de entradas y manejo de
# división por cero.
# ============================================================
# FUNCIONES DE VALIDACIÓN
# ============================================================
# Verifica si el argumento es un número válido
# Acepta: enteros (5, -3), decimales (2.5, -0.7)
es_numero() {
[[ "$1" =~ ^-?[0-9]+(\.[0-9]+)?$ ]]
}
# Verifica si el argumento es cero (numéricamente)
es_cero() {
[ "$(echo "$1 == 0" | bc 2>/dev/null)" -eq 1 ] 2>/dev/null
}
# ============================================================
# FUNCIONES PRINCIPALES
# ============================================================
# Muestra
# Verifica si el argumento es un número válido
# Acepta: enteros (5, -3), decimales (2.5, -0.7)
es_numero() {
[[ "$1" =~ ^-?[0-9]+(\.[0-9]+)?$ ]]
}
# Verifica si el argumento es cero (numéricamente)
es_cero() {
[ "$(echo "$1 == 0" | bc 2>/dev/null)" -eq 1 ] 2>/dev/null
}
## ============================================================
# FUNCIONES PRINCIPALES
# ============================================================
# Muestra el menú principal
mostrar_menu() {
clear 2>/dev/null || echo ""
echo "================================"
echo " CALCULADORA BÁSICA"
echo "================================"
echo " 1. Sumar"
echo " 2. Restar"
echo " 3. Multiplicar"
echo " 4. Dividir"
echo " 5. Salir"
echo "================================"
}
# Solicita un número al usuario con validación
solicitar_numero() {
local mensaje="$1"
local numero
while true; do
read -p "$mensaje" numero
if es_numero "$numero"; then
echo "$numero"
return 0
else
echo " Error: '$numero' no es un número válido"
echo " Ejemplos válidos: 5, -3, 2.5"
fi

done
}
# Realiza la operación seleccionada
realizar_operacion() {
local opcion="$1"
local num1="$2"
local num2="$3"
local resultado
case $opcion in
1)
resultado=$(echo "scale=2; $num1 + $num2" | bc)
echo " $num1 + $num2 = $resultado"
;;
2)
resultado=$(echo "scale=2; $num1 - $num2" | bc)
echo " $num1 - $num2 = $resultado"
;;
3)
resultado=$(echo "scale=2; $num1 * $num2" | bc)
echo " $num1 × $num2 = $resultado"
;;
4)
if es_cero "$num2"; then
echo " Error: No se puede dividir por cero"
return 1
fi
resultado=$(echo "scale=2; $num1 / $num2" | bc)
# Eliminar ceros innecesarios al final
resultado=$(echo "$resultado" | sed 's/\.\{0,1\}0*$//')
echo " $num1 ÷ $num2 = $resultado"
;;
}
# ============================================================
# PROGRAMA PRINCIPAL
# ============================================================

