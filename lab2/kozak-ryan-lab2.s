.data

#Initial Message on Startup
start_message:
    .ascii "Your're at a vending machine, put in some coins...\n\0"

#Post Coint Input Message
put_in_message:
    .ascii "Yout put in: \0"

#Monetery Input Messages
m_quarters:
    .ascii "\nQuarters: \0"
m_dimes:
    .ascii "\nDimes: \0"
m_nickels:
    .ascii "\nNickels: \0"
m_pennies:
    .ascii "\nPennies: \0"

#Monetry Stored Values
d_quarters:
    .long 0
d_dimes:
    .long 0
d_nickels:
    .long 0
d_pennies:
    .long 0
d_total:
    .long 0




.text

.global _start

_start:
    
    call getMoney
    call displayMoney

    mov $post_in_message, %eax
    call PrintCString

    mov d_total, %eax
    call PrintUInt

    call EndProgram



getMoney:
    push %eax #backs up register data to stack

    mov $start_message, %eax
    call PrintCString

    #Begin Quarters
    mov $m_quarters, %eax
    call PrintCString
    call ScanUInt
    mov %eax, d_quarters
    #End Quarters

    #Begin Dimes
    mov $m_dimes, %eax
    call PrintCString
    call ScanUInt
    mov %eax, d_dimes
    #End Dimes
    
    #Begin Nickels
    mov $m_nickels, %eax
    call PrintCString
    call ScanUInt
    mov %eax, d_nickels
    #End Nickels

    #Begin Pennies
    mov $m_pennies, %eax
    call PrintCString
    call ScanUInt
    mov %eax, d_pennies
    #End Pennies

    pop %eax #sets register to previous state before method call
    ret 


displayMoney:
    push %eax 

    mov $m_quarters, %eax
    call PrintCString
    mov d_quarters, %eax
    call PrintUInt

    mov $m_dimes, %eax
    call PrintCString
    mov d_dimes, %eax
    call PrintUInt

    mov $m_nickels, %eax
    call PrintCString
    mov d_nickels, %eax
    call PrintUInt

    mov $m_pennies, %eax
    call PrintCString
    mov d_pennies, %eax
    call PrintUInt

    call purseTotal

    pop %eax
    ret


purseTotal:
    puch %eax

    mov d_quarters, $eax
    mov $25, %edx
    mul %edx
    add %eax, d_total

    mov d_dimes, $eax
    mov $10, %edx
    mul %edx
    add %eax, d_total

    mov d_nickels, $eax
    mov $5, %edx
    mul %edx
    add %eax, d_total

    #Just add don't need to convert
    add d_pennies, d_total

    mov d_total, $eax
    call PrintUInt

    pop%eax
    ret

