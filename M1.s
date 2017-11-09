! 1 
! 1 # 1 "M1.c"
! 1 int kernelLength = 0;
.data
export	_kernelLength
_kernelLength:
.word	0
!BCC_EOS
! 2 int signalLength = 0;
export	_signalLength
_signalLength:
.word	0
!BCC_EOS
! 3 
! 4 int avgElement(midIndex,signal)
! 5 # 4 "M1.c"
! 4 int midIndex;
.text
export	_avgElement
_avgElement:
!BCC_EOS
! 5 # 4 "M1.c"
! 4 int *signal;
!BCC_EOS
! 5 {
! 6     int i;
!BCC_EOS
! 7     int sum = 0;
push	bp
mov	bp,sp
push	di
push	si
add	sp,*-4
! Debug: eq int = const 0 to int sum = [S+$A-$A] (used reg = )
xor	ax,ax
mov	-8[bp],ax
!BCC_EOS
! 8     int intersectionIndex = -1;
dec	sp
dec	sp
! Debug: eq int = const -1 to int intersectionIndex = [S+$C-$C] (used reg = )
mov	ax,*-1
mov	-$A[bp],ax
!BCC_EOS
! 9     if (midIndex < 0)
! Debug: lt int = const 0 to int midIndex = [S+$C+2] (used reg = )
mov	ax,4[bp]
test	ax,ax
jge 	.1
.2:
! 10     {
! 11         intersectionIndex = -1 * midIndex;
! Debug: mul int midIndex = [S+$C+2] to int = const -1 (used reg = )
! Debug: expression subtree swapping
mov	ax,4[bp]
mov	cx,*-1
imul	cx
! Debug: eq int = ax+0 to int intersectionIndex = [S+$C-$C] (used reg = )
mov	-$A[bp],ax
!BCC_EOS
! 12     }
! 13     else
! 14     {
jmp .3
.1:
! 15         intersectionIndex = 0;
! Debug: eq int = const 0 to int intersectionIndex = [S+$C-$C] (used reg = )
xor	ax,ax
mov	-$A[bp],ax
!BCC_EOS
! 16     }
! 17     i = intersectionIndex;
.3:
! Debug: eq int intersectionIndex = [S+$C-$C] to int i = [S+$C-8] (used reg = )
mov	ax,-$A[bp]
mov	-6[bp],ax
!BCC_EOS
! 18     while (i < signalLength && i < (kernelLength - midIndex))
! 19     {
jmp .5
.6:
! 20         sum += signal[i];
! Debug: ptradd int i = [S+$C-8] to * int signal = [S+$C+4] (used reg = )
mov	ax,-6[bp]
shl	ax,*1
add	ax,6[bp]
mov	bx,ax
! Debug: addab int = [bx+0] to int sum = [S+$C-$A] (used reg = )
mov	ax,-8[bp]
add	ax,[bx]
mov	-8[bp],ax
!BCC_EOS
! 21         i++;
! Debug: postinc int i = [S+$C-8] (used reg = )
mov	ax,-6[bp]
inc	ax
mov	-6[bp],ax
!BCC_EOS
! 22     }
! 23     return (sum / (i - intersectionIndex));
.5:
! Debug: lt int = [signalLength+0] to int i = [S+$C-8] (used reg = )
mov	ax,-6[bp]
cmp	ax,[_signalLength]
jge 	.7
.8:
! Debug: sub int midIndex = [S+$C+2] to int = [kernelLength+0] (used reg = )
mov	ax,[_kernelLength]
sub	ax,4[bp]
! Debug: lt int = ax+0 to int i = [S+$C-8] (used reg = )
cmp	ax,-6[bp]
jg 	.6
.7:
.4:
! Debug: sub int intersectionIndex = [S+$C-$C] to int i = [S+$C-8] (used reg = )
mov	ax,-6[bp]
sub	ax,-$A[bp]
! Debug: div int = ax+0 to int sum = [S+$C-$A] (used reg = )
mov	bx,ax
mov	ax,-8[bp]
cwd
idiv	bx
! Debug: cast int = const 0 to int = ax+0 (used reg = )
add	sp,*6
pop	si
pop	di
pop	bp
ret
!BCC_EOS
! 24 }
! 25 
! 26 int *avgSignal(signal,kernel)
! Register BX used in function avgElement
! 27 # 26 "M1.c"
! 26 int *signal;
export	_avgSignal
_avgSignal:
!BCC_EOS
! 27 # 26 "M1.c"
! 26 int *kernel;
!BCC_EOS
! 27 {
! 28     int midIndex = (kernelLength / 2) - 1;
push	bp
mov	bp,sp
push	di
push	si
dec	sp
dec	sp
! Debug: div int = const 2 to int = [kernelLength+0] (used reg = )
mov	ax,[_kernelLength]
sar	ax,*1
! Debug: sub int = const 1 to int = ax+0 (used reg = )
! Debug: eq int = ax-1 to int midIndex = [S+8-8] (used reg = )
dec	ax
mov	-6[bp],ax
!BCC_EOS
! 29     int *result = malloc(signalLength * sizeof(int));
dec	sp
dec	sp
! Debug: mul int = const 2 to int = [signalLength+0] (used reg = )
mov	ax,[_signalLength]
shl	ax,*1
! Debug: list int = ax+0 (used reg = )
push	ax
! Debug: func () int = malloc+0 (used reg = )
call	_malloc
inc	sp
inc	sp
! Debug: eq int = ax+0 to * int result = [S+$A-$A] (used reg = )
mov	-8[bp],ax
!BCC_EOS
! 30     int i = 0;
dec	sp
dec	sp
! Debug: eq int = const 0 to int i = [S+$C-$C] (used reg = )
xor	ax,ax
mov	-$A[bp],ax
!BCC_EOS
! 31     while (i < signalLength)
! 32     {
jmp .A
.B:
! 33         result[i] = avgElement(midIndex--,signal);
! Debug: list * int signal = [S+$C+2] (used reg = )
push	4[bp]
! Debug: postdec int midIndex = [S+$E-8] (used reg = )
mov	ax,-6[bp]
dec	ax
mov	-6[bp],ax
! Debug: list int = ax+1 (used reg = )
inc	ax
push	ax
! Debug: func () int = avgElement+0 (used reg = )
call	_avgElement
add	sp,*4
push	ax
! Debug: ptradd int i = [S+$E-$C] to * int result = [S+$E-$A] (used reg = )
mov	ax,-$A[bp]
shl	ax,*1
add	ax,-8[bp]
mov	bx,ax
! Debug: eq int (temp) = [S+$E-$E] to int = [bx+0] (used reg = )
mov	ax,-$C[bp]
mov	[bx],ax
inc	sp
inc	sp
!BCC_EOS
! 34         i++;
! Debug: postinc int i = [S+$C-$C] (used reg = )
mov	ax,-$A[bp]
inc	ax
mov	-$A[bp],ax
!BCC_EOS
! 35     }
! 36     return result;
.A:
! Debug: lt int = [signalLength+0] to int i = [S+$C-$C] (used reg = )
mov	ax,-$A[bp]
cmp	ax,[_signalLength]
jl 	.B
.C:
.9:
mov	ax,-8[bp]
add	sp,*6
pop	si
pop	di
pop	bp
ret
!BCC_EOS
! 37 }
! 38 
! 39 main()
! Register BX used in function avgSignal
! 40 {
export	_main
_main:
! 41     int *result;
!BCC_EOS
! 42     int kernel[10];
!BCC_EOS
! 43     int signal[7];
!BCC_EOS
! 44     int i = 0;
push	bp
mov	bp,sp
push	di
push	si
add	sp,*-$26
! Debug: eq int = const 0 to int i = [S+$2C-$2C] (used reg = )
xor	ax,ax
mov	-$2A[bp],ax
!BCC_EOS
! 45     signal[0] = 1;
! Debug: eq int = const 1 to int signal = [S+$2C-$2A] (used reg = )
mov	ax,*1
mov	-$28[bp],ax
!BCC_EOS
! 46     signal[1] = 2;
! Debug: eq int = const 2 to int signal = [S+$2C-$28] (used reg = )
mov	ax,*2
mov	-$26[bp],ax
!BCC_EOS
! 47     signal[2] = 3;
! Debug: eq int = const 3 to int signal = [S+$2C-$26] (used reg = )
mov	ax,*3
mov	-$24[bp],ax
!BCC_EOS
! 48     signal[3] = 4;
! Debug: eq int = const 4 to int signal = [S+$2C-$24] (used reg = )
mov	ax,*4
mov	-$22[bp],ax
!BCC_EOS
! 49     signal[4] = 5;
! Debug: eq int = const 5 to int signal = [S+$2C-$22] (used reg = )
mov	ax,*5
mov	-$20[bp],ax
!BCC_EOS
! 50     signal[5] = 6;
! Debug: eq int = const 6 to int signal = [S+$2C-$20] (used reg = )
mov	ax,*6
mov	-$1E[bp],ax
!BCC_EOS
! 51     signal[6] = 7;
! Debug: eq int = const 7 to int signal = [S+$2C-$1E] (used reg = )
mov	ax,*7
mov	-$1C[bp],ax
!BCC_EOS
! 52 
! 53     kernel[0] = 1;
! Debug: eq int = const 1 to int kernel = [S+$2C-$1C] (used reg = )
mov	ax,*1
mov	-$1A[bp],ax
!BCC_EOS
! 54     kernel[1] = 1;
! Debug: eq int = const 1 to int kernel = [S+$2C-$1A] (used reg = )
mov	ax,*1
mov	-$18[bp],ax
!BCC_EOS
! 55     kernel[2] = 1;
! Debug: eq int = const 1 to int kernel = [S+$2C-$18] (used reg = )
mov	ax,*1
mov	-$16[bp],ax
!BCC_EOS
! 56     kernel[3] = 1;
! Debug: eq int = const 1 to int kernel = [S+$2C-$16] (used reg = )
mov	ax,*1
mov	-$14[bp],ax
!BCC_EOS
! 57     kernel[4] = 1;
! Debug: eq int = const 1 to int kernel = [S+$2C-$14] (used reg = )
mov	ax,*1
mov	-$12[bp],ax
!BCC_EOS
! 58     kernel[5] = 1;
! Debug: eq int = const 1 to int kernel = [S+$2C-$12] (used reg = )
mov	ax,*1
mov	-$10[bp],ax
!BCC_EOS
! 59     kernel[6] = 1;
! Debug: eq int = const 1 to int kernel = [S+$2C-$10] (used reg = )
mov	ax,*1
mov	-$E[bp],ax
!BCC_EOS
! 60     kernel[7] = 1;
! Debug: eq int = const 1 to int kernel = [S+$2C-$E] (used reg = )
mov	ax,*1
mov	-$C[bp],ax
!BCC_EOS
! 61     kernel[8] = 1;
! Debug: eq int = const 1 to int kernel = [S+$2C-$C] (used reg = )
mov	ax,*1
mov	-$A[bp],ax
!BCC_EOS
! 62     kernel[9] = 1;
! Debug: eq int = const 1 to int kernel = [S+$2C-$A] (used reg = )
mov	ax,*1
mov	-8[bp],ax
!BCC_EOS
! 63 
! 64     kernelLength = sizeof(kernel) / sizeof(int);
! Debug: eq int = const $A to int = [kernelLength+0] (used reg = )
mov	ax,*$A
mov	[_kernelLength],ax
!BCC_EOS
! 65     signalLength = sizeof(signal) / sizeof(int);
! Debug: eq int = const 7 to int = [signalLength+0] (used reg = )
mov	ax,*7
mov	[_signalLength],ax
!BCC_EOS
! 66     result = avgSignal(signal,kernel);}
! Debug: list * int kernel = S+$2C-$1C (used reg = )
lea	bx,-$1A[bp]
push	bx
! Debug: list * int signal = S+$2E-$2A (used reg = )
lea	bx,-$28[bp]
push	bx
! Debug: func () * int = avgSignal+0 (used reg = )
call	_avgSignal
add	sp,*4
! Debug: eq * int = ax+0 to * int result = [S+$2C-8] (used reg = )
mov	-6[bp],ax
!BCC_EOS
add	sp,*$26
pop	si
pop	di
pop	bp
ret
! 67 
! Register BX used in function main
.data
.bss

! 0 errors detected
