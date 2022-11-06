SECTION "ROM Bank $010", ROMX[$4000], BANK[$10]

colour_4000:
;{
    db $00, $00, $00, $00, $B1, $1D, $1D, $2B, $66, $00, $24, $11, $22, $00, $0A, $08
    db $00, $00, $00, $00, $3F, $3B, $97, $7D, $7F, $22, $11, $4C, $73, $15, $09, $3C
    db $00, $00, $00, $00, $D5, $3A, $69, $00, $6C, $19, $11, $5E, $42, $00, $24, $00
    db $00, $00, $00, $00, $D2, $7E, $DB, $7F, $E2, $44, $0C, $52, $01, $18, $82, $18
    db $00, $00, $00, $00, $1F, $33, $DF, $6F, $F7, $09, $9C, $02, $A9, $00, $2D, $0C
    db $00, $00, $00, $00, $BC, $51, $56, $02, $10, $34, $70, $1C, $06, $04, $26, $0C
    db $00, $00, $00, $00, $D5, $1E, $95, $02, $E4, $00, $61, $15, $41, $00, $61, $00
    db $00, $00, $00, $00, $39, $63, $E8, $3B, $4B, $21, $D0, $18, $64, $04, $66, $00
;}

colour_4080:
;{
    push hl
    push de
    push bc
    ld a, $01
    ldh [$FF4D], a
    stop
    call colour_40B0
    ld a, $02
    ldh [$FF70], a
    ld hl, $D000
    ld de, colour_4100
    
    .code_4096
        ld a, [de]
        ldi [hl], a
        inc de
        ld a, h
        cp $D2
    jr nz, .code_4096
    ld a, $01
    ldh [$FF70], a
    pop bc
    pop de
    pop hl
    ret
;}

ds $A

colour_40B0:
;{
    ld c, $00
    ld b, $00
    
    .code_40B4
        push bc
        ld c, b
        ld b, $D1
        ld a, [bc]
        ld d, a
        inc bc
        ld a, [bc]
        ld e, a
        pop bc
        ld hl, $FF68
        ld a, c
        ldi [hl], a
        ld a, d
        ld [hl], a
        ld hl, $FF68
        ld a, c
        inc a
        ldi [hl], a
        ld a, e
        ld [hl], a
        inc b
        inc b
        push bc
        ld c, b
        ld b, $D1
        ld a, [bc]
        ld d, a
        inc bc
        ld a, [bc]
        ld e, a
        pop bc
        ld hl, $FF6A
        ld a, c
        ldi [hl], a
        ld a, d
        ld [hl], a
        ld hl, $FF6A
        ld a, c
        inc a
        ldi [hl], a
        ld a, e
        ld [hl], a
        inc c
        inc c
        inc b
        inc b
        bit 6, c
    jr z, .code_40B4
    ret
;}

ds $F

colour_4100:
;{
db $06, $03, $05, $01, $07, $02, $00, $04, $00, $00, $00, $00, $DF, $6F, $DF, $6F
db $9C, $02, $9C, $02, $2D, $0C, $2D, $0C
;}

colour_4118:
;{
    push hl
    push de
    push bc
    ld hl, $FF4D
    bit 7, [hl]
    jr nz, .endIf
        set 0, [hl]
        xor a
        ldh [$FF0F], a
        ldh [$FFFF], a
        ld a, $30
        ldh [$FF00], a
        stop
    .endIf
    
    ld hl, colour_4000
    ld de, $D100
    ld bc, $0080
    call $038A
    ld hl, colour_4000
    ld de, $D180
    ld bc, $0080
    call $038A
    call colour_40B0
    ld a, $00
    ld [$D446], a
    xor a
    ld [$D441], a
    ld [$D442], a
    ld [$D444], a
    ld [$D448], a
    ld [$D44A], a
    ld [$D44B], a
    ld a, $80
    ld [$D44C], a
    ld [$D445], a
    pop bc
    pop de
    pop hl
    ret

;}

colour_416E:
;{
    push bc
    push de
    call $3FAE
    pop hl
    pop bc
;}

colour_4175:
;{
    .loop
        ld e, [hl]
        ld a, e
        sub $80
        ld d, $69
        rl d
        ld a, $FF
        ldh [$FF4F], a
        ld a, [de]
        ldi [hl], a
        xor a
        ldh [$FF4F], a
        dec bc
        ld a, b
        or c
    jr nz, .loop
    ret
;}

colour_418C:
;{
    ld d, $D2
    ld hl, $C000
    ld a, [$D064]
    ld b, a
    
    .code_4195
        ld a, l
        cp b
        jr z, .code_41B8
        inc l
        inc l
        ldi a, [hl]
        ld e, a
        ld a, [de]
        ld c, a
        ld a, [hl]
        bit 4, a
        jr z, .code_41B1
            ld a, c
            cp $03
            jr z, .code_41AD
                ld c, $03
                jr .code_41B1
            .code_41AD
                ld c, $01
                jr .code_41B1
        .code_41B1
        ld a, [hl]
        and $F0
        or c
        ldi [hl], a
    jr .code_4195
    
    .code_41B8
    ldh a, [$FF8D]
    ld b, a
    
    .code_41BB
        ld a, l
        cp b
        ret z
        inc l
        inc l
        ldi a, [hl]
        ld e, a
        ld a, [de]
        ld c, a
        ld a, [hl]
        and $07
        ld a, [hl]
        jr nz, .code_41DF
            bit 4, a
            jr z, .code_41DB
            ld a, c
            cp $03
            jr z, .code_41D7
                ld c, $03
                jr .code_41DB
            .code_41D7
                ld c, $01
                jr .code_41DB
            .code_41DB
            ld a, [hl]
            and $F0
            or c
        .code_41DF
        
        ldi [hl], a
    jr .code_41BB
    
    ret
;}

colour_41E3:
;{
    ld a, [$C215]
    ld l, a
    ld a, [$C216]
    ld h, a
    ld bc, $0014
    jp colour_4175
;}

colour_41F1:
;{
    ld a, $00
    ld [$D446], a
    ld hl, $FFB6
    ldd a, [hl]
    ld b, a
    ldd a, [hl]
    ld c, a
    or b
        jr z, .code_4262
        
    ld a, [$D08C]
    or a
        jr nz, .code_4262
        
    ldd a, [hl]
    ld d, a
    ldd a, [hl]
    ld e, a
    ld h, [hl]
    ldh a, [$FFB1]
    ld l, a
    ld a, c
    sub $40
    ld a, b
    sbc a, $00
    jr c, .code_4219
        ld bc, $0040
    .code_4219

    ld a, c
    ld [$D447], a
    push de
    push hl
    ld de, $D380
    call $3FB5
    pop hl
    pop de
    ld a, [$D447]
    ld c, a
    ldh a, [$FFB4]
    sub $80
    jr c, .code_423E
        sub $18
        jr c, .code_423B
            cp $08
                jr c, .code_4245
                
            jr .code_423E
        .code_423B
            call $3F9F
    .code_423E

    ld a, $02
    ld [$D446], a
    jr .code_4262

    .code_4245
    ld a, $01
    ld [$D446], a
    ld d, $69
    ld hl, $D380

    .code_424F
        ld e, [hl]
        ld a, e
        sub $80
        rl d
        ld a, [de]
        set 6, l
        ldi [hl], a
        res 6, l
        rr d
        dec bc
        ld a, b
        or c
    jr nz, .code_424F

    .code_4262
    ret
;}

colour_4263:
;{
    db $93, $93, $A3, $A7, $E7, $EB, $FB, $FF, $FF
;}

colour_426C:
;{
    ld a, [$D44C]
    ld b, a
    ld a, [$D44B]
    cp b
    ret z
    add a, a
    add a, a
    call colour_458A
    ld a, [$D44B]
    ld [$D44C], a
    ld hl, colour_4263
    ld e, a
    ld d, $00
    add hl, de
    ld a, [hl]
    ld [$D07E], a
    ld [$D07F], a
    ret
;}

colour_428F:
;{
    ld a, [$C3C8]
    or a
        jr z, .code_42D0
    ld b, a
    ld a, [$C3C9]
    or a
        jr nz, .code_42D0
    ld a, b
    and $80
    jr nz, .code_42AB
        ld hl, $70CA
        ld de, $7134
        ld c, $0C
        jr .code_42B3
    .code_42AB
        ld hl, $70C4
        ld de, $7124
        ld c, $10
    .code_42B3
    
    ld a, e
    ld [$D451], a
    ld a, d
    ld [$D452], a
    xor a
    ld [$D450], a
    ld a, b
    and $7F
    dec a
    add a, a
    ld e, a
    ld d, $00
    add hl, de
    ldi a, [hl]
    ld h, [hl]
    ld l, a
    jr .code_4307
    
    .data_42CD
    db $A2, $C6, $EA
    
    .code_42D0
    xor a
    ld [$D452], a
    ld a, [$C3CA]
    or a
    jr nz, .code_42DE
        ld [$D453], a
        ret
    .code_42DE
    
    cp $04
    jr nc, .code_42F2
        ld hl, .data_42CD
        dec a
        ld e, a
        ld d, $00
        add hl, de
        ld l, [hl]
        ld h, $6F
        ld de, $9C00
        jr .code_42FD
    .code_42F2
        ld hl, $C3F2
        ldi a, [hl]
        ld e, a
        ldi a, [hl]
        ld d, a
        ld l, [hl]
        ld h, d
        ld d, $9C
    .code_42FD
    
    ld a, e
    ld [$D44F], a
    ld a, d
    ld [$D450], a
    ld c, $12
    
    .code_4307
    ld a, c
    ld [$D453], a
    ld de, $D420
    ld b, $69
    
    .code_4310
        push af
        ldi a, [hl]
        ld c, a
        sub $80
        rl b
        ld a, [bc]
        ld [de], a
        inc e
        srl b
        ldi a, [hl]
        ld c, a
        sub $80
        rl b
        ld a, [bc]
        ld [de], a
        inc e
        srl b
        pop af
        sub $02
    jr nz, .code_4310
    ret
;}

colour_432D:
;{
    push bc
    push de
    push hl
    call colour_41F1
    call colour_418C
    ld de, $0100
    ldh a, [$FF9B]
    cp $04
        jr z, .code_434D
    cp $08
        jr z, .code_437A
    cp $01
        jr z, .code_436F
    cp $12
        jr z, .code_4385
    jr .code_4393
    
    .code_434D
    ld a, [$D445]
    cp $08
    jr z, .code_4358
        ld a, [$D44B]
        ld e, a
    .code_4358
    
    ld a, [$D08B]
    cp $11
        jr nz, .code_4393
    push de
    call colour_428F
    pop de
    ld a, [$C3D2]
    cp $03
        jr nz, .code_4393
    ld d, $83
    jr .code_4393
    
    .code_436F
    ld a, [$D07E]
    cp $93
        jr z, .code_4393
    ld d, $82
    jr .code_4393
    
    .code_437A
    ld a, [$D07E]
    cp $93
        jr z, .code_4393
    ld e, $02
    jr .code_4393
    
    .code_4385
    ld a, [$D066]
    add a, $11
    rra
    swap a
    and $0F
    cpl
    add a, $09
    ld e, a
    
    .code_4393
    ld a, [$D448]
    cp d
        jr nz, .code_43A1
    ld a, [$D44C]
    cp e
        jr nz, .code_43A1
    jr .code_43AE
    
    .code_43A1
    ld a, $01
    ld [$D44A], a
    ld a, d
    ld [$D449], a
    ld a, e
    ld [$D44B], a
    
    .code_43AE
    call colour_426C
    pop hl
    pop de
    pop bc
    ret
;}

colour_43B5:
;{
    ldh a, [$FF04]
    ld [$D443], a
    push bc
    ld a, [$D442]
    ld b, a
    ldh a, [$FF44]
    cp b
    jr c, .code_43C7
        ld [$D442], a
    .code_43C7

    call colour_432D
    ld a, [$D443]
    ld b, a
    ldh a, [$FF04]
    sub b
    ld b, a
    ld a, [$D444]
    cp b
    jr nc, .code_43DC
        ld a, b
        ld [$D444], a
    .code_43DC

    ldh a, [$FF82]
    or a
    jr z, .code_43E9
        ldh a, [$FF44]
        cp $90
            jr nc, .code_4411
            
        jr .code_4417
    .code_43E9
        ldh a, [$FF44]
        cp $8F
            jr nc, .code_43F8
        halt
        nop
        ldh a, [$FF82]
        or a
            jr nz, .code_43FD
    jr .code_43E9

    .code_43F8
        ldh a, [$FF82]
        or a
    jr z, .code_43F8

    .code_43FD
    ldh a, [$FF04]
    ld c, a
    ld a, [$D440]
    cpl
    inc a
    add a, c
    ld c, a
    ld a, [$D441]
    cp c
    jr nc, .code_4411
        ld a, c
        ld [$D441], a
    .code_4411
        ldh a, [$FF44]
        cp $90
    jr nc, .code_4411

    .code_4417
    ldh a, [$FF9B]
    ld [$D445], a
    pop bc
    ret
;}

colour_441E:
;{
    ldh a, [$FF04]
    ld [$D440], a
    ld a, [$D07E]
    ldh [$FF47], a
    ld a, [$D07F]
    ldh [$FF48], a
    ld a, [$DE01]
    or a
        jr nz, .code_4440
    
    ld a, [$D44A]
    or a
        jr z, .code_4440
    
    call colour_45A4
    xor a
    ld [$D44A], a
    
    .code_4440
    ret
;}

colour_4441:
;{
    ld b, $00
    ld a, [$D447]
    ld c, a
    ld hl, $FFB1
    ld a, [hl]
    add a, c
    ldi [hl], a
    ld a, [hl]
    adc a, b
    ldi [hl], a
    ldi a, [hl]
    ld e, a
    ldi a, [hl]
    ld d, a
    ld a, [$D446]
    or a
        jr z, .code_4491
    
    dec a
    jr z, .code_445F
        jr .code_4475
    .code_445F
    
    push de
    ld hl, $D3C0
    ld a, $FF
    ldh [$FF4F], a
    
    .code_4467
    ldi a, [hl]
    ld [de], a
    inc de
    dec c
    jr nz, .code_4467
    xor a
    ldh [$FF4F], a
    pop de
    ld a, [$D447]
    ld c, a
    
    .code_4475
    ld hl, $D380
    
    .code_4478
    ldi a, [hl]
    ld [de], a
    inc de
    dec c
    jr nz, .code_4478
    ld hl, $FFB3
    ld a, e
    ldi [hl], a
    ld a, d
    ldi [hl], a
    ld a, [$D447]
    ld c, a
    ld a, [hl]
    sub c
    ldi [hl], a
    ld c, a
    ld a, [hl]
    sbc a, b
    ldi [hl], a
    ld b, a
    
    .code_4491
    ret
;}

colour_4492:
;{
    push bc
    push de
    ld bc, $D008
    ld d, $69
    
    .code_4499
        ld a, [bc]
        ldi [hl], a
        ld e, a
        sub $80
        rl d
        ld a, [de]
        ldi [hl], a
        inc bc
        srl d
        bit 2, c
    jr z, .code_4499
    
    pop de
    pop bc
    ret
;}

colour_44AC:
;{
    push bc
    ld bc, $001F
    ld de, $DDFF
    
    .code_44B3
    inc de
    ld a, [de]
    ld l, a
    inc e
    ld a, [de]
    ld h, a
    and a
    jr z, .code_44EF
        inc de
        ld a, [de]
        ld [hl], a
        ld a, c
        ldh [$FF4F], a
        inc e
        ld a, [de]
        ldi [hl], a
        xor a
        ldh [$FF4F], a
        inc e
        ld a, [de]
        ld [hl], a
        ld a, c
        ldh [$FF4F], a
        inc e
        ld a, [de]
        ld [hl], a
        xor a
        ldh [$FF4F], a
        add hl, bc
        inc e
        ld a, [de]
        ld [hl], a
        ld a, c
        ldh [$FF4F], a
        inc e
        ld a, [de]
        ldi [hl], a
        xor a
        ldh [$FF4F], a
        inc e
        ld a, [de]
        ld [hl], a
        ld a, c
        ldh [$FF4F], a
        inc e
        ld a, [de]
        ld [hl], a
        xor a
        ldh [$FF4F], a
    jr .code_44B3
    
    .code_44EF
    pop bc
    ret
;}

colour_44F1:
;{
    ld a, b
    cp $04
    jr nc, .code_4554
        push bc
        push de
        
        .code_44F8
            ldi a, [hl]
            ld [de], a
            inc de
            ldi a, [hl]
            ld [de], a
            inc de
            dec c
        jr nz, .code_44F8
        
        pop hl
        pop bc
        ld a, b
        or a
        ret z
        cp $02
            jr z, .code_4520
            jr nc, .code_4538
            
        ld de, $3DEF
        
        .code_450F
            ldi a, [hl]
            ld b, a
            ld a, [hl]
            srl a
            rr b
            and d
            ldd [hl], a
            ld a, b
            and e
            ldi [hl], a
            inc l
            dec c
        jr nz, .code_450F
        ret
        
        .code_4520
        ld de, $1CE7
        
        .code_4523
            ldi a, [hl]
            ld b, a
            ld a, [hl]
            srl a
            rr b
            srl a
            rr b
            and d
            ldd [hl], a
            ld a, b
            and e
            ldi [hl], a
            inc l
            dec c
        jr nz, .code_4523
        ret
        
        .code_4538
        ld de, $0C63
        
        .code_453B
            ldi a, [hl]
            ld b, a
            ld a, [hl]
            srl a
            rr b
            srl a
            rr b
            srl a
            rr b
            and d
            ldd [hl], a
            ld a, b
            and e
            ldi [hl], a
            inc l
            dec c
        jr nz, .code_453B
        ret
    .code_4554
    
    ld l, e
    ld h, d
    
    .code_4556
        xor a
        ldi [hl], a
        ldi [hl], a
        dec c
    jr nz, .code_4556
    ret
;}

colour_455D:
;{
    push bc
    push de
    inc b
    srl b
    ld c, $40
    call colour_44F1
    pop hl
    pop bc
    ld a, b
    cp $07
    jr nc, .code_4589
    and $01
    jr z, .code_4589
    inc l
    
    .code_4573
    ldd a, [hl]
    srl a
    and $3D
    ld d, a
    ld a, [hl]
    ld e, a
    rr a
    and $EF
    add a, e
    ldi [hl], a
    ld a, [hl]
    adc a, d
    ldi [hl], a
    inc l
    bit 7, l
    jr z, .code_4573
    
    .code_4589
    ret
;}

colour_458A:
;{
    ld b, a
    ld de, $D100
    ld hl, $D180
    ld a, $01
    ld [$D44A], a
    ld a, b
    srl a
    srl a
    and $0F
    ld b, a
    ld c, $40
    call colour_455D
    ret
;}

colour_45A4:
;{
    ld a, [$D44A]
    or a
    ret z
    ld a, [$D449]
    cp $82
        jr z, .code_45E4
    cp $83
        jr z, .code_4611
    ld a, [$D448]
    ld b, a
    and $80
        jr z, .code_45C5
    ld a, b
    cp $82
        jr z, .code_460E
    cp $83
        jr z, .code_4632
    
    .code_45C5
    ld a, $80
    ldh [$FF68], a
    ldh [$FF6A], a
    ld hl, $D100
    ld de, $FF69
    ld bc, $FF6B
    
    .code_45D4
        ldi a, [hl]
        ld [de], a
        ldi a, [hl]
        ld [de], a
        ldi a, [hl]
        ld [bc], a
        ldi a, [hl]
        ld [bc], a
        ldh a, [$FF68]
        and $3F
    jr nz, .code_45D4
    jr .code_4637
    
    .code_45E4
    ld a, $FF
    
    .code_45E6
    ld hl, $FF68
    ld de, $FF69
    ld [hl], $80
    ld [de], a
    ld [de], a
    ld [hl], $88
    ld [de], a
    ld [de], a
    ld [hl], $90
    ld [de], a
    ld [de], a
    ld [hl], $98
    ld [de], a
    ld [de], a
    ld [hl], $A0
    ld [de], a
    ld [de], a
    ld [hl], $A8
    ld [de], a
    ld [de], a
    ld [hl], $B0
    ld [de], a
    ld [de], a
    ld [hl], $B8
    ld [de], a
    ld [de], a
    jr .code_4637
    
    .code_460E
    xor a
    jr .code_45E6
    
    .code_4611
    ld hl, .data_4644
    
    .code_4614
    ld de, $FF69
    ld b, $03
    
    .code_4619
        ldi a, [hl]
        ldh [$FF68], a
        ldi a, [hl]
        push hl
        ld h, $D1
        ld l, a
        ld c, $03
        
        .code_4623
            ldi a, [hl]
            ld [de], a
            ldi a, [hl]
            ld [de], a
            inc l
            inc l
            dec c
        jr nz, .code_4623
        pop hl
        dec b
    jr nz, .code_4619
    jr .code_4637
    
    .code_4632
    ld hl, .data_463E
    jr .code_4614
    
    .code_4637
    ld a, [$D449]
    ld [$D448], a
    ret

.data_463E
    db $92,$24, $AA,$54, $B2,$64

.data_4644
    db $92,$36, $AA,$36, $B2,$36
;}

colour_464A:
;{
    ld a,[hl]
    and $F0
    cp $E0
        ret nz
        
    ld a, [hl]
    and $0F
    or a
        ret nz
        
    ld a, [$D065]
    push af
    push bc
    push de
    inc hl
    ldi a, [hl]
    ld e, a
    ldi a, [hl]
    ld d, a
    ldi a, [hl]
    ld [$D065], a
    ldi a, [hl]
    ld c, a
    ldi a, [hl]
    ld b, a
    push hl
    push bc
    ldi a, [hl]
    ld b, [hl]
    ld c, a
    pop hl
    call $3FB5
    pop hl
    inc hl
    inc hl
    pop de
    pop bc
    pop af
    ld [$D065], a
    ret
;}

colour_467B: ; Credits
;{
    db $F1, $F1, $F1, $F1, $F1, $F1, $F1, $F1, $F1, $F1, $F1, $20, $20, $20, $20, $20
    db $20, $20, $53, $54, $41, $46, $46, $20, $20, $20, $20, $20, $20, $20, $20, $F1
    db $F1, $F1, $F1, $F1, $F1, $F1, $20, $5E, $5E, $20, $54, $45, $41, $4D, $20, $4D
    db $45, $54, $52, $4F, $49, $44, $20, $5E, $5E, $20, $F1, $F1, $F1, $F1, $F1, $20
    db $50, $52, $4F, $44, $55, $43, $45, $52, $20, $20, $20, $20, $20, $20, $20, $20
    db $20, $20, $20, $F1, $F1, $20, $20, $47, $55, $4E, $50, $45, $49, $20, $59, $4F
    db $4B, $4F, $49, $20, $20, $20, $20, $20, $20, $F1, $F1, $F1, $F1, $F1, $F1, $F1
    db $20, $44, $49, $52, $45, $43, $54, $4F, $52, $20, $20, $20, $20, $20, $20, $20
    db $20, $20, $20, $20, $F1, $F1, $20, $20, $48, $49, $52, $4F, $4A, $49, $20, $4B
    db $49, $59, $4F, $54, $41, $4B, $45, $20, $20, $20, $F1, $F1, $20, $20, $48, $49
    db $52, $4F, $59, $55, $4B, $49, $20, $4B, $49, $4D, $55, $52, $41, $20, $20, $20
    db $F1, $F1, $F1, $F1, $F1, $F1, $F1, $20, $4D, $41, $49, $4E, $20, $50, $52, $4F
    db $47, $52, $41, $4D, $4D, $45, $52, $20, $20, $20, $20, $F1, $F1, $20, $20, $54
    db $41, $4B, $41, $48, $49, $52, $4F, $20, $48, $41, $52, $41, $44, $41, $20, $20
    db $20, $F1, $F1, $F1, $F1, $F1, $F1, $F1, $20, $50, $52, $4F, $47, $52, $41, $4D
    db $4D, $45, $52, $20, $20, $20, $20, $20, $20, $20, $20, $20, $F1, $F1, $20, $20
    db $4D, $41, $53, $41, $52, $55, $20, $59, $41, $4D, $41, $4E, $41, $4B, $41, $20
    db $20, $20, $F1, $20, $20, $4D, $41, $53, $41, $4F, $20, $59, $41, $4D, $41, $4D
    db $4F, $54, $4F, $20, $20, $20, $20, $F1, $20, $20, $49, $53, $41, $4F, $20, $48
    db $49, $52, $41, $4E, $4F, $20, $20, $20, $20, $20, $20, $20, $F1, $F1, $F1, $F1
    db $F1, $F1, $20, $47, $52, $41, $50, $48, $49, $43, $20, $44, $45, $53, $49, $47
    db $4E, $45, $52, $20, $20, $20, $F1, $F1, $20, $20, $48, $49, $52, $4F, $4A, $49
    db $20, $4B, $49, $59, $4F, $54, $41, $4B, $45, $20, $20, $20, $F1, $20, $20, $48
    db $49, $52, $4F, $59, $55, $4B, $49, $20, $4B, $49, $4D, $55, $52, $41, $20, $20
    db $20, $F1, $F1, $F1, $F1, $F1, $F1, $20, $50, $52, $4F, $47, $52, $41, $4D, $20
    db $41, $53, $53, $49, $53, $54, $41, $4E, $54, $20, $20, $F1, $F1, $20, $20, $59
    db $55, $5A, $55, $52, $55, $20, $4F, $47, $41, $57, $41, $20, $20, $20, $20, $20
    db $20, $F1, $20, $20, $4E, $4F, $42, $55, $48, $49, $52, $4F, $20, $4F, $5A, $41
    db $4B, $49, $20, $20, $20, $20, $F1, $F1, $F1, $F1, $F1, $F1, $20, $53, $4F, $55
    db $4E, $44, $20, $50, $52, $4F, $47, $52, $41, $4D, $4D, $45, $52, $20, $20, $20
    db $F1, $F1, $20, $20, $52, $59, $4F, $48, $4A, $49, $20, $59, $4F, $53, $48, $49
    db $54, $4F, $4D, $49, $20, $20, $F1, $F1, $F1, $F1, $F1, $F1, $20, $44, $45, $53
    db $49, $47, $4E, $45, $52, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20
    db $F1, $F1, $20, $20, $4D, $41, $4B, $4F, $54, $4F, $20, $4B, $41, $4E, $4F, $48
    db $20, $20, $20, $20, $20, $20, $F1, $20, $20, $4D, $41, $53, $41, $46, $55, $4D
    db $49, $20, $53, $41, $4B, $41, $53, $48, $49, $54, $41, $F1, $20, $20, $54, $4F
    db $4D, $4F, $59, $4F, $53, $48, $49, $20, $59, $41, $4D, $41, $4E, $45, $20, $20
    db $F1, $20, $20, $54, $41, $4B, $45, $48, $49, $4B, $4F, $20, $48, $4F, $53, $4F
    db $4B, $41, $57, $41, $20, $F1, $20, $20, $59, $41, $53, $55, $4F, $20, $49, $4E
    db $4F, $55, $45, $20, $20, $20, $20, $20, $20, $20, $F1, $F1, $F1, $F1, $F1, $F1
    db $20, $44, $45, $42, $55, $47, $47, $45, $52, $20, $20, $20, $20, $20, $20, $20
    db $20, $20, $20, $20, $F1, $F1, $20, $20, $4D, $41, $53, $41, $52, $55, $20, $4F
    db $4B, $41, $44, $41, $20, $20, $20, $20, $20, $20, $F1, $20, $20, $4B, $45, $4E
    db $4A, $49, $20, $4E, $49, $53, $48, $49, $5A, $41, $57, $41, $20, $20, $20, $F1
    db $20, $20, $48, $49, $52, $4F, $46, $55, $4D, $49, $20, $4D, $41, $54, $53, $55
    db $4F, $4B, $41, $20, $F1, $20, $20, $54, $4F, $48, $52, $55, $20, $4F, $48, $53
    db $41, $57, $41, $20, $20, $20, $20, $20, $20, $F1, $20, $20, $4B, $4F, $48, $54
    db $41, $20, $46, $55, $4B, $55, $49, $20, $20, $20, $20, $20, $20, $20, $F1, $20
    db $20, $4B, $45, $49, $53, $55, $4B, $45, $20, $54, $45, $52, $41, $53, $41, $4B
    db $49, $20, $20, $F1, $20, $20, $4B, $45, $4E, $49, $43, $48, $49, $20, $53, $55
    db $47, $49, $4E, $4F, $20, $20, $20, $20, $F1, $20, $20, $48, $49, $54, $4F, $53
    db $48, $49, $20, $59, $41, $4D, $41, $47, $41, $4D, $49, $20, $20, $F1, $20, $20
    db $4B, $41, $54, $53, $55, $59, $41, $20, $59, $41, $4D, $41, $4E, $4F, $20, $20
    db $20, $20, $F1, $20, $20, $59, $55, $4A, $49, $20, $48, $4F, $52, $49, $20, $20
    db $20, $20, $20, $20, $20, $20, $20, $F1, $F1, $F1, $F1, $F1, $F1, $F1, $F1, $5E
    db $20, $46, $41, $4E, $20, $43, $4F, $4C, $4F, $52, $49, $5A, $41, $54, $49, $4F
    db $4E, $20, $5E, $F1, $F1, $F1, $F1, $F1, $F1, $F1, $F1, $20, $47, $52, $41, $50
    db $48, $49, $43, $20, $44, $45, $53, $49, $47, $4E, $45, $52, $20, $20, $20, $F1
    db $F1, $20, $20, $45, $4A, $52, $20, $54, $41, $49, $52, $4E, $45, $20, $20, $20
    db $20, $20, $20, $20, $20, $F1, $F1, $F1, $F1, $F1, $F1, $20, $50, $52, $4F, $47
    db $52, $41, $4D, $4D, $45, $52, $20, $20, $20, $20, $20, $20, $20, $20, $20, $F1
    db $F1, $20, $20, $4A, $55, $53, $54, $49, $4E, $20, $4F, $4C, $42, $52, $41, $4E
    db $54, $5A, $20, $20, $20, $F1, $20, $20, $20, $20, $20, $20, $20, $20, $5E, $20
    db $51, $55, $41, $4E, $54, $41, $4D, $20, $5E, $20, $F1, $F1, $F1, $F1, $F1, $F1
    db $F1, $F1, $20, $5E, $20, $53, $50, $45, $43, $49, $41, $4C, $20, $54, $48, $41
    db $4E, $4B, $53, $20, $5E, $20, $F1, $20, $20, $20, $20, $20, $20, $20, $20, $20
    db $54, $4F, $20, $20, $20, $20, $20, $20, $20, $20, $20, $F1, $F1, $20, $20, $54
    db $41, $4B, $45, $48, $49, $52, $4F, $20, $49, $5A, $55, $53, $48, $49, $20, $20
    db $20, $F1, $20, $20, $50, $48, $49, $4C, $20, $53, $41, $4E, $44, $48, $4F, $50
    db $20, $20, $20, $20, $20, $20, $F1, $20, $20, $54, $4F, $4E, $59, $20, $53, $54
    db $41, $4E, $43, $5A, $59, $4B, $20, $20, $20, $20, $20, $F1, $20, $20, $59, $55
    db $4B, $41, $20, $4E, $41, $4B, $41, $54, $41, $20, $20, $20, $20, $20, $20, $20
    db $F1, $20, $20, $48, $49, $52, $4F, $20, $59, $41, $4D, $41, $44, $41, $20, $20
    db $20, $20, $20, $20, $20, $F1, $20, $20, $44, $41, $4E, $20, $4F, $57, $53, $45
    db $4E, $20, $20, $20, $20, $20, $20, $20, $20, $20, $F1, $20, $20, $44, $59, $4C
    db $41, $4E, $20, $43, $55, $54, $48, $42, $45, $52, $54, $20, $20, $20, $20, $F1
    db $20, $20, $53, $41, $43, $48, $49, $45, $20, $49, $4E, $4F, $4B, $45, $20, $20
    db $20, $20, $20, $20, $F1, $20, $20, $41, $4E, $44, $20, $47, $42, $44, $45, $56
    db $20, $20, $20, $20, $20, $20, $20, $20, $20, $F1, $F1, $F1, $F1, $F1, $F1, $F1
    db $F1, $F1, $F1, $F1, $F1, $F1, $F1, $20, $20, $20, $50, $52, $45, $53, $45, $4E
    db $54, $45, $44, $20, $20, $20, $20, $20, $20, $20, $20, $F1, $20, $20, $20, $20
    db $20, $20, $20, $42, $59, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20
    db $F1, $20, $20, $20, $20, $20, $4E, $49, $4E, $54, $45, $4E, $44, $4F, $20, $20
    db $20, $20, $20, $20, $20, $F1, $F1, $F1, $F1, $F1, $F1, $F1, $F1, $F1, $F1, $F1
    db $F1, $F1, $F1, $F1, $F1, $F1, $20, $20, $20, $20, $20, $21, $22, $23, $20, $24
    db $25, $20, $26, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $20, $27
    db $28, $29, $2A, $2B, $2C, $2D, $2E, $20, $20, $20, $20, $20, $20, $20, $F1, $F1
    db $F1, $F1, $F1, $20, $20, $54, $49, $4D, $45, $20, $20, $20, $1B, $20, $20, $20
    db $20, $20, $20, $20, $20, $20, $20, $F1, $F1, $F1, $F0, $00, $00, $76, $00, $76
    db $00, $76
;}
