.data

message:
	.ascii "Hello world!\nRyan Kozak\n\0"
wayne:
	.ascii "You miss 100% of the shots you don't take\n\0"
grad:
	.ascii "I will in \0"
afterInt:
	.ascii " from Sacramento State\n\0"
	
.text
.global _start

_start:
	mov $message, %eax

	call PrintCString

	mov $wayne, %eax

	call PrintCString

	mov $grad, %eax

	call PrintCString	

	mov $2018, %eax

	call PrintUInt

	mov $afterInt, %eax

	call PrintCString
	
	call EndProgram
