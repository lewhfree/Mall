WCC = wcc
WASM = wasm
WLINK = wlink

BUILDDIR = build

C_SRC = src/main.c

C_OBJ = $(C_SRC:src/%.c=$(BUILDDIR)/%.o)

#ASM_SRC = src/boot.asm

#ASM_OBJ = $(BUILDDIR)/boot.o

LINKERSCRIPT=linkerScript

ALL_FLAGS = -q


all: $(BUILDDIR) FALL.EXE

$(BUILDDIR):
	mkdir -p $(BUILDDIR)

FALL.EXE: $(C_OBJ) #$(ASM_OBJ)
	$(WLINK) @$(LINKERSCRIPT)

$(C_OBJ): $(C_SRC)
	$(WCC) $(ALL_FLAGS) -fo=$@ -bt=dos $<

$(ASM_OBJ): $(ASM_SRC)
	$(WASM) $(ALL_FLAGS) -fo=$@ $<

clean:
	rm -rfv $(C_OBJ) $(ASM_OBJ) $(BUILDDIR) FALL.EXE
