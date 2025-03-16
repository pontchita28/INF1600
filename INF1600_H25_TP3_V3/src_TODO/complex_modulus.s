/*
INF1600 - TP3 - Visualisation de la serie de Mandelbrot
Matricules: 2324529, 2108889
Date: 
Version: 1.0
Description:

/* Attention, ici il faudra utiliser les instructions
l'instruction faddp, fmulp et fsqrt (pour faire dea opérations sur
2 nombres de la pile flottante et met le résultat sur le dessus de la pile.
Ex : fmulp ST(1), ST(0) → multiplie ST(1) = ST(1) * ST(0))
*/ 

.data

.text
.globl _ZNK7Complex7modulusEv

_ZNK7Complex7modulusEv:
    # prologue
    push    %ebp
    movl    %esp, %ebp

    # TODO

    // pour avoir le modulus: on doit faire sqrt(image^2 + reel^2)


    // faddp: fait la somme de la source et de la destination et mets le résultat
    // dans la destination 
    
    // on a deux fonctions qui nous permettent de retourner 
    // la partie image et la partie réelle directement 
    // faire des appels de fonctions pour pouvoir les utiliser 
    // en faisant un push premièrement pour leurs paramètres respectifs
    // pour mettre leur utilisation 

    // pas de paramètres, donc appel direct des fonctions

    // appel de la fonction pour avoir la valeur réelle 
    call _ZNK7Complex8realPartEv # va mettre le résultat dans le premier registre de la FPU ST[0]

    // calcul de la partie réelle au carré (se trouve dans ST[1])
    // chargement de cette même valeur au dessus de la pile 
    fld %st(0)

    // faire la multiplication de st(0) et st(1) pour avoir le carré

    fmulp %st(1), %st(0) # multiplication de la valeur qui se trouve dans cette adresse par elle-même
        // mets la nouvelle valeur dans st(0) et dépile ce qui a dans st(1)
    
    
    // appel de la fonction pour avoir la partie complexe 
    call _ZNK7Complex8imagPartEv # va mettre le résultat dans le premier registre de la FPU ST[0]
        // décalage de la valeur de l'autre résultat de la valeur réelle dans ST[1]

    fld %st(0) # va décaler partie réelle dans st(2), le résultat du call dans st(1) et le nouveau placement
    // dans st(0)

    fmulp %st(1), %st(0) #st(0) sera vide 

    // partie reelle dans st(2) et image dans st(1) sous la forme de carrés

    faddp %st(1), %st(0) # addition de ST(1) + ST(2) pour la mettre dans ST(1)

    // faire une racine carrée du résultat 
    fsqrt  # retourner la valeur de la racine carrée dans ST(0) implicitement 

    // comme on veut retourner un flottant, on laisse la valeur dans ST(0)

    # epilogue
    leave
    ret
