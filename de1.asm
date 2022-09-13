#Bai 1 Done
#Với N là số 4-bit nhập từ SW[5:2], viết chương trình assembly cho hệ
#thống để tính r16 = 1 + 3 + 5 + … + (2*N + 1)
#Kết quả xuất ra RED_LED.
#Viết chương trình con để thực hiện việc tính tổng r16 = 1 + 3 + 5+ … + (2*N + 1).
/*  sum=0
for (int i=0;i<n;i++)
{
  if (i%2==1){
    s+=i;
    }   
}
*/
.text
.equ LEDS_BASE, 0xFF200000
.equ SW_BASE  , 0xFF200040
.equ SDRAM_END, 0x03FFFFFF
.global _start
_start:
     movia r2,LEDS_BASE
     movia r3,SW_BASE
     movia sp,SDRAM_END-3
     movia r10,N  
START:
     movi r1,0x1
     ldwio r5,0(r3)
     addi r5,r5,0b111100  #And Switch 5:2
     srli r5,r5,0x2 #dich sang trai 2 bit
     add r5,r5,0x1
     call SUM
     ldw r16,0(r10)
     stwio r16,0(r2)
     br START
SUM: 
     subi sp,sp,0x8
     stw  r16, 0(sp)
     stw  r1,  4(sp)
     movi r16, 0x0
LOOP: 
    bgt r1,r5,END_FUNC
    add r16,r16,r1
    addi r1,r1,0x2
    br  LOOP
END_FUNC: 
    stw r16,0(r10)
    ldw r16,0(sp)
    ldw r1,4(sp)
    addi sp,sp,0x8
    ret
.data
N: .word 0
.end 

     
