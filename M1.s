! 1 
! 1 # 1 "M1.c"
! 1 int kernelLength;
!BCC_EOS
! 2 int signalLength;
!BCC_EOS
! 3 
! 4 int avgElement(midIndex,signal)
! 5 # 4 "M1.c"
! 4 int midIndex;
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
! 26 
! 27 main()
! Register BX used in function avgElement
! 28 {
export	_main
_main:
! 29     int *result;
!BCC_EOS
! 30     int kernel[10];
!BCC_EOS
! 31     int signal[7];
!BCC_EOS
! 32     int i;
!BCC_EOS
! 33     int midIndex;
!BCC_EOS
! 34     
! 35     
! 36     
! 37     
! 38     
! 39     
! 40     
! 41     
! 42 
! 43     
! 44     
! 45     
! 46     
! 47     
! 48     
! 49     
! 50     
! 51     
! 52     
! 53     
! 54     
! 55     
! 56 
! 57     result = malloc(signalLength * sizeof(int));
push	bp
mov	bp,sp
push	di
push	si
add	sp,*-$28
! Debug: mul int = const 2 to int = [signalLength+0] (used reg = )
mov	ax,[_signalLength]
shl	ax,*1
! Debug: list int = ax+0 (used reg = )
push	ax
! Debug: func () int = malloc+0 (used reg = )
call	_malloc
inc	sp
inc	sp
! Debug: eq int = ax+0 to * int result = [S+$2E-8] (used reg = )
mov	-6[bp],ax
!BCC_EOS
! 58     while (i < signalLength)
! 59     {
jmp .A
.B:
! 60         result[i] = avgElement(midIndex--,signal);
! Debug: list * int signal = S+$2E-$2A (used reg = )
lea	bx,-$28[bp]
push	bx
! Debug: postdec int midIndex = [S+$30-$2E] (used reg = )
mov	ax,-$2C[bp]
dec	ax
mov	-$2C[bp],ax
! Debug: list int = ax+1 (used reg = )
inc	ax
push	ax
! Debug: func () int = avgElement+0 (used reg = )
call	_avgElement
add	sp,*4
push	ax
! Debug: ptradd int i = [S+$30-$2C] to * int result = [S+$30-8] (used reg = )
mov	ax,-$2A[bp]
shl	ax,*1
add	ax,-6[bp]
mov	bx,ax
! Debug: eq int (temp) = [S+$30-$30] to int = [bx+0] (used reg = )
mov	ax,-$2E[bp]
mov	[bx],ax
inc	sp
inc	sp
!BCC_EOS
! 61         i++;
! Debug: postinc int i = [S+$2E-$2C] (used reg = )
mov	ax,-$2A[bp]
inc	ax
mov	-$2A[bp],ax
!BCC_EOS
! 62     }
! 63 }
.A:
! Debug: lt int = [signalLength+0] to int i = [S+$2E-$2C] (used reg = )
mov	ax,-$2A[bp]
cmp	ax,[_signalLength]
jl 	.B
.C:
.9:
add	sp,*$28
pop	si
pop	di
pop	bp
ret
! 64 
! Register BX used in function main
.data
.bss
.comm	_kernelLength,2
.comm	_signalLength,2

! 0 errors detected
