.p2align 2,,3
.syntax unified
.text
iwpad:
	.word 935519
	.word 3270578671
	@ .word 4288150635
    @ .word 4202629097
    @ .word 132839438
    @ .word 4284414565
    @ .word 137624047
    @ .word 4270392526
    @ .word 4212590266
    @ .word 4178246142
	.word 38075360
    .word 23002444
    .word 4192009670
    .word 15663379
    .word 4194236986
    .word 4258792500
    .word 4277272246
    .word 4166450295

.global iRader17_iGood17x9_306
.type iRader17_iGood17x9_306, %function
iRader17_iGood17x9_306:
	push {r2-r12, lr}
	adr lr, iwpad
	vldm lr, {s2-s11}
    vmov s15, r0
	vmov s0, r0
    vmov s1, r1
	sub.w sp, sp, #612
	mov.w r0, sp
	vmov s0, r0
	add.w lr, r0, #36
iRader_iGood_part1:
	ldr.w r3, [r1, #468]
	ldr.w r4, [r1, #180]
	ldr.w r5, [r1, #540]
	ldr.w r6, [r1, #396]
	ldr.w r7, [r1, #144]
	ldr.w r8, [r1, #432]
	ldr.w r9, [r1, #72]
	ldr.w r10, [r1, #216]

	sadd16 r12, r3, r4
	sadd16 r12, r12, r5
	sadd16 r12, r12, r6
	sadd16 r12, r12, r7
	sadd16 r12, r12, r8
	sadd16 r12, r12, r9
	sadd16 r12, r12, r10

	sadd16 r2, r3, r7 @ c4 mod (x^8 - 1)
	ssub16 r7, r3, r7 @ c4 mod (x^8 + 1)
	sadd16 r3, r4, r8 @ c5 mod (x^8 - 1)
	ssub16 r8, r4, r8 @ c5 mod (x^8 + 1)
	sadd16 r4, r5, r9 @ c6 mod (x^8 - 1)
	ssub16 r9, r5, r9 @ c6 mod (x^8 + 1)
	sadd16 r5, r6, r10 @ c7 mod (x^8 - 1)
	ssub16 r10, r6, r10 @ c7 mod (x^8 + 1)

	pkhtb r11, r10, r9, asr #16 @ c6, c7 mod (x^8 + 1) b
	pkhbt r10, r9, r10, lsl #16 @ c6, c7 mod (x^8 + 1) a
	pkhtb r9, r8, r7, asr #16 @ c4, c5 mod (x^8 + 1) b
	pkhbt r8, r7, r8, lsl #16 @ c4, c5 mod (x^8 + 1) a
	pkhtb r7, r5, r4, asr #16 @ c6, c7 mod (x^8 - 1) b
	pkhbt r6, r4, r5, lsl #16 @ c6, c7 mod (x^8 - 1) a
	pkhtb r5, r3, r2, asr #16 @ c4, c5 mod (x^8 - 1) b
	pkhbt r4, r2, r3, lsl #16 @ c4, c5 mod (x^8 - 1) a

	str.w r8, [r0, #252]
	str.w r10, [r0, #288]
	str.w r9, [r0, #540]
	str.w r11, [r0, #576]
	vmov s12, r12

@ r4, r6 = c4~c7 mod (x^8 - 1) a, r5, r7 = c4~c7 mod (x^8 - 1) b
	ldr.w r8, [r1, #324]
	ldr.w r9, [r1, #360]
	ldr.w r10, [r1, #288]
	ldr.w r11, [r1, #252]

	sadd16 r12, r8, r9
	sadd16 r12, r12, r10
	sadd16 r12, r12, r11

	sadd16 r2, r8, r10 @ c2 mod (x^8 - 1)
	ssub16 r8, r8, r10 @ c2 mod (x^8 + 1)
	sadd16 r3, r9, r11 @ c3 mod (x^8 - 1)
	ssub16 r9, r9, r11 @ c3 mod (x^8 + 1)

	pkhbt r10, r8, r9, lsl #16 @ c2, c3 mod (x^8 + 1) a
	pkhtb r11, r9, r8, asr #16 @ c2, c3 mod (x^8 + 1) b
	pkhbt r8, r2, r3, lsl #16 @ c2, c3 mod (x^8 - 1) a
	pkhtb r9, r3, r2, asr #16 @ c2, c3 mod (x^8 - 1) b

	sadd16 r2, r8, r6 @ c2, c3 mod (x^4 - 1) a
	ssub16 r6, r8, r6 @ c2, c3 mod (x^4 + 1) a
	sadd16 r3, r9, r7 @ c2, c3 mod (x^4 - 1) b
	ssub16 r7, r9, r7 @ c2, c3 mod (x^4 + 1) b

@ r2 = c2~c3 mod (x^4 - 1) a, r3 = c2~c3 mod (x^4 - 1) b, r4 = c4~c5 mod (x^8 - 1) a, r5 = c4~c5 mod (x^8 - 1) b
	str.w r10, [r0, #216]
	str.w r11, [r0, #504]
	str.w r6, [r0, #144]
	str.w r7, [r0, #432]

	ldr.w r8, [r1, #36]
	ldr.w r9, [r1, #108]
	ldr.w r10, [r1, #576]
	ldr.w r11, [r1, #504]

	sadd16 r12, r12, r8
	sadd16 r12, r12, r9
	sadd16 r12, r12, r10
	sadd16 r12, r12, r11

	sadd16 r6, r8, r10 @ c0 mod (x^8 - 1)
	ssub16 r8, r8, r10 @ c0 mod (x^8 + 1)
	sadd16 r7, r9, r11 @ c1 mod (x^8 - 1)
	ssub16 r9, r9, r11 @ c1 mod (x^8 + 1)

	pkhbt r10, r8, r9, lsl #16 @ c0, c1 mod (x^8 + 1) a
	pkhtb r11, r9, r8, asr #16 @ c0, c1 mod (x^8 + 1) b
	pkhbt r8, r6, r7, lsl #16 @ c0, c1 mod (x^8 - 1) a
	pkhtb r9, r7, r6, asr #16 @ c0, c1 mod (x^8 - 1) b

	sadd16 r6, r8, r4 @ c0, c1 mod (x^4 - 1) a
	ssub16 r8, r8, r4 @ c0, c1 mod (x^4 + 1) a
	sadd16 r7, r9, r5 @ c0, c1 mod (x^4 - 1) b
	ssub16 r9, r9, r5 @ c0, c1 mod (x^4 + 1) b

	sadd16 r4, r6, r2
	ssub16 r6, r6, r2
	sadd16 r5, r7, r3
	ssub16 r7, r7, r3

	str.w r10, [r0, #180]
	str.w r11, [r0, #468]
	str.w r8, [r0, #108]
	str.w r9, [r0, #396]
	str.w r4, [r0, #36]
	str.w r6, [r0, #72]
	str.w r5, [r0, #324]
	str.w r7, [r0, #360]

	vmov r11, s12
	vmov r10, s2
	mov.w r9, #4591
	ldr.w r8, [r1], #4

	sbfx r2, r11, #0, #16
	sbfx r3, r12, #0, #16
	sbfx r4, r11, #16, #16
	sbfx r5, r12, #16, #16
	
	add.w r2, r2, r3
	add.w r3, r4, r5
	smmulr r4, r2, r10
	mls r2, r4, r9, r2
	smmulr r4, r3, r10
	mls r3, r4, r9, r3

	pkhbt r2, r2, r3, lsl #16
	sadd16 r2, r2, r8

	str.w r2, [r0], #4
	cmp.w r0, lr
	bne.w iRader_iGood_part1

    vmov r0, s0
    vmov r12, s3
    add.w lr, r0, #36
    vmov r1, s4
    vmov r2, s5
    vmov r3, s6
    vmov r4, s7
iRader_iGood_part2:
	ldr.w r5, [r0, #36]
	ldr.w r6, [r0, #72]
	ldr.w r7, [r0, #108]
	ldr.w r8, [r0, #144]

	smuad r9, r1, r5
	smuadx r10, r1, r5
	smusd r11, r2, r6
	smuadx r5, r2, r6
	add.w r6, r9, r11 @ 0
	sub.w r9, r9, r11 @ 2
	add.w r11, r10, r5 @ 1
	sub.w r10, r10, r5 @ 3
	smulbt r5, r6, r12
	smlabb r6, r5, r12, r6
	smulbt r5, r9, r12
	smlabb r9, r5, r12, r9
	smulbt r5, r11, r12
	smlabb r11, r5, r12, r11
	smulbt r5, r10, r12
	smlabb r10, r5, r12, r10
	pkhtb r10, r10, r9, asr #16
	pkhtb r9, r11, r6, asr #16

	@ smuad r9, r1, r5
	@ smuadx r10, r1, r5
	@ smulbt r5, r9, r12
	@ smlabb r9, r5, r12, r9
	@ smulbt r5, r10, r12
	@ smlabb r10, r5, r12, r10
	@ pkhtb r5, r10, r9, asr #16
	@ smusd r9, r2, r6
	@ smuadx r10, r2, r6
	@ smulbt r6, r9, r12
	@ smlabb r9, r6, r12, r9
	@ smulbt r6, r10, r12
	@ smlabb r10, r6, r12, r10
	@ pkhtb r6, r10, r9, asr #16
	@ sadd16 r9, r5, r6
	@ ssub16 r10, r5, r6

	smuadx r11, r3, r7
	smuadx r5, r4, r8
	sub.w r11, r11, r5
	smuadx r5, r3, r8
	smladx r5, r4, r7, r5
	smulbt r6, r11, r12
	smlabb r11, r6, r12, r11
	smulbt r6, r5, r12
	smlabb r5, r6, r12, r5
	pkhtb r6, r5, r11, asr #16
	pkhbt r11, r7, r8
	pkhtb r5, r7, r8
	smusd r7, r3, r11
	smuad r8, r4, r5
	sub.w r7, r7, r8
	smuad r8, r3, r5
	smlsd r8, r4, r11, r8
	smulbt r11, r7, r12
	smlabb r7, r11, r12, r7
	smulbt r11, r8, r12
	smlabb r8, r11, r12, r8
	pkhtb r7, r8, r7, asr #16
	pkhbt r8, r7, r6, lsl #16
	pkhtb r7, r6, r7, asr #16
	sadd16 r11, r9, r8
	ssub16 r5, r9, r8
	sadd16 r6, r10, r7
	ssub16 r9, r10, r7
	str.w r11, [r0, #36]
	str.w r6, [r0, #72]
	str.w r5, [r0, #108]
	str.w r9, [r0, #144]
	ldr.w r5, [r0, #324]
	ldr.w r6, [r0, #360]
	ldr.w r7, [r0, #396]
	ldr.w r8, [r0, #432]

	smuad r9, r1, r5
	smuadx r10, r1, r5
	smusd r11, r2, r6
	smuadx r5, r2, r6
	add.w r6, r9, r11 @ 0
	sub.w r9, r9, r11 @ 2
	add.w r11, r10, r5 @ 1
	sub.w r10, r10, r5 @ 3
	smulbt r5, r6, r12
	smlabb r6, r5, r12, r6
	smulbt r5, r9, r12
	smlabb r9, r5, r12, r9
	smulbt r5, r11, r12
	smlabb r11, r5, r12, r11
	smulbt r5, r10, r12
	smlabb r10, r5, r12, r10
	pkhtb r10, r10, r9, asr #16
	pkhtb r9, r11, r6, asr #16

	@ smuad r9, r1, r5
	@ smuadx r10, r1, r5
	@ smulbt r5, r9, r12
	@ smlabb r9, r5, r12, r9
	@ smulbt r5, r10, r12
	@ smlabb r10, r5, r12, r10
	@ pkhtb r5, r10, r9, asr #16
	@ smusd r9, r2, r6
	@ smuadx r10, r2, r6
	@ smulbt r6, r9, r12
	@ smlabb r9, r6, r12, r9
	@ smulbt r6, r10, r12
	@ smlabb r10, r6, r12, r10
	@ pkhtb r6, r10, r9, asr #16
	@ sadd16 r9, r5, r6
	@ ssub16 r10, r5, r6

	smuadx r11, r3, r7
	smuadx r5, r4, r8
	sub.w r11, r11, r5
	smuadx r5, r3, r8
	smladx r5, r4, r7, r5
	smulbt r6, r11, r12
	smlabb r11, r6, r12, r11
	smulbt r6, r5, r12
	smlabb r5, r6, r12, r5
	pkhtb r6, r5, r11, asr #16
	pkhbt r11, r7, r8
	pkhtb r5, r7, r8
	smusd r7, r3, r11
	smuad r8, r4, r5
	sub.w r7, r7, r8
	smuad r8, r3, r5
	smlsd r8, r4, r11, r8
	smulbt r11, r7, r12
	smlabb r7, r11, r12, r7
	smulbt r11, r8, r12
	smlabb r8, r11, r12, r8
	pkhtb r7, r8, r7, asr #16
	pkhbt r8, r7, r6, lsl #16
	pkhtb r7, r6, r7, asr #16
	sadd16 r11, r9, r8
	ssub16 r5, r9, r8
	sadd16 r6, r10, r7
	ssub16 r9, r10, r7
	str.w r11, [r0, #324]
	str.w r6, [r0, #360]
	str.w r5, [r0, #396]
	str.w r9, [r0, #432]
    add.w r0, r0, #4
    cmp.w r0, lr
    bne.w iRader_iGood_part2

    vmov r0, s0
    vmov r1, s8
    vmov r2, s9
    vmov r3, s10
    vmov r4, s11
iRader_iGood_part3:
    ldr.w r5, [r0, #180]
	ldr.w r6, [r0, #216]
	ldr.w r7, [r0, #252]
	ldr.w r8, [r0, #288]
	smuadx r9, r1, r5
	smuadx r10, r2, r8
	smladx r10, r3, r7, r10
	smladx r10, r4, r6, r10
	sub.w r9, r9, r10
	smuadx r10, r1, r6
	smladx r10, r2, r5, r10
	smuadx r11, r3, r8
	smladx r11, r4, r7, r11
	sub.w r10, r10, r11
	smulbt r11, r9, r12
	smlabb r9, r11, r12, r9
	smulbt r11, r10, r12
	smlabb r10, r11, r12, r10
	pkhtb r9, r10, r9, asr #16
	vmov s12, r9
	smuadx r9, r1, r7
	smladx r9, r2, r6, r9
	smladx r9, r3, r5, r9
	smuadx r10, r4, r8
	sub.w r9, r9, r10
	smuadx r10, r1, r8
	smladx r10, r2, r7, r10
	smladx r10, r3, r6, r10
	smladx r10, r4, r5, r10
	smulbt r11, r9, r12
	smlabb r9, r11, r12, r9
	smulbt r11, r10, r12
	smlabb r10, r11, r12, r10
	pkhtb r9, r10, r9, asr #16
	vmov s13, r9
	pkhbt r9, r5, r8
	pkhtb r5, r5, r6
	pkhtb r6, r6, r7
	pkhtb r7, r7, r8
	smusd r8, r1, r9
	smuad r10, r2, r7
	smlad r10, r3, r6, r10
	smlad r10, r4, r5, r10
	sub.w r8, r8, r10
	smuad r10, r1, r5
	smlsd r10, r2, r9, r10
	smuad r11, r3, r7
	smlad r11, r4, r6, r11
	sub.w r10, r10, r11
	smulbt r11, r8, r12
	smlabb r8, r11, r12, r8
	smulbt r11, r10, r12
	smlabb r10, r11, r12, r10
	pkhtb r11, r10, r8, asr #16
	smuad r8, r1, r6
	smlad r8, r2, r5, r8
	smlsd r8, r3, r9, r8
	smuad r10, r4, r7
	sub.w r8, r8, r10
	smuad r10, r1, r7
	smlad r10, r2, r6, r10
	smlad r10, r3, r5, r10
	smlsd r10, r4, r9, r10
	smulbt r9, r8, r12
	smlabb r8, r9, r12, r8
	smulbt r9, r10, r12
	smlabb r10, r9, r12, r10
	pkhtb r8, r10, r8, asr #16
	vmov r10, s12
	vmov r9, s13
	pkhbt r5, r11, r10, lsl #16
	pkhtb r10, r10, r11, asr #16
	pkhbt r11, r8, r9, lsl #16
	pkhtb r8, r9, r8, asr #16
	str.w r5, [r0, #180]
	str.w r10, [r0, #216]
	str.w r11, [r0, #252]
	str.w r8, [r0, #288]
	ldr.w r5, [r0, #468]
	ldr.w r6, [r0, #504]
	ldr.w r7, [r0, #540]
	ldr.w r8, [r0, #576]
	smuadx r9, r1, r5
	smuadx r10, r2, r8
	smladx r10, r3, r7, r10
	smladx r10, r4, r6, r10
	sub.w r9, r9, r10
	smuadx r10, r1, r6
	smladx r10, r2, r5, r10
	smuadx r11, r3, r8
	smladx r11, r4, r7, r11
	sub.w r10, r10, r11
	smulbt r11, r9, r12
	smlabb r9, r11, r12, r9
	smulbt r11, r10, r12
	smlabb r10, r11, r12, r10
	pkhtb r9, r10, r9, asr #16
	vmov s12, r9
	smuadx r9, r1, r7
	smladx r9, r2, r6, r9
	smladx r9, r3, r5, r9
	smuadx r10, r4, r8
	sub.w r9, r9, r10
	smuadx r10, r1, r8
	smladx r10, r2, r7, r10
	smladx r10, r3, r6, r10
	smladx r10, r4, r5, r10
	smulbt r11, r9, r12
	smlabb r9, r11, r12, r9
	smulbt r11, r10, r12
	smlabb r10, r11, r12, r10
	pkhtb r9, r10, r9, asr #16
	vmov s13, r9
	pkhbt r9, r5, r8
	pkhtb r5, r5, r6
	pkhtb r6, r6, r7
	pkhtb r7, r7, r8
	smusd r8, r1, r9
	smuad r10, r2, r7
	smlad r10, r3, r6, r10
	smlad r10, r4, r5, r10
	sub.w r8, r8, r10
	smuad r10, r1, r5
	smlsd r10, r2, r9, r10
	smuad r11, r3, r7
	smlad r11, r4, r6, r11
	sub.w r10, r10, r11
	smulbt r11, r8, r12
	smlabb r8, r11, r12, r8
	smulbt r11, r10, r12
	smlabb r10, r11, r12, r10
	pkhtb r11, r10, r8, asr #16
	smuad r8, r1, r6
	smlad r8, r2, r5, r8
	smlsd r8, r3, r9, r8
	smuad r10, r4, r7
	sub.w r8, r8, r10
	smuad r10, r1, r7
	smlad r10, r2, r6, r10
	smlad r10, r3, r5, r10
	smlsd r10, r4, r9, r10
	smulbt r9, r8, r12
	smlabb r8, r9, r12, r8
	smulbt r9, r10, r12
	smlabb r10, r9, r12, r10
	pkhtb r8, r10, r8, asr #16
	vmov r10, s12
	vmov r9, s13
	pkhbt r5, r11, r10, lsl #16
	pkhtb r10, r10, r11, asr #16
	pkhbt r11, r8, r9, lsl #16
	pkhtb r8, r9, r8, asr #16
	str.w r5, [r0, #468]
	str.w r10, [r0, #504]
	str.w r11, [r0, #540]
	str.w r8, [r0, #576]
    add.w r0, r0, #4
    cmp.w r0, lr
    bne.w iRader_iGood_part3

	vmov r0, s15 @ real output
	vmov r1, s0 @ buffer
	vmov r2, s1 @ input
	mov.w r3, #3459
	mov.w r4, #4591
	vmov r5, s2
	add.w lr, r0, #4
	
iRader_iGood_part4_0:
	ldr.w r6, [r2], #4
	smulbb r7, r3, r6
	smulbt r8, r3, r6
	smmulr r9, r7, r5
	mls r7, r9, r4, r7
	smmulr r9, r8, r5
	mls r8, r9, r4, r8
	pkhbt r6, r7, r8, lsl #16

	ldr.w r7, [r1, #36]
	ldr.w r8, [r1, #180]
	ldr.w r9, [r1, #324]
	ldr.w r10, [r1, #468]
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 1
	pkhtb r10, r7, r11, asr #16 @ 2
	pkhbt r11, r12, r8, lsl #16 @ 9
	pkhtb r12, r8, r12, asr #16 @ 10
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #180]
	str.w r10, [r0, #468]
	str.w r11, [r0, #432]
	str.w r12, [r0, #144]

	ldr.w r7, [r1, #72]
	ldr.w r8, [r1, #216]
	ldr.w r9, [r1, #360]
	ldr.w r10, [r1, #504]
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 3
	pkhtb r10, r7, r11, asr #16 @ 4
	pkhbt r11, r12, r8, lsl #16 @ 11
	pkhtb r12, r8, r12, asr #16 @ 12
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #360]
	str.w r10, [r0, #324]
	str.w r11, [r0, #252]
	str.w r12, [r0, #288]

	ldr.w r7, [r1, #108]
	ldr.w r8, [r1, #252]
	ldr.w r9, [r1, #396]
	ldr.w r10, [r1, #540]
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 5
	pkhtb r10, r7, r11, asr #16 @ 6
	pkhbt r11, r12, r8, lsl #16 @ 13
	pkhtb r12, r8, r12, asr #16 @ 14
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #108]
	str.w r10, [r0, #36]
	str.w r11, [r0, #504]
	str.w r12, [r0, #576]

	ldr.w r7, [r1, #144]
	ldr.w r8, [r1, #288]
	ldr.w r9, [r1, #432]
	ldr.w r10, [r1, #576]
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 7
	pkhtb r10, r7, r11, asr #16 @ 8
	pkhbt r11, r12, r8, lsl #16 @ 15
	pkhtb r12, r8, r12, asr #16 @ 16
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #216]
	str.w r10, [r0, #72]
	str.w r11, [r0, #396]
	str.w r12, [r0, #540]

	ldr.w r9, [r1], #4
	smulbb r10, r3, r9
	smulbt r11, r3, r9
	smmulr r12, r10, r5
	mls r10, r12, r4, r10
	smmulr r12, r11, r5
	mls r11, r12, r4, r11
	pkhbt r9, r10, r11, lsl #16
	str.w r9, [r0], #4
	cmp.w r0, lr
	bne.w iRader_iGood_part4_0
	vmov r0, s15
iRader_iGood_part4_1:
	ldr.w r6, [r2], #4
	smulbb r7, r3, r6
	smulbt r8, r3, r6
	smmulr r9, r7, r5
	mls r7, r9, r4, r7
	smmulr r9, r8, r5
	mls r8, r9, r4, r8
	pkhbt r6, r7, r8, lsl #16

	ldr.w r7, [r1, #36]
	ldr.w r8, [r1, #180]
	ldr.w r9, [r1, #324]
	ldr.w r10, [r1, #468]
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 1
	pkhtb r10, r7, r11, asr #16 @ 2
	pkhbt r11, r12, r8, lsl #16 @ 9
	pkhtb r12, r8, r12, asr #16 @ 10
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #112]
	str.w r10, [r0, #400]
	str.w r11, [r0, #364]
	str.w r12, [r0, #76]

	ldr.w r7, [r1, #72]
	ldr.w r8, [r1, #216]
	ldr.w r9, [r1, #360]
	ldr.w r10, [r1, #504]
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 3
	pkhtb r10, r7, r11, asr #16 @ 4
	pkhbt r11, r12, r8, lsl #16 @ 11
	pkhtb r12, r8, r12, asr #16 @ 12
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #292]
	str.w r10, [r0, #256]
	str.w r11, [r0, #184]
	str.w r12, [r0, #220]

	ldr.w r7, [r1, #108]
	ldr.w r8, [r1, #252]
	ldr.w r9, [r1, #396]
	ldr.w r10, [r1, #540]
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 5
	pkhtb r10, r7, r11, asr #16 @ 6
	pkhbt r11, r12, r8, lsl #16 @ 13
	pkhtb r12, r8, r12, asr #16 @ 14
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #40]
	str.w r10, [r0, #580]
	str.w r11, [r0, #436]
	str.w r12, [r0, #508]

	ldr.w r7, [r1, #144]
	ldr.w r8, [r1, #288]
	ldr.w r9, [r1, #432]
	ldr.w r10, [r1, #576]
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 7
	pkhtb r10, r7, r11, asr #16 @ 8
	pkhbt r11, r12, r8, lsl #16 @ 15
	pkhtb r12, r8, r12, asr #16 @ 16
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #148]
	str.w r10, [r0, #4]
	str.w r11, [r0, #328]
	str.w r12, [r0, #472]

	ldr.w r9, [r1], #4
	smulbb r10, r3, r9
	smulbt r11, r3, r9
	smmulr r12, r10, r5
	mls r10, r12, r4, r10
	smmulr r12, r11, r5
	mls r11, r12, r4, r11
	pkhbt r9, r10, r11, lsl #16
	str.w r9, [r0, #544]
	add.w r0, r0, #4
	cmp.w r0, lr
	bne.w iRader_iGood_part4_1
	vmov r0, s15
iRader_iGood_part4_2:
	ldr.w r6, [r2], #4
	smulbb r7, r3, r6
	smulbt r8, r3, r6
	smmulr r9, r7, r5
	mls r7, r9, r4, r7
	smmulr r9, r8, r5
	mls r8, r9, r4, r8
	pkhbt r6, r7, r8, lsl #16

	ldr.w r7, [r1, #36]
	ldr.w r8, [r1, #180]
	ldr.w r9, [r1, #324]
	ldr.w r10, [r1, #468]
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 1
	pkhtb r10, r7, r11, asr #16 @ 2
	pkhbt r11, r12, r8, lsl #16 @ 9
	pkhtb r12, r8, r12, asr #16 @ 10
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #44]
	str.w r10, [r0, #332]
	str.w r11, [r0, #296]
	str.w r12, [r0, #8]

	ldr.w r7, [r1, #72]
	ldr.w r8, [r1, #216]
	ldr.w r9, [r1, #360]
	ldr.w r10, [r1, #504]
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 3
	pkhtb r10, r7, r11, asr #16 @ 4
	pkhbt r11, r12, r8, lsl #16 @ 11
	pkhtb r12, r8, r12, asr #16 @ 12
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #224]
	str.w r10, [r0, #188]
	str.w r11, [r0, #116]
	str.w r12, [r0, #152]

	ldr.w r7, [r1, #108]
	ldr.w r8, [r1, #252]
	ldr.w r9, [r1, #396]
	ldr.w r10, [r1, #540]
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 5
	pkhtb r10, r7, r11, asr #16 @ 6
	pkhbt r11, r12, r8, lsl #16 @ 13
	pkhtb r12, r8, r12, asr #16 @ 14
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #584]
	str.w r10, [r0, #512]
	str.w r11, [r0, #368]
	str.w r12, [r0, #440]

	ldr.w r7, [r1, #144]
	ldr.w r8, [r1, #288]
	ldr.w r9, [r1, #432]
	ldr.w r10, [r1, #576]
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 7
	pkhtb r10, r7, r11, asr #16 @ 8
	pkhbt r11, r12, r8, lsl #16 @ 15
	pkhtb r12, r8, r12, asr #16 @ 16
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #80]
	str.w r10, [r0, #548]
	str.w r11, [r0, #260]
	str.w r12, [r0, #404]

	ldr.w r9, [r1], #4
	smulbb r10, r3, r9
	smulbt r11, r3, r9
	smmulr r12, r10, r5
	mls r10, r12, r4, r10
	smmulr r12, r11, r5
	mls r11, r12, r4, r11
	pkhbt r9, r10, r11, lsl #16
	str.w r9, [r0, #476]
	add.w r0, r0, #4
	cmp.w r0, lr
	bne.w iRader_iGood_part4_2
	vmov r0, s15
iRader_iGood_part4_3:
	ldr.w r6, [r2], #4
	smulbb r7, r3, r6
	smulbt r8, r3, r6
	smmulr r9, r7, r5
	mls r7, r9, r4, r7
	smmulr r9, r8, r5
	mls r8, r9, r4, r8
	pkhbt r6, r7, r8, lsl #16

	ldr.w r7, [r1, #36]
	ldr.w r8, [r1, #180]
	ldr.w r9, [r1, #324]
	ldr.w r10, [r1, #468]
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 1
	pkhtb r10, r7, r11, asr #16 @ 2
	pkhbt r11, r12, r8, lsl #16 @ 9
	pkhtb r12, r8, r12, asr #16 @ 10
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #588]
	str.w r10, [r0, #264]
	str.w r11, [r0, #228]
	str.w r12, [r0, #552]

	ldr.w r7, [r1, #72]
	ldr.w r8, [r1, #216]
	ldr.w r9, [r1, #360]
	ldr.w r10, [r1, #504]
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 3
	pkhtb r10, r7, r11, asr #16 @ 4
	pkhbt r11, r12, r8, lsl #16 @ 11
	pkhtb r12, r8, r12, asr #16 @ 12
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #156]
	str.w r10, [r0, #120]
	str.w r11, [r0, #48]
	str.w r12, [r0, #84]

	ldr.w r7, [r1, #108]
	ldr.w r8, [r1, #252]
	ldr.w r9, [r1, #396]
	ldr.w r10, [r1, #540]
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 5
	pkhtb r10, r7, r11, asr #16 @ 6
	pkhbt r11, r12, r8, lsl #16 @ 13
	pkhtb r12, r8, r12, asr #16 @ 14
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #516]
	str.w r10, [r0, #444]
	str.w r11, [r0, #300]
	str.w r12, [r0, #372]

	ldr.w r7, [r1, #144]
	ldr.w r8, [r1, #288]
	ldr.w r9, [r1, #432]
	ldr.w r10, [r1, #576]
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 7
	pkhtb r10, r7, r11, asr #16 @ 8
	pkhbt r11, r12, r8, lsl #16 @ 15
	pkhtb r12, r8, r12, asr #16 @ 16
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #12]
	str.w r10, [r0, #480]
	str.w r11, [r0, #192]
	str.w r12, [r0, #336]

	ldr.w r9, [r1], #4
	smulbb r10, r3, r9
	smulbt r11, r3, r9
	smmulr r12, r10, r5
	mls r10, r12, r4, r10
	smmulr r12, r11, r5
	mls r11, r12, r4, r11
	pkhbt r9, r10, r11, lsl #16
	str.w r9, [r0, #408]
	add.w r0, r0, #4
	cmp.w r0, lr
	bne.w iRader_iGood_part4_3
	vmov r0, s15
iRader_iGood_part4_4:
	ldr.w r6, [r2], #4
	smulbb r7, r3, r6
	smulbt r8, r3, r6
	smmulr r9, r7, r5
	mls r7, r9, r4, r7
	smmulr r9, r8, r5
	mls r8, r9, r4, r8
	pkhbt r6, r7, r8, lsl #16

	ldr.w r7, [r1, #36]
	ldr.w r8, [r1, #180]
	ldr.w r9, [r1, #324]
	ldr.w r10, [r1, #468]
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 1
	pkhtb r10, r7, r11, asr #16 @ 2
	pkhbt r11, r12, r8, lsl #16 @ 9
	pkhtb r12, r8, r12, asr #16 @ 10
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #520]
	str.w r10, [r0, #196]
	str.w r11, [r0, #160]
	str.w r12, [r0, #484]

	ldr.w r7, [r1, #72]
	ldr.w r8, [r1, #216]
	ldr.w r9, [r1, #360]
	ldr.w r10, [r1, #504]
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 3
	pkhtb r10, r7, r11, asr #16 @ 4
	pkhbt r11, r12, r8, lsl #16 @ 11
	pkhtb r12, r8, r12, asr #16 @ 12
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #88]
	str.w r10, [r0, #52]
	str.w r11, [r0, #592]
	str.w r12, [r0, #16]

	ldr.w r7, [r1, #108]
	ldr.w r8, [r1, #252]
	ldr.w r9, [r1, #396]
	ldr.w r10, [r1, #540]
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 5
	pkhtb r10, r7, r11, asr #16 @ 6
	pkhbt r11, r12, r8, lsl #16 @ 13
	pkhtb r12, r8, r12, asr #16 @ 14
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #448]
	str.w r10, [r0, #376]
	str.w r11, [r0, #232]
	str.w r12, [r0, #304]

	ldr.w r7, [r1, #144]
	ldr.w r8, [r1, #288]
	ldr.w r9, [r1, #432]
	ldr.w r10, [r1, #576]
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 7
	pkhtb r10, r7, r11, asr #16 @ 8
	pkhbt r11, r12, r8, lsl #16 @ 15
	pkhtb r12, r8, r12, asr #16 @ 16
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #556]
	str.w r10, [r0, #412]
	str.w r11, [r0, #124]
	str.w r12, [r0, #268]

	ldr.w r9, [r1], #4
	smulbb r10, r3, r9
	smulbt r11, r3, r9
	smmulr r12, r10, r5
	mls r10, r12, r4, r10
	smmulr r12, r11, r5
	mls r11, r12, r4, r11
	pkhbt r9, r10, r11, lsl #16
	str.w r9, [r0, #340]
	add.w r0, r0, #4
	cmp.w r0, lr
	bne.w iRader_iGood_part4_4
	vmov r0, s15
iRader_iGood_part4_5:
	ldr.w r6, [r2], #4
	smulbb r7, r3, r6
	smulbt r8, r3, r6
	smmulr r9, r7, r5
	mls r7, r9, r4, r7
	smmulr r9, r8, r5
	mls r8, r9, r4, r8
	pkhbt r6, r7, r8, lsl #16

	ldr.w r7, [r1, #36]
	ldr.w r8, [r1, #180]
	ldr.w r9, [r1, #324]
	ldr.w r10, [r1, #468]
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 1
	pkhtb r10, r7, r11, asr #16 @ 2
	pkhbt r11, r12, r8, lsl #16 @ 9
	pkhtb r12, r8, r12, asr #16 @ 10
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #452]
	str.w r10, [r0, #128]
	str.w r11, [r0, #92]
	str.w r12, [r0, #416]

	ldr.w r7, [r1, #72]
	ldr.w r8, [r1, #216]
	ldr.w r9, [r1, #360]
	ldr.w r10, [r1, #504]
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 3
	pkhtb r10, r7, r11, asr #16 @ 4
	pkhbt r11, r12, r8, lsl #16 @ 11
	pkhtb r12, r8, r12, asr #16 @ 12
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #20]
	str.w r10, [r0, #596]
	str.w r11, [r0, #524]
	str.w r12, [r0, #560]

	ldr.w r7, [r1, #108]
	ldr.w r8, [r1, #252]
	ldr.w r9, [r1, #396]
	ldr.w r10, [r1, #540]
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 5
	pkhtb r10, r7, r11, asr #16 @ 6
	pkhbt r11, r12, r8, lsl #16 @ 13
	pkhtb r12, r8, r12, asr #16 @ 14
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #380]
	str.w r10, [r0, #308]
	str.w r11, [r0, #164]
	str.w r12, [r0, #236]

	ldr.w r7, [r1, #144]
	ldr.w r8, [r1, #288]
	ldr.w r9, [r1, #432]
	ldr.w r10, [r1, #576]
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 7
	pkhtb r10, r7, r11, asr #16 @ 8
	pkhbt r11, r12, r8, lsl #16 @ 15
	pkhtb r12, r8, r12, asr #16 @ 16
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #488]
	str.w r10, [r0, #344]
	str.w r11, [r0, #56]
	str.w r12, [r0, #200]

	ldr.w r9, [r1], #4
	smulbb r10, r3, r9
	smulbt r11, r3, r9
	smmulr r12, r10, r5
	mls r10, r12, r4, r10
	smmulr r12, r11, r5
	mls r11, r12, r4, r11
	pkhbt r9, r10, r11, lsl #16
	str.w r9, [r0, #272]
	add.w r0, r0, #4
	cmp.w r0, lr
	bne.w iRader_iGood_part4_5
	vmov r0, s15
iRader_iGood_part4_6:
	ldr.w r6, [r2], #4
	smulbb r7, r3, r6
	smulbt r8, r3, r6
	smmulr r9, r7, r5
	mls r7, r9, r4, r7
	smmulr r9, r8, r5
	mls r8, r9, r4, r8
	pkhbt r6, r7, r8, lsl #16

	ldr.w r7, [r1, #36]
	ldr.w r8, [r1, #180]
	ldr.w r9, [r1, #324]
	ldr.w r10, [r1, #468]
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 1
	pkhtb r10, r7, r11, asr #16 @ 2
	pkhbt r11, r12, r8, lsl #16 @ 9
	pkhtb r12, r8, r12, asr #16 @ 10
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #384]
	str.w r10, [r0, #60]
	str.w r11, [r0, #24]
	str.w r12, [r0, #348]

	ldr.w r7, [r1, #72]
	ldr.w r8, [r1, #216]
	ldr.w r9, [r1, #360]
	ldr.w r10, [r1, #504]
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 3
	pkhtb r10, r7, r11, asr #16 @ 4
	pkhbt r11, r12, r8, lsl #16 @ 11
	pkhtb r12, r8, r12, asr #16 @ 12
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #564]
	str.w r10, [r0, #528]
	str.w r11, [r0, #456]
	str.w r12, [r0, #492]

	ldr.w r7, [r1, #108]
	ldr.w r8, [r1, #252]
	ldr.w r9, [r1, #396]
	ldr.w r10, [r1, #540]
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 5
	pkhtb r10, r7, r11, asr #16 @ 6
	pkhbt r11, r12, r8, lsl #16 @ 13
	pkhtb r12, r8, r12, asr #16 @ 14
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #312]
	str.w r10, [r0, #240]
	str.w r11, [r0, #96]
	str.w r12, [r0, #168]

	ldr.w r7, [r1, #144]
	ldr.w r8, [r1, #288]
	ldr.w r9, [r1, #432]
	ldr.w r10, [r1, #576]
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 7
	pkhtb r10, r7, r11, asr #16 @ 8
	pkhbt r11, r12, r8, lsl #16 @ 15
	pkhtb r12, r8, r12, asr #16 @ 16
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #420]
	str.w r10, [r0, #276]
	str.w r11, [r0, #600]
	str.w r12, [r0, #132]

	ldr.w r9, [r1], #4
	smulbb r10, r3, r9
	smulbt r11, r3, r9
	smmulr r12, r10, r5
	mls r10, r12, r4, r10
	smmulr r12, r11, r5
	mls r11, r12, r4, r11
	pkhbt r9, r10, r11, lsl #16
	str.w r9, [r0, #204]
	add.w r0, r0, #4
	cmp.w r0, lr
	bne.w iRader_iGood_part4_6
	vmov r0, s15
iRader_iGood_part4_7:
	ldr.w r6, [r2], #4
	smulbb r7, r3, r6
	smulbt r8, r3, r6
	smmulr r9, r7, r5
	mls r7, r9, r4, r7
	smmulr r9, r8, r5
	mls r8, r9, r4, r8
	pkhbt r6, r7, r8, lsl #16

	ldr.w r7, [r1, #36]
	ldr.w r8, [r1, #180]
	ldr.w r9, [r1, #324]
	ldr.w r10, [r1, #468]
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 1
	pkhtb r10, r7, r11, asr #16 @ 2
	pkhbt r11, r12, r8, lsl #16 @ 9
	pkhtb r12, r8, r12, asr #16 @ 10
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #316]
	str.w r10, [r0, #604]
	str.w r11, [r0, #568]
	str.w r12, [r0, #280]

	ldr.w r7, [r1, #72]
	ldr.w r8, [r1, #216]
	ldr.w r9, [r1, #360]
	ldr.w r10, [r1, #504]
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 3
	pkhtb r10, r7, r11, asr #16 @ 4
	pkhbt r11, r12, r8, lsl #16 @ 11
	pkhtb r12, r8, r12, asr #16 @ 12
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #496]
	str.w r10, [r0, #460]
	str.w r11, [r0, #388]
	str.w r12, [r0, #424]

	ldr.w r7, [r1, #108]
	ldr.w r8, [r1, #252]
	ldr.w r9, [r1, #396]
	ldr.w r10, [r1, #540]
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 5
	pkhtb r10, r7, r11, asr #16 @ 6
	pkhbt r11, r12, r8, lsl #16 @ 13
	pkhtb r12, r8, r12, asr #16 @ 14
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #244]
	str.w r10, [r0, #172]
	str.w r11, [r0, #28]
	str.w r12, [r0, #100]

	ldr.w r7, [r1, #144]
	ldr.w r8, [r1, #288]
	ldr.w r9, [r1, #432]
	ldr.w r10, [r1, #576]
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 7
	pkhtb r10, r7, r11, asr #16 @ 8
	pkhbt r11, r12, r8, lsl #16 @ 15
	pkhtb r12, r8, r12, asr #16 @ 16
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #352]
	str.w r10, [r0, #208]
	str.w r11, [r0, #532]
	str.w r12, [r0, #64]

	ldr.w r9, [r1], #4
	smulbb r10, r3, r9
	smulbt r11, r3, r9
	smmulr r12, r10, r5
	mls r10, r12, r4, r10
	smmulr r12, r11, r5
	mls r11, r12, r4, r11
	pkhbt r9, r10, r11, lsl #16
	str.w r9, [r0, #136]
	add.w r0, r0, #4
	cmp.w r0, lr
	bne.w iRader_iGood_part4_7
	vmov r0, s15
iRader_iGood_part4_8:
	ldr.w r6, [r2], #4
	smulbb r7, r3, r6
	smulbt r8, r3, r6
	smmulr r9, r7, r5
	mls r7, r9, r4, r7
	smmulr r9, r8, r5
	mls r8, r9, r4, r8
	pkhbt r6, r7, r8, lsl #16

	ldr.w r7, [r1, #36]
	ldr.w r8, [r1, #180]
	ldr.w r9, [r1, #324]
	ldr.w r10, [r1, #468]
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 1
	pkhtb r10, r7, r11, asr #16 @ 2
	pkhbt r11, r12, r8, lsl #16 @ 9
	pkhtb r12, r8, r12, asr #16 @ 10
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #248]
	str.w r10, [r0, #536]
	str.w r11, [r0, #500]
	str.w r12, [r0, #212]

	ldr.w r7, [r1, #72]
	ldr.w r8, [r1, #216]
	ldr.w r9, [r1, #360]
	ldr.w r10, [r1, #504]
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 3
	pkhtb r10, r7, r11, asr #16 @ 4
	pkhbt r11, r12, r8, lsl #16 @ 11
	pkhtb r12, r8, r12, asr #16 @ 12
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #428]
	str.w r10, [r0, #392]
	str.w r11, [r0, #320]
	str.w r12, [r0, #356]

	ldr.w r7, [r1, #108]
	ldr.w r8, [r1, #252]
	ldr.w r9, [r1, #396]
	ldr.w r10, [r1, #540]
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 5
	pkhtb r10, r7, r11, asr #16 @ 6
	pkhbt r11, r12, r8, lsl #16 @ 13
	pkhtb r12, r8, r12, asr #16 @ 14
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #176]
	str.w r10, [r0, #104]
	str.w r11, [r0, #572]
	str.w r12, [r0, #32]

	ldr.w r7, [r1, #144]
	ldr.w r8, [r1, #288]
	ldr.w r9, [r1, #432]
	ldr.w r10, [r1, #576]
	sadd16 r11, r7, r8
	ssub16 r12, r7, r8
	sadd16 r7, r9, r10
	ssub16 r8, r9, r10
	pkhbt r9, r11, r7, lsl #16 @ 7
	pkhtb r10, r7, r11, asr #16 @ 8
	pkhbt r11, r12, r8, lsl #16 @ 15
	pkhtb r12, r8, r12, asr #16 @ 16
	sadd16 r9, r9, r6
	sadd16 r10, r10, r6
	sadd16 r11, r11, r6
	sadd16 r12, r12, r6
	str.w r9, [r0, #284]
	str.w r10, [r0, #140]
	str.w r11, [r0, #464]
	str.w r12, [r0, #608]

	ldr.w r9, [r1], #4
	smulbb r10, r3, r9
	smulbt r11, r3, r9
	smmulr r12, r10, r5
	mls r10, r12, r4, r10
	smmulr r12, r11, r5
	mls r11, r12, r4, r11
	pkhbt r9, r10, r11, lsl #16
	str.w r9, [r0, #68]
	add.w r0, r0, #4
	cmp.w r0, lr
	bne.w iRader_iGood_part4_8
	add.w sp, sp, #612
	pop.w {r2-r12, pc}






















































































































































































