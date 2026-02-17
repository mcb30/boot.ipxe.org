SRCDIR			?= src

SPECIAL_FILES		+= 1mb
SPECIAL_FILES		+= errors

STATIC_FILES		+= hw.ipxe
STATIC_FILES		+= ipxe.png
STATIC_FILES		+= texture.png
STATIC_FILES		+= tinycore.ipxe
STATIC_FILES		+= demo/boot.php
STATIC_FILES		+= demo/index.html

BIN_FILES		+= bin/ipxe.lkrn
BIN_FILES		+= bin/ipxe.pxe
BIN_FILES		+= bin/ipxe-legacy.lkrn
BIN_FILES		+= bin/ipxe-legacy.pxe
BIN_FILES		+= bin/undionly.kpxe
BIN_FILES		+= bin/niclist.txt

BIN_COMBI_FILES		+= bin-combi/ipxe.iso
BIN_COMBI_FILES		+= bin-combi/ipxe.usb
BIN_COMBI_FILES		+= bin-combi/ipxe-legacy.iso
BIN_COMBI_FILES		+= bin-combi/ipxe-legacy.usb

BIN_OTHER_FILES		+= bin-arm32-efi/ipxe.efi
BIN_OTHER_FILES		+= bin-arm32-efi/ipxe-legacy.efi
BIN_OTHER_FILES		+= bin-arm32-efi/snponly.efi
BIN_OTHER_FILES		+= bin-arm32-linux/ipxe.linux
BIN_OTHER_FILES		+= bin-arm64-efi/ipxe.efi
BIN_OTHER_FILES		+= bin-arm64-efi/ipxe-legacy.efi
BIN_OTHER_FILES		+= bin-arm64-efi/snponly.efi
BIN_OTHER_FILES		+= bin-arm64-efi-sb/ipxe.efi
BIN_OTHER_FILES		+= bin-arm64-efi-sb/snponly.efi
BIN_OTHER_FILES		+= bin-arm64-efi-sb/testsign.crt
BIN_OTHER_FILES		+= bin-arm64-linux/ipxe.linux
BIN_OTHER_FILES		+= bin-i386-efi/ipxe.efi
BIN_OTHER_FILES		+= bin-i386-efi/ipxe-legacy.efi
BIN_OTHER_FILES		+= bin-i386-efi/snponly.efi
BIN_OTHER_FILES		+= bin-i386-linux/ipxe.linux
BIN_OTHER_FILES		+= bin-loong64-efi/ipxe.efi
BIN_OTHER_FILES		+= bin-loong64-efi/ipxe-legacy.efi
BIN_OTHER_FILES		+= bin-loong64-efi/snponly.efi
BIN_OTHER_FILES		+= bin-loong64-linux/ipxe.linux
BIN_OTHER_FILES		+= bin-riscv32/ipxe.lkrn
BIN_OTHER_FILES		+= bin-riscv32/ipxe.sbi
BIN_OTHER_FILES		+= bin-riscv32-efi/ipxe.efi
BIN_OTHER_FILES		+= bin-riscv32-efi/ipxe-legacy.efi
BIN_OTHER_FILES		+= bin-riscv32-efi/snponly.efi
BIN_OTHER_FILES		+= bin-riscv32-linux/ipxe.linux
BIN_OTHER_FILES		+= bin-riscv64/ipxe.lkrn
BIN_OTHER_FILES		+= bin-riscv64/ipxe.sbi
BIN_OTHER_FILES		+= bin-riscv64-efi/ipxe.efi
BIN_OTHER_FILES		+= bin-riscv64-efi/ipxe-legacy.efi
BIN_OTHER_FILES		+= bin-riscv64-efi/snponly.efi
BIN_OTHER_FILES		+= bin-riscv64-linux/ipxe.linux
BIN_OTHER_FILES		+= bin-x86_64-efi/ipxe.efi
BIN_OTHER_FILES		+= bin-x86_64-efi/ipxe-legacy.efi
BIN_OTHER_FILES		+= bin-x86_64-efi/snponly.efi
BIN_OTHER_FILES		+= bin-x86_64-efi-sb/ipxe.efi
BIN_OTHER_FILES		+= bin-x86_64-efi-sb/snponly.efi
BIN_OTHER_FILES		+= bin-x86_64-efi-sb/testsign.crt
BIN_OTHER_FILES		+= bin-x86_64-linux/ipxe.linux
BIN_OTHER_FILES		+= bin-x86_64-pcbios/ipxe.lkrn
BIN_OTHER_FILES		+= bin-x86_64-pcbios/ipxe.pxe
BIN_OTHER_FILES		+= bin-x86_64-pcbios/undionly.kpxe

ERROR_FILES		+= bin/errors
ERROR_FILES		+= bin-arm32-efi/errors
ERROR_FILES		+= bin-arm32-linux/errors
ERROR_FILES		+= bin-arm64-efi/errors
ERROR_FILES		+= bin-arm64-linux/errors
ERROR_FILES		+= bin-i386-efi/errors
ERROR_FILES		+= bin-i386-linux/errors
ERROR_FILES		+= bin-loong64-efi/errors
ERROR_FILES		+= bin-loong64-linux/errors
ERROR_FILES		+= bin-riscv32/errors
ERROR_FILES		+= bin-riscv32-efi/errors
ERROR_FILES		+= bin-riscv32-linux/errors
ERROR_FILES		+= bin-riscv64/errors
ERROR_FILES		+= bin-riscv64-efi/errors
ERROR_FILES		+= bin-riscv64-linux/errors
ERROR_FILES		+= bin-x86_64-efi/errors
ERROR_FILES		+= bin-x86_64-linux/errors
ERROR_FILES		+= bin-x86_64-pcbios/errors

OUTPUTS_SPECIAL		:= $(patsubst %,output/%,$(SPECIAL_FILES))
OUTPUTS_STATIC		:= $(patsubst %,output/%,$(STATIC_FILES))
OUTPUTS_BIN		:= $(patsubst bin/%,output/%,$(BIN_FILES))
OUTPUTS_BIN_COMBI	:= $(patsubst bin-combi/%,output/%,$(BIN_COMBI_FILES))
OUTPUTS_BIN_OTHER	:= $(patsubst bin-%,output/%,$(BIN_OTHER_FILES))

ALL_OUTPUTS		+= $(OUTPUTS_SPECIAL)
ALL_OUTPUTS		+= $(OUTPUTS_STATIC)
ALL_OUTPUTS		+= $(OUTPUTS_BIN)
ALL_OUTPUTS		+= $(OUTPUTS_BIN_COMBI)
ALL_OUTPUTS		+= $(OUTPUTS_BIN_OTHER)

INDEX_DIRS		:= $(sort $(foreach X,$(ALL_OUTPUTS),$(dir $(X))))
INDEX_FILES		:= $(patsubst %/,%/index.html,$(INDEX_DIRS))
INDEX_FIXED		:= $(filter %/index.html,$(ALL_OUTPUTS))
INDEX_DYNAMIC		:= $(filter-out $(INDEX_FIXED),$(INDEX_FILES))

all : $(ALL_OUTPUTS) $(INDEX_DYNAMIC)

clean :
	find output -type  f ! -name .gitignore -delete
	find output -type d -empty -delete

output/1mb :
	dd if=/dev/zero bs=1M count=1 | \
	    openssl aes-256-ctr -nosalt -pass pass:none -iter 1 -out $@

output/errors : $(patsubst %,$(SRCDIR)/%,$(ERROR_FILES))
	sort -u $^ -o $@

$(OUTPUTS_STATIC) : output/% : static/%
	ln -sf $(realpath $<) $@

$(OUTPUTS_BIN) : output/% : $(SRCDIR)/bin/%
	ln -sf $(realpath $<) $@

$(OUTPUTS_BIN_COMBI) : output/% : $(SRCDIR)/bin-combi/%
	ln -sf $(realpath $<) $@

$(OUTPUTS_BIN_OTHER) : output/% : $(SRCDIR)/bin-%
	ln -sf $(realpath $<) $@

$(INDEX_DYNAMIC) : output/% : $(ALL_OUTPUTS)
	( cd $(dir $@) ; \
	  tree -H "." --filesfirst -I index.html -o index.html )
