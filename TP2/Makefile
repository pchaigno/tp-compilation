#			TP2. Analyseur Syntaxique
#
#	Makefile donn� � titre d'exemple
#
#
#	Der. Rev. : 03 Oct. 08		par : Beno�t Boyer
#
#


# Indiquer ici la liste des fichiers.
# Pour chaque fichier source *.ml que vous allez cr�er, 
# ajouter les fichiers *.cmo correspondants.
# Exemple : 
#	sources : file_1.ml file_2.ml main.ml
# CMO=file_1.cmo file_2.cmo file_3.cmo
CMO=fichier_1.cmo fichier_2.cmo fichier_3.cmo

######################################################################
# pour utilizer l'analyseur lexical de secours, d�commentez la ligne #
# suivante (retirez le # devant LEX)				     #
######################################################################
# LEX=analex.cma
#
# Informations pour utiliser l'analyseur lexical de secours
DIR=lib/

# Nom de l'ex�cutable produit (vous pouvez le changer � votre guise)
OUT=tp2


CFLAGS=-dtypes -I $(DIR)
CC=ocamlc $(CFLAGS)
RM=rm -rf

.PHONY: clean all

# Pour compiler sans la librairie 
all: $(OUT)

$(OUT): $(CMO)
	$(CC) $(LEX) $^ -o $@
	@echo "===> $@ est compil� avec succ�s!!!"


-include .depend

%.cmo:	%.ml 
	$(CC) -c $<

clean:
	$(RM) $(OUT) *~ $(CMO) .depend \
	$(CMO:.cmo=.cmi) $(CMO:.cmo=.annot)

.depend:$(shell *.ml *.mli)
	ocamldep $(CMO) > .depend
