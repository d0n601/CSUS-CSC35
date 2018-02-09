.data

cls:
	.ascii "\x1B[H\x1B[2J"
sp:
	.ascii " "
PERIOD:
	.ascii ".\n"
Welcome:
	.ascii "Welcome to Silly Sentences!\n\n" #29 char

Prompt1:
	.ascii "Player A, enter a noun: " #24 char
Prompt2:
	.ascii "Player B, enter a verb: " #24 char
Prompt3:
	.ascii "Player A, enter a preposition: " #31 char
Prompt4:
	.ascii "Player B, enter a noun: " #24 char
EndPrompt:
	.ascii "Your sentence is:\n\n" #19 char

A1:
	.space 60
A2:
	.space 60
A3:
	.space 60
A4:
	.space 60

l1:
	.space 60
l2:
	.space 60
l3:
	.space 60
l4:
	.space 60

.text

.global _start


_start:
	call clear

	mov $4, %eax	#Welcome Message
	mov $1, %ebx
	mov $Welcome, %ecx
	mov $29, %edx
	int $0x80

	mov $4, %eax	#First Prompt
        mov $1, %ebx
        mov $Prompt1, %ecx
        mov $24, %edx
        int $0x80

	mov $3, %eax	#FIRST SCAN
	mov $0, %ebx
	mov $A1, %ecx
	mov $60, %edx
	int $0x80

	sub $1, %eax	#So I guess i have to do this because the hitting enter stores the dang return?? sillyness indeed....
	mov %eax, l1 	#Store the byte length
	call clear	

	mov $4, %eax	#Second Prompt
	mov $1, %ebx
	mov $Prompt2, %ecx
	mov $24, %edx
	int $0x80

        mov $3, %eax	#Second Scan
        mov $1, %ebx
        mov $A2, %ecx
        mov $60, %edx
        int $0x80

	sub $1, %eax
	mov %eax, l2
	call clear


        mov $4, %eax    #Third Prompt
        mov $1, %ebx
        mov $Prompt3, %ecx
        mov $31, %edx
        int $0x80

        mov $3, %eax    #Third Scan
        mov $1, %ebx
        mov $A3, %ecx
        mov $60, %edx
        int $0x80

	sub $1, %eax
	mov %eax, l3
	call clear

        mov $4, %eax    #Fourth Prompt
        mov $1, %ebx
        mov $Prompt4, %ecx
        mov $24, %edx
        int $0x80

        mov $3, %eax    #Fourth Scan
        mov $1, %ebx
        mov $A4, %ecx
        mov $60, %edx
        int $0x80
	
	sub $1, %eax
	mov %eax, l4
	call clear


	mov $4, %eax	#Say the stuff to say
        mov $1, %ebx
        mov $EndPrompt, %ecx
        mov $19, %edx
        int $0x80

        mov $4, %eax    #Noun 1
        mov $1, %ebx
        mov $A1, %ecx
        mov l1, %edx
        int $0x80

	call space 	#Derp me a space in these wordz

	mov $4, %eax    #Verb
        mov $1, %ebx
        mov $A2, %ecx
        mov l2, %edx
        int $0x80

	call space

        mov $4, %eax    #Preposition
        mov $1, %ebx
        mov $A3, %ecx
        mov l3, %edx
        int $0x80

	call space

        mov $4, %eax    #Noun2
        mov $1, %ebx
        mov $A4, %ecx
        mov l4, %edx
        int $0x80

        mov $4, %eax    #Finish it off with proper grammarz and new line
        mov $1, %ebx
        mov $PERIOD, %ecx
        mov $2, %edx
        int $0x80

	call end


clear:
	mov $4, %eax
	mov $1, %ebx
	mov $cls, %ecx
	mov $7, %edx
	int $0x80


space:
        mov $4, %eax          
        mov $1, %ebx
        mov $sp, %ecx
        mov $1, %edx
        int $0x80
	ret
	
end:
	mov $1, %eax
	int $0x80

