local content = require("ccb").content

local LIGHT_EXERCISE = 2

-- 67 canvas sheets by weight, plus extra filament_canvas for quilting threads. Then add 20% more solely
-- converted to byproducts.
-- Garment zips up on the sides of the torso and along the underside of the arm.
-- roughly 40 hours total for the craft while skilled. articulation needed for the arms.
-- byproducts are 25% patches and 75% scraps (32 scrap per sheet, 8 patch per sheet)
content.add(content.Recipe {
    id = "aketon_canvas",
    result = "aketon_canvas",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 13680000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component_any({
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "santa_belt", count = 1 }
        })
    :requirement("filament_canvas", 100)
    :requirement("tailoring_canvas_patchwork", 80)
    :requirement("fastener_large", 2)
    :requirement("fastener_small", 10)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
    :byproduct("scrap_canvas", 312)
    :byproduct("canvas_patch", 26)
)

-- 100 canvas sheets by weight, plus extra filament_canvas for quilting threads. Then add 20% more solely
-- converted to byproducts.
-- byproducts are 25% patches and 75% scraps (32 scrap per sheet, 8 patch per sheet)
content.add(content.Recipe {
    id = "xl_aketon_canvas",
    result = "xl_aketon_canvas",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 20520000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component_any({
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "santa_belt", count = 1 }
        })
    :requirement("filament_canvas", 150)
    :requirement("tailoring_canvas_patchwork", 120)
    :requirement("fastener_large", 2)
    :requirement("fastener_small", 14)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
    :byproduct("scrap_canvas", 480)
    :byproduct("canvas_patch", 40)
)

-- 50 canvas sheets by weight, plus extra filament_canvas for quilting threads. Then add 20% more solely
-- converted to byproducts.
-- byproducts are 25% patches and 75% scraps (32 scrap per sheet, 8 patch per sheet)
content.add(content.Recipe {
    id = "xs_aketon_canvas",
    result = "xs_aketon_canvas",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 10440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component_any({
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "santa_belt", count = 1 }
        })
    :requirement("filament_canvas", 75)
    :requirement("tailoring_canvas_patchwork", 60)
    :requirement("fastener_large", 2)
    :requirement("fastener_small", 8)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
    :byproduct("scrap_canvas", 240)
    :byproduct("canvas_patch", 20)
)

-- 49 canvas sheets by weight, plus extra filament_canvas for quilting threads. Then add 20% more solely
-- converted to byproducts.
-- Garment zips up on the sides of the torso.
-- roughly 20 hours total for the craft. no articulation needed - much simpler than the jacket.
-- byproducts are 25% patches and 75% scraps (32 scrap per sheet, 8 patch per sheet)
content.add(content.Recipe {
    id = "aketon_canvas_vest",
    result = "aketon_canvas_vest",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 7200000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :component_any({
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "santa_belt", count = 1 }
        })
    :requirement("filament_canvas", 70)
    :requirement("tailoring_canvas_patchwork", 59)
    :requirement("fastener_large", 2)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_quilting")
    :byproduct("scrap_canvas", 240)
    :byproduct("canvas_patch", 20)
)

-- 75 canvas sheets by weight, plus extra filament_canvas for quilting threads. Then add 20% more solely
-- converted to byproducts.
-- byproducts are 25% patches and 75% scraps (32 scrap per sheet, 8 patch per sheet)
content.add(content.Recipe {
    id = "xl_aketon_canvas_vest",
    result = "xl_aketon_canvas_vest",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 10800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :component_any({
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "santa_belt", count = 1 }
        })
    :requirement("filament_canvas", 105)
    :requirement("tailoring_canvas_patchwork", 90)
    :requirement("fastener_large", 2)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_quilting")
    :byproduct("scrap_canvas", 360)
    :byproduct("canvas_patch", 30)
)

-- 38 canvas sheets by weight, plus extra filament_canvas for quilting threads. Then add 20% more solely
-- converted to byproducts.
-- byproducts are 25% patches and 75% scraps (32 scrap per sheet, 8 patch per sheet)
content.add(content.Recipe {
    id = "xs_aketon_canvas_vest",
    result = "xs_aketon_canvas_vest",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 5400000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :component_any({
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "santa_belt", count = 1 }
        })
    :requirement("filament_canvas", 53)
    :requirement("tailoring_canvas_patchwork", 45)
    :requirement("fastener_large", 2)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_quilting")
    :byproduct("scrap_canvas", 180)
    :byproduct("canvas_patch", 15)
)

-- 36 canvas sheets by weight, plus extra filament_canvas for quilting threads. Then add 20% more solely
-- converted to byproducts.
-- Garment zips up on the lower legs and the crotch.
-- roughly 24 hours for the craft, less material here overall than the jack, though articulation still
-- needed.
-- byproducts are 25% patches and 75% scraps (32 scrap per sheet, 8 patch per sheet)
content.add(content.Recipe {
    id = "aketon_pants_canvas",
    result = "aketon_pants_canvas",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 8640000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :requirement("filament_canvas", 40)
    :requirement("tailoring_canvas_patchwork", 42)
    :requirement("fastener_small", 5)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
    :byproduct("scrap_canvas", 144)
    :byproduct("canvas_patch", 12)
)

-- 54 canvas sheets by weight, plus extra filament_canvas for quilting threads. Then add 20% more solely
-- converted to byproducts.
-- byproducts are 25% patches and 75% scraps (32 scrap per sheet, 8 patch per sheet)
content.add(content.Recipe {
    id = "xl_aketon_pants_canvas",
    result = "xl_aketon_pants_canvas",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12960000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component_any({
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "santa_belt", count = 1 }
        })
    :requirement("filament_canvas", 60)
    :requirement("tailoring_canvas_patchwork", 63)
    :requirement("fastener_small", 7)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
    :byproduct("scrap_canvas", 216)
    :byproduct("canvas_patch", 18)
)

-- 27 canvas sheets by weight, plus extra filament_canvas for quilting threads. Then add 20% more solely
-- converted to byproducts.
-- byproducts are 25% patches and 75% scraps (32 scrap per sheet, 8 patch per sheet)
content.add(content.Recipe {
    id = "xs_aketon_pants_canvas",
    result = "xs_aketon_pants_canvas",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 6480000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component_any({
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "santa_belt", count = 1 }
        })
    :requirement("filament_canvas", 30)
    :requirement("tailoring_canvas_patchwork", 31)
    :requirement("fastener_small", 5)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
    :byproduct("scrap_canvas", 108)
    :byproduct("canvas_patch", 9)
)

-- 10 canvas sheets by weight, plus extra filament_canvas for quilting threads. Then add 20% more solely
-- converted to byproducts.
-- byproducts are 25% patches and 75% scraps (32 scrap per sheet, 8 patch per sheet)
content.add(content.Recipe {
    id = "aketon_hood_canvas",
    result = "aketon_hood_canvas",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2160000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :requirement("filament_canvas", 10)
    :requirement("tailoring_canvas_patchwork", 12)
    :requirement("fastener_small", 2)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_quilting")
    :byproduct("scrap_canvas", 48)
    :byproduct("canvas_patch", 4)
)

-- 15 canvas sheets by weight, plus extra filament_canvas for quilting threads. Then add 20% more solely
-- converted to byproducts.
-- byproducts are 25% patches and 75% scraps (32 scrap per sheet, 8 patch per sheet)
content.add(content.Recipe {
    id = "xl_aketon_hood_canvas",
    result = "xl_aketon_hood_canvas",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :requirement("filament_canvas", 15)
    :requirement("tailoring_canvas_patchwork", 18)
    :requirement("fastener_small", 4)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_quilting")
    :byproduct("scrap_canvas", 72)
    :byproduct("canvas_patch", 6)
)

-- 8 canvas sheets by weight, plus extra filament_canvas for quilting threads. Then add 20% more solely
-- converted to byproducts.
-- byproducts are 25% patches and 75% scraps (32 scrap per sheet, 8 patch per sheet)
content.add(content.Recipe {
    id = "xs_aketon_hood_canvas",
    result = "xs_aketon_hood_canvas",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :requirement("filament_canvas", 8)
    :requirement("tailoring_canvas_patchwork", 9)
    :requirement("fastener_small", 2)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_quilting")
    :byproduct("scrap_canvas", 36)
    :byproduct("canvas_patch", 3)
)

-- 4 canvas sheets by weight, plus extra filament_canvas for quilting threads
-- byproducts are 25% patches and 75% scraps (32 scrap per sheet, 8 patch per sheet)
content.add(content.Recipe {
    id = "aketon_gloves_canvas",
    result = "aketon_gloves_canvas",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2160000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :requirement("filament_canvas", 10)
    :requirement("tailoring_canvas_patchwork", 5)
    :requirement("fastener_small", 2)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
    :byproduct("scrap_canvas", 24)
    :byproduct("canvas_patch", 2)
)

-- 6 canvas sheets by weight, plus extra filament_canvas for quilting threads. Then add 20% more solely
-- converted to byproducts.
-- byproducts are 25% patches and 75% scraps (32 scrap per sheet, 8 patch per sheet)
content.add(content.Recipe {
    id = "xl_aketon_gloves_canvas",
    result = "xl_aketon_gloves_canvas",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :requirement("filament_canvas", 15)
    :requirement("tailoring_canvas_patchwork", 6)
    :requirement("fastener_small", 2)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
    :byproduct("scrap_canvas", 36)
    :byproduct("canvas_patch", 3)
)

-- 3 canvas sheets by weight, plus extra filament_canvas for quilting threads. Then add 20% more solely
-- converted to byproducts.
-- byproducts are 25% patches and 75% scraps (32 scrap per sheet, 8 patch per sheet)
content.add(content.Recipe {
    id = "xs_aketon_gloves_canvas",
    result = "xs_aketon_gloves_canvas",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :requirement("filament_canvas", 8)
    :requirement("tailoring_canvas_patchwork", 4)
    :requirement("fastener_small", 2)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
    :byproduct("scrap_canvas", 18)
    :byproduct("canvas_patch", 1)
)

-- 141 canvas sheets by weight, plus extra filament_canvas for quilting threads. Then add 20% more solely
-- converted to byproducts.
-- Garment zips up on the sides of the torso and along the underside of the arm.
-- roughly 80 hours total for the craft while skilled. articulation needed for the arms.
-- byproducts are 25% patches and 75% scraps (32 scrap per sheet, 8 patch per sheet)
content.add(content.Recipe {
    id = "gambeson_canvas",
    result = "gambeson_canvas",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 28800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component_any({
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "santa_belt", count = 1 }
        })
    :requirement("filament_canvas", 150)
    :requirement("tailoring_canvas_patchwork", 169)
    :requirement("fastener_large", 2)
    :requirement("fastener_small", 10)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
    :byproduct("scrap_canvas", 672)
    :byproduct("canvas_patch", 56)
)

-- 211 canvas sheets by weight, plus extra filament_canvas for quilting threads. Then add 20% more solely
-- converted to byproducts.
-- byproducts are 25% patches and 75% scraps (32 scrap per sheet, 8 patch per sheet)
content.add(content.Recipe {
    id = "xl_gambeson_canvas",
    result = "xl_gambeson_canvas",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 43200000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component_any({
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "santa_belt", count = 1 }
        })
    :requirement("filament_canvas", 225)
    :requirement("tailoring_canvas_patchwork", 253)
    :requirement("fastener_large", 2)
    :requirement("fastener_small", 14)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
    :byproduct("scrap_canvas", 1008)
    :byproduct("canvas_patch", 84)
)

-- 106 canvas sheets by weight, plus extra filament_canvas for quilting threads. Then add 20% more solely
-- converted to byproducts.
-- byproducts are 25% patches and 75% scraps (32 scrap per sheet, 8 patch per sheet)
content.add(content.Recipe {
    id = "xs_gambeson_canvas",
    result = "xs_gambeson_canvas",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 21600000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component_any({
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "santa_belt", count = 1 }
        })
    :requirement("filament_canvas", 114)
    :requirement("tailoring_canvas_patchwork", 127)
    :requirement("fastener_large", 2)
    :requirement("fastener_small", 8)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
    :byproduct("scrap_canvas", 504)
    :byproduct("canvas_patch", 42)
)

-- 123 canvas sheets by weight, plus extra filament_canvas for quilting threads. Then add 20% more solely
-- converted to byproducts.
-- Garment zips up on the sides of the torso and along the underside of the arm.
-- roughly 70 hours total for the craft while skilled. articulation needed for the arms.
-- byproducts are 25% patches and 75% scraps (32 scrap per sheet, 8 patch per sheet)
content.add(content.Recipe {
    id = "gambeson_canvas_thinsleeved",
    result = "gambeson_canvas_thinsleeved",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 25200000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component_any({
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "santa_belt", count = 1 }
        })
    :requirement("filament_canvas", 140)
    :requirement("tailoring_canvas_patchwork", 148)
    :requirement("fastener_large", 2)
    :requirement("fastener_small", 10)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
    :byproduct("scrap_canvas", 600)
    :byproduct("canvas_patch", 50)
)

-- 185 canvas sheets by weight, plus extra filament_canvas for quilting threads. Then add 20% more solely
-- converted to byproducts.
-- byproducts are 25% patches and 75% scraps (32 scrap per sheet, 8 patch per sheet)
content.add(content.Recipe {
    id = "xl_gambeson_canvas_thinsleeved",
    result = "xl_gambeson_canvas_thinsleeved",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 37800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component_any({
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "santa_belt", count = 1 }
        })
    :requirement("filament_canvas", 210)
    :requirement("tailoring_canvas_patchwork", 222)
    :requirement("fastener_large", 2)
    :requirement("fastener_small", 14)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
    :byproduct("scrap_canvas", 888)
    :byproduct("canvas_patch", 74)
)

-- 92 canvas sheets by weight, plus extra filament_canvas for quilting threads. Then add 20% more solely
-- converted to byproducts.
-- byproducts are 25% patches and 75% scraps (32 scrap per sheet, 8 patch per sheet)
content.add(content.Recipe {
    id = "xs_gambeson_canvas_thinsleeved",
    result = "xs_gambeson_canvas_thinsleeved",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 19440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component_any({
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "santa_belt", count = 1 }
        })
    :requirement("filament_canvas", 105)
    :requirement("tailoring_canvas_patchwork", 110)
    :requirement("fastener_large", 2)
    :requirement("fastener_small", 8)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
    :byproduct("scrap_canvas", 444)
    :byproduct("canvas_patch", 37)
)

-- 105 canvas sheets by weight, plus extra filament_canvas for quilting threads. Then add 20% more solely
-- converted to byproducts.
-- Garment zips up on the sides of the torso.
-- roughly 42 hours total for the craft. no articulation needed - much simpler than the gambeson.
-- byproducts are 25% patches and 75% scraps (32 scrap per sheet, 8 patch per sheet)
content.add(content.Recipe {
    id = "gambeson_canvas_vest",
    result = "gambeson_canvas_vest",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 15120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :component_any({
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "santa_belt", count = 1 }
        })
    :requirement("filament_canvas", 90)
    :requirement("tailoring_canvas_patchwork", 126)
    :requirement("fastener_large", 2)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_quilting")
    :byproduct("scrap_canvas", 504)
    :byproduct("canvas_patch", 42)
)

-- 158 canvas sheets by weight, plus extra filament_canvas for quilting threads. Then add 20% more solely
-- converted to byproducts.
-- byproducts are 25% patches and 75% scraps (32 scrap per sheet, 8 patch per sheet)
content.add(content.Recipe {
    id = "xl_gambeson_canvas_vest",
    result = "xl_gambeson_canvas_vest",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 22680000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :component_any({
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "santa_belt", count = 1 }
        })
    :requirement("filament_canvas", 135)
    :requirement("tailoring_canvas_patchwork", 190)
    :requirement("fastener_large", 2)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_quilting")
    :byproduct("scrap_canvas", 768)
    :byproduct("canvas_patch", 64)
)

-- 77 canvas sheets by weight, plus extra filament_canvas for quilting threads. Then add 20% more solely
-- converted to byproducts.
-- byproducts are 25% patches and 75% scraps (32 scrap per sheet, 8 patch per sheet)
content.add(content.Recipe {
    id = "xs_gambeson_canvas_vest",
    result = "xs_gambeson_canvas_vest",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 11160000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :component_any({
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "santa_belt", count = 1 }
        })
    :requirement("filament_canvas", 74)
    :requirement("tailoring_canvas_patchwork", 94)
    :requirement("fastener_large", 2)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_quilting")
    :byproduct("scrap_canvas", 360)
    :byproduct("canvas_patch", 30)
)

-- 72 canvas sheets by weight, plus extra filament_canvas for quilting threads. Then add 20% more solely
-- converted to byproducts.
-- Garment zips up on the lower legs and the crotch.
-- roughly 48 hours for the craft, less material here overall than the jack, though articulation still
-- needed.
-- byproducts are 25% patches and 75% scraps (32 scrap per sheet, 8 patch per sheet)
content.add(content.Recipe {
    id = "gambeson_pants_canvas",
    result = "gambeson_pants_canvas",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 17280000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :requirement("filament_canvas", 50)
    :requirement("tailoring_canvas_patchwork", 86)
    :requirement("fastener_small", 5)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
    :byproduct("scrap_canvas", 336)
    :byproduct("canvas_patch", 28)
)

-- 108 canvas sheets by weight, plus extra filament_canvas for quilting threads. Then add 20% more solely
-- converted to byproducts.
-- byproducts are 25% patches and 75% scraps (32 scrap per sheet, 8 patch per sheet)
content.add(content.Recipe {
    id = "xl_gambeson_pants_canvas",
    result = "xl_gambeson_pants_canvas",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 25920000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :requirement("filament_canvas", 75)
    :requirement("tailoring_canvas_patchwork", 130)
    :requirement("fastener_small", 7)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
    :byproduct("scrap_canvas", 528)
    :byproduct("canvas_patch", 44)
)

content.add(content.Recipe {
    id = "xs_gambeson_pants_canvas",
    result = "xs_gambeson_pants_canvas",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12960000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :requirement("filament_canvas", 38)
    :requirement("tailoring_canvas_patchwork", 65)
    :requirement("fastener_small", 5)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
    :byproduct("scrap_canvas", 264)
    :byproduct("canvas_patch", 22)
)

-- 9 canvas sheets by weight, plus extra filament_canvas for quilting threads. Then add 20% more solely
-- converted to byproducts.
-- byproducts are 25% patches and 75% scraps (32 scrap per sheet, 8 patch per sheet)
content.add(content.Recipe {
    id = "gambeson_gloves_canvas",
    result = "gambeson_gloves_canvas",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3600000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :requirement("filament_canvas", 22)
    :requirement("tailoring_canvas_patchwork", 11)
    :requirement("fastener_small", 4)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
    :byproduct("scrap_canvas", 48)
    :byproduct("canvas_patch", 4)
)

-- 14 canvas sheets by weight, plus extra filament_canvas for quilting threads. Then add 20% more solely
-- converted to byproducts.
-- byproducts are 25% patches and 75% scraps (32 scrap per sheet, 8 patch per sheet)
content.add(content.Recipe {
    id = "xl_gambeson_gloves_canvas",
    result = "xl_gambeson_gloves_canvas",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 5400000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :requirement("filament_canvas", 33)
    :requirement("tailoring_canvas_patchwork", 17)
    :requirement("fastener_small", 4)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
    :byproduct("scrap_canvas", 72)
    :byproduct("canvas_patch", 6)
)

-- 7 canvas sheets by weight, plus extra filament_canvas for quilting threads. Then add 20% more solely
-- converted to byproducts.
-- byproducts are 25% patches and 75% scraps (32 scrap per sheet, 8 patch per sheet)
content.add(content.Recipe {
    id = "xs_gambeson_gloves_canvas",
    result = "xs_gambeson_gloves_canvas",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2880000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :requirement("filament_canvas", 17)
    :requirement("tailoring_canvas_patchwork", 8)
    :requirement("fastener_small", 4)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
    :byproduct("scrap_canvas", 24)
    :byproduct("canvas_patch", 2)
)

-- 141 nylon sheets by weight, plus extra filament_canvas for quilting threads. Then add 20% more solely
-- converted to byproducts.
-- Garment zips up on the sides of the torso and along the underside of the arm.
-- roughly 80 hours total for the craft while skilled. articulation needed for the arms.
-- byproducts are 25% patches and 75% scraps (32 scrap per sheet, 8 patch per sheet)
content.add(content.Recipe {
    id = "gambeson_nylon",
    result = "gambeson_nylon",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 28800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component_any({
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "santa_belt", count = 1 }
        })
    :requirement("filament_canvas", 150)
    :requirement("tailoring_nylon_patchwork", 169)
    :requirement("fastener_large", 2)
    :requirement("fastener_small", 10)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
    :byproduct("scrap_nylon", 672)
    :byproduct("nylon", 56)
)

-- 211 nylon sheets by weight, plus extra filament_canvas for quilting threads. Then add 20% more solely
-- converted to byproducts.
-- byproducts are 25% patches and 75% scraps (32 scrap per sheet, 8 patch per sheet)
content.add(content.Recipe {
    id = "xl_gambeson_nylon",
    result = "xl_gambeson_nylon",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 43200000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component_any({
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "santa_belt", count = 1 }
        })
    :requirement("filament_canvas", 225)
    :requirement("tailoring_nylon_patchwork", 253)
    :requirement("fastener_large", 2)
    :requirement("fastener_small", 14)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
    :byproduct("scrap_nylon", 1008)
    :byproduct("nylon", 84)
)

-- 106 nylon sheets by weight, plus extra filament_canvas for quilting threads. Then add 20% more solely
-- converted to byproducts.
-- byproducts are 25% patches and 75% scraps (32 scrap per sheet, 8 patch per sheet)
content.add(content.Recipe {
    id = "xs_gambeson_nylon",
    result = "xs_gambeson_nylon",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 21600000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component_any({
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "santa_belt", count = 1 }
        })
    :requirement("filament_canvas", 114)
    :requirement("tailoring_nylon_patchwork", 127)
    :requirement("fastener_large", 2)
    :requirement("fastener_small", 8)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
    :byproduct("scrap_nylon", 504)
    :byproduct("nylon", 42)
)

-- 123 nylon sheets by weight, plus extra filament_canvas for quilting threads. Then add 20% more solely
-- converted to byproducts.
-- Garment zips up on the sides of the torso and along the underside of the arm.
-- roughly 70 hours total for the craft while skilled. articulation needed for the arms.
-- byproducts are 25% patches and 75% scraps (32 scrap per sheet, 8 patch per sheet)
content.add(content.Recipe {
    id = "gambeson_nylon_thinsleeved",
    result = "gambeson_nylon_thinsleeved",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 25200000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component_any({
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "santa_belt", count = 1 }
        })
    :requirement("filament_canvas", 140)
    :requirement("tailoring_nylon_patchwork", 148)
    :requirement("fastener_large", 2)
    :requirement("fastener_small", 10)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
    :byproduct("scrap_nylon", 600)
    :byproduct("nylon", 50)
)

-- 185 nylon sheets by weight, plus extra filament_canvas for quilting threads. Then add 20% more solely
-- converted to byproducts.
-- byproducts are 25% patches and 75% scraps (32 scrap per sheet, 8 patch per sheet)
content.add(content.Recipe {
    id = "xl_gambeson_nylon_thinsleeved",
    result = "xl_gambeson_nylon_thinsleeved",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 37800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component_any({
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "santa_belt", count = 1 }
        })
    :requirement("filament_canvas", 210)
    :requirement("tailoring_nylon_patchwork", 222)
    :requirement("fastener_large", 2)
    :requirement("fastener_small", 14)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
    :byproduct("scrap_nylon", 888)
    :byproduct("nylon", 74)
)

-- 92 canvas sheets by weight, plus extra filament_canvas for quilting threads. Then add 20% more solely
-- converted to byproducts.
-- byproducts are 25% patches and 75% scraps (32 scrap per sheet, 8 patch per sheet)
content.add(content.Recipe {
    id = "xs_gambeson_nylon_thinsleeved",
    result = "xs_gambeson_nylon_thinsleeved",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 19440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component_any({
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "santa_belt", count = 1 }
        })
    :requirement("filament_canvas", 105)
    :requirement("tailoring_nylon_patchwork", 110)
    :requirement("fastener_large", 2)
    :requirement("fastener_small", 8)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
    :byproduct("scrap_nylon", 444)
    :byproduct("nylon", 37)
)

-- 105 nylon sheets by weight, plus extra filament_canvas for quilting threads. Then add 20% more solely
-- converted to byproducts.
-- Garment zips up on the sides of the torso.
-- roughly 42 hours total for the craft. no articulation needed - much simpler than the gambeson.
-- byproducts are 25% patches and 75% scraps (32 scrap per sheet, 8 patch per sheet)
content.add(content.Recipe {
    id = "gambeson_nylon_vest",
    result = "gambeson_nylon_vest",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 15120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :component_any({
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "santa_belt", count = 1 }
        })
    :requirement("filament_canvas", 90)
    :requirement("tailoring_nylon_patchwork", 126)
    :requirement("fastener_large", 2)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_quilting")
    :byproduct("scrap_nylon", 504)
    :byproduct("nylon", 42)
)

-- 158 nylon sheets by weight, plus extra filament_canvas for quilting threads. Then add 20% more solely
-- converted to byproducts.
-- byproducts are 25% patches and 75% scraps (32 scrap per sheet, 8 patch per sheet)
content.add(content.Recipe {
    id = "xl_gambeson_nylon_vest",
    result = "xl_gambeson_nylon_vest",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 22680000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :component_any({
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "santa_belt", count = 1 }
        })
    :requirement("filament_canvas", 135)
    :requirement("tailoring_nylon_patchwork", 190)
    :requirement("fastener_large", 2)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_quilting")
    :byproduct("scrap_nylon", 768)
    :byproduct("nylon", 64)
)

-- 77 nylon sheets by weight, plus extra filament_canvas for quilting threads. Then add 20% more solely
-- converted to byproducts.
-- byproducts are 25% patches and 75% scraps (32 scrap per sheet, 8 patch per sheet)
content.add(content.Recipe {
    id = "xs_gambeson_nylon_vest",
    result = "xs_gambeson_nylon_vest",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 11160000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :component_any({
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "santa_belt", count = 1 }
        })
    :requirement("filament_canvas", 74)
    :requirement("tailoring_nylon_patchwork", 94)
    :requirement("fastener_large", 2)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_quilting")
    :byproduct("scrap_nylon", 360)
    :byproduct("nylon", 30)
)

-- 72 nylon sheets by weight, plus extra filament_canvas for quilting threads. Then add 20% more solely
-- converted to byproducts.
-- Garment zips up on the lower legs and the crotch.
-- roughly 48 hours for the craft, less material here overall than the jack, though articulation still
-- needed.
-- byproducts are 25% patches and 75% scraps (32 scrap per sheet, 8 patch per sheet)
content.add(content.Recipe {
    id = "gambeson_pants_nylon",
    result = "gambeson_pants_nylon",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 17280000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :requirement("filament_canvas", 50)
    :requirement("tailoring_nylon_patchwork", 86)
    :requirement("fastener_small", 5)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
    :byproduct("scrap_nylon", 336)
    :byproduct("nylon", 28)
)

-- 108 nylon sheets by weight, plus extra filament_canvas for quilting threads. Then add 20% more solely
-- converted to byproducts.
-- byproducts are 25% patches and 75% scraps (32 scrap per sheet, 8 patch per sheet)
content.add(content.Recipe {
    id = "xl_gambeson_pants_nylon",
    result = "xl_gambeson_pants_nylon",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 25920000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :requirement("filament_canvas", 75)
    :requirement("tailoring_nylon_patchwork", 130)
    :requirement("fastener_small", 7)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
    :byproduct("scrap_nylon", 528)
    :byproduct("nylon", 44)
)

-- 54 nylon sheets by weight, plus extra filament_canvas for quilting threads. Then add 20% more solely
-- converted to byproducts.
-- byproducts are 25% patches and 75% scraps (32 scrap per sheet, 8 patch per sheet)
content.add(content.Recipe {
    id = "xs_gambeson_pants_nylon",
    result = "xs_gambeson_pants_nylon",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12960000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :requirement("filament_canvas", 38)
    :requirement("tailoring_nylon_patchwork", 65)
    :requirement("fastener_small", 5)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
    :byproduct("scrap_nylon", 264)
    :byproduct("nylon", 22)
)

-- 9 nylon sheets by weight, plus extra filament_canvas for quilting threads. Then add 20% more solely
-- converted to byproducts.
-- byproducts are 25% patches and 75% scraps (32 scrap per sheet, 8 patch per sheet)
content.add(content.Recipe {
    id = "gambeson_gloves_nylon",
    result = "gambeson_gloves_nylon",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3600000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :requirement("filament_canvas", 22)
    :requirement("tailoring_nylon_patchwork", 11)
    :requirement("fastener_small", 4)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
    :byproduct("scrap_nylon", 48)
    :byproduct("nylon", 4)
)

-- 14 nylon sheets by weight, plus extra filament_canvas for quilting threads. Then add 20% more solely
-- converted to byproducts.
-- byproducts are 25% patches and 75% scraps (32 scrap per sheet, 8 patch per sheet)
content.add(content.Recipe {
    id = "xl_gambeson_gloves_nylon",
    result = "xl_gambeson_gloves_nylon",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 5400000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :requirement("filament_canvas", 33)
    :requirement("tailoring_nylon_patchwork", 17)
    :requirement("fastener_small", 4)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
    :byproduct("scrap_nylon", 72)
    :byproduct("nylon", 6)
)

-- 7 nylon sheets by weight, plus extra filament_canvas for quilting threads. Then add 20% more solely
-- converted to byproducts.
-- byproducts are 25% patches and 75% scraps (32 scrap per sheet, 8 patch per sheet)
content.add(content.Recipe {
    id = "xs_gambeson_gloves_nylon",
    result = "xs_gambeson_gloves_nylon",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2880000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :requirement("filament_canvas", 17)
    :requirement("tailoring_nylon_patchwork", 8)
    :requirement("fastener_small", 4)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
    :byproduct("scrap_nylon", 24)
    :byproduct("nylon", 2)
)

-- 1814g per quilt, result is 4355g, so 3 quilts with 1087g of byproducts.
-- Garment zips up on the sides of the torso and along the underside of the arm.
-- roughly 30 hours total for the craft while skilled. articulation needed for the arms.  Lower time thanks
-- to big premade sheets.
-- byproducts are 25% patches and 75% scraps (scrap is 1g and patch is 3g)
content.add(content.Recipe {
    id = "aketon_wool",
    result = "aketon_wool",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 10800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component_any({
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "santa_belt", count = 1 }
        })
    :component_any({
            { id = "quilt", count = 2 },
            { id = "quilt_patchwork", count = 2 }
        })
    :component_any({
            { id = "quilt", count = 1 },
            { id = "quilt_patchwork", count = 1 }
        })
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("filament_canvas", 300)
    :requirement("fastener_large", 2)
    :requirement("fastener_small", 10)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
    :byproduct("scrap_felt", 793)
    :byproduct("felt_patch", 97)
)

-- 1814g per quilt, result is 6532g, so 4 quilts with 724g of byproducts.
-- byproducts are 25% patches and 75% scraps (scrap is 1g and patch is 3g)
content.add(content.Recipe {
    id = "xl_aketon_wool",
    result = "xl_aketon_wool",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 16200000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component_any({
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "santa_belt", count = 1 }
        })
    :component_any({
            { id = "quilt", count = 2 },
            { id = "quilt_patchwork", count = 2 }
        })
    :component_any({
            { id = "quilt", count = 2 },
            { id = "quilt_patchwork", count = 2 }
        })
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("filament_canvas", 450)
    :requirement("fastener_large", 2)
    :requirement("fastener_small", 14)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
    :byproduct("scrap_felt", 543)
    :byproduct("felt_patch", 60)
)

-- 1814g per quilt, result is 3266g, so 2 quilts with 362g of byproducts.
-- byproducts are 25% patches and 75% scraps (scrap is 1g and patch is 3g)
content.add(content.Recipe {
    id = "xs_aketon_wool",
    result = "xs_aketon_wool",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 8100000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component_any({
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "santa_belt", count = 1 }
        })
    :component_any({
            { id = "quilt", count = 1 },
            { id = "quilt_patchwork", count = 1 }
        })
    :component_any({
            { id = "quilt", count = 1 },
            { id = "quilt_patchwork", count = 1 }
        })
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("filament_canvas", 225)
    :requirement("fastener_large", 2)
    :requirement("fastener_small", 14)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
    :byproduct("scrap_felt", 272)
    :byproduct("felt_patch", 30)
)

-- 1814g per quilt, result is 3185g, so 2 quilts with 443g of byproducts.
-- Garment zips up on the sides of the torso and along the underside of the arm.
-- roughly 16 hours total for the craft while skilled.  Lower time thanks to big premade sheets.
-- byproducts are 25% patches and 75% scraps (scrap is 1g and patch is 3g))
content.add(content.Recipe {
    id = "aketon_wool_vest",
    result = "aketon_wool_vest",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 5760000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component_any({
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "santa_belt", count = 1 }
        })
    :component_any({
            { id = "quilt", count = 1 },
            { id = "quilt_patchwork", count = 1 }
        })
    :component_any({
            { id = "quilt", count = 1 },
            { id = "quilt_patchwork", count = 1 }
        })
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("filament_canvas", 225)
    :requirement("fastener_large", 2)
    :requirement("fastener_small", 10)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_quilting")
    :byproduct("scrap_felt", 332)
    :byproduct("felt_patch", 37)
)

-- 1814g per quilt, result is 4778g, so 3 quilts with 664g of byproducts.
-- byproducts are 25% patches and 75% scraps (scrap is 1g and patch is 3g)
content.add(content.Recipe {
    id = "xl_aketon_wool_vest",
    result = "xl_aketon_wool_vest",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 8640000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component_any({
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "santa_belt", count = 1 }
        })
    :component_any({
            { id = "quilt", count = 2 },
            { id = "quilt_patchwork", count = 2 }
        })
    :component_any({
            { id = "quilt", count = 1 },
            { id = "quilt_patchwork", count = 1 }
        })
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("filament_canvas", 310)
    :requirement("fastener_large", 2)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_quilting")
    :byproduct("scrap_felt", 498)
    :byproduct("felt_patch", 55)
)

-- 1814g per quilt, result is 2389g, so 2 quilts with 1239g of byproducts.
-- byproducts are 25% patches and 75% scraps (scrap is 1g and patch is 3g)
content.add(content.Recipe {
    id = "xs_aketon_wool_vest",
    result = "xs_aketon_wool_vest",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 4320000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component_any({
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "santa_belt", count = 1 }
        })
    :component_any({
            { id = "quilt", count = 1 },
            { id = "quilt_patchwork", count = 1 }
        })
    :component_any({
            { id = "quilt", count = 1 },
            { id = "quilt_patchwork", count = 1 }
        })
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("filament_canvas", 155)
    :requirement("fastener_large", 2)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_quilting")
    :byproduct("scrap_felt", 929)
    :byproduct("felt_patch", 103)
)

-- 1814g per quilt, result is 2340g, so 2 quilts with 1288g of byproducts.
-- Garment zips up on the sides of the torso and along the underside of the arm.
-- roughly 20 hours total for the craft while skilled.  Lower time thanks to big premade sheets.
-- byproducts are 25% patches and 75% scraps (scrap is 1g and patch is 3g)
content.add(content.Recipe {
    id = "aketon_pants_wool",
    result = "aketon_pants_wool",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 7200000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component_any({
            { id = "quilt", count = 2 },
            { id = "quilt_patchwork", count = 2 }
        })
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("filament_canvas", 150)
    :requirement("fastener_small", 6)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
    :byproduct("scrap_felt", 967)
    :byproduct("felt_patch", 107)
)

-- 1814g per quilt, result is 3510g, so 2 quilts with 118g of byproducts.
-- byproducts are 25% patches and 75% scraps (scrap is 1g and patch is 3g)
content.add(content.Recipe {
    id = "xl_aketon_pants_wool",
    result = "xl_aketon_pants_wool",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 10800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component_any({
            { id = "quilt", count = 2 },
            { id = "quilt_patchwork", count = 2 }
        })
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("filament_canvas", 225)
    :requirement("fastener_small", 7)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
    :byproduct("scrap_felt", 89)
    :byproduct("felt_patch", 9)
)

-- 1814g per quilt, result is 1755g, so 1 quilt with 59g of byproducts.
-- byproducts are 25% patches and 75% scraps (scrap is 1g and patch is 3g)
content.add(content.Recipe {
    id = "xs_aketon_pants_wool",
    result = "xs_aketon_pants_wool",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 5400000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component_any({
            { id = "quilt", count = 1 },
            { id = "quilt_patchwork", count = 1 }
        })
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("filament_canvas", 112)
    :requirement("fastener_small", 5)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
    :byproduct("scrap_felt", 45)
    :byproduct("felt_patch", 4)
)

-- 1814g per quilt, result is 650g, so 1 quilt with 1164g of byproducts.
-- Garment zips up on the sides of the torso and along the underside of the arm.
-- roughly 5 hours total for the craft while skilled.  Lower time thanks to big premade sheets.
-- byproducts are 25% patches and 75% scraps (scrap is 1g and patch is 3g)
content.add(content.Recipe {
    id = "aketon_hood_wool",
    result = "aketon_hood_wool",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component_any({
            { id = "quilt", count = 1 },
            { id = "quilt_patchwork", count = 1 }
        })
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("filament_canvas", 50)
    :requirement("fastener_small", 2)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_quilting")
    :byproduct("scrap_felt", 873)
    :byproduct("felt_patch", 97)
)

-- 1814g per quilt, result is 975g, so 1 quilt with 839g of byproducts.
-- byproducts are 25% patches and 75% scraps (scrap is 1g and patch is 3g)
content.add(content.Recipe {
    id = "xl_aketon_hood_wool",
    result = "xl_aketon_hood_wool",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2700000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component_any({
            { id = "quilt", count = 1 },
            { id = "quilt_patchwork", count = 1 }
        })
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("filament_canvas", 75)
    :requirement("fastener_small", 3)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_quilting")
    :byproduct("scrap_felt", 629)
    :byproduct("felt_patch", 69)
)

-- 1814g per quilt, result is 487g, so 1 quilt with 1327g of byproducts.
-- byproducts are 25% patches and 75% scraps (scrap is 1g and patch is 3g)
content.add(content.Recipe {
    id = "xs_aketon_hood_wool",
    result = "xs_aketon_hood_wool",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1350000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component_any({
            { id = "quilt", count = 1 },
            { id = "quilt_patchwork", count = 1 }
        })
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("filament_canvas", 37)
    :requirement("fastener_small", 2)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_quilting")
    :byproduct("scrap_felt", 995)
    :byproduct("felt_patch", 110)
)

-- 1814g per quilt, result is 260g, so 1 quilt with 1554g of byproducts.
-- Garment zips up on the sides of the torso and along the underside of the arm.
-- roughly 5 hours total for the craft while skilled.  Lower time thanks to big premade sheets.
-- byproducts are 25% patches and 75% scraps (scrap is 1g and patch is 3g)
content.add(content.Recipe {
    id = "aketon_gloves_wool",
    result = "aketon_gloves_wool",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3600000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component_any({
            { id = "quilt", count = 1 },
            { id = "quilt_patchwork", count = 1 }
        })
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("filament_canvas", 36)
    :requirement("fastener_small", 2)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
    :byproduct("scrap_felt", 1167)
    :byproduct("felt_patch", 129)
)

-- 1814g per quilt, result is 390g, so 1 quilt with 1424g of byproducts.
-- byproducts are 25% patches and 75% scraps (scrap is 1g and patch is 3g)
content.add(content.Recipe {
    id = "xl_aketon_gloves_wool",
    result = "xl_aketon_gloves_wool",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 5400000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component_any({
            { id = "quilt", count = 1 },
            { id = "quilt_patchwork", count = 1 }
        })
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("filament_canvas", 54)
    :requirement("fastener_small", 3)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
    :byproduct("scrap_felt", 1068)
    :byproduct("felt_patch", 118)
)

-- 1814g per quilt, result is 195g, so 1 quilt with 1619g of byproducts.
-- byproducts are 25% patches and 75% scraps (scrap is 1g and patch is 3g)
content.add(content.Recipe {
    id = "xs_aketon_gloves_wool",
    result = "xs_aketon_gloves_wool",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2880000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component_any({
            { id = "quilt", count = 1 },
            { id = "quilt_patchwork", count = 1 }
        })
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("filament_canvas", 27)
    :requirement("fastener_small", 2)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
    :byproduct("scrap_felt", 1214)
    :byproduct("felt_patch", 135)
)

-- 1814g per quilt, result is 10140g, so 6 quilts with 744g of byproducts.
-- Garment zips up on the sides of the torso and along the underside of the arm.
-- roughly 65 hours total for the craft while skilled. articulation needed for the arms.  Lower time thanks
-- to big premade sheets.
-- byproducts are 25% patches and 75% scraps (scrap is 1g and patch is 3g)
content.add(content.Recipe {
    id = "gambeson_wool",
    result = "gambeson_wool",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 23400000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component_any({
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "santa_belt", count = 1 }
        })
    :component_any({
            { id = "quilt", count = 3 },
            { id = "quilt_patchwork", count = 3 }
        })
    :component_any({
            { id = "quilt", count = 3 },
            { id = "quilt_patchwork", count = 3 }
        })
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("filament_canvas", 700)
    :requirement("fastener_large", 2)
    :requirement("fastener_small", 10)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
    :byproduct("scrap_felt", 558)
    :byproduct("felt_patch", 62)
)

-- 1814g per quilt, result is 15210g, so 9 quilts with 1116g of byproducts.
-- byproducts are 25% patches and 75% scraps (scrap is 1g and patch is 3g)
content.add(content.Recipe {
    id = "xl_gambeson_wool",
    result = "xl_gambeson_wool",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 34920000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component_any({
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "santa_belt", count = 1 }
        })
    :component_any({
            { id = "quilt", count = 5 },
            { id = "quilt_patchwork", count = 5 }
        })
    :component_any({
            { id = "quilt", count = 4 },
            { id = "quilt_patchwork", count = 4 }
        })
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("filament_canvas", 1050)
    :requirement("fastener_large", 2)
    :requirement("fastener_small", 15)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
    :byproduct("scrap_felt", 837)
    :byproduct("felt_patch", 93)
)

-- 1814g per quilt, result is 7605g, so 5 quilts with 1465g of byproducts.
-- byproducts are 25% patches and 75% scraps (scrap is 1g and patch is 3g)
content.add(content.Recipe {
    id = "xs_gambeson_wool",
    result = "xs_gambeson_wool",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 17640000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component_any({
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "santa_belt", count = 1 }
        })
    :component_any({
            { id = "quilt", count = 3 },
            { id = "quilt_patchwork", count = 3 }
        })
    :component_any({
            { id = "quilt", count = 2 },
            { id = "quilt_patchwork", count = 2 }
        })
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("filament_canvas", 550)
    :requirement("fastener_large", 2)
    :requirement("fastener_small", 8)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
    :byproduct("scrap_felt", 1099)
    :byproduct("felt_patch", 122)
)

-- 1814g per quilt, result is 8970g, so 5 quilts with 100g of byproducts.
-- Garment zips up on the sides of the torso and along the underside of the arm.
-- roughly 58 hours total for the craft while skilled. articulation needed for the arms.  Lower time thanks
-- to big premade sheets.
-- byproducts are 25% patches and 75% scraps (scrap is 1g and patch is 3g)
content.add(content.Recipe {
    id = "gambeson_wool_thinsleeved",
    result = "gambeson_wool_thinsleeved",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 20880000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component_any({
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "santa_belt", count = 1 }
        })
    :component_any({
            { id = "quilt", count = 3 },
            { id = "quilt_patchwork", count = 3 }
        })
    :component_any({
            { id = "quilt", count = 2 },
            { id = "quilt_patchwork", count = 2 }
        })
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("filament_canvas", 600)
    :requirement("fastener_large", 2)
    :requirement("fastener_small", 10)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
    :byproduct("scrap_felt", 76)
    :byproduct("felt_patch", 8)
)

-- 1814g per quilt, result is 13455g, so 8 quilts with 1057g of byproducts.
-- byproducts are 25% patches and 75% scraps (scrap is 1g and patch is 3g)
content.add(content.Recipe {
    id = "xl_gambeson_wool_thinsleeved",
    result = "xl_gambeson_wool_thinsleeved",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 31320000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component_any({
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "santa_belt", count = 1 }
        })
    :component_any({
            { id = "quilt", count = 4 },
            { id = "quilt_patchwork", count = 4 }
        })
    :component_any({
            { id = "quilt", count = 4 },
            { id = "quilt_patchwork", count = 4 }
        })
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("filament_canvas", 900)
    :requirement("fastener_large", 2)
    :requirement("fastener_small", 15)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
    :byproduct("scrap_felt", 793)
    :byproduct("felt_patch", 88)
)

-- 1814g per quilt, result is 6727g, so 4 quilts with 529g of byproducts.
-- byproducts are 25% patches and 75% scraps (scrap is 1g and patch is 3g)
content.add(content.Recipe {
    id = "xs_gambeson_wool_thinsleeved",
    result = "xs_gambeson_wool_thinsleeved",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 15840000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component_any({
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "santa_belt", count = 1 }
        })
    :component_any({
            { id = "quilt", count = 2 },
            { id = "quilt_patchwork", count = 2 }
        })
    :component_any({
            { id = "quilt", count = 2 },
            { id = "quilt_patchwork", count = 2 }
        })
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("filament_canvas", 450)
    :requirement("fastener_large", 2)
    :requirement("fastener_small", 8)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
    :byproduct("scrap_felt", 397)
    :byproduct("felt_patch", 44)
)

-- 1814g per quilt, result is 7800g, so 5 quilts with 1270g of byproducts.
-- Garment zips up on the sides of the torso and along the underside of the arm.
-- roughly 36 hours total for the craft while skilled. much simpler craft, articulation not needed.  Lower
-- time thanks to big premade sheets.
-- byproducts are 25% patches and 75% scraps (scrap is 1g and patch is 3g)
content.add(content.Recipe {
    id = "gambeson_wool_vest",
    result = "gambeson_wool_vest",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12960000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component_any({
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "santa_belt", count = 1 }
        })
    :component_any({
            { id = "quilt", count = 3 },
            { id = "quilt_patchwork", count = 3 }
        })
    :component_any({
            { id = "quilt", count = 2 },
            { id = "quilt_patchwork", count = 2 }
        })
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("filament_canvas", 520)
    :requirement("fastener_large", 2)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_quilting")
    :byproduct("scrap_felt", 76)
    :byproduct("felt_patch", 8)
)

-- 1814g per quilt, result is 11700g, so 7 quilts with 998g of byproducts.
-- byproducts are 25% patches and 75% scraps (scrap is 1g and patch is 3g)
content.add(content.Recipe {
    id = "xl_gambeson_wool_vest",
    result = "xl_gambeson_wool_vest",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 19440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component_any({
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "santa_belt", count = 1 }
        })
    :component_any({
            { id = "quilt", count = 4 },
            { id = "quilt_patchwork", count = 4 }
        })
    :component_any({
            { id = "quilt", count = 3 },
            { id = "quilt_patchwork", count = 3 }
        })
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("filament_canvas", 795)
    :requirement("fastener_large", 2)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_quilting")
    :byproduct("scrap_felt", 749)
    :byproduct("felt_patch", 83)
)

-- 1814g per quilt, result is 5850g, so 4 quilts with 1406g of byproducts.
-- byproducts are 25% patches and 75% scraps (scrap is 1g and patch is 3g)
content.add(content.Recipe {
    id = "xs_gambeson_wool_vest",
    result = "xs_gambeson_wool_vest",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 9720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component_any({
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "santa_belt", count = 1 }
        })
    :component_any({
            { id = "quilt", count = 2 },
            { id = "quilt_patchwork", count = 2 }
        })
    :component_any({
            { id = "quilt", count = 2 },
            { id = "quilt_patchwork", count = 2 }
        })
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("filament_canvas", 398)
    :requirement("fastener_large", 2)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_quilting")
    :byproduct("scrap_felt", 1055)
    :byproduct("felt_patch", 117)
)

-- 1814g per quilt, result is 4680g, so 3 quilts with 762g of byproducts.
-- Garment zips up on the sides of the torso and along the underside of the arm.
-- roughly 40 hours total for the craft while skilled.  Lower time thanks to big premade sheets.
-- byproducts are 25% patches and 75% scraps (scrap is 1g and patch is 3g)
content.add(content.Recipe {
    id = "gambeson_pants_wool",
    result = "gambeson_pants_wool",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 14400000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component_any({
            { id = "quilt", count = 2 },
            { id = "quilt_patchwork", count = 2 }
        })
    :component_any({
            { id = "quilt", count = 1 },
            { id = "quilt_patchwork", count = 1 }
        })
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("filament_canvas", 270)
    :requirement("fastener_small", 5)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
    :byproduct("scrap_felt", 573)
    :byproduct("felt_patch", 63)
)

-- 1814g per quilt, result is 7020g, so 4 quilts with 236g of byproducts.
-- byproducts are 25% patches and 75% scraps (scrap is 1g and patch is 3g)
content.add(content.Recipe {
    id = "xl_gambeson_pants_wool",
    result = "xl_gambeson_pants_wool",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 21600000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component_any({
            { id = "quilt", count = 2 },
            { id = "quilt_patchwork", count = 2 }
        })
    :component_any({
            { id = "quilt", count = 2 },
            { id = "quilt_patchwork", count = 2 }
        })
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("filament_canvas", 405)
    :requirement("fastener_small", 7)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
    :byproduct("scrap_felt", 116)
    :byproduct("felt_patch", 20)
)

-- 1814g per quilt, result is 3510g, so 2 quilts with 118g of byproducts.
-- byproducts are 25% patches and 75% scraps (scrap is 1g and patch is 3g)
content.add(content.Recipe {
    id = "xs_gambeson_pants_wool",
    result = "xs_gambeson_pants_wool",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 10800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component_any({
            { id = "quilt", count = 1 },
            { id = "quilt_patchwork", count = 1 }
        })
    :component_any({
            { id = "quilt", count = 1 },
            { id = "quilt_patchwork", count = 1 }
        })
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("filament_canvas", 202)
    :requirement("fastener_small", 5)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
    :byproduct("scrap_felt", 58)
    :byproduct("felt_patch", 10)
)

-- 1814g per quilt, result is 585g, so 1 quilt with 1289g of byproducts.
-- Garment zips up on the sides of the torso and along the underside of the arm.
-- roughly 8 hours total for the craft while skilled.  Lower time thanks to big premade sheets.
-- byproducts are 25% patches and 75% scraps (scrap is 1g and patch is 3g)
content.add(content.Recipe {
    id = "gambeson_gloves_wool",
    result = "gambeson_gloves_wool",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2880000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component_any({
            { id = "quilt", count = 1 },
            { id = "quilt_patchwork", count = 1 }
        })
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("filament_canvas", 70)
    :requirement("fastener_small", 2)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
    :byproduct("scrap_felt", 968)
    :byproduct("felt_patch", 107)
)

-- 1814g per quilt, result is 878g, so 1 quilt with 936g of byproducts.
-- byproducts are 25% patches and 75% scraps (scrap is 1g and patch is 3g)
content.add(content.Recipe {
    id = "xl_gambeson_gloves_wool",
    result = "xl_gambeson_gloves_wool",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 4320000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component_any({
            { id = "quilt", count = 1 },
            { id = "quilt_patchwork", count = 1 }
        })
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("filament_canvas", 105)
    :requirement("fastener_small", 3)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
    :byproduct("scrap_felt", 702)
    :byproduct("felt_patch", 78)
)

-- 1814g per quilt, result is 439g, so 1 quilt with 1375g of byproducts.
-- byproducts are 25% patches and 75% scraps (scrap is 1g and patch is 3g)
content.add(content.Recipe {
    id = "xs_gambeson_gloves_wool",
    result = "xs_gambeson_gloves_wool",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2160000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component_any({
            { id = "quilt", count = 1 },
            { id = "quilt_patchwork", count = 1 }
        })
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("filament_canvas", 52)
    :requirement("fastener_small", 2)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
    :byproduct("scrap_felt", 1031)
    :byproduct("felt_patch", 114)
)

-- basically just anything you can fit inside some sheets as stuffing to make a gambeson more cheaply
content.add(content.Recipe {
    id = "gambeson_batting",
    result = "gambeson_batting",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_TOOLS",
    duration_moves = 500,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    result_multiplier = 4,
}
    :component_any({
            { id = "scrap_cotton", count = 200 },
            { id = "scrap_felt", count = 200 },
            { id = "scrap_canvas", count = 100 },
            { id = "scrap_fur", count = 67 },
            { id = "cotton_patchwork", count = 40 },
            { id = "felt_patch", count = 50 },
            { id = "wool_staple", count = 200 },
            { id = "sinew", count = 200 },
            { id = "thread", count = 200 },
            { id = "yarn", count = 200 },
            { id = "plant_fibre", count = 200 },
            { id = "straw_pile", count = 10 },
            { id = "cable", count = 13 }
        })
    :quality("CUT", 1, 1)
)

-- 420g per sheet (each Sheet is roughly 0.25mm, being two layers of cotton each about half the GSM of canvas
-- which is .25mm)
-- 4200g of sheets total for a 11850g product, leaving 7650g of waste fabric batting
-- Garment zips up on the sides of the torso and along the underside of the arm.
-- roughly 36 hours total for the craft while skilled. articulation needed for the arms.  Much lower time
-- thanks to big premade sheets + batting layers.
-- no byproducts because whatever is left would get shredded up and stuffed in the gambeson (batting is 50g
-- each)
content.add(content.Recipe {
    id = "gambeson",
    result = "gambeson",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12960000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :component_any({
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "santa_belt", count = 1 }
        })
    :component("sheet", 10)
    :component("gambeson_batting", 153)
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("filament_canvas", 350)
    :requirement("fastener_large", 2)
    :requirement("fastener_small", 10)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
)

-- 420g per sheet (each Sheet is roughly 0.25mm, being two layers of cotton each about half the GSM of canvas
-- which is .25mm)
-- 6300g of sheets total for a 17775g product, leaving 11475g of waste fabric batting
content.add(content.Recipe {
    id = "xl_gambeson",
    result = "xl_gambeson",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 19440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :component_any({
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "santa_belt", count = 1 }
        })
    :component("sheet", 15)
    :component("gambeson_batting", 230)
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("filament_canvas", 475)
    :requirement("fastener_large", 2)
    :requirement("fastener_small", 16)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
)

-- 420g per sheet (each Sheet is roughly 0.25mm, being two layers of cotton each about half the GSM of canvas
-- which is .25mm)
-- 3360g of sheets total for a 8887g product, leaving 5527g of waste fabric batting
content.add(content.Recipe {
    id = "gambeson_xs",
    result = "gambeson_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 19440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :component_any({
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "santa_belt", count = 1 }
        })
    :component("sheet", 8)
    :component("gambeson_batting", 111)
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("filament_canvas", 233)
    :requirement("fastener_large", 2)
    :requirement("fastener_small", 8)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
)

-- 420g per sheet (each Sheet is roughly 0.25mm, being two layers of cotton each about half the GSM of canvas
-- which is .25mm)
-- 4200g of sheets total for a 9120g product, leaving 4920g of waste fabric batting
-- Garment zips up on the sides of the torso.
-- roughly 20 hours total for the craft while skilled.  Much lower time thanks to big premade sheets +
-- batting layers.
-- no byproducts because whatever is left would get shredded up and stuffed in the gambeson (batting is 50g
-- each)
content.add(content.Recipe {
    id = "gambeson_vest",
    result = "gambeson_vest",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 7200000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :component_any({
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "santa_belt", count = 1 }
        })
    :component("sheet", 10)
    :component("gambeson_batting", 99)
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("filament_canvas", 260)
    :requirement("fastener_large", 2)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_quilting")
)

-- 420g per sheet (each Sheet is roughly 0.25mm, being two layers of cotton each about half the GSM of canvas
-- which is .25mm)
-- 6300g of sheets total for a 13680g product, leaving 7380g of waste fabric batting
content.add(content.Recipe {
    id = "xl_gambeson_vest",
    result = "xl_gambeson_vest",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 19440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :component_any({
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "santa_belt", count = 1 }
        })
    :component("sheet", 15)
    :component("gambeson_batting", 148)
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("filament_canvas", 390)
    :requirement("fastener_large", 2)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_quilting")
)

-- 420g per sheet (each Sheet is roughly 0.25mm, being two layers of cotton each about half the GSM of canvas
-- which is .25mm)
-- 3360g of sheets total for a 6840g product, leaving 3480g of waste fabric batting
content.add(content.Recipe {
    id = "gambeson_vest_xs",
    result = "gambeson_vest_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 19440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :component_any({
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "santa_belt", count = 1 }
        })
    :component("sheet", 8)
    :component("gambeson_batting", 70)
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("filament_canvas", 195)
    :requirement("fastener_large", 2)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_quilting")
)

-- 420g per sheet (each Sheet is roughly 0.25mm, being two layers of cotton each about half the GSM of canvas
-- which is .25mm)
-- 1680g of sheets total for a 2736g product, leaving 1056g of waste fabric batting
-- Garment zips up on the lower legs and the crotch.
-- roughly 24 hours for the craft, less material here overall than the jack, though articulation still
-- needed.  Much lower time thanks to big premade sheets + batting layers and being overall much thinner..
-- no byproducts because whatever is left would get shredded up and stuffed in the gambeson (batting is 50g
-- each)
content.add(content.Recipe {
    id = "gambeson_pants",
    result = "gambeson_pants",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 7200000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :component("sheet", 4)
    :component("gambeson_batting", 21)
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("filament_canvas", 100)
    :requirement("fastener_small", 5)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
)

-- 420g per sheet (each Sheet is roughly 0.25mm, being two layers of cotton each about half the GSM of canvas
-- which is .25mm)
-- 2520g of sheets total for a 4104g product, leaving 1584g of waste fabric batting
content.add(content.Recipe {
    id = "xl_gambeson_pants",
    result = "xl_gambeson_pants",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 19440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :component("sheet", 6)
    :component("gambeson_batting", 32)
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("filament_canvas", 150)
    :requirement("fastener_large", 2)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
)

-- 420g per sheet (each Sheet is roughly 0.25mm, being two layers of cotton each about half the GSM of canvas
-- which is .25mm)
-- 1260g of sheets total for a 2052g product, leaving 792g of waste fabric batting
content.add(content.Recipe {
    id = "gambeson_pants_xs",
    result = "gambeson_pants_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 19440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :component("sheet", 3)
    :component("gambeson_batting", 16)
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("filament_canvas", 75)
    :requirement("fastener_large", 2)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
)

-- 420g per sheet (each Sheet is roughly 0.25mm, being two layers of cotton each about half the GSM of canvas
-- which is .25mm)
-- 420g of sheets total for a 510g product, leaving 10g of waste fabric batting
-- Garment zips up on the lower legs and the crotch.
-- roughly 24 hours for the craft, less material here overall than the jack, though articulation still
-- needed.  Much lower time thanks to big premade sheets + batting layers and being overall much thinner..
-- no byproducts because whatever is left would get shredded up and stuffed in the gambeson (batting is 50g
-- each)
content.add(content.Recipe {
    id = "gambeson_hood",
    result = "gambeson_hood",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component("sheet", 1)
    :component("gambeson_batting", 2)
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("filament_canvas", 30)
    :requirement("fastener_small", 2)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_quilting")
)

content.add(content.Recipe {
    id = "xl_gambeson_hood",
    result = "xl_gambeson_hood",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component("sheet", 2)
    :component("gambeson_batting", 3)
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("filament_canvas", 45)
    :requirement("fastener_small", 3)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_quilting")
)

content.add(content.Recipe {
    id = "xs_gambeson_hood",
    result = "xs_gambeson_hood",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component("sheet", 1)
    :component("gambeson_batting", 1)
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("filament_canvas", 24)
    :requirement("fastener_small", 2)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_quilting")
)
