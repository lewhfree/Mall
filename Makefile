WCC = wcc
WASM = wasm
WCL = wcl

BUILDDIR = build

C_SRC = src/main.c
ASM_SRC = src/boot.asm

C_OBJ = $(C_SRC:src/%.c=$(BUILDDIR)/%.o)

ASM_OBJ = $(BUILDDIR)/boot.o

ALL_FLAGS = -q


all: $(BUILDDIR) FALL.EXE

$(BUILDDIR):
	mkdir -p $(BUILDDIR)

FALL.EXE: $(C_OBJ) $(ASM_OBJ)
	$(WCL) $(ALL_FLAGS) -fe=FALL.EXE $(C_OBJ) $(ASM_OBJ)

$(C_OBJ): $(C_SRC)
	$(WCC) $(ALL_FLAGS) -fo=$@ -bt=dos $<

$(ASM_OBJ): $(ASM_SRC)
	$(WASM) $(ALL_FLAGS) -fo=$@ $<

clean:
	rm -rfv $(C_OBJ) $(ASM_OBJ) $(BUILDDIR) FALL.EXE
