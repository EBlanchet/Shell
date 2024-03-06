#!/bin/sh

# nombres d'arguments != 1
if [ $# -ne 1 ]; then
    echo "./exo4.sh [répertoire contenant des fichiers .c]"
    exit 1
fi

# le répertoire où se situe l'exécutable
repertoire=$(pwd)

# le répertoire en paramètre n'existe pas
if  [ ! -d $1 ]; then
    echo "Le répertoire $1 n'existe pas"
    exit 1
fi

# met la chaine contenant le répertoire à sauvegarder à l'envers
repertoireslash=$(echo $1 | rev)

# enlève les '/' si un ou plusieurs sont présent au début
while [[ ${repertoireslash::1} == "/" ]];
do
    repertoireslash="${repertoireslash:1}"
done

repertoireslash=$(echo $repertoireslash | rev)

# pour avoir uniquement le nom du dossier contenant les fichiers .c
nomdossier=$(echo $repertoireslash | rev | cut -d'/' -f-1 | rev)
repertoiresauv=$repertoireslash

# nom du repertoire sans le dossier à sauvegarder
repertoiresauv=${repertoiresauv%$nomdossier}

# création du répertoire backup s'il n'existe pas
if  [ ! -d backup ]; then
    echo "Le répertoire backup n'existe pas"
    echo "Création du répertoire backup"
    echo "" # saut de ligne
    mkdir backup
fi

echo "Recherche de fichier .c"
echo ""

fichier=$(find $1 -name *.c)

# find renvoie séparément tous les fichiers correspondant
# a ce que l'on souhaite
if [ -z "$fichier" ]; then
    echo "Aucun fichier .c n'a été trouvé dans le répertoire $1"
    exit 0
fi

for prog in $fichier
do
    echo "Fichier .c trouvé : $prog"
    # affiche le nom du programme pour l'envoyer comme entrée de la commande sed
    # remplace le nom du répertoire par backup
    # puis renverse la chaine
    # enlève le premier élément séparé par un '/'
    # puis retourne de nouveau la chaine
    nvrep=$(echo $prog | sed s/"$nomdossier"/"backup"/1 | rev | cut -d'/' -f2- | rev)
    # on enlève tout ce qui est avant le nom du dossier backup
    # si le répertoire est déjà sous la bonne forme
    # la chaine reste la même car $repertoiresauv est une chaine vide
    nvrep=${nvrep#$repertoiresauv}
    # uniquement avoir le nom du fichier .c
    nomfichierc=$(basename $prog)
    if  [ ! -d  $nvrep ]; then
        echo "Creation du chemin : $nvrep"
        # -p : permet de creer backup/a/b même si backup/a n'existe pas sans générer d'erreur
        mkdir -p $nvrep
    else
        echo "Le répertoire \"$nvrep\" existe déjà"
    fi
    echo "Copie de $prog dans $nvrep/$nomfichierc.save"
    cp $prog $nvrep/$nomfichierc.save
done

echo ""
echo "Le répertoire $1 a entièrement été sauvegardé dans $repertoire/backup"

exit 0
