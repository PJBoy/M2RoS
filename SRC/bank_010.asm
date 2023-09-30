SECTION "ROM Bank $010", ROMX[$4000], BANK[$10]

;------------------------------------------------------------------------------

titleScreen_manageBackground: ;{
    ld a, [title_state]
    cp a, title_state_page0
    jr nz, .endCase_page0
    ;{
        ; Set default palette
        ld a, $93
        ld [bg_palette], a
        
        ; Flip page if some time has expired
        ld a, [countdownTimerLow]
        and a
            ret nz
        ld a, [countdownTimerHigh]
        and a
            ret nz
        
        ld a, 3 * titleScreen_fadeStepTimer + 1
        ld [countdownTimerLow], a
        
        ld a, title_state_page0FadeOut
        ld [title_state], a
        
        ret
    ;}
    .endCase_page0
    
    cp a, title_state_page1
    jr nz, .endCase_page1
    ;{
        ; Set default palette
        ld a, $93
        ld [bg_palette], a
        
        ; Flip page if some time has expired
        ld a, [countdownTimerLow]
        and a
            ret nz
        ld a, [countdownTimerHigh]
        and a
            ret nz
        
        ld a, 3 * titleScreen_fadeStepTimer + 1
        ld [countdownTimerLow], a
        
        ld a, title_state_page1FadeOut
        ld [title_state], a
        
        ret
    ;}
    .endCase_page1
    
    cp a, title_state_page0FadeOut
    jr nz, .endCase_page0FadeOut
    ;{
        ld a, [countdownTimerLow]
        and a
            jr z, .page0FadeOut_done
        
        jr .fadeOut
        
        .page0FadeOut_done
        ; Load title tilemap
        ld de, _SCRN0
        ld hl, title_tilemap_page1
        halt ; Is this good enough?
        .loop_page0:
            ld a, [hl+]
            ld [de], a
            inc de
            ld a, d
            cp $9c
        jr nz, .loop_page0
        
        ld a, 3 * titleScreen_fadeStepTimer + 1
        ld [countdownTimerLow], a
        
        ld a, title_state_page1FadeIn
        ld [title_state], a
        
        ret
    ;}
    .endCase_page0FadeOut
    
    cp a, title_state_page1FadeOut
    jr nz, .endCase_page1FadeOut
    ;{
        ld a, [countdownTimerLow]
        and a
            jr z, .page1FadeOut_done
        
        jr .fadeOut
        
        .page1FadeOut_done
        ld de, _SCRN0
        ld hl, title_tilemap_page0
        halt ; Is this good enough?
        .loop_page1:
            ld a, [hl+]
            ld [de], a
            inc de
            ld a, d
            cp $9c
        jr nz, .loop_page1
        
        ld a, 3 * titleScreen_fadeStepTimer + 1
        ld [countdownTimerLow], a
        
        ld a, title_state_page0FadeIn
        ld [title_state], a
        
        ret
    ;}
    .endCase_page1FadeOut
    
    cp a, title_state_page1FadeIn
    jr nz, .endCase_page1FadeIn
    ;{
        ld a, [countdownTimerLow]
        and a
            jr z, .page0FadeIn_done
        
        jr .fadeIn
        
        .page0FadeIn_done
        ld a, LOW(titleScreen_pageTimer)
        ld [countdownTimerLow], a
        ld a, HIGH(titleScreen_pageTimer)
        ld [countdownTimerHigh], a
        
        ld a, title_state_page1
        ld [title_state], a
        
        ret
    ;}
    .endCase_page1FadeIn
    
    ;cp a, title_state_page0FadeIn
    ;jr nz, .endCase_page0FadeIn
    ;{
        ld a, [countdownTimerLow]
        and a
            jr z, .page1FadeIn_done
        
        jr .fadeIn
        
        .page1FadeIn_done
        ld a, LOW(titleScreen_pageTimer)
        ld [countdownTimerLow], a
        ld a, HIGH(titleScreen_pageTimer)
        ld [countdownTimerHigh], a
        
        ld a, title_state_page0
        ld [title_state], a
        
        ret
    ;}
    ; .endCase_page0FadeIn
    
    ;ret
    
    .fadeOut
    ;{
        dec a
        rept titleScreen_fadeStepTimerLog
            srl a
        endr
        ld hl, .fadePalettes
        ld e, a
        ld d, 0
        add hl, de
        ld a, [hl]
        ld [bg_palette], a
        ret
    ;}
    
    .fadeIn
    ;{
        dec a
        rept titleScreen_fadeStepTimerLog
            srl a
        endr
        xor a, $03
        ld hl, .fadePalettes-1
        ld e, a
        ld d, 0
        add hl, de
        ld a, [hl]
        ld [bg_palette], a
        ret
    ;}

    .fadePalettes
    db $FF, $FB, $E7
;}

title_tilemap_page0: include "data/title_tilemap.asm"
title_tilemap_page1: include "data/title_tilemap_page2.asm"
