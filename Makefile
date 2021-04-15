PROJ_DIR=${PWD}
INC_DIR=${PROJ_DIR}/include
OBJ_DIR=${PROJ_DIR}/obj
BIN_DIR=${PROJ_DIR}/bin
SRC_DIR=${PROJ_DIR}/src

.SUFFIXES: .o .c

OBJFILES= ${OBJ_DIR}/foo.o ${OBJ_DIR}/goo.o ${OBJ_DIR}/myapp.o
CFLAGS= -g -Wall
SRCS := ${shell find ${SRC_DIC} -name "*.c"}

all: dep ${BIN_DIR}/myapp

${BIN_DIR}/myapp: $(OBJFILES)
	gcc $(CFLAGS) -o ${BIN_DIR}/myapp $(OBJFILES)
${OBJ_DIR}/%.o: ${SRC_DIR}/%.c
	gcc $(CFLAGS) -c $< -o $@ -I${INC_DIR}

#./obj/foo.o: ./src/foo.c
#	gcc -c ./src/foo.c -o ./obj/foo.o $(INCLUDE)
#./obj/goo.o: ./src/goo.c
#	gcc -c ./src/goo.c -o ./obj/goo.o $(INCLUDE)
#./obj/myapp.o: ./src/myapp.c
#	gcc -c ./src/myapp.c -o ./obj/myapp.o $(INCLUDE)

dep: .depend

.depend: ${SRCS}
	rm -f ./.depend
	gcc ${CFLAGS} -I${INC_DIR} -M $^ > ./.depend

include ./.depend


clean:
	rm -f ${OBJ_DIR}/*.o
	rm -f ${BIN_DIR}/*
	rm -f ./.depend
