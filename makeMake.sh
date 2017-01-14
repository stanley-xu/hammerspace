#!/bin/bash

# help
if [ $# -eq 0 ] || [ $1 == "help" ]; then
    echo "Usage: ./makeMake.sh [executable] [list of .o files]"
    exit 0
fi

# remove existing Makefile
if [ -f Makefile ]; then
    rm Makefile
fi

# read EXEC and OBJECTS from args
for arg in "$@"; do
    if [ ${arg} == $1 ]; then
        echo "EXEC=${arg}" >> Makefile
    else 
        objList+=${arg}
        objList+=" "
    fi
done

echo "OBJECTS=${objList}" >> Makefile

# cat the rest into Makefile
echo "CXX=g++-5" >> Makefile
echo "CXXFLAGS=-std=c++14 -Wall -MMD" >> Makefile
echo "DEP=\${OBJECTS:.o=.d}" >> Makefile
echo "" >> Makefile

echo "\${EXEC}: \${OBJECTS}" >> Makefile
echo -e "\t\${CXX} \${CXXFLAGS} \${OBJECTS} -o \${EXEC}" >> Makefile
echo "-include \${DEP}" >> Makefile
echo "" >> Makefile

echo ".PHONY: clean" >> Makefile
echo "clean:" >> Makefile
echo -e "\trm \${EXEC} \${OBJECTS} \${DEP}" >> Makefile
