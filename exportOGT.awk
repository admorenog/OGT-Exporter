#!/bin/awk -f

# convert rick.jpg txt: | ./exportOGT.awk
NR==1 {
	split($5,metadata,",");
	format = "OGT";
	version ="v0.5";
	lastPositionInY = 0;
	printf format";"version";"metadata[1]";"metadata[2]";";
	for(i=0;i<metadata[1]-4;i++){
		printf ";";
	}
	print "";
}
NR>1 {
	split($1,position,",");
	x = position[1];
	split(position[2], tempY, ":");
	y = tempY[1];
	sameLine = lastPositionInY==y;

	if(!sameLine) {
		# LF
		print "";
	}
	printf $3";";
	lastPositionInY = y

}
END {
	# Terminamos con LF por si acaso
	print "";
}
