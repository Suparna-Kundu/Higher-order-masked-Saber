
// void gf_polymul_512x512_mod3 (int *h, int *f, int *g);
	.p2align	2,,3	
	.syntax		unified
	.text
	.global gf_polymul_512x512_mod3
	.type	gf_polymul_512x512_mod3, %function
gf_polymul_512x512_mod3:
    push.w {r3-r12, lr}
    vmov.w s0, r0
    sub.w sp, sp, #2048
    mov.w r0, sp
    mov.w r12, #0x03030303
    add.w lr, r0, #256
gf_polymul_512x512_mod3_extend:
    ldr.w r4, [r1, #4]
    ldr.w r5, [r1, #256]
    ldr.w r6, [r1, #260]
    ldr.w r3, [r1], #8
    ldr.w r8, [r2, #4]
    ldr.w r9, [r2, #256]
    ldr.w r10, [r2, #260]
    ldr.w r7, [r2], #8
    add.w r3, r3, r5
    add.w r4, r4, r6
    add.w r7, r7, r9
    add.w r8, r8, r10
    usub8.w r5, r3, r12
    sel.w r3, r5, r3
    usub8.w r6, r4, r12
    sel.w r4, r6, r4
    usub8.w r9, r7, r12
    sel.w r7, r9, r7
    usub8.w r10, r8, r12
    sel.w r8, r10, r8
    str.w r4, [r0, #4]
    str.w r7, [r0, #256]
    str.w r8, [r0, #260]
    str.w r3, [r0], #8
    cmp.w r0, lr
    bne.w gf_polymul_512x512_mod3_extend
    add.w r0, r0, #256 @ stack #512
    sub.w r1, r1, #256 @ f #0
    sub.w r2, r2, #256 @ g #0
    mov.w r4, r0
    mov.w r5, r1
    mov.w r6, r2
    bl.w gf_polymul_256x256_mod3 @ a0*b0
    add.w r0, r4, #512
    add.w r1, r5, #256
    add.w r2, r6, #256
    bl.w gf_polymul_256x256_mod3 @ a1*b1
    add.w r0, r4, #1024
    sub.w r1, r4, #512
    sub.w r2, r4, #256
    bl.w gf_polymul_256x256_mod3 @ (a0+a1)*(b0+b1)
    vmov r0, s0 @ h
    mov.w r1, r4
    add.w lr, r1, #256
@ (a0+a1)(b0+b1)x + (1-x)(a0b0-a1b1x)
@ a0b0bot a0b0top
@         -a1b1bot -a1b1top
@         -a0b0bot -a0b0top
@                  a1b1bot  a1b1top
@         aabbbot  aabbtop
    mov.w r12, #0x03030303
gf_polymul_512x512_mod3_output:
    ldr.w r3, [r1, #256] @ a0b0 top
    ldr.w r4, [r1, #512] @ a1b1 bot
    ldr.w r5, [r1, #768] @ a1b1 top
    ldr.w r6, [r1, #1024] @ (a0+a1)(b0+b1) bot
    ldr.w r7, [r1, #1280] @ (a0+a1)(b0+b1) top
    ldr.w r2, [r1], #4 @ a0b0 bot
    str.w r5, [r0, #768]
    usub8.w r8, r12, r4 @ - a1b1 bot
    add.w r8, r3, r8 @ a0b0 top - a1b1 bot
    usub8.w r9, r8, r12
    sel.w r8, r9, r8
    usub8.w r9, r12, r2 @ -a0b0 bot
    add.w r9, r8, r9
    usub8.w r10, r9, r12
    sel.w r9, r10, r9
    add.w r9, r9, r6
    usub8.w r10, r9, r12
    sel.w r6, r10, r9 @ str at #256
    usub8.w r8, r12, r8
    usub8.w r9, r12, r5 @ -a1b1 top
    add.w r8, r8, r9
    usub8.w r9, r8, r12
    sel.w r8, r9, r8
    add.w r8, r8, r7
    usub8.w r9, r8, r12
    sel.w r7, r9, r8 @ str at #512
    str.w r7, [r0, #512]
    str.w r6, [r0, #256]
    str.w r2, [r0], #4
    cmp.w r1, lr
    bne.w gf_polymul_512x512_mod3_output
    add.w sp, sp, #2048
    pop.w {r3-r12, pc}