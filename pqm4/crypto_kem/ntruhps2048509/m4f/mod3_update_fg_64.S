// void __update_fg_64x64 (int *f, int*g, int *M1);
.p2align 2,,3
.syntax unified
.text
.global __update_fg_64x64
.type __update_fg_64x64, %function
__update_fg_64x64:
	push.w {r3-r12,lr}
	ldr r11, =0x03030303
	vmov.w s0, s1, r0, r1
	vmov.w s2, r2
	sub.w sp, #276
	mov.w r0, sp
	movw.w lr, #0
	str.w lr, [r0], #1
	vmov.w r1, s2
	vmov.w r2, s0
	bl __polymul_64x64_jump_head
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #64
	bl __polymul_64x64_jump_head
	vmov.w r1, s2
	vmov.w r2, s0
	add.w r1, #128
	sub.w r0, #1
	bl __polymul_64x64_jump_head
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #192
	bl __polymul_64x64_jump_head
	mov.w r10, sp
	vmov.w r0, r1, s0, s1
	add.w r10, #4
	add.w lr, r0, #64
add_loop_64:
	ldr.w r2, [r10, #136]
	ldr.w r3, [r10, #140]
	ldr.w r4, [r10, #144]
	ldr.w r5, [r10, #148]
	ldr.w r6, [r10, #204]
	ldr.w r7, [r10, #208]
	ldr.w r8, [r10, #212]
	ldr.w r9, [r10, #216]
	add.w r2, r6
	add.w r3, r7
	add.w r4, r8
	add.w r5, r9
	and.w r12, r2, #0xF0F0F0F0 // top 4b < 16
	and.w r2, r2, #0x0F0F0F0F // bot 4b < 16
	add.w r2, r2, r12, LSR #4 // range < 31
	bic.w r12, r2, r11 // top 3b < 8
	and.w r2, r2, r11 // bot 2b < 4
	add.w r2, r2, r12, LSR #2 // range <=10
	bic.w r12, r2, r11 // top 3b < 3
	and.w r2, r2, r11 // bot 2b < 4
	add.w r2, r2, r12, LSR #2 // range <=5
	usub8.w r12, r2, r11 // >= 3 ?
	sel.w r2, r12, r2 // select
	and.w r12, r3, #0xF0F0F0F0 // top 4b < 16
	and.w r3, r3, #0x0F0F0F0F // bot 4b < 16
	add.w r3, r3, r12, LSR #4 // range < 31
	bic.w r12, r3, r11 // top 3b < 8
	and.w r3, r3, r11 // bot 2b < 4
	add.w r3, r3, r12, LSR #2 // range <=10
	bic.w r12, r3, r11 // top 3b < 3
	and.w r3, r3, r11 // bot 2b < 4
	add.w r3, r3, r12, LSR #2 // range <=5
	usub8.w r12, r3, r11 // >= 3 ?
	sel.w r3, r12, r3 // select
	and.w r12, r4, #0xF0F0F0F0 // top 4b < 16
	and.w r4, r4, #0x0F0F0F0F // bot 4b < 16
	add.w r4, r4, r12, LSR #4 // range < 31
	bic.w r12, r4, r11 // top 3b < 8
	and.w r4, r4, r11 // bot 2b < 4
	add.w r4, r4, r12, LSR #2 // range <=10
	bic.w r12, r4, r11 // top 3b < 3
	and.w r4, r4, r11 // bot 2b < 4
	add.w r4, r4, r12, LSR #2 // range <=5
	usub8.w r12, r4, r11 // >= 3 ?
	sel.w r4, r12, r4 // select
	and.w r12, r5, #0xF0F0F0F0 // top 4b < 16
	and.w r5, r5, #0x0F0F0F0F // bot 4b < 16
	add.w r5, r5, r12, LSR #4 // range < 31
	bic.w r12, r5, r11 // top 3b < 8
	and.w r5, r5, r11 // bot 2b < 4
	add.w r5, r5, r12, LSR #2 // range <=10
	bic.w r12, r5, r11 // top 3b < 3
	and.w r5, r5, r11 // bot 2b < 4
	add.w r5, r5, r12, LSR #2 // range <=5
	usub8.w r12, r5, r11 // >= 3 ?
	sel.w r5, r12, r5 // select
	str.w r3, [r1, #4]
	str.w r4, [r1, #8]
	str.w r5, [r1, #12]
	str.w r2, [r1], #16
	ldr.w r6, [r10, #68]
	ldr.w r7, [r10, #72]
	ldr.w r8, [r10, #76]
	ldr.w r9, [r10, #80]
	ldr.w r3, [r10, #4]
	ldr.w r4, [r10, #8]
	ldr.w r5, [r10, #12]
	ldr.w r2, [r10], #16
	add.w r2, r6
	add.w r3, r7
	add.w r4, r8
	add.w r5, r9
	and.w r12, r2, #0xF0F0F0F0 // top 4b < 16
	and.w r2, r2, #0x0F0F0F0F // bot 4b < 16
	add.w r2, r2, r12, LSR #4 // range < 31
	bic.w r12, r2, r11 // top 3b < 8
	and.w r2, r2, r11 // bot 2b < 4
	add.w r2, r2, r12, LSR #2 // range <=10
	bic.w r12, r2, r11 // top 3b < 3
	and.w r2, r2, r11 // bot 2b < 4
	add.w r2, r2, r12, LSR #2 // range <=5
	usub8.w r12, r2, r11 // >= 3 ?
	sel.w r2, r12, r2 // select
	and.w r12, r3, #0xF0F0F0F0 // top 4b < 16
	and.w r3, r3, #0x0F0F0F0F // bot 4b < 16
	add.w r3, r3, r12, LSR #4 // range < 31
	bic.w r12, r3, r11 // top 3b < 8
	and.w r3, r3, r11 // bot 2b < 4
	add.w r3, r3, r12, LSR #2 // range <=10
	bic.w r12, r3, r11 // top 3b < 3
	and.w r3, r3, r11 // bot 2b < 4
	add.w r3, r3, r12, LSR #2 // range <=5
	usub8.w r12, r3, r11 // >= 3 ?
	sel.w r3, r12, r3 // select
	and.w r12, r4, #0xF0F0F0F0 // top 4b < 16
	and.w r4, r4, #0x0F0F0F0F // bot 4b < 16
	add.w r4, r4, r12, LSR #4 // range < 31
	bic.w r12, r4, r11 // top 3b < 8
	and.w r4, r4, r11 // bot 2b < 4
	add.w r4, r4, r12, LSR #2 // range <=10
	bic.w r12, r4, r11 // top 3b < 3
	and.w r4, r4, r11 // bot 2b < 4
	add.w r4, r4, r12, LSR #2 // range <=5
	usub8.w r12, r4, r11 // >= 3 ?
	sel.w r4, r12, r4 // select
	and.w r12, r5, #0xF0F0F0F0 // top 4b < 16
	and.w r5, r5, #0x0F0F0F0F // bot 4b < 16
	add.w r5, r5, r12, LSR #4 // range < 31
	bic.w r12, r5, r11 // top 3b < 8
	and.w r5, r5, r11 // bot 2b < 4
	add.w r5, r5, r12, LSR #2 // range <=10
	bic.w r12, r5, r11 // top 3b < 3
	and.w r5, r5, r11 // bot 2b < 4
	add.w r5, r5, r12, LSR #2 // range <=5
	usub8.w r12, r5, r11 // >= 3 ?
	sel.w r5, r12, r5 // select
	str.w r3, [r0, #4]
	str.w r4, [r0, #8]
	str.w r5, [r0, #12]
	str.w r2, [r0], #16
	cmp.w r0, lr
	bne.w add_loop_64
	add.w sp, #276
	pop.w {r3-r12,pc}
// void __update_fg_64x128 (int *f, int*g, int *M1);
.p2align 2,,3
.syntax unified
.text
.global __update_fg_64x128
.type __update_fg_64x128, %function
__update_fg_64x128:
	push.w {r3-r12,lr}
	ldr r11, =0x03030303
	vmov.w s0, s1, r0, r1
	vmov.w s2, r2
	sub.w sp, #532
	mov.w r0, sp
	movw.w lr, #0
	str.w lr, [r0], #1
	vmov.w r1, s2
	vmov.w r2, s0
	bl __polymul_64x128_jump_head
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #64
	bl __polymul_64x128_jump_head
	vmov.w r1, s2
	vmov.w r2, s0
	add.w r1, #128
	sub.w r0, #1
	bl __polymul_64x128_jump_head
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #192
	bl __polymul_64x128_jump_head
	mov.w r10, sp
	vmov.w r0, r1, s0, s1
	add.w r10, #4
	add.w lr, r0, #128
add_loop_128:
	ldr.w r2, [r10, #264]
	ldr.w r3, [r10, #268]
	ldr.w r4, [r10, #272]
	ldr.w r5, [r10, #276]
	ldr.w r6, [r10, #396]
	ldr.w r7, [r10, #400]
	ldr.w r8, [r10, #404]
	ldr.w r9, [r10, #408]
	add.w r2, r6
	add.w r3, r7
	add.w r4, r8
	add.w r5, r9
	and.w r12, r2, #0xF0F0F0F0 // top 4b < 16
	and.w r2, r2, #0x0F0F0F0F // bot 4b < 16
	add.w r2, r2, r12, LSR #4 // range < 31
	bic.w r12, r2, r11 // top 3b < 8
	and.w r2, r2, r11 // bot 2b < 4
	add.w r2, r2, r12, LSR #2 // range <=10
	bic.w r12, r2, r11 // top 3b < 3
	and.w r2, r2, r11 // bot 2b < 4
	add.w r2, r2, r12, LSR #2 // range <=5
	usub8.w r12, r2, r11 // >= 3 ?
	sel.w r2, r12, r2 // select
	and.w r12, r3, #0xF0F0F0F0 // top 4b < 16
	and.w r3, r3, #0x0F0F0F0F // bot 4b < 16
	add.w r3, r3, r12, LSR #4 // range < 31
	bic.w r12, r3, r11 // top 3b < 8
	and.w r3, r3, r11 // bot 2b < 4
	add.w r3, r3, r12, LSR #2 // range <=10
	bic.w r12, r3, r11 // top 3b < 3
	and.w r3, r3, r11 // bot 2b < 4
	add.w r3, r3, r12, LSR #2 // range <=5
	usub8.w r12, r3, r11 // >= 3 ?
	sel.w r3, r12, r3 // select
	and.w r12, r4, #0xF0F0F0F0 // top 4b < 16
	and.w r4, r4, #0x0F0F0F0F // bot 4b < 16
	add.w r4, r4, r12, LSR #4 // range < 31
	bic.w r12, r4, r11 // top 3b < 8
	and.w r4, r4, r11 // bot 2b < 4
	add.w r4, r4, r12, LSR #2 // range <=10
	bic.w r12, r4, r11 // top 3b < 3
	and.w r4, r4, r11 // bot 2b < 4
	add.w r4, r4, r12, LSR #2 // range <=5
	usub8.w r12, r4, r11 // >= 3 ?
	sel.w r4, r12, r4 // select
	and.w r12, r5, #0xF0F0F0F0 // top 4b < 16
	and.w r5, r5, #0x0F0F0F0F // bot 4b < 16
	add.w r5, r5, r12, LSR #4 // range < 31
	bic.w r12, r5, r11 // top 3b < 8
	and.w r5, r5, r11 // bot 2b < 4
	add.w r5, r5, r12, LSR #2 // range <=10
	bic.w r12, r5, r11 // top 3b < 3
	and.w r5, r5, r11 // bot 2b < 4
	add.w r5, r5, r12, LSR #2 // range <=5
	usub8.w r12, r5, r11 // >= 3 ?
	sel.w r5, r12, r5 // select
	str.w r3, [r1, #4]
	str.w r4, [r1, #8]
	str.w r5, [r1, #12]
	str.w r2, [r1], #16
	ldr.w r6, [r10, #132]
	ldr.w r7, [r10, #136]
	ldr.w r8, [r10, #140]
	ldr.w r9, [r10, #144]
	ldr.w r3, [r10, #4]
	ldr.w r4, [r10, #8]
	ldr.w r5, [r10, #12]
	ldr.w r2, [r10], #16
	add.w r2, r6
	add.w r3, r7
	add.w r4, r8
	add.w r5, r9
	and.w r12, r2, #0xF0F0F0F0 // top 4b < 16
	and.w r2, r2, #0x0F0F0F0F // bot 4b < 16
	add.w r2, r2, r12, LSR #4 // range < 31
	bic.w r12, r2, r11 // top 3b < 8
	and.w r2, r2, r11 // bot 2b < 4
	add.w r2, r2, r12, LSR #2 // range <=10
	bic.w r12, r2, r11 // top 3b < 3
	and.w r2, r2, r11 // bot 2b < 4
	add.w r2, r2, r12, LSR #2 // range <=5
	usub8.w r12, r2, r11 // >= 3 ?
	sel.w r2, r12, r2 // select
	and.w r12, r3, #0xF0F0F0F0 // top 4b < 16
	and.w r3, r3, #0x0F0F0F0F // bot 4b < 16
	add.w r3, r3, r12, LSR #4 // range < 31
	bic.w r12, r3, r11 // top 3b < 8
	and.w r3, r3, r11 // bot 2b < 4
	add.w r3, r3, r12, LSR #2 // range <=10
	bic.w r12, r3, r11 // top 3b < 3
	and.w r3, r3, r11 // bot 2b < 4
	add.w r3, r3, r12, LSR #2 // range <=5
	usub8.w r12, r3, r11 // >= 3 ?
	sel.w r3, r12, r3 // select
	and.w r12, r4, #0xF0F0F0F0 // top 4b < 16
	and.w r4, r4, #0x0F0F0F0F // bot 4b < 16
	add.w r4, r4, r12, LSR #4 // range < 31
	bic.w r12, r4, r11 // top 3b < 8
	and.w r4, r4, r11 // bot 2b < 4
	add.w r4, r4, r12, LSR #2 // range <=10
	bic.w r12, r4, r11 // top 3b < 3
	and.w r4, r4, r11 // bot 2b < 4
	add.w r4, r4, r12, LSR #2 // range <=5
	usub8.w r12, r4, r11 // >= 3 ?
	sel.w r4, r12, r4 // select
	and.w r12, r5, #0xF0F0F0F0 // top 4b < 16
	and.w r5, r5, #0x0F0F0F0F // bot 4b < 16
	add.w r5, r5, r12, LSR #4 // range < 31
	bic.w r12, r5, r11 // top 3b < 8
	and.w r5, r5, r11 // bot 2b < 4
	add.w r5, r5, r12, LSR #2 // range <=10
	bic.w r12, r5, r11 // top 3b < 3
	and.w r5, r5, r11 // bot 2b < 4
	add.w r5, r5, r12, LSR #2 // range <=5
	usub8.w r12, r5, r11 // >= 3 ?
	sel.w r5, r12, r5 // select
	str.w r3, [r0, #4]
	str.w r4, [r0, #8]
	str.w r5, [r0, #12]
	str.w r2, [r0], #16
	cmp.w r0, lr
	bne.w add_loop_128
	add.w sp, #532
	pop.w {r3-r12,pc}
// void __update_fg_64x192 (int *f, int*g, int *M1);
.p2align 2,,3
.syntax unified
.text
.global __update_fg_64x192
.type __update_fg_64x192, %function
__update_fg_64x192:
	push.w {r3-r12,lr}
	ldr r11, =0x03030303
	vmov.w s0, s1, r0, r1
	vmov.w s2, r2
	sub.w sp, #788
	mov.w r0, sp
	movw.w lr, #0
	str.w lr, [r0], #1
	vmov.w r1, s2
	vmov.w r2, s0
	bl __polymul_64x192_jump_head
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #64
	bl __polymul_64x192_jump_head
	vmov.w r1, s2
	vmov.w r2, s0
	add.w r1, #128
	sub.w r0, #1
	bl __polymul_64x192_jump_head
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #192
	bl __polymul_64x192_jump_head
	mov.w r10, sp
	vmov.w r0, r1, s0, s1
	add.w r10, #4
	add.w lr, r0, #192
add_loop_192:
	ldr.w r2, [r10, #392]
	ldr.w r3, [r10, #396]
	ldr.w r4, [r10, #400]
	ldr.w r5, [r10, #404]
	ldr.w r6, [r10, #588]
	ldr.w r7, [r10, #592]
	ldr.w r8, [r10, #596]
	ldr.w r9, [r10, #600]
	add.w r2, r6
	add.w r3, r7
	add.w r4, r8
	add.w r5, r9
	and.w r12, r2, #0xF0F0F0F0 // top 4b < 16
	and.w r2, r2, #0x0F0F0F0F // bot 4b < 16
	add.w r2, r2, r12, LSR #4 // range < 31
	bic.w r12, r2, r11 // top 3b < 8
	and.w r2, r2, r11 // bot 2b < 4
	add.w r2, r2, r12, LSR #2 // range <=10
	bic.w r12, r2, r11 // top 3b < 3
	and.w r2, r2, r11 // bot 2b < 4
	add.w r2, r2, r12, LSR #2 // range <=5
	usub8.w r12, r2, r11 // >= 3 ?
	sel.w r2, r12, r2 // select
	and.w r12, r3, #0xF0F0F0F0 // top 4b < 16
	and.w r3, r3, #0x0F0F0F0F // bot 4b < 16
	add.w r3, r3, r12, LSR #4 // range < 31
	bic.w r12, r3, r11 // top 3b < 8
	and.w r3, r3, r11 // bot 2b < 4
	add.w r3, r3, r12, LSR #2 // range <=10
	bic.w r12, r3, r11 // top 3b < 3
	and.w r3, r3, r11 // bot 2b < 4
	add.w r3, r3, r12, LSR #2 // range <=5
	usub8.w r12, r3, r11 // >= 3 ?
	sel.w r3, r12, r3 // select
	and.w r12, r4, #0xF0F0F0F0 // top 4b < 16
	and.w r4, r4, #0x0F0F0F0F // bot 4b < 16
	add.w r4, r4, r12, LSR #4 // range < 31
	bic.w r12, r4, r11 // top 3b < 8
	and.w r4, r4, r11 // bot 2b < 4
	add.w r4, r4, r12, LSR #2 // range <=10
	bic.w r12, r4, r11 // top 3b < 3
	and.w r4, r4, r11 // bot 2b < 4
	add.w r4, r4, r12, LSR #2 // range <=5
	usub8.w r12, r4, r11 // >= 3 ?
	sel.w r4, r12, r4 // select
	and.w r12, r5, #0xF0F0F0F0 // top 4b < 16
	and.w r5, r5, #0x0F0F0F0F // bot 4b < 16
	add.w r5, r5, r12, LSR #4 // range < 31
	bic.w r12, r5, r11 // top 3b < 8
	and.w r5, r5, r11 // bot 2b < 4
	add.w r5, r5, r12, LSR #2 // range <=10
	bic.w r12, r5, r11 // top 3b < 3
	and.w r5, r5, r11 // bot 2b < 4
	add.w r5, r5, r12, LSR #2 // range <=5
	usub8.w r12, r5, r11 // >= 3 ?
	sel.w r5, r12, r5 // select
	str.w r3, [r1, #4]
	str.w r4, [r1, #8]
	str.w r5, [r1, #12]
	str.w r2, [r1], #16
	ldr.w r6, [r10, #196]
	ldr.w r7, [r10, #200]
	ldr.w r8, [r10, #204]
	ldr.w r9, [r10, #208]
	ldr.w r3, [r10, #4]
	ldr.w r4, [r10, #8]
	ldr.w r5, [r10, #12]
	ldr.w r2, [r10], #16
	add.w r2, r6
	add.w r3, r7
	add.w r4, r8
	add.w r5, r9
	and.w r12, r2, #0xF0F0F0F0 // top 4b < 16
	and.w r2, r2, #0x0F0F0F0F // bot 4b < 16
	add.w r2, r2, r12, LSR #4 // range < 31
	bic.w r12, r2, r11 // top 3b < 8
	and.w r2, r2, r11 // bot 2b < 4
	add.w r2, r2, r12, LSR #2 // range <=10
	bic.w r12, r2, r11 // top 3b < 3
	and.w r2, r2, r11 // bot 2b < 4
	add.w r2, r2, r12, LSR #2 // range <=5
	usub8.w r12, r2, r11 // >= 3 ?
	sel.w r2, r12, r2 // select
	and.w r12, r3, #0xF0F0F0F0 // top 4b < 16
	and.w r3, r3, #0x0F0F0F0F // bot 4b < 16
	add.w r3, r3, r12, LSR #4 // range < 31
	bic.w r12, r3, r11 // top 3b < 8
	and.w r3, r3, r11 // bot 2b < 4
	add.w r3, r3, r12, LSR #2 // range <=10
	bic.w r12, r3, r11 // top 3b < 3
	and.w r3, r3, r11 // bot 2b < 4
	add.w r3, r3, r12, LSR #2 // range <=5
	usub8.w r12, r3, r11 // >= 3 ?
	sel.w r3, r12, r3 // select
	and.w r12, r4, #0xF0F0F0F0 // top 4b < 16
	and.w r4, r4, #0x0F0F0F0F // bot 4b < 16
	add.w r4, r4, r12, LSR #4 // range < 31
	bic.w r12, r4, r11 // top 3b < 8
	and.w r4, r4, r11 // bot 2b < 4
	add.w r4, r4, r12, LSR #2 // range <=10
	bic.w r12, r4, r11 // top 3b < 3
	and.w r4, r4, r11 // bot 2b < 4
	add.w r4, r4, r12, LSR #2 // range <=5
	usub8.w r12, r4, r11 // >= 3 ?
	sel.w r4, r12, r4 // select
	and.w r12, r5, #0xF0F0F0F0 // top 4b < 16
	and.w r5, r5, #0x0F0F0F0F // bot 4b < 16
	add.w r5, r5, r12, LSR #4 // range < 31
	bic.w r12, r5, r11 // top 3b < 8
	and.w r5, r5, r11 // bot 2b < 4
	add.w r5, r5, r12, LSR #2 // range <=10
	bic.w r12, r5, r11 // top 3b < 3
	and.w r5, r5, r11 // bot 2b < 4
	add.w r5, r5, r12, LSR #2 // range <=5
	usub8.w r12, r5, r11 // >= 3 ?
	sel.w r5, r12, r5 // select
	str.w r3, [r0, #4]
	str.w r4, [r0, #8]
	str.w r5, [r0, #12]
	str.w r2, [r0], #16
	cmp.w r0, lr
	bne.w add_loop_192
	add.w sp, #788
	pop.w {r3-r12,pc}
// void __update_fg_64x256 (int *f, int*g, int *M1);
.p2align 2,,3
.syntax unified
.text
.global __update_fg_64x256
.type __update_fg_64x256, %function
__update_fg_64x256:
	push.w {r3-r12,lr}
	ldr r11, =0x03030303
	vmov.w s0, s1, r0, r1
	vmov.w s2, r2
	sub.w sp, #1044
	mov.w r0, sp
	movw.w lr, #0
	str.w lr, [r0], #1
	vmov.w r1, s2
	vmov.w r2, s0
	bl __polymul_64x256_jump_head
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #64
	bl __polymul_64x256_jump_head
	vmov.w r1, s2
	vmov.w r2, s0
	add.w r1, #128
	sub.w r0, #1
	bl __polymul_64x256_jump_head
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #192
	bl __polymul_64x256_jump_head
	mov.w r10, sp
	vmov.w r0, r1, s0, s1
	add.w r10, #4
	add.w lr, r0, #256
add_loop_256:
	ldr.w r2, [r10, #520]
	ldr.w r3, [r10, #524]
	ldr.w r4, [r10, #528]
	ldr.w r5, [r10, #532]
	ldr.w r6, [r10, #780]
	ldr.w r7, [r10, #784]
	ldr.w r8, [r10, #788]
	ldr.w r9, [r10, #792]
	add.w r2, r6
	add.w r3, r7
	add.w r4, r8
	add.w r5, r9
	and.w r12, r2, #0xF0F0F0F0 // top 4b < 16
	and.w r2, r2, #0x0F0F0F0F // bot 4b < 16
	add.w r2, r2, r12, LSR #4 // range < 31
	bic.w r12, r2, r11 // top 3b < 8
	and.w r2, r2, r11 // bot 2b < 4
	add.w r2, r2, r12, LSR #2 // range <=10
	bic.w r12, r2, r11 // top 3b < 3
	and.w r2, r2, r11 // bot 2b < 4
	add.w r2, r2, r12, LSR #2 // range <=5
	usub8.w r12, r2, r11 // >= 3 ?
	sel.w r2, r12, r2 // select
	and.w r12, r3, #0xF0F0F0F0 // top 4b < 16
	and.w r3, r3, #0x0F0F0F0F // bot 4b < 16
	add.w r3, r3, r12, LSR #4 // range < 31
	bic.w r12, r3, r11 // top 3b < 8
	and.w r3, r3, r11 // bot 2b < 4
	add.w r3, r3, r12, LSR #2 // range <=10
	bic.w r12, r3, r11 // top 3b < 3
	and.w r3, r3, r11 // bot 2b < 4
	add.w r3, r3, r12, LSR #2 // range <=5
	usub8.w r12, r3, r11 // >= 3 ?
	sel.w r3, r12, r3 // select
	and.w r12, r4, #0xF0F0F0F0 // top 4b < 16
	and.w r4, r4, #0x0F0F0F0F // bot 4b < 16
	add.w r4, r4, r12, LSR #4 // range < 31
	bic.w r12, r4, r11 // top 3b < 8
	and.w r4, r4, r11 // bot 2b < 4
	add.w r4, r4, r12, LSR #2 // range <=10
	bic.w r12, r4, r11 // top 3b < 3
	and.w r4, r4, r11 // bot 2b < 4
	add.w r4, r4, r12, LSR #2 // range <=5
	usub8.w r12, r4, r11 // >= 3 ?
	sel.w r4, r12, r4 // select
	and.w r12, r5, #0xF0F0F0F0 // top 4b < 16
	and.w r5, r5, #0x0F0F0F0F // bot 4b < 16
	add.w r5, r5, r12, LSR #4 // range < 31
	bic.w r12, r5, r11 // top 3b < 8
	and.w r5, r5, r11 // bot 2b < 4
	add.w r5, r5, r12, LSR #2 // range <=10
	bic.w r12, r5, r11 // top 3b < 3
	and.w r5, r5, r11 // bot 2b < 4
	add.w r5, r5, r12, LSR #2 // range <=5
	usub8.w r12, r5, r11 // >= 3 ?
	sel.w r5, r12, r5 // select
	str.w r3, [r1, #4]
	str.w r4, [r1, #8]
	str.w r5, [r1, #12]
	str.w r2, [r1], #16
	ldr.w r6, [r10, #260]
	ldr.w r7, [r10, #264]
	ldr.w r8, [r10, #268]
	ldr.w r9, [r10, #272]
	ldr.w r3, [r10, #4]
	ldr.w r4, [r10, #8]
	ldr.w r5, [r10, #12]
	ldr.w r2, [r10], #16
	add.w r2, r6
	add.w r3, r7
	add.w r4, r8
	add.w r5, r9
	and.w r12, r2, #0xF0F0F0F0 // top 4b < 16
	and.w r2, r2, #0x0F0F0F0F // bot 4b < 16
	add.w r2, r2, r12, LSR #4 // range < 31
	bic.w r12, r2, r11 // top 3b < 8
	and.w r2, r2, r11 // bot 2b < 4
	add.w r2, r2, r12, LSR #2 // range <=10
	bic.w r12, r2, r11 // top 3b < 3
	and.w r2, r2, r11 // bot 2b < 4
	add.w r2, r2, r12, LSR #2 // range <=5
	usub8.w r12, r2, r11 // >= 3 ?
	sel.w r2, r12, r2 // select
	and.w r12, r3, #0xF0F0F0F0 // top 4b < 16
	and.w r3, r3, #0x0F0F0F0F // bot 4b < 16
	add.w r3, r3, r12, LSR #4 // range < 31
	bic.w r12, r3, r11 // top 3b < 8
	and.w r3, r3, r11 // bot 2b < 4
	add.w r3, r3, r12, LSR #2 // range <=10
	bic.w r12, r3, r11 // top 3b < 3
	and.w r3, r3, r11 // bot 2b < 4
	add.w r3, r3, r12, LSR #2 // range <=5
	usub8.w r12, r3, r11 // >= 3 ?
	sel.w r3, r12, r3 // select
	and.w r12, r4, #0xF0F0F0F0 // top 4b < 16
	and.w r4, r4, #0x0F0F0F0F // bot 4b < 16
	add.w r4, r4, r12, LSR #4 // range < 31
	bic.w r12, r4, r11 // top 3b < 8
	and.w r4, r4, r11 // bot 2b < 4
	add.w r4, r4, r12, LSR #2 // range <=10
	bic.w r12, r4, r11 // top 3b < 3
	and.w r4, r4, r11 // bot 2b < 4
	add.w r4, r4, r12, LSR #2 // range <=5
	usub8.w r12, r4, r11 // >= 3 ?
	sel.w r4, r12, r4 // select
	and.w r12, r5, #0xF0F0F0F0 // top 4b < 16
	and.w r5, r5, #0x0F0F0F0F // bot 4b < 16
	add.w r5, r5, r12, LSR #4 // range < 31
	bic.w r12, r5, r11 // top 3b < 8
	and.w r5, r5, r11 // bot 2b < 4
	add.w r5, r5, r12, LSR #2 // range <=10
	bic.w r12, r5, r11 // top 3b < 3
	and.w r5, r5, r11 // bot 2b < 4
	add.w r5, r5, r12, LSR #2 // range <=5
	usub8.w r12, r5, r11 // >= 3 ?
	sel.w r5, r12, r5 // select
	str.w r3, [r0, #4]
	str.w r4, [r0, #8]
	str.w r5, [r0, #12]
	str.w r2, [r0], #16
	cmp.w r0, lr
	bne.w add_loop_256
	add.w sp, #1044
	pop.w {r3-r12,pc}
// void __update_fg_64x320 (int *f, int*g, int *M1);
.p2align 2,,3
.syntax unified
.text
.global __update_fg_64x320
.type __update_fg_64x320, %function
__update_fg_64x320:
	push.w {r3-r12,lr}
	ldr r11, =0x03030303
	vmov.w s0, s1, r0, r1
	vmov.w s2, r2
	sub.w sp, #1300
	mov.w r0, sp
	movw.w lr, #0
	str.w lr, [r0], #1
	vmov.w r1, s2
	vmov.w r2, s0
	bl __polymul_64x320_jump_head
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #64
	bl __polymul_64x320_jump_head
	vmov.w r1, s2
	vmov.w r2, s0
	add.w r1, #128
	sub.w r0, #1
	bl __polymul_64x320_jump_head
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #192
	bl __polymul_64x320_jump_head
	mov.w r10, sp
	vmov.w r0, r1, s0, s1
	add.w r10, #4
	add.w lr, r0, #320
add_loop_320:
	ldr.w r2, [r10, #648]
	ldr.w r3, [r10, #652]
	ldr.w r4, [r10, #656]
	ldr.w r5, [r10, #660]
	ldr.w r6, [r10, #972]
	ldr.w r7, [r10, #976]
	ldr.w r8, [r10, #980]
	ldr.w r9, [r10, #984]
	add.w r2, r6
	add.w r3, r7
	add.w r4, r8
	add.w r5, r9
	and.w r12, r2, #0xF0F0F0F0 // top 4b < 16
	and.w r2, r2, #0x0F0F0F0F // bot 4b < 16
	add.w r2, r2, r12, LSR #4 // range < 31
	bic.w r12, r2, r11 // top 3b < 8
	and.w r2, r2, r11 // bot 2b < 4
	add.w r2, r2, r12, LSR #2 // range <=10
	bic.w r12, r2, r11 // top 3b < 3
	and.w r2, r2, r11 // bot 2b < 4
	add.w r2, r2, r12, LSR #2 // range <=5
	usub8.w r12, r2, r11 // >= 3 ?
	sel.w r2, r12, r2 // select
	and.w r12, r3, #0xF0F0F0F0 // top 4b < 16
	and.w r3, r3, #0x0F0F0F0F // bot 4b < 16
	add.w r3, r3, r12, LSR #4 // range < 31
	bic.w r12, r3, r11 // top 3b < 8
	and.w r3, r3, r11 // bot 2b < 4
	add.w r3, r3, r12, LSR #2 // range <=10
	bic.w r12, r3, r11 // top 3b < 3
	and.w r3, r3, r11 // bot 2b < 4
	add.w r3, r3, r12, LSR #2 // range <=5
	usub8.w r12, r3, r11 // >= 3 ?
	sel.w r3, r12, r3 // select
	and.w r12, r4, #0xF0F0F0F0 // top 4b < 16
	and.w r4, r4, #0x0F0F0F0F // bot 4b < 16
	add.w r4, r4, r12, LSR #4 // range < 31
	bic.w r12, r4, r11 // top 3b < 8
	and.w r4, r4, r11 // bot 2b < 4
	add.w r4, r4, r12, LSR #2 // range <=10
	bic.w r12, r4, r11 // top 3b < 3
	and.w r4, r4, r11 // bot 2b < 4
	add.w r4, r4, r12, LSR #2 // range <=5
	usub8.w r12, r4, r11 // >= 3 ?
	sel.w r4, r12, r4 // select
	and.w r12, r5, #0xF0F0F0F0 // top 4b < 16
	and.w r5, r5, #0x0F0F0F0F // bot 4b < 16
	add.w r5, r5, r12, LSR #4 // range < 31
	bic.w r12, r5, r11 // top 3b < 8
	and.w r5, r5, r11 // bot 2b < 4
	add.w r5, r5, r12, LSR #2 // range <=10
	bic.w r12, r5, r11 // top 3b < 3
	and.w r5, r5, r11 // bot 2b < 4
	add.w r5, r5, r12, LSR #2 // range <=5
	usub8.w r12, r5, r11 // >= 3 ?
	sel.w r5, r12, r5 // select
	str.w r3, [r1, #4]
	str.w r4, [r1, #8]
	str.w r5, [r1, #12]
	str.w r2, [r1], #16
	ldr.w r6, [r10, #324]
	ldr.w r7, [r10, #328]
	ldr.w r8, [r10, #332]
	ldr.w r9, [r10, #336]
	ldr.w r3, [r10, #4]
	ldr.w r4, [r10, #8]
	ldr.w r5, [r10, #12]
	ldr.w r2, [r10], #16
	add.w r2, r6
	add.w r3, r7
	add.w r4, r8
	add.w r5, r9
	and.w r12, r2, #0xF0F0F0F0 // top 4b < 16
	and.w r2, r2, #0x0F0F0F0F // bot 4b < 16
	add.w r2, r2, r12, LSR #4 // range < 31
	bic.w r12, r2, r11 // top 3b < 8
	and.w r2, r2, r11 // bot 2b < 4
	add.w r2, r2, r12, LSR #2 // range <=10
	bic.w r12, r2, r11 // top 3b < 3
	and.w r2, r2, r11 // bot 2b < 4
	add.w r2, r2, r12, LSR #2 // range <=5
	usub8.w r12, r2, r11 // >= 3 ?
	sel.w r2, r12, r2 // select
	and.w r12, r3, #0xF0F0F0F0 // top 4b < 16
	and.w r3, r3, #0x0F0F0F0F // bot 4b < 16
	add.w r3, r3, r12, LSR #4 // range < 31
	bic.w r12, r3, r11 // top 3b < 8
	and.w r3, r3, r11 // bot 2b < 4
	add.w r3, r3, r12, LSR #2 // range <=10
	bic.w r12, r3, r11 // top 3b < 3
	and.w r3, r3, r11 // bot 2b < 4
	add.w r3, r3, r12, LSR #2 // range <=5
	usub8.w r12, r3, r11 // >= 3 ?
	sel.w r3, r12, r3 // select
	and.w r12, r4, #0xF0F0F0F0 // top 4b < 16
	and.w r4, r4, #0x0F0F0F0F // bot 4b < 16
	add.w r4, r4, r12, LSR #4 // range < 31
	bic.w r12, r4, r11 // top 3b < 8
	and.w r4, r4, r11 // bot 2b < 4
	add.w r4, r4, r12, LSR #2 // range <=10
	bic.w r12, r4, r11 // top 3b < 3
	and.w r4, r4, r11 // bot 2b < 4
	add.w r4, r4, r12, LSR #2 // range <=5
	usub8.w r12, r4, r11 // >= 3 ?
	sel.w r4, r12, r4 // select
	and.w r12, r5, #0xF0F0F0F0 // top 4b < 16
	and.w r5, r5, #0x0F0F0F0F // bot 4b < 16
	add.w r5, r5, r12, LSR #4 // range < 31
	bic.w r12, r5, r11 // top 3b < 8
	and.w r5, r5, r11 // bot 2b < 4
	add.w r5, r5, r12, LSR #2 // range <=10
	bic.w r12, r5, r11 // top 3b < 3
	and.w r5, r5, r11 // bot 2b < 4
	add.w r5, r5, r12, LSR #2 // range <=5
	usub8.w r12, r5, r11 // >= 3 ?
	sel.w r5, r12, r5 // select
	str.w r3, [r0, #4]
	str.w r4, [r0, #8]
	str.w r5, [r0, #12]
	str.w r2, [r0], #16
	cmp.w r0, lr
	bne.w add_loop_320
	add.w sp, #1300
	pop.w {r3-r12,pc}
// void __update_fg_64x384 (int *f, int*g, int *M1);
.p2align 2,,3
.syntax unified
.text
.global __update_fg_64x384
.type __update_fg_64x384, %function
__update_fg_64x384:
	push.w {r3-r12,lr}
	ldr r11, =0x03030303
	vmov.w s0, s1, r0, r1
	vmov.w s2, r2
	sub.w sp, #1556
	mov.w r0, sp
	movw.w lr, #0
	str.w lr, [r0], #1
	vmov.w r1, s2
	vmov.w r2, s0
	bl __polymul_64x384_jump_head
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #64
	bl __polymul_64x384_jump_head
	vmov.w r1, s2
	vmov.w r2, s0
	add.w r1, #128
	sub.w r0, #1
	bl __polymul_64x384_jump_head
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #192
	bl __polymul_64x384_jump_head
	mov.w r10, sp
	vmov.w r0, r1, s0, s1
	add.w r10, #4
	add.w lr, r0, #384
add_loop_384:
	ldr.w r2, [r10, #776]
	ldr.w r3, [r10, #780]
	ldr.w r4, [r10, #784]
	ldr.w r5, [r10, #788]
	ldr.w r6, [r10, #1164]
	ldr.w r7, [r10, #1168]
	ldr.w r8, [r10, #1172]
	ldr.w r9, [r10, #1176]
	add.w r2, r6
	add.w r3, r7
	add.w r4, r8
	add.w r5, r9
	and.w r12, r2, #0xF0F0F0F0 // top 4b < 16
	and.w r2, r2, #0x0F0F0F0F // bot 4b < 16
	add.w r2, r2, r12, LSR #4 // range < 31
	bic.w r12, r2, r11 // top 3b < 8
	and.w r2, r2, r11 // bot 2b < 4
	add.w r2, r2, r12, LSR #2 // range <=10
	bic.w r12, r2, r11 // top 3b < 3
	and.w r2, r2, r11 // bot 2b < 4
	add.w r2, r2, r12, LSR #2 // range <=5
	usub8.w r12, r2, r11 // >= 3 ?
	sel.w r2, r12, r2 // select
	and.w r12, r3, #0xF0F0F0F0 // top 4b < 16
	and.w r3, r3, #0x0F0F0F0F // bot 4b < 16
	add.w r3, r3, r12, LSR #4 // range < 31
	bic.w r12, r3, r11 // top 3b < 8
	and.w r3, r3, r11 // bot 2b < 4
	add.w r3, r3, r12, LSR #2 // range <=10
	bic.w r12, r3, r11 // top 3b < 3
	and.w r3, r3, r11 // bot 2b < 4
	add.w r3, r3, r12, LSR #2 // range <=5
	usub8.w r12, r3, r11 // >= 3 ?
	sel.w r3, r12, r3 // select
	and.w r12, r4, #0xF0F0F0F0 // top 4b < 16
	and.w r4, r4, #0x0F0F0F0F // bot 4b < 16
	add.w r4, r4, r12, LSR #4 // range < 31
	bic.w r12, r4, r11 // top 3b < 8
	and.w r4, r4, r11 // bot 2b < 4
	add.w r4, r4, r12, LSR #2 // range <=10
	bic.w r12, r4, r11 // top 3b < 3
	and.w r4, r4, r11 // bot 2b < 4
	add.w r4, r4, r12, LSR #2 // range <=5
	usub8.w r12, r4, r11 // >= 3 ?
	sel.w r4, r12, r4 // select
	and.w r12, r5, #0xF0F0F0F0 // top 4b < 16
	and.w r5, r5, #0x0F0F0F0F // bot 4b < 16
	add.w r5, r5, r12, LSR #4 // range < 31
	bic.w r12, r5, r11 // top 3b < 8
	and.w r5, r5, r11 // bot 2b < 4
	add.w r5, r5, r12, LSR #2 // range <=10
	bic.w r12, r5, r11 // top 3b < 3
	and.w r5, r5, r11 // bot 2b < 4
	add.w r5, r5, r12, LSR #2 // range <=5
	usub8.w r12, r5, r11 // >= 3 ?
	sel.w r5, r12, r5 // select
	str.w r3, [r1, #4]
	str.w r4, [r1, #8]
	str.w r5, [r1, #12]
	str.w r2, [r1], #16
	ldr.w r6, [r10, #388]
	ldr.w r7, [r10, #392]
	ldr.w r8, [r10, #396]
	ldr.w r9, [r10, #400]
	ldr.w r3, [r10, #4]
	ldr.w r4, [r10, #8]
	ldr.w r5, [r10, #12]
	ldr.w r2, [r10], #16
	add.w r2, r6
	add.w r3, r7
	add.w r4, r8
	add.w r5, r9
	and.w r12, r2, #0xF0F0F0F0 // top 4b < 16
	and.w r2, r2, #0x0F0F0F0F // bot 4b < 16
	add.w r2, r2, r12, LSR #4 // range < 31
	bic.w r12, r2, r11 // top 3b < 8
	and.w r2, r2, r11 // bot 2b < 4
	add.w r2, r2, r12, LSR #2 // range <=10
	bic.w r12, r2, r11 // top 3b < 3
	and.w r2, r2, r11 // bot 2b < 4
	add.w r2, r2, r12, LSR #2 // range <=5
	usub8.w r12, r2, r11 // >= 3 ?
	sel.w r2, r12, r2 // select
	and.w r12, r3, #0xF0F0F0F0 // top 4b < 16
	and.w r3, r3, #0x0F0F0F0F // bot 4b < 16
	add.w r3, r3, r12, LSR #4 // range < 31
	bic.w r12, r3, r11 // top 3b < 8
	and.w r3, r3, r11 // bot 2b < 4
	add.w r3, r3, r12, LSR #2 // range <=10
	bic.w r12, r3, r11 // top 3b < 3
	and.w r3, r3, r11 // bot 2b < 4
	add.w r3, r3, r12, LSR #2 // range <=5
	usub8.w r12, r3, r11 // >= 3 ?
	sel.w r3, r12, r3 // select
	and.w r12, r4, #0xF0F0F0F0 // top 4b < 16
	and.w r4, r4, #0x0F0F0F0F // bot 4b < 16
	add.w r4, r4, r12, LSR #4 // range < 31
	bic.w r12, r4, r11 // top 3b < 8
	and.w r4, r4, r11 // bot 2b < 4
	add.w r4, r4, r12, LSR #2 // range <=10
	bic.w r12, r4, r11 // top 3b < 3
	and.w r4, r4, r11 // bot 2b < 4
	add.w r4, r4, r12, LSR #2 // range <=5
	usub8.w r12, r4, r11 // >= 3 ?
	sel.w r4, r12, r4 // select
	and.w r12, r5, #0xF0F0F0F0 // top 4b < 16
	and.w r5, r5, #0x0F0F0F0F // bot 4b < 16
	add.w r5, r5, r12, LSR #4 // range < 31
	bic.w r12, r5, r11 // top 3b < 8
	and.w r5, r5, r11 // bot 2b < 4
	add.w r5, r5, r12, LSR #2 // range <=10
	bic.w r12, r5, r11 // top 3b < 3
	and.w r5, r5, r11 // bot 2b < 4
	add.w r5, r5, r12, LSR #2 // range <=5
	usub8.w r12, r5, r11 // >= 3 ?
	sel.w r5, r12, r5 // select
	str.w r3, [r0, #4]
	str.w r4, [r0, #8]
	str.w r5, [r0, #12]
	str.w r2, [r0], #16
	cmp.w r0, lr
	bne.w add_loop_384
	add.w sp, #1556
	pop.w {r3-r12,pc}
// void __update_fg_64x448 (int *f, int*g, int *M1);
.p2align 2,,3
.syntax unified
.text
.global __update_fg_64x448
.type __update_fg_64x448, %function
__update_fg_64x448:
	push.w {r3-r12,lr}
	ldr r11, =0x03030303
	vmov.w s0, s1, r0, r1
	vmov.w s2, r2
	sub.w sp, #1812
	mov.w r0, sp
	movw.w lr, #0
	str.w lr, [r0], #1
	vmov.w r1, s2
	vmov.w r2, s0
	bl __polymul_64x448_jump_head
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #64
	bl __polymul_64x448_jump_head
	vmov.w r1, s2
	vmov.w r2, s0
	add.w r1, #128
	sub.w r0, #1
	bl __polymul_64x448_jump_head
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #192
	bl __polymul_64x448_jump_head
	mov.w r10, sp
	vmov.w r0, r1, s0, s1
	add.w r10, #4
	add.w lr, r0, #448
add_loop_448:
	ldr.w r2, [r10, #904]
	ldr.w r3, [r10, #908]
	ldr.w r4, [r10, #912]
	ldr.w r5, [r10, #916]
	ldr.w r6, [r10, #1356]
	ldr.w r7, [r10, #1360]
	ldr.w r8, [r10, #1364]
	ldr.w r9, [r10, #1368]
	add.w r2, r6
	add.w r3, r7
	add.w r4, r8
	add.w r5, r9
	and.w r12, r2, #0xF0F0F0F0 // top 4b < 16
	and.w r2, r2, #0x0F0F0F0F // bot 4b < 16
	add.w r2, r2, r12, LSR #4 // range < 31
	bic.w r12, r2, r11 // top 3b < 8
	and.w r2, r2, r11 // bot 2b < 4
	add.w r2, r2, r12, LSR #2 // range <=10
	bic.w r12, r2, r11 // top 3b < 3
	and.w r2, r2, r11 // bot 2b < 4
	add.w r2, r2, r12, LSR #2 // range <=5
	usub8.w r12, r2, r11 // >= 3 ?
	sel.w r2, r12, r2 // select
	and.w r12, r3, #0xF0F0F0F0 // top 4b < 16
	and.w r3, r3, #0x0F0F0F0F // bot 4b < 16
	add.w r3, r3, r12, LSR #4 // range < 31
	bic.w r12, r3, r11 // top 3b < 8
	and.w r3, r3, r11 // bot 2b < 4
	add.w r3, r3, r12, LSR #2 // range <=10
	bic.w r12, r3, r11 // top 3b < 3
	and.w r3, r3, r11 // bot 2b < 4
	add.w r3, r3, r12, LSR #2 // range <=5
	usub8.w r12, r3, r11 // >= 3 ?
	sel.w r3, r12, r3 // select
	and.w r12, r4, #0xF0F0F0F0 // top 4b < 16
	and.w r4, r4, #0x0F0F0F0F // bot 4b < 16
	add.w r4, r4, r12, LSR #4 // range < 31
	bic.w r12, r4, r11 // top 3b < 8
	and.w r4, r4, r11 // bot 2b < 4
	add.w r4, r4, r12, LSR #2 // range <=10
	bic.w r12, r4, r11 // top 3b < 3
	and.w r4, r4, r11 // bot 2b < 4
	add.w r4, r4, r12, LSR #2 // range <=5
	usub8.w r12, r4, r11 // >= 3 ?
	sel.w r4, r12, r4 // select
	and.w r12, r5, #0xF0F0F0F0 // top 4b < 16
	and.w r5, r5, #0x0F0F0F0F // bot 4b < 16
	add.w r5, r5, r12, LSR #4 // range < 31
	bic.w r12, r5, r11 // top 3b < 8
	and.w r5, r5, r11 // bot 2b < 4
	add.w r5, r5, r12, LSR #2 // range <=10
	bic.w r12, r5, r11 // top 3b < 3
	and.w r5, r5, r11 // bot 2b < 4
	add.w r5, r5, r12, LSR #2 // range <=5
	usub8.w r12, r5, r11 // >= 3 ?
	sel.w r5, r12, r5 // select
	str.w r3, [r1, #4]
	str.w r4, [r1, #8]
	str.w r5, [r1, #12]
	str.w r2, [r1], #16
	ldr.w r6, [r10, #452]
	ldr.w r7, [r10, #456]
	ldr.w r8, [r10, #460]
	ldr.w r9, [r10, #464]
	ldr.w r3, [r10, #4]
	ldr.w r4, [r10, #8]
	ldr.w r5, [r10, #12]
	ldr.w r2, [r10], #16
	add.w r2, r6
	add.w r3, r7
	add.w r4, r8
	add.w r5, r9
	and.w r12, r2, #0xF0F0F0F0 // top 4b < 16
	and.w r2, r2, #0x0F0F0F0F // bot 4b < 16
	add.w r2, r2, r12, LSR #4 // range < 31
	bic.w r12, r2, r11 // top 3b < 8
	and.w r2, r2, r11 // bot 2b < 4
	add.w r2, r2, r12, LSR #2 // range <=10
	bic.w r12, r2, r11 // top 3b < 3
	and.w r2, r2, r11 // bot 2b < 4
	add.w r2, r2, r12, LSR #2 // range <=5
	usub8.w r12, r2, r11 // >= 3 ?
	sel.w r2, r12, r2 // select
	and.w r12, r3, #0xF0F0F0F0 // top 4b < 16
	and.w r3, r3, #0x0F0F0F0F // bot 4b < 16
	add.w r3, r3, r12, LSR #4 // range < 31
	bic.w r12, r3, r11 // top 3b < 8
	and.w r3, r3, r11 // bot 2b < 4
	add.w r3, r3, r12, LSR #2 // range <=10
	bic.w r12, r3, r11 // top 3b < 3
	and.w r3, r3, r11 // bot 2b < 4
	add.w r3, r3, r12, LSR #2 // range <=5
	usub8.w r12, r3, r11 // >= 3 ?
	sel.w r3, r12, r3 // select
	and.w r12, r4, #0xF0F0F0F0 // top 4b < 16
	and.w r4, r4, #0x0F0F0F0F // bot 4b < 16
	add.w r4, r4, r12, LSR #4 // range < 31
	bic.w r12, r4, r11 // top 3b < 8
	and.w r4, r4, r11 // bot 2b < 4
	add.w r4, r4, r12, LSR #2 // range <=10
	bic.w r12, r4, r11 // top 3b < 3
	and.w r4, r4, r11 // bot 2b < 4
	add.w r4, r4, r12, LSR #2 // range <=5
	usub8.w r12, r4, r11 // >= 3 ?
	sel.w r4, r12, r4 // select
	and.w r12, r5, #0xF0F0F0F0 // top 4b < 16
	and.w r5, r5, #0x0F0F0F0F // bot 4b < 16
	add.w r5, r5, r12, LSR #4 // range < 31
	bic.w r12, r5, r11 // top 3b < 8
	and.w r5, r5, r11 // bot 2b < 4
	add.w r5, r5, r12, LSR #2 // range <=10
	bic.w r12, r5, r11 // top 3b < 3
	and.w r5, r5, r11 // bot 2b < 4
	add.w r5, r5, r12, LSR #2 // range <=5
	usub8.w r12, r5, r11 // >= 3 ?
	sel.w r5, r12, r5 // select
	str.w r3, [r0, #4]
	str.w r4, [r0, #8]
	str.w r5, [r0, #12]
	str.w r2, [r0], #16
	cmp.w r0, lr
	bne.w add_loop_448
	add.w sp, #1812
	pop.w {r3-r12,pc}
// void __update_fg_64x512 (int *f, int*g, int *M1);
.p2align 2,,3
.syntax unified
.text
.global __update_fg_64x512
.type __update_fg_64x512, %function
__update_fg_64x512:
	push.w {r3-r12,lr}
	ldr r11, =0x03030303
	vmov.w s0, s1, r0, r1
	vmov.w s2, r2
	sub.w sp, #2068
	mov.w r0, sp
	movw.w lr, #0
	str.w lr, [r0], #1
	vmov.w r1, s2
	vmov.w r2, s0
	bl __polymul_64x512_jump_head
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #64
	bl __polymul_64x512_jump_head
	vmov.w r1, s2
	vmov.w r2, s0
	add.w r1, #128
	sub.w r0, #1
	bl __polymul_64x512_jump_head
	vmov.w r1, s2
	vmov.w r2, s1
	add.w r1, #192
	bl __polymul_64x512_jump_head
	mov.w r10, sp
	vmov.w r0, r1, s0, s1
	add.w r10, #4
	add.w lr, r0, #512
add_loop_512:
	ldr.w r2, [r10, #1032]
	ldr.w r3, [r10, #1036]
	ldr.w r4, [r10, #1040]
	ldr.w r5, [r10, #1044]
	ldr.w r6, [r10, #1548]
	ldr.w r7, [r10, #1552]
	ldr.w r8, [r10, #1556]
	ldr.w r9, [r10, #1560]
	add.w r2, r6
	add.w r3, r7
	add.w r4, r8
	add.w r5, r9
	and.w r12, r2, #0xF0F0F0F0 // top 4b < 16
	and.w r2, r2, #0x0F0F0F0F // bot 4b < 16
	add.w r2, r2, r12, LSR #4 // range < 31
	bic.w r12, r2, r11 // top 3b < 8
	and.w r2, r2, r11 // bot 2b < 4
	add.w r2, r2, r12, LSR #2 // range <=10
	bic.w r12, r2, r11 // top 3b < 3
	and.w r2, r2, r11 // bot 2b < 4
	add.w r2, r2, r12, LSR #2 // range <=5
	usub8.w r12, r2, r11 // >= 3 ?
	sel.w r2, r12, r2 // select
	and.w r12, r3, #0xF0F0F0F0 // top 4b < 16
	and.w r3, r3, #0x0F0F0F0F // bot 4b < 16
	add.w r3, r3, r12, LSR #4 // range < 31
	bic.w r12, r3, r11 // top 3b < 8
	and.w r3, r3, r11 // bot 2b < 4
	add.w r3, r3, r12, LSR #2 // range <=10
	bic.w r12, r3, r11 // top 3b < 3
	and.w r3, r3, r11 // bot 2b < 4
	add.w r3, r3, r12, LSR #2 // range <=5
	usub8.w r12, r3, r11 // >= 3 ?
	sel.w r3, r12, r3 // select
	and.w r12, r4, #0xF0F0F0F0 // top 4b < 16
	and.w r4, r4, #0x0F0F0F0F // bot 4b < 16
	add.w r4, r4, r12, LSR #4 // range < 31
	bic.w r12, r4, r11 // top 3b < 8
	and.w r4, r4, r11 // bot 2b < 4
	add.w r4, r4, r12, LSR #2 // range <=10
	bic.w r12, r4, r11 // top 3b < 3
	and.w r4, r4, r11 // bot 2b < 4
	add.w r4, r4, r12, LSR #2 // range <=5
	usub8.w r12, r4, r11 // >= 3 ?
	sel.w r4, r12, r4 // select
	and.w r12, r5, #0xF0F0F0F0 // top 4b < 16
	and.w r5, r5, #0x0F0F0F0F // bot 4b < 16
	add.w r5, r5, r12, LSR #4 // range < 31
	bic.w r12, r5, r11 // top 3b < 8
	and.w r5, r5, r11 // bot 2b < 4
	add.w r5, r5, r12, LSR #2 // range <=10
	bic.w r12, r5, r11 // top 3b < 3
	and.w r5, r5, r11 // bot 2b < 4
	add.w r5, r5, r12, LSR #2 // range <=5
	usub8.w r12, r5, r11 // >= 3 ?
	sel.w r5, r12, r5 // select
	str.w r3, [r1, #4]
	str.w r4, [r1, #8]
	str.w r5, [r1, #12]
	str.w r2, [r1], #16
	ldr.w r6, [r10, #516]
	ldr.w r7, [r10, #520]
	ldr.w r8, [r10, #524]
	ldr.w r9, [r10, #528]
	ldr.w r3, [r10, #4]
	ldr.w r4, [r10, #8]
	ldr.w r5, [r10, #12]
	ldr.w r2, [r10], #16
	add.w r2, r6
	add.w r3, r7
	add.w r4, r8
	add.w r5, r9
	and.w r12, r2, #0xF0F0F0F0 // top 4b < 16
	and.w r2, r2, #0x0F0F0F0F // bot 4b < 16
	add.w r2, r2, r12, LSR #4 // range < 31
	bic.w r12, r2, r11 // top 3b < 8
	and.w r2, r2, r11 // bot 2b < 4
	add.w r2, r2, r12, LSR #2 // range <=10
	bic.w r12, r2, r11 // top 3b < 3
	and.w r2, r2, r11 // bot 2b < 4
	add.w r2, r2, r12, LSR #2 // range <=5
	usub8.w r12, r2, r11 // >= 3 ?
	sel.w r2, r12, r2 // select
	and.w r12, r3, #0xF0F0F0F0 // top 4b < 16
	and.w r3, r3, #0x0F0F0F0F // bot 4b < 16
	add.w r3, r3, r12, LSR #4 // range < 31
	bic.w r12, r3, r11 // top 3b < 8
	and.w r3, r3, r11 // bot 2b < 4
	add.w r3, r3, r12, LSR #2 // range <=10
	bic.w r12, r3, r11 // top 3b < 3
	and.w r3, r3, r11 // bot 2b < 4
	add.w r3, r3, r12, LSR #2 // range <=5
	usub8.w r12, r3, r11 // >= 3 ?
	sel.w r3, r12, r3 // select
	and.w r12, r4, #0xF0F0F0F0 // top 4b < 16
	and.w r4, r4, #0x0F0F0F0F // bot 4b < 16
	add.w r4, r4, r12, LSR #4 // range < 31
	bic.w r12, r4, r11 // top 3b < 8
	and.w r4, r4, r11 // bot 2b < 4
	add.w r4, r4, r12, LSR #2 // range <=10
	bic.w r12, r4, r11 // top 3b < 3
	and.w r4, r4, r11 // bot 2b < 4
	add.w r4, r4, r12, LSR #2 // range <=5
	usub8.w r12, r4, r11 // >= 3 ?
	sel.w r4, r12, r4 // select
	and.w r12, r5, #0xF0F0F0F0 // top 4b < 16
	and.w r5, r5, #0x0F0F0F0F // bot 4b < 16
	add.w r5, r5, r12, LSR #4 // range < 31
	bic.w r12, r5, r11 // top 3b < 8
	and.w r5, r5, r11 // bot 2b < 4
	add.w r5, r5, r12, LSR #2 // range <=10
	bic.w r12, r5, r11 // top 3b < 3
	and.w r5, r5, r11 // bot 2b < 4
	add.w r5, r5, r12, LSR #2 // range <=5
	usub8.w r12, r5, r11 // >= 3 ?
	sel.w r5, r12, r5 // select
	str.w r3, [r0, #4]
	str.w r4, [r0, #8]
	str.w r5, [r0, #12]
	str.w r2, [r0], #16
	cmp.w r0, lr
	bne.w add_loop_512
	add.w sp, #2068
	pop.w {r3-r12,pc}
