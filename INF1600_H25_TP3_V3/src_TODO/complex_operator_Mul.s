/*
INF1600 - TP3 - Visualisation de la serie de Mandelbrot
Matricules: 
Date:
Version: 1.0
Description:



/* Attention, ici il faudra utiliser les opérateurs surchargés : _ZNK7Complex8realPartEv et _ZNK7Complex8imagPartEv 
ainsi que l'instruction faddp (pour multiplier 2 nombres de la pile flottante et met le résultat sur le dessus de la pile.
Ex : fmulp ST(1), ST(0) ? multiplie ST(1) = ST(1) * ST(0))
l'instruction fsubrp et l'instructions  faddp  pour soustraire et additionner
et l'instruction fstps pour dépile la dernière valeur de la pile flottante et mets la valeur dans l'adresse indiquée

L'opérateur plus doit appeler un constructeur pour créer le nombre complexe résultat de l'addition (retour de la fonction)
*/
.extern malloc
.data

.text
.globl _ZmlRK7ComplexS1_            # mangling vous est fourni

_ZmlRK7ComplexS1_  :
     # Prologue : Sauvegarder EBP et sauvegarder %ebx et %edi sur la pile
    push    %ebp                    
    movl    %esp, %ebp               # Initialisation de la pile de la fonction
    push    %ebx                     # Sauvegarder %ebx (callee-saved)
    push    %edi                     # Sauvegarder %edi (callee-saved)

     subl $8, %esp #réserve l'espace pour les résultats temporaires


    pushl 8(%ebp)                    
    call _ZNK7Complex8realPartEv     
    addl $4, %esp                    

    pushl 12(%ebp)                   
    call _ZNK7Complex8realPartEv     
    addl $4, %esp                    

    fmulp %st(1), %st                

    pushl 8(%ebp)                    
    call _ZNK7Complex8imagPartEv     
    addl $4, %esp                    

    pushl 12(%ebp)                   
    call _ZNK7Complex8imagPartEv     
    addl $4, %esp                    

    fmulp %st(1), %st                
    fsubp                            

    fstps (%esp)                     

    # Calcul de la partie imaginaire (ad + bc)
    pushl 8(%ebp)                    
    call _ZNK7Complex8realPartEv     
    addl $4, %esp                    

    pushl 12(%ebp)                  
    call _ZNK7Complex8imagPartEv     
    addl $4, %esp                    # Nettoie la pile

    fmulp %st(1), %st                # Multiplie a * d

    pushl 8(%ebp)                    # Pointeur vers c1
    call _ZNK7Complex8imagPartEv     # Obtient la partie imaginaire de c1
    addl $4, %esp                    # Nettoie la pile

    pushl 12(%ebp)                   # Pointeur vers c2
    call _ZNK7Complex8realPartEv     # Obtient la partie réelle de c2
    addl $4, %esp                    # Nettoie la pile

    fmulp %st(1), %st                # Multiplie b * c
    faddp                            # Additionne (ad + bc)

    fstps 4(%esp)                    # Stocke le résultat dans l'espace réservé

    # Préparation pour l'appel au constructeur
    subl $12, %esp                   # Réserve de l'espace pour les arguments du constructeur

    pushl $8                         # Taille d'un objet Complex (8 octets)
    call malloc                      
    addl $4, %esp                    # Nettoie la pile

    # Vérification de l'allocation mémoire
    testl %eax, %eax
    jz .malloc_failed                # Si malloc échoue, saute à la gestion d'erreur

    # Préparation des arguments pour le constructeur
    movl %eax, (%esp)                
    flds 16(%esp)                    
    fstps 4(%esp)                    
    flds 20(%esp)                    
    fstps 8(%esp)                    

    call _ZN7ComplexC1Eff            

    addl $20, %esp                   

.epilogue:
    popl    %edi                     
    popl    %ebx                     
    leave                            
    ret

.malloc_failed:
    xorl %eax, %eax                  
    jmp .epilogue

