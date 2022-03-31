cleanup_flag=0
auto_run_flag=0


while getopts 'cr' FLAG
    do
        case $FLAG in
            c)     cleanup_flag=1
                   ;;
            r)     auto_run_flag=$(echo ${auto_run_flag}+1 | bc)
                   ;;
            ?)     printf "Usage: $0 [-c] [-r] [FILENAME]\n"
                   exit 1
                   ;;
        esac
    done
shift $(($OPTIND - 1))

extension=$(echo $1 |awk -F . '{if (NF>1) {print $NF}}')
argcount=$#
if [ ${extension} != "asm" ]; then
    printf "Selected file should have a .asm extension\n"
    exit 1
fi
filename=$(echo $(realpath $1) | cut -f 1 -d '.')

if [ ${argcount} -eq 1 ]; then
    printf "Compiling...\n"
    nasm -f elf64 -g -F DWARF ${filename}.asm
    printf "Object file creation complete, linking...\n"
    ld -e start -o ${filename} ${filename}.o
    printf "Finished linking, run $(realpath $filename) to see the output\n"
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
if [ ${auto_run_flag} -gt 0 ]; then
     printf "Running the generated file ...\n-------------------------------------\n\n"
     $(realpath ${filename})

     if [ ${auto_run_flag} -gt 1 ] && [ ${cleanup_flag} -eq 1 ]; then
         printf "\n-------------------------------------\nRemoving generated file\n"
         rm ${filename}
     fi
fi
exit 0
