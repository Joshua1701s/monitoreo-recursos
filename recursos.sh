#!/bin/bash
output_file="monitoreo.txt"
cont=1
seg=0
echo -e "Tiempo(s)\tCPU_libre (%)\tMemoria_libre (%)\tDisco_libre (%)" > "$output_file"
while [ $cont -le 5 ]; do
	sleep 60
	seg=$((seg+60))
	cpu_reposo=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print $1}')
	cpu=$(echo "100 - $cpu_reposo" | bc)
	memoria=$(free -m | awk 'NR==2{print $4}') 
	disco=$(df -h | awk 'NR==2{print $4}')
	printf "%-15s\t%-15s\t%-20s\t%-15s\n" "$seg" "$cpu" "$memoria" "$disco" >> "$output_file"
 	((cont++))
done
