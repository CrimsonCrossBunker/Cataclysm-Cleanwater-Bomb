local content = require("ccb").content

local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "kantele",
    result = "kantele",
    category = "CC_MUSIC",
    subcategory = "CSC_MUSIC_STRING",
    duration_moves = 3720000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("tonewood", 2)
    :component("glue_weak", 2)
    :component("wood_panel", 1)
    :component("qt_wire", 5)
    :component("tuning_pegs", 5)
    :quality("LUTHIER", 1, 1)
    :quality("SAW_W", 2, 1)
    :quality("CHISEL_WOOD", 1, 1)
    :proficiency("prof_carpentry_basic")
    :proficiency("prof_luthier_basic")
    :byproduct("splinter", 68)
)

content.add(content.Recipe {
    id = "krar",
    result = "krar",
    category = "CC_MUSIC",
    subcategory = "CSC_MUSIC_STRING",
    duration_moves = 2520000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("tonewood", 3)
    :component("glue_weak", 2)
    :component("wood_panel", 1)
    :component("qt_wire", 5)
    :component("tuning_pegs", 5)
    :quality("LUTHIER", 1, 1)
    :quality("SAW_W", 2, 1)
    :quality("CHISEL_WOOD", 1, 1)
    :proficiency("prof_carpentry_basic")
    :proficiency("prof_luthier_basic")
    :byproduct("splinter", 68)
)

content.add(content.Recipe {
    id = "acoustic_guitar",
    result = "acoustic_guitar",
    category = "CC_MUSIC",
    subcategory = "CSC_MUSIC_STRING",
    duration_moves = 4320000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :component("tonewood", 2)
    :component("glue_weak", 2)
    :component("wood_panel", 1)
    :component("qt_wire", 6)
    :component("tuning_pegs", 6)
    :quality("LUTHIER", 1, 1)
    :quality("SAW_W", 2, 1)
    :quality("CHISEL_WOOD", 1, 1)
    :proficiency("prof_carpentry_basic")
    :proficiency("prof_luthier_basic")
    :byproduct("splinter", 89)
)

content.add(content.Recipe {
    id = "drum_percussion",
    result = "drum_percussion",
    category = "CC_MUSIC",
    subcategory = "CSC_MUSIC_STRING",
    duration_moves = 4320000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("tonewood", 6)
    :component("glue_weak", 2)
    :component("drum_skin", 2)
    :component("tuning_pegs", 12)
    :quality("LUTHIER", 1, 1)
    :quality("SAW_W", 2, 1)
    :quality("CHISEL_WOOD", 1, 1)
    :proficiency("prof_carpentry_basic")
    :byproduct("splinter", 89)
)

content.add(content.Recipe {
    id = "drum_percussion_primitive",
    result = "drum_percussion_primitive",
    category = "CC_MUSIC",
    subcategory = "CSC_MUSIC_STRING",
    duration_moves = 4320000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("tonewood", 6)
    :component("glue_weak", 2)
    :component("tanned_hide", 2)
    :component("tuning_pegs", 12)
    :quality("LUTHIER", 1, 1)
    :quality("SAW_W", 2, 1)
    :quality("CHISEL_WOOD", 1, 1)
    :proficiency("prof_carpentry_basic")
    :byproduct("splinter", 89)
)
