CAF=caf

alloc_test: alloc_test.f90
	$(CAF) $< -o $@
