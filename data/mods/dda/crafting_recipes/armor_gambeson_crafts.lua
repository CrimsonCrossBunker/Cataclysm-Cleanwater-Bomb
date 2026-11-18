local content = require("ccb").content

local LIGHT_EXERCISE = 2

-- 67 nylon sheets by weight, plus extra filament_canvas for quilting threads. Then add 20% more solely
-- converted to byproducts.
-- Garment zips up on the sides of the torso and along the underside of the arm.
-- roughly 40 hours total for the craft while skilled. articulation needed for the arms.
-- byproducts are 25% patches and 75% scraps (32 scrap per sheet, 8 patch per sheet)
content.add(content.Recipe {
    id = "aketon_nylon",
    result = "aketon_nylon",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 13680000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 6,
}
    :component_any({
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "santa_belt", count = 1 }
        })
    :requirement("filament_canvas", 100)
    :requirement("tailoring_nylon_patchwork", 80)
    :requirement("fastener_large", 2)
    :requirement("fastener_small", 10)
    :book("textbook_armwest", 4)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
    :byproduct("scrap_nylon", 312)
    :byproduct("nylon", 26)
)

-- 100 nylon sheets by weight, plus extra filament_canvas for quilting threads. Then add 20% more solely
-- converted to byproducts.
-- byproducts are 25% patches and 75% scraps (32 scrap per sheet, 8 patch per sheet)
content.add(content.Recipe {
    id = "xl_aketon_nylon",
    result = "xl_aketon_nylon",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 20520000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 6,
}
    :component_any({
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "santa_belt", count = 1 }
        })
    :requirement("filament_canvas", 150)
    :requirement("tailoring_nylon_patchwork", 120)
    :requirement("fastener_large", 2)
    :requirement("fastener_small", 14)
    :book("textbook_armwest", 4)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
    :byproduct("scrap_nylon", 480)
    :byproduct("nylon", 40)
)

-- 50 canvas sheets by weight, plus extra filament_canvas for quilting threads. Then add 20% more solely
-- converted to byproducts.
-- byproducts are 25% patches and 75% scraps (32 scrap per sheet, 8 patch per sheet)
content.add(content.Recipe {
    id = "xs_aketon_nylon",
    result = "xs_aketon_nylon",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 10440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 6,
}
    :component_any({
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "santa_belt", count = 1 }
        })
    :requirement("filament_canvas", 75)
    :requirement("tailoring_nylon_patchwork", 60)
    :requirement("fastener_large", 2)
    :requirement("fastener_small", 8)
    :book("textbook_armwest", 4)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
    :byproduct("scrap_nylon", 240)
    :byproduct("nylon", 20)
)

-- 49 nylon sheets by weight, plus extra filament_canvas for quilting threads. Then add 20% more solely
-- converted to byproducts.
-- Garment zips up on the sides of the torso.
-- roughly 20 hours total for the craft. no articulation needed - much simpler than the jacket.
-- byproducts are 25% patches and 75% scraps (32 scrap per sheet, 8 patch per sheet)
content.add(content.Recipe {
    id = "aketon_nylon_vest",
    result = "aketon_nylon_vest",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 7200000,
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
    :requirement("filament_canvas", 70)
    :requirement("tailoring_nylon_patchwork", 59)
    :requirement("fastener_large", 2)
    :book("textbook_armwest", 4)
    :proficiency("prof_closures")
    :proficiency("prof_quilting")
    :byproduct("scrap_nylon", 240)
    :byproduct("nylon", 20)
)

-- 75 nylon sheets by weight, plus extra filament_canvas for quilting threads. Then add 20% more solely
-- converted to byproducts.
-- byproducts are 25% patches and 75% scraps (32 scrap per sheet, 8 patch per sheet)
content.add(content.Recipe {
    id = "xl_aketon_nylon_vest",
    result = "xl_aketon_nylon_vest",
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
    :requirement("filament_canvas", 105)
    :requirement("tailoring_nylon_patchwork", 90)
    :requirement("fastener_large", 2)
    :book("textbook_armwest", 4)
    :proficiency("prof_closures")
    :proficiency("prof_quilting")
    :byproduct("scrap_nylon", 360)
    :byproduct("nylon", 30)
)

-- 38 nylon sheets by weight, plus extra filament_canvas for quilting threads. Then add 20% more solely
-- converted to byproducts.
-- byproducts are 25% patches and 75% scraps (32 scrap per sheet, 8 patch per sheet)
content.add(content.Recipe {
    id = "xs_aketon_nylon_vest",
    result = "xs_aketon_nylon_vest",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 5400000,
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
    :requirement("filament_canvas", 53)
    :requirement("tailoring_nylon_patchwork", 45)
    :requirement("fastener_large", 2)
    :book("textbook_armwest", 4)
    :proficiency("prof_closures")
    :proficiency("prof_quilting")
    :byproduct("scrap_nylon", 180)
    :byproduct("nylon", 15)
)

-- 36 nylon sheets by weight, plus extra filament_canvas for quilting threads. Then add 20% more solely
-- converted to byproducts.
-- Garment zips up on the lower legs and the crotch.
-- roughly 24 hours for the craft, less material here overall than the jack, though articulation still
-- needed.
-- byproducts are 25% patches and 75% scraps (32 scrap per sheet, 8 patch per sheet)
content.add(content.Recipe {
    id = "aketon_pants_nylon",
    result = "aketon_pants_nylon",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 8640000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 6,
}
    :requirement("filament_canvas", 40)
    :requirement("tailoring_nylon_patchwork", 42)
    :requirement("fastener_small", 5)
    :book("textbook_armwest", 4)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
    :byproduct("scrap_nylon", 144)
    :byproduct("nylon", 12)
)

-- 54 nylon sheets by weight, plus extra filament_canvas for quilting threads. Then add 20% more solely
-- converted to byproducts.
-- byproducts are 25% patches and 75% scraps (32 scrap per sheet, 8 patch per sheet)
content.add(content.Recipe {
    id = "xl_aketon_pants_nylon",
    result = "xl_aketon_pants_nylon",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 12960000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 6,
}
    :component_any({
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "santa_belt", count = 1 }
        })
    :requirement("filament_canvas", 60)
    :requirement("tailoring_nylon_patchwork", 63)
    :requirement("fastener_small", 7)
    :book("textbook_armwest", 4)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
    :byproduct("scrap_nylon", 216)
    :byproduct("nylon", 18)
)

-- 27 nylon sheets by weight, plus extra filament_canvas for quilting threads. Then add 20% more solely
-- converted to byproducts.
-- byproducts are 25% patches and 75% scraps (32 scrap per sheet, 8 patch per sheet)
content.add(content.Recipe {
    id = "xs_aketon_pants_nylon",
    result = "xs_aketon_pants_nylon",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 6480000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 6,
}
    :component_any({
            { id = "leather_belt", count = 1 },
            { id = "webbing_belt", count = 1 },
            { id = "santa_belt", count = 1 }
        })
    :requirement("filament_canvas", 30)
    :requirement("tailoring_nylon_patchwork", 31)
    :requirement("fastener_small", 5)
    :book("textbook_armwest", 4)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
    :byproduct("scrap_nylon", 108)
    :byproduct("nylon", 9)
)

-- 10 nylon sheets by weight, plus extra filament_canvas for quilting threads. Then add 20% more solely
-- converted to byproducts.
-- byproducts are 25% patches and 75% scraps (32 scrap per sheet, 8 patch per sheet)
content.add(content.Recipe {
    id = "aketon_hood_nylon",
    result = "aketon_hood_nylon",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2160000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :requirement("filament_canvas", 10)
    :requirement("tailoring_nylon_patchwork", 12)
    :requirement("fastener_small", 2)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_quilting")
    :byproduct("scrap_nylon", 48)
    :byproduct("nylon", 4)
)

-- 15 nylon sheets by weight, plus extra filament_canvas for quilting threads. Then add 20% more solely
-- converted to byproducts.
-- byproducts are 25% patches and 75% scraps (32 scrap per sheet, 8 patch per sheet)
content.add(content.Recipe {
    id = "xl_aketon_hood_nylon",
    result = "xl_aketon_hood_nylon",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :requirement("filament_canvas", 15)
    :requirement("tailoring_nylon_patchwork", 18)
    :requirement("fastener_small", 4)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_quilting")
    :byproduct("scrap_nylon", 72)
    :byproduct("nylon", 6)
)

-- 8 nylon sheets by weight, plus extra filament_canvas for quilting threads. Then add 20% more solely
-- converted to byproducts.
-- byproducts are 25% patches and 75% scraps (32 scrap per sheet, 8 patch per sheet)
content.add(content.Recipe {
    id = "xs_aketon_hood_nylon",
    result = "xs_aketon_hood_nylon",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :requirement("filament_canvas", 8)
    :requirement("tailoring_nylon_patchwork", 9)
    :requirement("fastener_small", 2)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_quilting")
    :byproduct("scrap_nylon", 36)
    :byproduct("nylon", 3)
)

-- 4 nylon sheets by weight, plus extra filament_canvas for quilting threads
-- byproducts are 25% patches and 75% scraps (32 scrap per sheet, 8 patch per sheet)
content.add(content.Recipe {
    id = "aketon_gloves_nylon",
    result = "aketon_gloves_nylon",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2160000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :requirement("filament_canvas", 10)
    :requirement("tailoring_nylon_patchwork", 5)
    :requirement("fastener_small", 2)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
    :byproduct("scrap_nylon", 24)
    :byproduct("nylon", 2)
)

-- 6 nylon sheets by weight, plus extra filament_canvas for quilting threads. Then add 20% more solely
-- converted to byproducts.
-- byproducts are 25% patches and 75% scraps (32 scrap per sheet, 8 patch per sheet)
content.add(content.Recipe {
    id = "xl_aketon_gloves_nylon",
    result = "xl_aketon_gloves_nylon",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :requirement("filament_canvas", 15)
    :requirement("tailoring_nylon_patchwork", 6)
    :requirement("fastener_small", 2)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
    :byproduct("scrap_nylon", 36)
    :byproduct("nylon", 3)
)

-- 3 nylon sheets by weight, plus extra filament_canvas for quilting threads. Then add 20% more solely
-- converted to byproducts.
-- byproducts are 25% patches and 75% scraps (32 scrap per sheet, 8 patch per sheet)
content.add(content.Recipe {
    id = "xs_aketon_gloves_nylon",
    result = "xs_aketon_gloves_nylon",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :requirement("filament_canvas", 8)
    :requirement("tailoring_nylon_patchwork", 4)
    :requirement("fastener_small", 2)
    :book("textbook_armwest", 3)
    :proficiency("prof_closures")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
    :byproduct("scrap_nylon", 18)
    :byproduct("nylon", 1)
)
