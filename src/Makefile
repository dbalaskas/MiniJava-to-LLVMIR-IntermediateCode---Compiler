# Created by Dionysios Taxiarchis Balaskas - 1115201700094

all: compile

compile:
	java -jar ../jtb132di.jar -te minijava.jj
	java -jar ../javacc5.jar minijava-jtb.jj
	javac Main.java

clean:
	rm *.class
	rm db_visitor/*.class
	rm symbolTable/*.class
	# rm *.java
	# rm *.java !("Main.java")
	rm -r syntaxtree/
	rm -r visitor/