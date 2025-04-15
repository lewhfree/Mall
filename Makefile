WCC = wcc
WASM = wasm
WCL = wcl

C_SRC = src/main.c
ASM_SRC = src/boot.asm

C_OBJ = $(C_SRC:src/%.c=build/%.o)
ASM_OBJ = build/boot.o

ALL_FLAGS = -q

all: FALL.EXE

FALL.EXE: $(C_OBJ) $(ASM_OBJ)
	$(WCL) $(ALL_FLAGS) -fe=FALL.EXE $(C_OBJ) $(ASM_OBJ)

$(C_OBJ): $(C_SRC)
	$(WCC) $(ALL_FLAGS) -fo=$@ -bt=dos $<

$(ASM_OBJ): $(ASM_SRC)
	$(WASM) $(ALL_FLAGS) -fo=$@ $<

clean:
	rm -fv $(C_OBJ) $(ASM_OBJ) FALL.EXE
