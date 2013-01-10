OS = LINUX
PKGS = 	--pkg gee-1.0 --pkg gtk+-3.0 --pkg gio-2.0 --pkg gmodule-2.0 --pkg Sxml-0.1 
		\
# Pakete
PACKAGES       =  gee-1.0  gtk+-3.0  gio-2.0  gmodule-2.0  Sxml-0.1
PKG_FLAGS             = $(PACKAGES:%=--pkg %)
# Version des Pakets
VERSION        = 0.0
# Name des Pakets
PKG_NAME       = GRISBY

# Allgemeine Quelldateien mit Pfad
ASRC_FILES                 = $(wildcard src/*.vala) 
# Quelldateien mit Pfad
SRC_FILES                  = $(ASRC_FILES)
LIBS = \
	
FLAGS = -g
FILES = \
	  src/main.vala \
	  src/MasterState.vala \
	  src/load_file.vala \
	  src/Bank.vala \
	  src/Konto.vala \
	  src/Transaktion.vala \
	  src/Kategorie.vala \
	  src/Subkategorie.vala \
	  src/vParty.vala \
	  src/Planer.vala \
    


all: $(FILES)
	valac $(FLAGS) $(PKGS) $(LIBS) -o main $(FILES)
	./main 

clean:
	find . -type f -name "*.so" -exec rm -f {} \;
	find . -type f -name "*.a" -exec rm -f {} \;
	find . -type f -name "*.o" -exec rm -f {} \;
	find . -type f -name "*.h" -exec rm -f {} \;
	find . -type f -name "*.c" -exec rm -f {} \;
	rm -r doc
	find . -type d -name "doc" -exec rm -r doc \;
	
	rm main

doc: $(SRC_FILES)
	@echo "Generating Documentation..."
	@valadoc -o doc/ --vapidir=/usr/share/vala-0.18/vapi/  $(PKGS) $(CC_FLAGS) $(SRC_FILES) --package-name $(PKG_NAME) --package-version=$(VERSION)
	@gnome-open ./doc/index.html
