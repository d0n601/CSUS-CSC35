.data

welcomeMessage:
	.ascii "\nI can tell that you're a cartoon duck.\nWhat kind of duck you are though is yet to be decided.\nAnswer my questions and I'll label you accordingly.\n\n\0"

q1:
   	.ascii "Are you exceedingly weathly? (1=Yes, 2=No)\n\0"
q2:
	.ascii "Are you insane? (1=Yes, 2=No)\n\0"
q3:
	.ascii "Are you selfish with your finances? (1=Yes, 2=No)\n\0"

scroogeMcDuck:
	.ascii "You're ScroogeMcDuck...I guess that's cool\n\0"

dewyDuck:
	.ascii "You must be Dewy Duck, young with a rich uncle\n\0"

donaldDuck:
	.ascii "You're Donald Duck, not as insane, not as rich, but kinda both\n\0"

daffyDuck:
	.ascii "Your're Daffy Duck, sorry for all the abuse you suffer\n\0"

.text

.global _start

_start:

       	mov $welcomeMessage, %eax
        call PrintCString
	
	mov $q1, %eax
	call PrintCString

	call ScanUInt
	cmp $1, %eax
	je Rich

Poor:
	mov $q2, %eax
	call PrintCString
	
	call ScanUInt
	cmp  $1, %eax
	je Insane

	mov $donaldDuck, %eax
	call PrintCString
	call EndProgram
	
Insane:
	mov $daffyDuck, %eax
	call PrintCString
	call EndProgram

Rich:
	mov $q3, %eax
	call PrintCString

	call ScanUInt
	cmp $1, %eax
	je Selfish

	mov $dewyDuck, %eax
	call PrintCString
	call EndProgram

Selfish:
	mov $scroogeMcDuck, %eax
	call PrintCString
        call EndProgram

