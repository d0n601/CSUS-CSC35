# Author: Ryan Kozak
# Class: CSC 35
# Prof: Cook, Devin



.data

########################################## BEGIN MESSAGES FOR USER INPUT ##########################################
machine:
    .ascii "\n\n ------------------- Samurai Vending Co. -------------------\n\n\0"
start_message:
    .ascii "\nWelcome honorable one, put in some Yen...\n\n\0"
m_exit:
    .ascii "\nSamurai Vending shutting down...\n\n\0"

#You put in xxx Yen.
m1_input:
    .ascii "\nYou put in: \0"
m2_input:   
    .ascii " Yen.\n\0"

#You have xxx Yen in change
m_change1:
    .ascii "\n\nYou have \0"
m_change2:
    .ascii " Yen in change\n\n\0"

#Menu Items
sentinel:
    .ascii "0. Exit without purchase\n\0"
item_1:
    .ascii "1. Iron Shavings (25 Yen)\n\0"
item_2:
    .ascii "2. Ninja Snacks (250 Yen)\n\0"
item_3:
    .ascii "3. Ninja Ball (60 Yen)\n\0"
item_4:
    .ascii "4. Mask of Face (1000 Yen)\n\0"
item_5:
    .ascii "5. Cheap Sword (2500 Yen)\n\0"

#Input Prompt
m_input:
    .ascii "\nYour selection: \0"

# Monetery Input Messages
# Values referenced from https://en.wikipedia.org/wiki/Japanese_yen
m_hyaku:
    .ascii "Hyaku-en kōka (100 Yen): \0"
m_goju:
    .ascii "Gojū-en kōka (50 Yen): \0"
m_juen:
    .ascii "Jū-en kōk (10 Yen): \0"
m_goen:
    .ascii "Go-en kōka (5 Yen): \0"
m2_hyaku:
    .ascii " Hyaku-en kōka (100 Yen)\n\0"
m2_goju:
    .ascii " Gojū-en kōka (50 Yen)\n\0"
m2_juen:
    .ascii " Jū-en kōk (10 Yen)\n\0"
m2_goen:
    .ascii " Go-en kōka (5 Yen)\n\0"

#Error Messages
e_selection:
    .ascii "\n\nYour selection was not found on the menu, please check the coin return below to retrieve your Yen and try again.\0"
e_funds:
    .ascii "\n\nInsufficients funds, please check the coin return below to retrieve your Yen and try again.\n\0"

########################################## END MESSAGES FOR USER INPUT PROMPTS ##########################################


################################################## STORED VARIABLES#########################################################
#Input Selection
d_input:
    .long 0

#Monetry Stored Values
d_hyaku:
    .long 0
d_goju:
    .long 0
d_juen:
    .long 0
d_goen:
    .long 0
d_total:
    .long 0
t_total:
    .long 0

#Item Pricing
item1:
    .long 25
item2:
    .long 250
item3:
    .long 60
item4:
    .long 1000
item5:
    .long 2500
############################################## END STORED VARIABLES#########################################################


.text


.global _start

_start:
    call getMoney #Welcome, get coint input
    call vendingMachine #Begin Menu and Vending 
    


getMoney:
    push %eax #backs up register data to stack

    mov $start_message, %eax
    call PrintCString

    #Hyaku - Input Prompt
    mov $m_hyaku, %eax
    call PrintCString
    call ScanUInt
    mov %eax, d_hyaku

    #Goju - Input Prompt
    mov $m_goju, %eax
    call PrintCString
    call ScanUInt
    mov %eax, d_goju
    
    #Ju-en - Input Prompt
    mov $m_juen, %eax
    call PrintCString
    call ScanUInt
    mov %eax, d_juen

    #Go-en - Input Prompt
    mov $m_goen, %eax
    call PrintCString
    call ScanUInt
    mov %eax, d_goen

    #Hyaku - Add to Total
    mov d_hyaku, %eax
    mov $100, %edx
    mul %edx
    add %eax, d_total

    #Goju - Add to Total
    mov d_goju, %eax
    mov $50, %edx
    mul %edx
    add %eax, d_total

    #Ju-en - Add to Total
    mov d_juen, %eax
    mov $10, %edx
    mul %edx
    add %eax, d_total

    #Go-en - Add to Total
    mov d_goen, %eax
    mov $5, %edx
    mul %edx
    add %eax, d_total

    #Outputs to user their current total
    mov $m1_input, %eax
    call PrintCString
    mov d_total, %eax
    call PrintUInt
    mov $m2_input, %eax
    call PrintCString

    pop %eax #reset register via stack
    ret  #return to main 



vendingMachine:
    #Output Vending Machine Name
    mov $machine, %eax
    call PrintCString

    #Begin Output of Menu Items
    mov $sentinel, %eax
    call PrintCString
    mov $item_1, %eax
    call PrintCString
    mov $item_2, %eax
    call PrintCString
    mov $item_3, %eax
    call PrintCString
    mov $item_4, %eax
    call PrintCString
    mov $item_5, %eax
    call PrintCString
    #End Output of Menu Items

    #Prompt for menu item selection
    mov $m_input, %eax
    call PrintCString
    #Recieve and store item selection
    call ScanUInt
    mov %eax, d_input

    #Validate user's selection
    call selectionValidation

    # Determines which item user has selected
    cmp $1, d_input # ITEM 1
    je vend_1 
    cmp $2, d_input # ITEM 2
    je vend_2
    cmp $3, d_input # ITEM 3
    je vend_3
    cmp $4, d_input # ITEM 4
    je vend_4
    cmp $5, d_input # ITEM 5
    je vend_5




# The Following Routines for Items 1 through 5 validate user has input enough funds. 

vend_1: #ITEM NUMBER 1
    mov item1, %edx # get item price
    cmp %edx, d_total # price check
    jl invalidFunds  # jump on low funds error
    sub %edx, d_total # subtract from total
    call coinReturn
vend_2: #ITEM NUMBER 2
    mov item2, %edx # get item price
    cmp %edx, d_total # price check
    jl invalidFunds  # jump on low funds error 
    sub %edx, d_total # subtract from total
    call coinReturn
vend_3: #ITEM NUMBER 3
    mov item3, %edx # get item price
    cmp %edx, d_total # price check
    jl invalidFunds  # jump on low funds error
    sub %edx, d_total # subtract from total
    call coinReturn
vend_4: #ITEM NUMBER 4
    mov item4, %edx # get item price
    cmp %edx, d_total # price check
    jl invalidFunds  # jump on low funds error  
    sub %edx, d_total # subtract from total
    call coinReturn
vend_5: #ITEM NUMBER 5
    mov item5, %edx # get item price
    cmp %edx, d_total # price check
    jl invalidFunds  # jump on low funds error
    sub %edx, d_total # subtract from total
    call coinReturn





coinReturn:
# After a purchase is made, or when the sentinel is called, this returns the user's money. 
# It calculates the fewest possible 'coins' to return, for efficiency. 

    #Displays "You have d_total Yen in change"
    mov $m_change1, %eax
    call PrintCString
    mov d_total, %eax
    call PrintUInt
    mov $m_change2, %eax
    call PrintCString

    #Set temp total to current total
    mov d_total, %eax
    mov %eax, t_total

    #Begin Hyaku
    mov t_total, %eax # Move temporary total to register
    cdq # 32bits VIA eax & edx
    mov $100, %ebx # Move coin value to register.
    div %ebx # Divide working total by coin value
    mov %eax, d_hyaku # Move whole result (quotient) to coin count
    mov %edx, t_total # Set remainder to new working total
    # Print coin value
    mov d_hyaku, %eax
    call PrintUInt
    mov $m2_hyaku, %eax
    call PrintCString
    #End Hyaku

    #Begin Goju
    mov t_total, %eax # Move temporary total to register
    cdq # 32bits VIA eax & edx
    mov $50, %ebx # Move coin value to register.
    div %ebx # Divide working total by coin value
    mov %eax, d_goju # Move whole result (quotient) to coin count
    mov %edx, t_total # Set remainder to new working total
    # Print coin value
    mov d_goju, %eax
    call PrintUInt
    mov $m2_goju, %eax
    call PrintCString
    #End Goju

    #Begin Ju-en
    mov t_total, %eax # Move temporary total to register
    cdq # 32bits VIA eax & edx
    mov $10, %ebx # Move coin value to register.
    div %ebx # Divide working total by coin value
    mov %eax, d_juen # Move whole result (quotient) to coin count
    mov %edx, t_total # Set remainder to new working total
    # Print coin value
    mov d_juen, %eax
    call PrintUInt
    mov $m2_juen, %eax
    call PrintCString
    #End Ju-en

    #Begin Go-en
    mov t_total, %eax # Move temporary total to register
    cdq # 32bits VIA eax & edx
    mov $5, %ebx # Move coin value to register.
    div %ebx # Divide working total by coin value
    mov %eax, d_goen # Move whole result (quotient) to coin count
    mov %edx, t_total # Set remainder to new working total
    # Print coin value
    mov d_goen, %eax
    call PrintUInt
    mov $m2_goen, %eax
    call PrintCString
    #End Go-en

    call quitNow #Exit with message



selectionValidation:
#Validates user input for item selection
    push %eax #backup register to stack
    cmp $6, d_input #if selection is out of range
    jge invalidSelection #throw invalid selection message and end program
    cmp $0, d_input #if selection is sentinel
    jle coinReturn #give money back and exit
    pop %eax #resent register from stack
    ret

invalidSelection:  
#Error Handling for Invalid Item Selection
    mov $e_selection, %eax # Move Error Message to Register
    call PrintCString # Show Error Message
    call coinReturn
    call EndProgram # Quit

invalidFunds:
#Error handling for Insufficient Funds to Make Purchase
    mov $e_funds, %eax # Move Error Message to Register
    call PrintCString # Show Error Message
    call coinReturn 
    call EndProgram # Quit
    
quitNow:
#Sentinel Call 
    mov $m_exit, %eax # Move Exit Message to Register
    call PrintCString # Show Exist Message
    call EndProgram # Quit
