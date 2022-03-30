cleanup_flag=0
auto_run_flag=0


while getopts 'cr' FLAG
	do
    	case $FLAG in
        	c)	cleanup_flag=1
        		;;
    		r)	auto_run_flag=1
    			;;
			?)	printf "Usage: $0 [-c] [-r] [FILENAME]\n"
				exit 1
				;;
    	esac
	done
shift $(($OPTIND - 1))


argcount=$#
filename=$(echo "$1" | cut -f 1 -d '.')

if [ ${argcount} -eq 1 ]; then
    printf "Compiling...\n"
    nasm -f elf64 -g -F DWARF ${filename}.asm
    printf "Object file creation complete, linking...\n"
    ld -e start -o ${filename} ${filename}.o
    printf "Finished linking, run ./${filename} to see the output\n"
elif [ ${argcount} -gt 1 ]; then
    printf "Please input path to only one file\n"
    exit 1
else
    printf "Please input path to a file\n"
    exit 1
fi
if [ ${cleanup_flag} -eq 1 ]; then
	printf "Removing object file\n"
	rm ${filename}.o
fi
if [ ${auto_run_flag} -eq 1 ]; then
	printf "Running the generated file ...\n\n"
	$(realpath ${filename})
fi
exit 0
