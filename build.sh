rm ./bin/*
echo "                      "
fpc -Px86_64 -Mdelphi -Cg -fPIC -FU./dcu -FE./bin -ojs.so -Un -Tlinux -veilb  ./lib/js.pas 
echo "                      "
echo "-----------------------------"
echo "                      "
fpc -Px86_64 -Mdelphi -Cg -FU./dcu -FE./bin -omain -Tlinux ./demo/main.pas


EXE=./bin/main
DLL=./bin/js.so
if [ -f $EXE -a -f $DLL ]; then
        echo "---------------"
        echo "Compiled ok           "
        echo "                      "
        $EXE
    else
        echo "Compilation failed...."
        if [[ ! -f $EXE ]]; then echo "      Missing  $EXE"; fi
        if [[ ! -f $DLL ]]; then echo "      Missing  $DLL"; fi
fi

