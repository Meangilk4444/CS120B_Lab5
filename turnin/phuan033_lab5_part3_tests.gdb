# Test file for "lab_chip"


# commands.gdb provides the following functions for ease:
#   test "<message>"
#       Where <message> is the message to print. Must call this at the beginning of every test
#       Example: test "PINA: 0x00 => expect PORTC: 0x01"
#   checkResult
#       Verify if the test passed or failed. Prints "passed." or "failed." accordingly, 
#       Must call this at the end of every test.
#   expectPORTx <val>
#       With x as the port (A,B,C,D)
#       The value the port is epected to have. If not it will print the erroneous actual value
#   setPINx <val>
#       With x as the port or pin (A,B,C,D)
#       The value to set the pin to (can be decimal or hexidecimal
#       Example: setPINA 0x01
#   printPORTx f OR printPINx f 
#       With x as the port or pin (A,B,C,D)
#       With f as a format option which can be: [d] decimal, [x] hexadecmial (default), [t] binary 
#       Example: printPORTC d
#   printDDRx
#       With x as the DDR (A,B,C,D)
#       Example: printDDRB

echo ======================================================\n
echo Running all tests..."\n\n

test "PINA: 0x00 => PORTB: 0x00"
set state = START
setPINA ~0x00
continue 2
expectPORTB 0x00
checkResult

test "PINA: 0x01 => PORTB: 0x21"
set state = START
setPINA ~0x01
continue 2
expectPORTB 0x21
checkResult

test "PINA: 0x01, 0x00, 0x01 = > PORTB: 0x12"
set state = START
setPINA ~0x01
continue 2
setPINA ~0x00
continue 2
setPINA ~0x01
continue 2
expectPORTB 0x12
checkResult

test "PINA: 0x01, 0x00, 0x01, 0x00 = > PORTB: 0x02"
set state = START
setPINA ~0x01
continue 2
setPINA ~0x00
continue 2
setPINA ~0x01
continue 2
setPINA ~0x00
continue 2
expectPORTB 0x12
checkResult

test "PINA: 0x01, 0x00, 0x01, 0x00, 0x01,0x00 => PORTB: 0x0C"
set state = START
setPINA ~0x01
continue 2
setPINA ~0x00
continue 2
setPINA ~0x01
continue 2
setPINA ~0x00
continue 2
setPINA ~0x01
continue 2
setPINA ~0x00
continue 2
expectPORTB 0x0C
checkResult

test "PINA: 0x01, 0x00, 0x01, 0x00, 0x01,0x00, 0x01 => PORTB: 0x0C"
set state = START
setPINA ~0x01
continue 2
setPINA ~0x00
continue 2
setPINA ~0x01
continue 2
setPINA ~0x00
continue 2
setPINA ~0x01
continue 2
setPINA ~0x00
continue 2
setPINA ~0x01
continue 2
expectPORTB 0x0C
checkResult

test "PINA: 0x01....one full round about => PORTB: 0x21"
set state = START
setPINA ~0x01
continue 2
setPINA ~0x00
continue 2
setPINA ~0x01
continue 2
setPINA ~0x00
continue 2
setPINA ~0x01
continue 2
setPINA ~0x00 #end of first cycle
continue 2
setPINA ~0x01 #0C
continue 2
setPINA ~0x00
continue 2
setPINA ~0x01 #12
continue 2
setPINA ~0x00
continue 2
setPINA ~0x01 #21
continue 2
setPINA ~0x00
continue 2
expectPORTB 0x21
checkResult

test "PINA: 0x01......(One full round about  + half round about) => PORTB: 0x0C"
set state = START
setPINA ~0x01
continue 2
setPINA ~0x00
continue 2
setPINA ~0x01
continue 2
setPINA ~0x00
continue 2
setPINA ~0x01
continue 2
setPINA ~0x00 #end of first cycle
continue 2
setPINA ~0x01 #0C
continue 2
setPINA ~0x00
continue 2
setPINA ~0x01 #12
continue 2
setPINA ~0x00
continue 2
setPINA ~0x01 #21
continue 2
setPINA ~0x00 #end of cycle 2
continue 2
setPINA ~0x01 #restarting cycle
continue 2
setPINA ~0x00
continue 2
setPINA ~0x01
continue 2
setPINA ~0x00
continue 2
setPINA ~0x01 #end of cycle
continue 2
expectPORTB 0x0C
checkResult

# Report on how many tests passed/tests ran
set $passed=$tests-$failed
eval "shell echo Passed %d/%d tests.\n",$passed,$tests
echo ======================================================\n
