SECTION "ROM Bank $027 plantBubbles", ROMX[gfx_plantBubbles], BANK[$27]
paletteIndices_plantBubbles: incbin "tilesets/colour/paletteIndices/plantBubbles.bin"

SECTION "ROM Bank $027 ruinsInside", ROMX[gfx_ruinsInside], BANK[$27]
paletteIndices_ruinsInside:  incbin "tilesets/colour/paletteIndices/ruinsInside.bin"

SECTION "ROM Bank $027 queenBG", ROMX[gfx_queenBG], BANK[$27]
paletteIndices_queenBG:      incbin "tilesets/colour/paletteIndices/queenBG.bin"

SECTION "ROM Bank $027 caveFirst", ROMX[gfx_caveFirst], BANK[$27]
paletteIndices_caveFirst:    incbin "tilesets/colour/paletteIndices/caveFirst.bin"

SECTION "ROM Bank $027 surfaceBG", ROMX[gfx_surfaceBG], BANK[$27]
paletteIndices_surfaceBG:    incbin "tilesets/colour/paletteIndices/surfaceBG.bin"

SECTION "ROM Bank $027 lavaCavesA", ROMX[gfx_lavaCavesA], BANK[$27]
paletteIndices_lavaCavesA:   incbin "tilesets/colour/paletteIndices/lavaCavesA.bin"

SECTION "ROM Bank $027 lavaCavesB", ROMX[gfx_lavaCavesB], BANK[$27]
paletteIndices_lavaCavesB:   incbin "tilesets/colour/paletteIndices/lavaCavesB.bin"

SECTION "ROM Bank $027 lavaCavesC", ROMX[gfx_lavaCavesC], BANK[$27]
paletteIndices_lavaCavesC:   incbin "tilesets/colour/paletteIndices/lavaCavesC.bin"

SECTION "ROM Bank $027 items", ROMX[gfx_items], BANK[$27]
paletteIndices_items:        incbin "gfx/colour/paletteIndices/items.bin"

SECTION "ROM Bank $027 itemOrb", ROMX[gfx_itemOrb], BANK[$27]
paletteIndices_itemOrb:      incbin "gfx/colour/paletteIndices/itemOrb.bin"

SECTION "ROM Bank $027 commonItems", ROMX[gfx_commonItems], BANK[$27]
paletteIndices_commonItems:  incbin "gfx/colour/paletteIndices/commonItems.bin"

SECTION "ROM Bank $027 $7BC0", ROMX[$7BC0], BANK[$27]
db $01 ; ...?
