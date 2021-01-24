#!/bin/awk -f

BEGIN {
	FS=";"; # Separador en la lectura de del fichero de OGT
	maxCharsByLine = 70; # Esto es parte de la especificación del P3
	print "P3"; #formato que usaremos, es necesario indicarlo
	lineChars = 0;
}
NR==1 {
	xSize = $3;
	ySize = $4;
	print xSize" "ySize; # tamaño de ancho y largo
	print "255"; # Aquí indicamos hasta donde irán los colores, en nuestro caso de 0 a 255
}
NR>1{
	for(idxField=1; idxField<NF; idxField++) {
		colors["1"] = substr($idxField, 2, 2); #puse 1, 2 y 3 para evitar problemas al recorrer el array
		colors["2"] = substr($idxField, 4, 2);
		colors["3"] = substr($idxField, 6, 2);

		# este formato solo acepta máximo 70 caracteres por línea
		# son 3 colores y pueden ir hasta 255, que son 3 caracteres
		# además han de estar separados por espacios, por lo que cada
		# pixel ocupará como máximo 4 caracteres
		for(color in colors)
		{
			decimalColor = sprintf("%d ", "0x"colors[color]);
			colorCharSize = length(decimalColor);
			lineChars = lineChars + colorCharSize;
			if(lineChars > maxCharsByLine -1) {
				print "";
				lineChars = colorCharSize;
			}
			printf(decimalColor);
		}
	}
}
END {
	print ""; # un salto de línea final por si acaso
}
