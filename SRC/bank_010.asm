SECTION "ROM Bank $010", ROMX[$4000], BANK[$10]

;------------------------------------------------------------------------------
titleScreen_flipPage: ;{
    ; Load title tilemap
    ld de, _SCRN0
    ld hl, title_tilemap_page2
    halt ; Is this good enough?
    .titleTilemapLoop:
        ld a, [hl+]
        ld [de], a
        inc de
        ld a, d
        cp $9c
    jr nz, .titleTilemapLoop
ret ;}

title_tilemap_page2: include "data/title_tilemap_page2.asm"
