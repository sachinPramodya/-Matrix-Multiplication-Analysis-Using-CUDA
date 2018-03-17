#!/bin/bash
echo "How many times do you want to run?"
read average
echo "Enter Matrix sizes...AFTER ENTERING PRESS 'Ctrl+d'"
while read line
do
   MatrixSize=("${MatrixSize[@]}" $line)
done

NoOfTimes=$average

#1 File
	echo ""
	outputfile=('output/Cpu.dat')
	program=('nvcc MatrixCPU.c -Wno-deprecated-gpu-targets')
	#program=('gcc Mat.c')
	if [ -e $outputfile ] 
	then
		rm -rf $outputfile
		touch $outputfile
	else
		touch $outputfile
	fi
	
	echo "Data for $outputfile "

	for i in "${MatrixSize[@]}"
	do
		:

		TtlTime=($(seq 0 $NoOfTimes))
		total="0"
		echo "N=$i"
		for j in "${TtlTime[@]}"
		do 
			:
			eval $program
			resp=$(./a.out $i)
			total=$(bc <<< "scale=10; $total+$resp")
			
		done

		avg=$(bc <<< "scale=10; $total/${#TtlTime[@]}")
		printf "( $i, $avg )\n" >> $outputfile
		echo "Average time for $j Iterations = $avg"
	done
	
#2 File
	echo ""
	outputfile=('output/GpuGlobal.dat')
	program=('nvcc Global.cu -Wno-deprecated-gpu-targets')
	#program=('gcc Matrix.c')
	if [ -e $outputfile ] 
	then
		rm -rf $outputfile
		touch $outputfile
	else
		touch $outputfile
	fi
	
	echo "Data for $outputfile "

	for i in "${MatrixSize[@]}"
	do
		:

		TtlTime=($(seq 0 $NoOfTimes))
		total="0"
		echo "N=$i"
		for j in "${TtlTime[@]}"
		do 
			:
			eval $program
			resp=$(./a.out $i)
			total=$(bc <<< "scale=10; $total+$resp")
			
		done

		avg=$(bc <<< "scale=10; $total/${#TtlTime[@]}")
		printf "( $i, $avg )\n" >> $outputfile
		echo "Average time for $j Iterations = $avg"
	done


#3 File
	echo ""
	outputfile=('output/GpuShared.dat')
	program=('nvcc Shared.cu -Wno-deprecated-gpu-targets')
	#program=('gcc MatrixCPU.c')
	if [ -e $outputfile ] 
	then
		rm -rf $outputfile
		touch $outputfile
	else
		touch $outputfile
	fi
	
	echo "Data for $outputfile "

	for i in "${MatrixSize[@]}"
	do
		:

		TtlTime=($(seq 0 $NoOfTimes))
		total="0"
		echo "N=$i"
		for j in "${TtlTime[@]}"
		do 
			:
			eval $program
			resp=$(./a.out $i)
			total=$(bc <<< "scale=10; $total+$resp")
			
		done

		avg=$(bc <<< "scale=10; $total/${#TtlTime[@]}")
		printf "( $i, $avg )\n" >> $outputfile
		echo "Average time for $j Iterations = $avg"
	done





cd output
pdflatex ltx.tex



