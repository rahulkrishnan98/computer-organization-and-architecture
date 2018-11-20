.data
    prompt: .asciiz "Enter the n"
.text
    main:
        #User I/O
        li $v0, 4
        la $a0, prompt
        syscall
        li $v0, 5
        syscall
        add $a0, $v0, $zero
        addi $a1, $zero, 1  #ans is stored in $a1
        jal fact
        j finish

        fact:
            addi $sp, $sp, -4  #adding an element (reserve space), since stacks start from higher mem address
            sw $ra, 0($sp)

            slti $t0, $a0, 1
            beq $t0, $zero, loop

            addi $sp, $sp, 4
            
            jr $ra

        loop:
            mul $a1, $a1, $a0
            addi $a0, $a0, -1
            jal fact    #stores address of the lw instruction and goes to label-->fact
        
        lw $ra, 0($sp)
        addi $sp, $sp, 4 #deleting 1 elements
        
        jr $ra #until main ra
        
        finish:

