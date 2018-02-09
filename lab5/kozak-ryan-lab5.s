.data

Input:
	.space 60
Message:

	.ascii "Please enter a text message\n\0"
FixPrompt:
	.ascii "Fixed sentence is:\n\0"
.text

.global _start

_start:
	mov $Message, %eax
	call PrintCString
	
	mov $Input, %eax
	mov $60, %ebx
	call ScanCString

	mov $Input, %eax
	call LengthCString

	mov $0, %edi

iLoop:
	mov Input(%edi), %al

	cmp $90, %al        
	jg IgnoreMe

	cmp $65, %al
	jl IgnoreMe

MakeChanges:	
	mov $Input, %eax
	add $32, (%eax, %edi)
 
IgnoreMe:
	cmp %ebx, %edi
	jge EndLoop
	add $1, %edi
	call iLoop	

EndLoop:
	mov $FixPrompt, %eax
	call PrintCString
	mov $Input, %eax
	call PrintCString
	call EndProgram
