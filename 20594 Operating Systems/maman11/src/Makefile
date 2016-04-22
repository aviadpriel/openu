FLAGS = -Wall  -L./ -m32

all: binsem.a ut.a clean

ut.a:
	gcc $(FLAGS)  -c ut/ut.c
	ar rcu libut.a ut.o
	ranlib libut.a 

binsem.a:
	gcc $(FLAGS)  -c binsem/binsem.c
	ar rcu libbinsem.a binsem.o
	ranlib libbinsem.a 

clean:
	rm -f *.o 
	rm -f a.out
	rm -f *~
	rm -f ph
	rm -f *a 
