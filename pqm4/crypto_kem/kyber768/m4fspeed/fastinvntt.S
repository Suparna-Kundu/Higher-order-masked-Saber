#include "macros.i"

.syntax unified
.cpu cortex-m4
.thumb

.macro mul_twiddle tb, a, twiddle, tmp, tmp2, q, qinv
  smulb\tb \tmp, \a, \twiddle
  smult\tb \a, \a, \twiddle
  montgomery \q, \qinv, \tmp, \tmp2 // reduce -> result in tmp2
  montgomery \q, \qinv, \a, \tmp // reduce -> result in tmp
  pkhtb \a, \tmp, \tmp2, asr#16 // combine results from above in one register as 16-bit halves
.endm

.macro doublebutterfly_light a0, a1, tmp, tmp2, q, qinv
  uadd16 \tmp, \a0, \a1
  usub16 \a1, \a0, \a1
  mov.w \a0, \tmp
.endm

.macro two_doublebutterfly_light a0, a1, a2, a3, tmp, tmp2, q, qinv
  doublebutterfly_light \a0, \a1, \tmp, \tmp2, \q, \qinv
  doublebutterfly_light \a2, \a3, \tmp, \tmp2, \q, \qinv
.endm

.macro doublebutterfly tb, a0, a1, twiddle, tmp, tmp2, q, qinv
  smulb\tb \tmp, \a1, \twiddle // a1_b * twiddle_tb
  smult\tb \a1, \a1, \twiddle // a1_t * twiddle_tb
  montgomery \q, \qinv, \tmp, \tmp2 // reduce -> result in tmp2
  montgomery \q, \qinv, \a1, \tmp // reduce -> result in tmp
  pkhtb \tmp2, \tmp, \tmp2, asr#16 // combine results from above in one register as 16-bit halves
  usub16 \a1, \a0, \tmp2 // a0 - a1 * twiddle (a0, a1 contain 2 coeffs)
  uadd16 \a0, \a0, \tmp2 // a0 + a1 * twiddle (a0, a1 contain 2 coeffs)
.endm

.macro two_doublebutterfly tb1, tb2, a0, a1, a2, a3, twiddle, tmp, tmp2, q, qinv
  doublebutterfly \tb1, \a0, \a1, \twiddle, \tmp, \tmp2, \q, \qinv
  doublebutterfly \tb2, \a2, \a3, \twiddle, \tmp, \tmp2, \q, \qinv
.endm

.macro half_barrett poly0, poly1, poly2, poly3, barrettconst, barrettconst2, tmp, tmp2, q
  doublebarrett_fast \poly0, \tmp, \tmp2, \q, \barrettconst, \barrettconst2
  doublebarrett_fast \poly1, \tmp, \tmp2, \q, \barrettconst, \barrettconst2
  doublebarrett_fast \poly2, \tmp, \tmp2, \q, \barrettconst, \barrettconst2
  doublebarrett_fast \poly3, \tmp, \tmp2, \q, \barrettconst, \barrettconst2
.endm

.macro _3_layer_double_inv_CT_16_light c0, c1, c2, c3, c4, c5, c6, c7, xi0, xi12, xi34, xi56, twiddle, q, qinv, tmp, tmp2

  // layer 1  
  sadd16.w \tmp, \c0, \c1 // c0, c1
  ssub16.w \c1, \c0, \c1
  sadd16.w \tmp2, \c2, \c3 // c2, c3
  ssub16.w \c3, \c2, \c3

  sadd16.w \c0, \c4, \c5 // c4, c5
  ssub16.w \c5, \c4, \c5
  sadd16.w \c2, \c6, \c7 // c6, c7
  ssub16.w \c7, \c6, \c7
  // c4, c6 are free at this point

  // layer 2
  sadd16.w \c6, \tmp, \tmp2 // c0, c2
  ssub16.w \tmp2, \tmp, \tmp2
  sadd16.w \c4, \c0, \c2 // c4, c6
  ssub16.w \c2, \c0, \c2

  vmov.w \twiddle, \xi12
  doublebutterfly t, \c1, \c3, \twiddle, \tmp, \c0, \q, \qinv // c0 has been used and c6 still free
  doublebutterfly t, \c5, \c7, \twiddle, \tmp, \c0, \q, \qinv 
  // c0, c6 are free at this point
  
  // layer 3
  sadd16.w \c0, \c6, \c4 // c0, c4
  ssub16.w \c4, \c6, \c4

  vmov.w \twiddle, \xi34
  doublebutterfly t, \c1, \c5, \twiddle, \tmp, \c6, \q, \qinv

  vmov.w \twiddle, \xi56
  // this block is one doublebutterfly
  smulbb \tmp, \c2, \twiddle // c2, c6
  smultb \c2, \c2, \twiddle
  montgomery_inplace \q, \qinv, \tmp, \c6
  montgomery_inplace \q, \qinv, \c2, \c6
  pkhtb \tmp, \c2, \tmp, asr #16
  ssub16.w \c6, \tmp2, \tmp 
  sadd16.w \c2, \tmp2, \tmp

  doublebutterfly t, \c3, \c7, \twiddle, \tmp, \tmp2, \q, \qinv
.endm

.macro _3_layer_double_inv_CT_16 c0, c1, c2, c3, c4, c5, c6, c7, twiddle, twiddle_ptr, Qprime, Q, tmp, tmp2
    // layer 3
    ldrh.w twiddle, [twiddle_ptr], #2
    two_doublebutterfly b, b, \c0, \c1, \c2, \c3, \twiddle, \tmp, \tmp2, \Q, \Qprime
    two_doublebutterfly b, b, \c4, \c5, \c6, \c7, \twiddle, \tmp, \tmp2, \Q, \Qprime

    // layer 2
    ldr.w twiddle, [twiddle_ptr], #4
    two_doublebutterfly b, t, \c0, \c2, \c1, \c3, \twiddle, \tmp, \tmp2, \Q, \Qprime

    two_doublebutterfly b, t, \c4, \c6, \c5, \c7, \twiddle, \tmp, \tmp2, \Q, \Qprime

    // layer 1
    ldr.w twiddle, [twiddle_ptr], #4
    two_doublebutterfly b, t, \c0, \c4, \c1, \c5, \twiddle, \tmp, \tmp2, \Q, \Qprime

    ldr.w twiddle, [twiddle_ptr], #4
    two_doublebutterfly b, t, \c2, \c6, \c3, \c7, \twiddle, \tmp, \tmp2, \Q, \Qprime
.endm

.macro _3_layer_double_inv_twist_16 c0, c1, c2, c3, c4, c5, c6, c7, twiddle, twiddle_ptr, Qprime, Q, tmp, tmp2
    ldr.w \twiddle, [\twiddle_ptr], #4
    mul_twiddle b, \c0, \twiddle, \tmp, \tmp2, \Q, \Qprime
    mul_twiddle t, \c1, \twiddle, \tmp, \tmp2, \Q, \Qprime
    ldr.w \twiddle, [\twiddle_ptr], #4
    mul_twiddle b, \c2, \twiddle, \tmp, \tmp2, \Q, \Qprime
    mul_twiddle t, \c3, \twiddle, \tmp, \tmp2, \Q, \Qprime
    ldr.w \twiddle, [\twiddle_ptr], #4
    mul_twiddle b, \c4, \twiddle, \tmp, \tmp2, \Q, \Qprime
    mul_twiddle t, \c5, \twiddle, \tmp, \tmp2, \Q, \Qprime
    ldr.w \twiddle, [\twiddle_ptr], #4
    mul_twiddle b, \c6, \twiddle, \tmp, \tmp2, \Q, \Qprime
    mul_twiddle t, \c7, \twiddle, \tmp, \tmp2, \Q, \Qprime
.endm

.global invntt_fast
.type invntt_fast, %function
.align 2
invntt_fast:
  push {r4-r11, r14}

  poly         .req r0
  twiddle_ptr  .req r1
  poly0        .req r2
  poly1        .req r3
  poly2        .req r4
  poly3        .req r5
  poly4        .req r6
  poly5        .req r7
  poly6        .req r8
  poly7        .req r9
  twiddle      .req r10
  barrettconst .req r10
  qinv         .req r11
  q            .req r11
  tmp          .req r12
  tmp2         .req r14

  movw q, #3329
  movt qinv, #3327
  
  // barrettconst = -(2^(32)/KYBER_Q)
  movw barrettconst, #0x5049
  movt barrettconst, #0xffec
  vmov s10, barrettconst

  // barrettconst2 = 2^(15)
  movw barrettconst, #32768
  vmov s11, barrettconst

  ### LAYER 7+6+5+4
  .equ distance, 16
  .equ offset, 32
  .equ strincr, 64

  // pre-load twiddle factors to FPU registers
  vldm twiddle_ptr!, {s20-s27}

  add.w tmp, poly, #8*strincr
  vmov s12, tmp
  1:
    // load a1, a3, ..., a15
    load poly, poly0, poly1, poly2, poly3, #offset, #distance/4+offset, #2*distance/4+offset, #3*distance/4+offset
    load poly, poly4, poly5, poly6, poly7, #distance+offset, #5*distance/4+offset, #6*distance/4+offset, #7*distance/4+offset
    
    // NTT on a1, a3, ..., a15   
    _3_layer_double_inv_CT_16_light poly0, poly1, poly2, poly3, poly4, poly5, poly6, poly7, s20, s21, s22, s23, twiddle, q, qinv, tmp, tmp2

    // multiply coeffs by layer 4 twiddles for later use
    vmov twiddle, s24 
    mul_twiddle b, poly0, twiddle, tmp, tmp2, q, qinv // could be omitted but kept for reduction only
    mul_twiddle t, poly1, twiddle, tmp, tmp2, q, qinv

    vmov twiddle, s25
    mul_twiddle b, poly2, twiddle, tmp, tmp2, q, qinv
    mul_twiddle t, poly3, twiddle, tmp, tmp2, q, qinv

    vmov twiddle, s26
    mul_twiddle b, poly4, twiddle, tmp, tmp2, q, qinv
    mul_twiddle t, poly5, twiddle, tmp, tmp2, q, qinv

    vmov twiddle, s27
    mul_twiddle b, poly6, twiddle, tmp, tmp2, q, qinv
    mul_twiddle t, poly7, twiddle, tmp, tmp2, q, qinv

    vmov s0, poly0 // a1
    vmov s1, poly1 // a3
    vmov s2, poly2 // a5
    vmov s3, poly3 // a7
    vmov s4, poly4 // a9
    vmov s5, poly5 // a11
    vmov s6, poly6 // a13
    vmov s7, poly7 // a15
    
    // ----------

    // load a0, a2, ..., a14
    load poly, poly0, poly1, poly2, poly3, #0, #distance/4, #2*distance/4, #3*distance/4
    load poly, poly4, poly5, poly6, poly7, #distance, #5*distance/4, #6*distance/4, #7*distance/4
    
    // NTT on a0, a2, ..., a14
    _3_layer_double_inv_CT_16_light poly0, poly1, poly2, poly3, poly4, poly5, poly6, poly7, s20, s21, s22, s23, twiddle, q, qinv, tmp, tmp2

    // layer 4 - 1
    // addsub: (a2, a6, a10, a14), (a3, a7, a11, a15)
    vmov tmp2, s1 // load a3
    uadd16 tmp, poly1, tmp2
    usub16 poly1, poly1, tmp2
    str.w tmp, [poly, #1*distance/4]
    str.w poly1, [poly, #1*distance/4+offset]

    vmov tmp2, s3 // load a7
    uadd16 tmp, poly3, tmp2
    usub16 poly3, poly3, tmp2
    str.w tmp, [poly, #3*distance/4]
    str.w poly3, [poly, #3*distance/4+offset]
    
    vmov tmp2, s5 // load a11
    uadd16 tmp, poly5, tmp2
    usub16 poly5, poly5, tmp2
    str.w tmp, [poly, #5*distance/4]
    str.w poly5, [poly, #5*distance/4+offset]
    
    vmov tmp2, s7 // load a15
    uadd16 tmp, poly7, tmp2
    usub16 poly7, poly7, tmp2
    str.w tmp, [poly, #7*distance/4]
    str.w poly7, [poly, #7*distance/4+offset]
    
    // layer 4 - 2    
    // addsub: (a0, a4, a8, a12), (a1, a5, a9, a13)
    vmov poly3, s2 // load a5
    uadd16 tmp, poly2, poly3
    usub16 tmp2, poly2, poly3
    str.w tmp, [poly, #2*distance/4]
    str.w tmp2, [poly, #2*distance/4+offset]

    vmov poly5, s4 // load a9
    uadd16 tmp, poly4, poly5
    usub16 tmp2, poly4, poly5
    str.w tmp, [poly, #4*distance/4]
    str.w tmp2, [poly, #4*distance/4+offset]

    vmov poly7, s6 // load a13
    uadd16 tmp, poly6, poly7
    usub16 tmp2, poly6, poly7
    str.w tmp, [poly, #6*distance/4]
    str.w tmp2, [poly, #6*distance/4+offset]
    
    vmov poly1, s0 // load a1
    uadd16 tmp, poly0, poly1
    usub16 tmp2, poly0, poly1
    str.w tmp2, [poly, #offset]    
    str.w tmp, [poly], #strincr // increase 2*8*4 = 64 (2 * 8 loads of 4 bytes each)

    vmov tmp, s12
    cmp.w poly, tmp
  bne.w 1b

  sub.w poly, #8*strincr  

  ### LAYER 3+2+1
  .equ distance, distance*16
  .equ strincr, 4

  // ITER 0
  load poly, poly0, poly1, poly2, poly3, #0, #distance/4, #2*distance/4, #3*distance/4
  load poly, poly4, poly5, poly6, poly7, #distance, #5*distance/4, #6*distance/4, #7*distance/4

  vmov barrettconst, s10
  vmov s2, poly
  vmov poly, s11
  half_barrett poly0, poly1, poly2, poly3, barrettconst, poly, tmp, tmp2, q
  half_barrett poly4, poly5, poly6, poly7, barrettconst, poly, tmp, tmp2, q
  vmov poly, s2
  vldm twiddle_ptr!, {s21-s23}

  _3_layer_double_inv_CT_16_light poly0, poly1, poly2, poly3, poly4, poly5, poly6, poly7, s20, s21, s22, s23, twiddle, q, qinv, tmp, tmp2

  // twisting
  _3_layer_double_inv_twist_16 poly0, poly1, poly2, poly3, poly4, poly5, poly6, poly7, twiddle, twiddle_ptr, qinv, q, tmp, tmp2
  
  store poly, poly4, poly5, poly6, poly7, #distance, #5*distance/4, #6*distance/4, #7*distance/4
  str.w poly1, [poly, #distance/4]
  str.w poly2, [poly, #2*distance/4]
  str.w poly3, [poly, #3*distance/4]
  str.w poly0, [poly], #4

  // ITER 1-12
  add.w tmp, poly, #strincr*3*(3+1)
  vmov s14, tmp
  3:
    add.w tmp, poly, #strincr*3
    vmov s13, tmp
    2:
      // polys upto 6q
      load poly, poly0, poly1, poly2, poly3, #0, #distance/4, #2*distance/4, #3*distance/4
      load poly, poly4, poly5, poly6, poly7, #distance, #5*distance/4, #6*distance/4, #7*distance/4
      
      
      _3_layer_double_inv_CT_16 poly0, poly1, poly2, poly3, poly4, poly5, poly6, poly7, twiddle, twiddle_ptr, qinv, q, tmp, tmp2

      // twisting
      _3_layer_double_inv_twist_16 poly0, poly1, poly2, poly3, poly4, poly5, poly6, poly7, twiddle, twiddle_ptr, qinv, q, tmp, tmp2

      store poly, poly4, poly5, poly6, poly7, #distance, #5*distance/4, #6*distance/4, #7*distance/4
      str.w poly1, [poly, #distance/4]
      str.w poly2, [poly, #2*distance/4]
      str.w poly3, [poly, #3*distance/4]
      str.w poly0, [poly], #4

      vmov tmp, s13
      cmp.w poly, tmp
    bne.w 2b

    // polys upto 9q
    load poly, poly0, poly1, poly2, poly3, #0, #distance/4, #2*distance/4, #3*distance/4
    load poly, poly4, poly5, poly6, poly7, #distance, #5*distance/4, #6*distance/4, #7*distance/4
    
    vmov barrettconst, s10
    vmov s2, poly
    vmov poly, s11
    half_barrett poly0, poly2, poly4, poly6, barrettconst, poly, tmp, tmp2, q
    vmov poly, s2

   _3_layer_double_inv_CT_16 poly0, poly1, poly2, poly3, poly4, poly5, poly6, poly7, twiddle, twiddle_ptr, qinv, q, tmp, tmp2

    // twisting
    _3_layer_double_inv_twist_16 poly0, poly1, poly2, poly3, poly4, poly5, poly6, poly7, twiddle, twiddle_ptr, qinv, q, tmp, tmp2

    store poly, poly4, poly5, poly6, poly7, #distance, #5*distance/4, #6*distance/4, #7*distance/4
    str.w poly1, [poly, #distance/4]
    str.w poly2, [poly, #2*distance/4]
    str.w poly3, [poly, #3*distance/4]
    str.w poly0, [poly], #4

    vmov tmp, s14
    cmp.w poly, tmp
  bne.w 3b

  // ITER 13-15
  add tmp, poly, #3*strincr
  vmov s13, tmp
  2:
    // polys upto 6q
    load poly, poly0, poly1, poly2, poly3, #0, #distance/4, #2*distance/4, #3*distance/4
    load poly, poly4, poly5, poly6, poly7, #distance, #5*distance/4, #6*distance/4, #7*distance/4

    _3_layer_double_inv_CT_16 poly0, poly1, poly2, poly3, poly4, poly5, poly6, poly7, twiddle, twiddle_ptr, qinv, q, tmp, tmp2

    // twisting
    _3_layer_double_inv_twist_16 poly0, poly1, poly2, poly3, poly4, poly5, poly6, poly7, twiddle, twiddle_ptr, qinv, q, tmp, tmp2

    store poly, poly4, poly5, poly6, poly7, #distance, #5*distance/4, #6*distance/4, #7*distance/4
    str.w poly1, [poly, #distance/4]
    str.w poly2, [poly, #2*distance/4]
    str.w poly3, [poly, #3*distance/4]
    str.w poly0, [poly], #strincr

    vmov tmp, s13
    cmp.w poly, tmp
  bne.w 2b

  pop {r4-r11, pc}
