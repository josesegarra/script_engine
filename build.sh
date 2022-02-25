rm ./bin/*

fpc -Px86_64 -Mdelphi -FU./dcu -FE./bin -ojs -Un -Tlinux ./lib/js.pas ./lib/jsFiles.pas
echo "---------------"
fpc -Px86_64 -Mdelphi -FU./dcu -FE./bin -omain -Tlinux ./demo/main.pas


FILE=./bin/main
if test -f "$FILE"; then
    echo "Ok"
    $FILE
    else
    echo "Compilation failed...."
fi


ask ()
{

    rm ./bin/*.sh
    rm ./bin/*.res

    ./fpc/ld -b elf32-i386 -m elf_i386  -init FPC_LIB_START -fini FPC_LIB_EXIT -soname js.so -shared \
        -o ./bin/js.so  \
        ./bin/js.o ./fpc/system.o  ./fpc/objpas.o  ./fpc/si_dll.o

    ./fpc/strip --discard-all --strip-debug ./bin/js.so


    ./fpc/ppc386 @./fpc/fpc.cfg -FE./bin -Tlinux   ./demo/main.pas

    #rm ./bin/*.sh
    #rm ./bin/*.res

    #./fpc/ld -b elf32-i386 -m elf_i386  --dynamic-linker=/lib/ld-linux.so.2  -o ./bin/main  ./fpc/si_dll.o ./fpc/dl.o ./fpc/dynlibs.o          \
    #                    ./fpc/libpsyscall.a ./fpc/libpdynlibs.a                    ./fpc/system.o  ./fpc/objpas.o  



    #rm ./bin/*.o

    echo " "

    FILE=./bin/main
    if test -f "$FILE"; then
        echo "Ok"
        else
        echo "Compilation failed...."
    fi

}