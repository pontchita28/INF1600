/*
INF1600 - TP3 - Visualisation de la serie de Mandelbrot
Matricules: 
Date: 
Version: 1.0
Description:


*/

/* Attention, ici il faudra utiliser les opérateurs surchargés : _ZNK7Complex8realPartEv et _ZNK7Complex8imagPartEv 
ainsi que l'instruction faddp (pour additionner 2 nombres de la pile flottante et met le résultat sur le dessus de la pile.
Ex : ADDP ST(1), ST(0) → Additionne ST(1) = ST(1) + ST(0))
et l'instruction fstps pour dépile la dernière valeur de la pile flottante et mets la valeur dans l'adresse indiquée

L'opérateur plus doit appeler un constructeur pour créer le nombre complexe résultat de l'addition (retour de la fonction)
*/


.data

.text
.globl _ZplRK7ComplexS1_            # mangling vous est fourni

_ZplRK7ComplexS1_:
    # Prologue
    push    %ebp
    movl    %esp, %ebp
    push    %ebx
    push    %edi

    # Allouer 32 octets sur la pile pour plus de sécurité
    subl    $24, %esp

    # Charger les adresses des objets Complex
    movl    12(%ebp), %ebx  # premier objet
    movl    16(%ebp), %edi # deuxième objet

    # Partie réelle
    pushl   %ebx  # Passer l'adresse du premier objet (this)
    call    _ZNK7Complex8realPartEv
    addl    $4, %esp  # Équilibrer la pile après l'appel
    fstps   -8(%ebp)  # Stocker la valeur float sur la pile

    pushl   %edi  # Passer l'adresse du deuxième objet (this)
    call    _ZNK7Complex8realPartEv
    addl    $4, %esp  # Équilibrer la pile après l'appel
    flds    -8(%ebp)  # Charger la partie réelle du premier objet
    faddp   %st(1), %st(0)  # Additionner les parties réelles
    fstps   -8(%ebp)  # Stocker le résultat (float)

    # Partie imaginaire
    pushl   %ebx  # Passer l'adresse du premier objet (this)
    call    _ZNK7Complex8imagPartEv
    addl    $4, %esp  # Équilibrer la pile après l'appel
    fstps   -16(%ebp)  # Stocker la valeur float sur la pile

    pushl   %edi  # Passer l'adresse du deuxième objet (this)
    call    _ZNK7Complex8imagPartEv
    addl    $4, %esp  # Équilibrer la pile après l'appel
    flds    -16(%ebp)  # Charger la partie imaginaire du premier objet
    faddp   %st(1), %st(0)  # Additionner les parties imaginaires
    fstps   -16(%ebp)  # Stocker le résultat (float)

    # Appel du constructeur
    leal    -24(%ebp), %ecx  # Allouer de l'espace pour l'objet Complex sur la pile
    movl    %ecx, (%esp)     # Passer l'adresse de l'objet (this) comme premier paramètre
    
    flds    -8(%ebp)         # Charger la partie réelle (float)
    fstps   4(%esp)          # Stocker la partie réelle sur la pile (x)
    
    flds    -16(%ebp)        # Charger la partie imaginaire (float)
    fstps   8(%esp)          # Stocker la partie imaginaire sur la pile (y)

    
    pushl %esp
    
    call    _ZN7ComplexC1Eff

    # Récupérer la valeur de retour du constructeur (adresse de l'objet dans %eax)
    movl    %ecx, %eax
    
    # Épilogue: Restaurer les registres et revenir
    addl    $24, %esp  # Libérer l'espace alloué sur la pile
    popl    %edi
    popl    %ebx
    leave
    ret