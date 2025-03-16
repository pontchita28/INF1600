/*
INF1600 - TP3 - Visualisation de la serie de Mandelbrot
Matricules: 2324529, 2108889
Date: 13 mars 2024
Version: 1.0
Description: 
*** Attention, c'est une methode, donc le parametre this est implicite:

*/

.data

.text

.globl _ZN7ComplexC1Eff

// constructeur va agir comme si elle était une fonction 
_ZN7ComplexC1Eff:
    # prologue
    push    %ebp
    movl    %esp, %ebp

    # TODO

    // utilisation des registres caller-safe: %eax, %ecx, %edx pour garder les variables temporaires

    // on a des paramètres qui sont fournis 
    // la fonction appelante va elle-même prendre les paramètres 
    // pour les mettre sur la pile 

    // constructeur va retourner le pointeur vers l'objet, donc son adresse
    // et va mettre l'ojet sur la pile dans la fonction appelante
    
    // mettre les valeurs des paramètres dans des registres pour les manipuler 
    movl 8(%ebp), %eax # pour mettre le premier paramètre (this) 
    movl 12(%ebp), %ecx # pour mettre le deuxième paramètre (x)
    movl 16(%ebp), %edx # pour mettre le 3ème paramètre (y)

    // initialisation de la structure en mettant à partir des
    // adresses contenues dans %eax les valeurs des paramètres 
    movl %ecx, (%eax) # pour mettre la valeur du paramètre x à sa place
    movl %edx, 4(%eax) # pour mettre la valeur du paramètre y à sa place 


    #epilogue                   
    leave

    // ces instructions sont faites directement par le leave
    // suppression des paramètres de la pile pour retourner à l'adresse 
    // avant l'appel de la fonction 
    //movl %ebp, %esp // pour mettre la valeur de l'ancien pointeur de la base dans %esp
        // %esp est le pointeur le plus haut 
    // popl %ebp // pour enlever %ebp de la pile et retourner au déroulement original 

    ret
