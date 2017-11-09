.model small
.stack 100
.data
        kernel dw [1,1,1,1,1,1,1,1,1,1]
        signal dw [1,2,3,4,5,6,7]
        midIndex db 0
        i db 0
        _kernelLength db 10
        _signalLength db 7
.code
        MAIN PROC FAR
        _avgElement:
        push 	[bp]
        mov 	[sp],	[bp]
        push 	[di]
        push 	[si]
        add 	-4,	[sp]
        xor 	[ax],	[ax]
        mov 	[ax],	[-8[bp]]
        dec 	[sp]
        dec 	[sp]
        mov 	-1,	[ax]
        mov 	[ax],	[-10[bp]]
        mov 	[4[bp]],	[ax]
        test 	[ax],	[ax]
        jge 	l1

        l2:
        mov 	[4[bp]],	[ax]
        mov 	-1,	[cx]
        imu 	DWORD [cx]
        mov 	[ax],	[-10[bp]]
        jmp 	l3

        l1:
        xor 	[ax],	[ax]
        mov 	[ax],	[-10[bp]]

        l3:
        mov 	[-10[bp]],	[ax]
        mov 	[ax],	[-6[bp]]
        jmp 	l5

        l6:
        mov 	[-6[bp]],	[ax]
        sh 	1,	DWORD [ax]
        add 	[6[bp]],	[ax]
        mov 	[ax],	[bx]
        mov 	[-8[bp]],	[ax]
        add 	[[bx]],	[ax]
        mov 	[ax],	[-8[bp]]
        mov 	[-6[bp]],	[ax]
        inc 	[ax]
        mov 	[ax],	[-6[bp]]

        l5:
        mov 	[-6[bp]],	[ax]
        cmp 	[[_signalLength]],	[ax]
        jge 	l7

        l8:
        mov 	[[_kernelLength]],	[ax]
        su 	BYTE [4[bp]],	BYTE [ax]
        cmp 	[-6[bp]],	[ax]
        jg 	l6

        l7:
        mov 	[-6[bp]],	[ax]
        su 	BYTE [-10[bp]],	BYTE [ax]
        mov 	[ax],	[bx]
        mov 	[-8[bp]],	[ax]
        cwd
        idiv 	[bx]
        add 	6,	[sp]
        pop 	[si]
        pop 	[di]
        pop 	[bp]
        ret

        _main:
        push 	[bp]
        mov 	[sp],	[bp]
        push 	[di]
        push 	[si]
        add 	[-40],	[sp]
        mov 	[[_signalLength]],	[ax]
        sh 	1,	DWORD [ax]
        push 	[ax]
        call 	_malloc
        inc 	[sp]
        inc 	[sp]
        mov 	[ax],	[-6[bp]]
        jmp 	_A

        _B:
        lea 	[-40[bp]],	[bx]
        push 	[bx]
        mov 	[-44[bp]],	[ax]
        dec 	[ax]
        mov 	[ax],	[-44[bp]]
        inc 	[ax]
        push 	[ax]
        call 	_avgElement
        add 	4,	[sp]
        push 	[ax]
        mov 	[-42[bp]],	[ax]
        sh 	1,	DWORD [ax]
        add 	[-6[bp]],	[ax]
        mov 	[ax],	[bx]
        mov 	[-46[bp]],	[ax]
        mov 	[ax],	[[bx]]
        inc 	[sp]
        inc 	[sp]
        mov 	[-42[bp]],	[ax]
        inc 	[ax]
        mov 	[ax],	[-42[bp]]

        _A:
        mov 	[-42[bp]],	[ax]
        cmp 	[[_signalLength]],	[ax]
        jl 	_B

        add 	40,	[sp]
        pop 	[si]
        pop 	[di]
        pop 	[bp]
        ret
    MAIN ENDP
END MAIN