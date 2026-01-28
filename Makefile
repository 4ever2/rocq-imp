all: Makefile.rocq
	@+$(MAKE) -f Makefile.rocq all

clean: Makefile.rocq
	@+$(MAKE) -f Makefile.rocq cleanall
	@rm -f Makefile.rocq Makefile.rocq.conf

Makefile.rocq: _CoqProject
	rocq makefile -f _CoqProject -o Makefile.rocq

imp.ast: all

imp.mlf: imp.ast
	peregrine ocaml imp.ast -o imp.mlf

force _CoqProject Makefile: ;

%: Makefile.rocq force
	@+$(MAKE) -f Makefile.rocq $@

.PHONY: all clean force
