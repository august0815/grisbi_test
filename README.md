grisby_test
===========

test with valama ,grisby savefile and simple xml reader

Test with valama
================

See https://github.com/Valama/valama
new IDE for VALA ,  at very early stage

download compile and install valama, then enter valama end enter in project selector grisbi_test
	mkdir build && cmake ..
	make
	copy the *.gsb file to build (at moment only file in same dir is opend)
	click on grisby.
	Please copy the main.ui  to build
	you could allso try to press compile button.

test with simple xml reader

you will need https://github.com/JumpLink/simple-xml-reader-vala compiled and installed !!

Some tests.

Sometime you get an error in grisbi file (bug in grisbi ??) : Bank="-1" is saved in <Account>
To solve this edit the account again in grisbi .

