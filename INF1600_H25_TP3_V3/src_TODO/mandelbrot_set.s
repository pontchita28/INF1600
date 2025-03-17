/*
INF1600 - TP3 - Visualisation de la serie de Mandelbrot
Matricules: 2324529, 2108889
Date: 13 mars 2024
Version: 1.0
Description:
Vous devrez utiliser la fonction
fisttpl qui prend le registre ST(0) de la pile FPU (valeur le plus récemment chargée)
et le met à l'emplacement mémoire spécifié. Puisque vous ne pouvez pas spécifier
directement un registre vous devrez faire comme suit (en utilisant le dessus de la pile)
si vous voulez de mettre dans le registre %eax
fisttpl (%esp)
movl (%esp), %eax
*/
.extern _Znwm
.data
maxIterations:
    .int 100
# Vous avez le choix de considerer la variable escapeRadius comme un float ou un int, dependament de votre implementation
# Les deux variables sont fournies pour vous faciliter la vie
escapeRadiusFloat:
.float 2.0
escapeRadiusInt:
.int 2

.text
.globl Z13mandelbrotSetRK7ComplexS1i # mangling vous est fourni
Z13mandelbrotSetRK7ComplexS1i: # mangling vous est fourni
    # prologue
    push %ebp
    movl %esp, %ebp
    # ebp + 8 est pointeur vers z
    # ebp + 12 est pointeur vers c
    # ebp + 16 est count
    movl 8(%ebp), %eax # z dans eax
    pushl (%eax)

    call _ZNK7Complex7modulusEv #le résultat du mod est a St(0)
    flds escapeRadiusFloat #charge escape radius pour la comparaison
    fcompp #compare st0 et st1 et vide la fpu
    fstsw %ax # charge l'état
    sahf #mets a jour le flag

    jbe end # si mod plus grand on retourne count
    addl $4, (%esp) # si c'est pas le cas, on retire z de la pile
    movl 16(%ebp), %eax
    addl $1, %eax

    cmpl maxIterations, %eax # compare count et max iteration
    jae end #fin si on atteint max

    #appel fonction recursive
    movl 8(%ebp), %eax
    pushl %eax
    pushl %eax # ajoute deux fois z sur la pile
    call _ZmlRK7ComplexS1_ #multiplie z et z et mets dans eax
    addl $8, %esp #nettoye la pile
    movl %eax, %ebx #mets z*z dans ebx
    movl 12(%ebp), %eax # c dans eax
    pushl %eax
    pushl %ebx #les deux sur la pile
    call _ZmlRK7ComplexS1_ #zz +c dans eax
    addl $8, %esp #nettoye la pile
    subl $12, %esp #réserve 3 espaces pour les parametres de la fonction
    movl %eax, (%esp) #premier argument : zz+c
    movl 12(%ebp), %eax
    movl %eax, 4(%esp) #deuxieme argument c
    movl 16(%ebp), %eax
    movl %eax, 8(%esp) #troisieme argument count
    call Z13mandelbrotSetRK7ComplexS1i #appelle récursive
    addl $12, %esp #nettoye la pîle.
 end:
# epilogue
leave
ret