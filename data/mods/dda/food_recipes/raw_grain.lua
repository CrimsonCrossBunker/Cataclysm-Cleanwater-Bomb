local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2
local BRISK_EXERCISE = 6

-- a minute in the microwave seems about right for such a small quantity
content.add(content.Recipe {
    id = "popcorn",
    result = "popcorn",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SNACK",
    duration_moves = 18000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("surface_heat", 3, true)
    :component("kernels", 1)
    :quality("COOK", 2, 1)
    :batch_discount(80, 1)
    :result_charges(4)
)

content.add(content.Recipe {
    id = "popcorn2",
    result = "popcorn2",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SNACK",
    duration_moves = 1800,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :component("popcorn", 1)
    :component_any({
            { id = "salt", count = 1 },
            { id = "seasoning_salt", count = 1 }
        })
    :batch_discount(80, 1)
    :result_charges(1)
)

-- 3u to pop the corn and 1u to melt the butter
content.add(content.Recipe {
    id = "popcorn3",
    result = "popcorn3",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 4, true)
    :component("kernels", 1)
    :component("any_butter", 1, true)
    :component_any({
            { id = "salt", count = 1 },
            { id = "seasoning_salt", count = 1 }
        })
    :quality("COOK", 3, 1)
    :batch_discount(80, 4)
    :result_charges(4)
)

content.add(content.Recipe {
    id = "corn_kernels",
    result = "corn_kernels",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 2000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :component("corn", 1)
    :quality("CUT", 1, 1)
    :byproduct("empty_corn_cob", 1)
)

-- qualities aren't inherited for some reason
content.add(content.Recipe {
    id = "corn_kernels_bulk",
    result = "corn_kernels",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 20000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    result_multiplier = 10,
    name = content.text("bulk %s"),
}
    :component("corn", 10)
    :quality("CUT", 1, 1)
    :byproduct("empty_corn_cob", 10)
)

content.add(content.Recipe {
    id = "popcorn_raw",
    result = "popcorn_raw",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 2000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :component("popcorn_cob", 1)
    :quality("CUT", 1, 1)
    :byproduct("empty_corn_cob", 1)
)

-- qualities aren't inherited for some reason
content.add(content.Recipe {
    id = "popcorn_raw_bulk",
    result = "popcorn_raw",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 20000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    result_multiplier = 10,
    name = content.text("bulk %s"),
}
    :component("popcorn_cob", 10)
    :quality("CUT", 1, 1)
    :byproduct("empty_corn_cob", 10)
)

content.add(content.Recipe {
    id = "kernels",
    result = "kernels",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_DRY",
    duration_moves = 108000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("dehydrating_heat", 15, true)
    :component("popcorn_raw", 1)
    :proficiency("prof_preservation")
    :batch_discount(67, 5)
    :result_charges(1)
)

-- Not having a flail slows this down considerably.
content.add(content.Recipe {
    id = "threshed_wheat",
    result = "threshed_wheat",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 90000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "survival",
}
    :tool_any({
            { id = "stick", count = 1 },
            { id = "2x4", count = 1 },
            { id = "club_wooden", count = 1 },
            { id = "cudgel", count = 1 }
        })
    :component("dry_wheat_stalks", 1)
    :batch_discount(90, 1)
    :byproduct("straw_pile", 2)
)

-- tools aren't inherited for some reason
content.add(content.Recipe {
    id = "threshed_wheat_bulk",
    result = "threshed_wheat",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 171300,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "survival",
    result_multiplier = 10,
    name = content.text("bulk %s"),
}
    :tool_any({
            { id = "stick", count = 1 },
            { id = "2x4", count = 1 },
            { id = "club_wooden", count = 1 },
            { id = "cudgel", count = 1 }
        })
    :component("dry_wheat_stalks", 10)
    :batch_setup(81300, 10)
    :byproduct("straw_pile", 20)
)

-- A person with a flail can do 420 pounds per day because threshing scales very well.
content.add(content.Recipe {
    id = "threshed_wheat_flail",
    result = "threshed_wheat",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 60000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "survival",
    name = content.text("%s with flail"),
}
    :tool("2h_flail_wood", 1)
    :component("dry_wheat_stalks", 1)
    :batch_discount(90, 1)
    :byproduct("straw_pile", 2)
)

-- tools aren't inherited for some reason
content.add(content.Recipe {
    id = "threshed_wheat_bulk_flail",
    result = "threshed_wheat",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 114200,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "survival",
    result_multiplier = 10,
    name = content.text("bulk %s with flail"),
}
    :tool("2h_flail_wood", 1)
    :component("dry_wheat_stalks", 10)
    :batch_setup(54200, 10)
    :byproduct("straw_pile", 20)
)

-- All the winter wheat recipes are copies of the regular wheat recipes with the components changed.
content.add(content.Recipe {
    id = "threshed_winter_wheat",
    result = "threshed_winter_wheat",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 90000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "survival",
}
    :tool_any({
            { id = "stick", count = 1 },
            { id = "2x4", count = 1 },
            { id = "club_wooden", count = 1 },
            { id = "cudgel", count = 1 }
        })
    :component("dry_winter_wheat_stalks", 1)
    :batch_discount(90, 1)
    :byproduct("straw_pile", 2)
)

content.add(content.Recipe {
    id = "threshed_winter_wheat_bulk",
    result = "threshed_winter_wheat",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 171300,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "survival",
    result_multiplier = 10,
    name = content.text("bulk %s"),
}
    :tool_any({
            { id = "stick", count = 1 },
            { id = "2x4", count = 1 },
            { id = "club_wooden", count = 1 },
            { id = "cudgel", count = 1 }
        })
    :component("dry_winter_wheat_stalks", 10)
    :batch_setup(81300, 10)
    :byproduct("straw_pile", 20)
)

content.add(content.Recipe {
    id = "threshed_winter_wheat_flail",
    result = "threshed_winter_wheat",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 60000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "survival",
    name = content.text("%s with flail"),
}
    :tool("2h_flail_wood", 1)
    :component("dry_winter_wheat_stalks", 1)
    :batch_discount(90, 1)
    :byproduct("straw_pile", 2)
)

content.add(content.Recipe {
    id = "threshed_winter_wheat_bulk_flail",
    result = "threshed_winter_wheat",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 114200,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "survival",
    result_multiplier = 10,
    name = content.text("bulk %s with flail"),
}
    :tool("2h_flail_wood", 1)
    :component("dry_winter_wheat_stalks", 10)
    :batch_setup(54200, 10)
    :byproduct("straw_pile", 20)
)

-- The fastest way to do this without tools is just to toss the wheat into the air and let the chaff float
-- away. This could also represent picking the seeds out by hand, etc.
content.add(content.Recipe {
    id = "wheat",
    result = "wheat",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
}
    :component("threshed_wheat", 1)
    :batch_discount(20, 1)
    :byproduct("chaff", 1)
)

-- Throwing the mixture into the air so that the wind blows away the lighter chaff
content.add(content.Recipe {
    id = "wheat_win1",
    result = "wheat",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    name = content.text("%s with winnowing"),
}
    :component("threshed_wheat", 1)
    :quality("WINNOW", 1, 1)
    :batch_discount(25, 1)
    :byproduct("chaff", 1)
)

-- qualities aren't inherited for some reason
content.add(content.Recipe {
    id = "wheat_bulk_win1",
    result = "wheat",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 232700,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    result_multiplier = 10,
    name = content.text("bulk %s with winnowing"),
}
    :component("threshed_wheat", 10)
    :quality("WINNOW", 1, 1)
    :batch_setup(30200, 10)
    :byproduct("chaff", 10)
)

-- Using a machine for separating the grain and chaff
content.add(content.Recipe {
    id = "wheat_win2",
    result = "wheat",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    name = content.text("%s with fan"),
}
    :component("threshed_wheat", 1)
    :quality("WINNOW", 2, 1)
    :batch_discount(80, 1)
    :byproduct("chaff", 1)
)

-- qualities aren't inherited for some reason
content.add(content.Recipe {
    id = "wheat_bulk_win2",
    result = "wheat",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 84200,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    result_multiplier = 10,
    name = content.text("bulk %s with fan"),
}
    :component("threshed_wheat", 10)
    :quality("WINNOW", 2, 1)
    :batch_setup(30200, 10)
    :byproduct("chaff", 10)
)

-- All the winter wheat recipes are copies of the regular wheat recipes with the components changed.
-- The fastest way to do this without tools is just to toss the wheat into the air and let the chaff float
-- away. This could also represent picking the seeds out by hand, etc.
content.add(content.Recipe {
    id = "winter_wheat",
    result = "winter_wheat",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
}
    :component("threshed_winter_wheat", 1)
    :batch_discount(20, 1)
    :byproduct("chaff", 1)
)

-- Throwing the mixture into the air so that the wind blows away the lighter chaff
content.add(content.Recipe {
    id = "winter_wheat_win1",
    result = "winter_wheat",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    name = content.text("%s with winnowing"),
}
    :component("threshed_winter_wheat", 1)
    :quality("WINNOW", 1, 1)
    :batch_discount(25, 1)
    :byproduct("chaff", 1)
)

content.add(content.Recipe {
    id = "winter_wheat_bulk_win1",
    result = "winter_wheat",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 232700,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    result_multiplier = 10,
    name = content.text("bulk %s with winnowing"),
}
    :component("threshed_winter_wheat", 10)
    :quality("WINNOW", 1, 1)
    :batch_setup(30200, 10)
    :byproduct("chaff", 10)
)

-- Using a machine for separating the grain and chaff
content.add(content.Recipe {
    id = "winter_wheat_win2",
    result = "winter_wheat",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    name = content.text("%s with fan"),
}
    :component("threshed_winter_wheat", 1)
    :quality("WINNOW", 2, 1)
    :batch_discount(80, 1)
    :byproduct("chaff", 1)
)

content.add(content.Recipe {
    id = "winter_wheat_bulk_win2",
    result = "winter_wheat",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 84200,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    result_multiplier = 10,
    name = content.text("bulk %s with fan"),
}
    :component("threshed_winter_wheat", 10)
    :quality("WINNOW", 2, 1)
    :batch_setup(30200, 10)
    :byproduct("chaff", 10)
)

content.add(content.Recipe {
    id = "threshed_oats",
    result = "threshed_oats",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 90000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "survival",
}
    :tool_any({
            { id = "stick", count = 1 },
            { id = "2x4", count = 1 },
            { id = "club_wooden", count = 1 },
            { id = "cudgel", count = 1 }
        })
    :component("dry_oat_stalks", 1)
    :batch_discount(90, 1)
    :byproduct("straw_pile", 2)
)

-- tools aren't inherited for some reason
content.add(content.Recipe {
    id = "threshed_oats_bulk",
    result = "threshed_oats",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 171300,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "survival",
    result_multiplier = 10,
    name = content.text("bulk %s"),
}
    :tool_any({
            { id = "stick", count = 1 },
            { id = "2x4", count = 1 },
            { id = "club_wooden", count = 1 },
            { id = "cudgel", count = 1 }
        })
    :component("dry_oat_stalks", 10)
    :batch_setup(81300, 10)
    :byproduct("straw_pile", 20)
)

-- Oats have half the calories of wheat, but it's the same number of stalks, so we get two piles and the full
-- crafting time.
content.add(content.Recipe {
    id = "threshed_oats_flail",
    result = "threshed_oats",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 60000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "survival",
    name = content.text("%s with flail"),
}
    :tool("2h_flail_wood", 1)
    :component("dry_oat_stalks", 1)
    :batch_discount(90, 1)
    :byproduct("straw_pile", 2)
)

-- tools aren't inherited for some reason
content.add(content.Recipe {
    id = "threshed_oats_flail_bulk",
    result = "threshed_oats",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 114200,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "survival",
    result_multiplier = 10,
    name = content.text("bulk %s with flail"),
}
    :tool("2h_flail_wood", 1)
    :component("dry_oat_stalks", 10)
    :batch_setup(54200, 10)
    :byproduct("straw_pile", 20)
)

content.add(content.Recipe {
    id = "oats",
    result = "oats",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
}
    :component("threshed_oats", 1)
    :batch_discount(20, 1)
    :byproduct("chaff", 1)
)

content.add(content.Recipe {
    id = "oats_win1",
    result = "oats",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    name = content.text("%s with winnowing"),
}
    :component("threshed_oats", 1)
    :quality("WINNOW", 1, 1)
    :batch_discount(25, 1)
    :byproduct("chaff", 1)
)

-- qualities aren't inherited for some reason
content.add(content.Recipe {
    id = "oats_bulk_win1",
    result = "oats",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 232700,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    result_multiplier = 10,
    name = content.text("bulk %s with winnowing"),
}
    :component("threshed_oats", 10)
    :quality("WINNOW", 1, 1)
    :batch_setup(30200, 10)
    :byproduct("chaff", 10)
)

content.add(content.Recipe {
    id = "oats_win2",
    result = "oats",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    name = content.text("%s with fan"),
}
    :component("threshed_oats", 1)
    :quality("WINNOW", 2, 1)
    :batch_discount(80, 1)
    :byproduct("chaff", 1)
)

-- qualities aren't inherited for some reason
content.add(content.Recipe {
    id = "oats_bulk_win2",
    result = "oats",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 84200,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    result_multiplier = 10,
    name = content.text("bulk %s with fan"),
}
    :component("threshed_oats", 10)
    :quality("WINNOW", 2, 1)
    :batch_setup(30200, 10)
    :byproduct("chaff", 10)
)

content.add(content.Recipe {
    id = "threshed_barley",
    result = "threshed_barley",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 90000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "survival",
}
    :tool_any({
            { id = "stick", count = 1 },
            { id = "2x4", count = 1 },
            { id = "club_wooden", count = 1 },
            { id = "cudgel", count = 1 }
        })
    :component("dry_barley_stalks", 1)
    :batch_discount(90, 1)
    :byproduct("straw_pile", 2)
)

-- tools aren't inherited for some reason
content.add(content.Recipe {
    id = "threshed_barley_bulk",
    result = "threshed_barley",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 171300,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "survival",
    result_multiplier = 10,
    name = content.text("bulk %s"),
}
    :tool_any({
            { id = "stick", count = 1 },
            { id = "2x4", count = 1 },
            { id = "club_wooden", count = 1 },
            { id = "cudgel", count = 1 }
        })
    :component("dry_barley_stalks", 10)
    :batch_setup(81300, 10)
    :byproduct("straw_pile", 20)
)

content.add(content.Recipe {
    id = "threshed_barley_flail",
    result = "threshed_barley",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 60000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "survival",
    name = content.text("%s with flail"),
}
    :tool("2h_flail_wood", 1)
    :component("dry_barley_stalks", 1)
    :batch_discount(90, 1)
    :byproduct("straw_pile", 2)
)

-- tools aren't inherited for some reason
content.add(content.Recipe {
    id = "threshed_barley_flail_bulk",
    result = "threshed_barley",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 114200,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "survival",
    result_multiplier = 10,
    name = content.text("bulk %s with flail"),
}
    :tool("2h_flail_wood", 1)
    :component("dry_barley_stalks", 10)
    :batch_setup(54200, 10)
    :byproduct("straw_pile", 20)
)

content.add(content.Recipe {
    id = "barley",
    result = "barley",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    result_multiplier = 4,
}
    :component("threshed_barley", 1)
    :batch_discount(20, 1)
    :byproduct("chaff", 1)
)

content.add(content.Recipe {
    id = "barley_win1",
    result = "barley",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    result_multiplier = 4,
    name = content.text("%s with winnowing"),
}
    :component("threshed_barley", 1)
    :quality("WINNOW", 1, 1)
    :batch_discount(25, 1)
    :byproduct("chaff", 1)
)

-- qualities aren't inherited for some reason
content.add(content.Recipe {
    id = "barley_bulk_win1",
    result = "barley",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 232700,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    result_multiplier = 40,
    name = content.text("bulk %s with winnowing"),
}
    :component("threshed_barley", 10)
    :quality("WINNOW", 1, 1)
    :batch_setup(30200, 10)
    :byproduct("chaff", 10)
)

content.add(content.Recipe {
    id = "barley_win2",
    result = "barley",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    result_multiplier = 4,
    name = content.text("%s with fan"),
}
    :component("threshed_barley", 1)
    :quality("WINNOW", 2, 1)
    :batch_discount(80, 1)
    :byproduct("chaff", 1)
)

-- qualities aren't inherited for some reason
content.add(content.Recipe {
    id = "barley_bulk_win2",
    result = "barley",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 84200,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    result_multiplier = 40,
    name = content.text("bulk %s with fan"),
}
    :component("threshed_barley", 10)
    :quality("WINNOW", 2, 1)
    :batch_setup(30200, 10)
    :byproduct("chaff", 10)
)

content.add(content.Recipe {
    id = "threshed_lentils",
    result = "threshed_lentils",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 48000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "survival",
}
    :tool_any({
            { id = "stick", count = 1 },
            { id = "2x4", count = 1 },
            { id = "club_wooden", count = 1 },
            { id = "cudgel", count = 1 }
        })
    :component("dry_lentil_stalks", 1)
    :batch_discount(90, 1)
    :byproduct("straw_pile", 1)
)

-- tools aren't inherited for some reason
content.add(content.Recipe {
    id = "threshed_lentils_bulk",
    result = "threshed_lentils",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 91400,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "survival",
    result_multiplier = 10,
    name = content.text("bulk %s"),
}
    :tool_any({
            { id = "stick", count = 1 },
            { id = "2x4", count = 1 },
            { id = "club_wooden", count = 1 },
            { id = "cudgel", count = 1 }
        })
    :component("dry_lentil_stalks", 10)
    :batch_setup(47000, 10)
    :byproduct("straw_pile", 10)
)

-- Lentils are half the volume of wheat, so we half the time and byproducts.
content.add(content.Recipe {
    id = "threshed_lentils_flail",
    result = "threshed_lentils",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 30000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "survival",
    name = content.text("%s with flail"),
}
    :tool("2h_flail_wood", 1)
    :component("dry_lentil_stalks", 1)
    :batch_discount(90, 1)
    :byproduct("straw_pile", 1)
)

-- tools aren't inherited for some reason
content.add(content.Recipe {
    id = "threshed_lentils_flail_bulk",
    result = "threshed_lentils",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 57200,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "survival",
    result_multiplier = 10,
    name = content.text("bulk %s with flail"),
}
    :tool("2h_flail_wood", 1)
    :component("dry_lentil_stalks", 10)
    :batch_setup(27200, 10)
    :byproduct("straw_pile", 10)
)

content.add(content.Recipe {
    id = "dry_lentils",
    result = "dry_lentils",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    result_multiplier = 2,
}
    :component("threshed_lentils", 1)
    :batch_discount(20, 1)
    :byproduct("chaff", 1)
)

content.add(content.Recipe {
    id = "dry_lentils_win1",
    result = "dry_lentils",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 18000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    result_multiplier = 2,
    name = content.text("%s with winnowing"),
}
    :component("threshed_lentils", 1)
    :quality("WINNOW", 1, 1)
    :batch_discount(25, 1)
    :byproduct("chaff", 1)
)

-- qualities aren't inherited for some reason
content.add(content.Recipe {
    id = "dry_lentils_bulk_win1",
    result = "dry_lentils",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 139500,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    result_multiplier = 20,
    name = content.text("bulk %s with winnowing"),
}
    :component("threshed_lentils", 10)
    :quality("WINNOW", 1, 1)
    :batch_setup(18200, 10)
    :byproduct("chaff", 10)
)

content.add(content.Recipe {
    id = "dry_lentils_win2",
    result = "dry_lentils",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 18000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    result_multiplier = 2,
    name = content.text("%s with fan"),
}
    :component("threshed_lentils", 1)
    :quality("WINNOW", 2, 1)
    :batch_discount(80, 1)
    :byproduct("chaff", 1)
)

-- qualities aren't inherited for some reason
content.add(content.Recipe {
    id = "dry_lentils_bulk_win2",
    result = "dry_lentils",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 50400,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    result_multiplier = 20,
    name = content.text("bulk %s with fan"),
}
    :component("threshed_lentils", 10)
    :quality("WINNOW", 2, 1)
    :batch_setup(30200, 10)
    :byproduct("chaff", 10)
)

content.add(content.Recipe {
    id = "wild_rice",
    result = "wild_rice",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 48000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "survival",
}
    :tool_any({
            { id = "stick", count = 1 },
            { id = "2x4", count = 1 },
            { id = "club_wooden", count = 1 },
            { id = "cudgel", count = 1 }
        })
    :component("dry_wild_rice_stalks", 1)
    :batch_discount(90, 1)
    :byproduct("straw_pile", 1)
)

-- tools aren't inherited for some reason
content.add(content.Recipe {
    id = "wild_rice_bulk",
    result = "wild_rice",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 91400,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "survival",
    result_multiplier = 10,
    name = content.text("bulk %s"),
}
    :tool_any({
            { id = "stick", count = 1 },
            { id = "2x4", count = 1 },
            { id = "club_wooden", count = 1 },
            { id = "cudgel", count = 1 }
        })
    :component("dry_wild_rice_stalks", 10)
    :batch_setup(47000, 10)
    :byproduct("straw_pile", 10)
)

content.add(content.Recipe {
    id = "wild_rice_flail",
    result = "wild_rice",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 30000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "survival",
    name = content.text("%s with flail"),
}
    :tool("2h_flail_wood", 1)
    :component("dry_wild_rice_stalks", 1)
    :batch_discount(90, 1)
    :byproduct("straw_pile", 1)
)

-- tools aren't inherited for some reason
content.add(content.Recipe {
    id = "wild_rice_flail_bulk",
    result = "wild_rice",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 57200,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "survival",
    result_multiplier = 10,
    name = content.text("bulk %s with flail"),
}
    :tool("2h_flail_wood", 1)
    :component("dry_wild_rice_stalks", 10)
    :batch_setup(27200, 10)
    :byproduct("straw_pile", 10)
)

-- Not having a flail slows this down considerably.
content.add(content.Recipe {
    id = "threshed_buckwheat",
    result = "threshed_buckwheat",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 90000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "survival",
}
    :tool_any({
            { id = "stick", count = 1 },
            { id = "2x4", count = 1 },
            { id = "club_wooden", count = 1 },
            { id = "cudgel", count = 1 }
        })
    :component("dry_buckwheat_stalks", 1)
    :batch_discount(90, 1)
    :byproduct("straw_pile", 1)
)

-- tools aren't inherited for some reason
content.add(content.Recipe {
    id = "threshed_buckwheat_bulk",
    result = "threshed_buckwheat",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 171300,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "survival",
    result_multiplier = 10,
    name = content.text("bulk %s"),
}
    :tool_any({
            { id = "stick", count = 1 },
            { id = "2x4", count = 1 },
            { id = "club_wooden", count = 1 },
            { id = "cudgel", count = 1 }
        })
    :component("dry_buckwheat_stalks", 10)
    :batch_setup(81300, 10)
    :byproduct("straw_pile", 10)
)

content.add(content.Recipe {
    id = "threshed_buckwheat_flail",
    result = "threshed_buckwheat",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 60000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "survival",
    name = content.text("%s with flail"),
}
    :tool("2h_flail_wood", 1)
    :component("dry_buckwheat_stalks", 1)
    :batch_discount(90, 1)
    :byproduct("straw_pile", 1)
)

-- tools aren't inherited for some reason
content.add(content.Recipe {
    id = "threshed_buckwheat_flail_bulk",
    result = "threshed_buckwheat",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 114200,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "survival",
    result_multiplier = 10,
    name = content.text("bulk %s with flail"),
}
    :tool("2h_flail_wood", 1)
    :component("dry_buckwheat_stalks", 10)
    :batch_setup(54200, 10)
    :byproduct("straw_pile", 10)
)

content.add(content.Recipe {
    id = "buckwheat",
    result = "buckwheat",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    result_multiplier = 2,
}
    :component("threshed_buckwheat", 1)
    :batch_discount(20, 1)
    :byproduct("chaff", 1)
)

-- qualities aren't inherited for some reason
content.add(content.Recipe {
    id = "buckwheat_win1",
    result = "buckwheat",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    result_multiplier = 2,
    name = content.text("%s with winnowing"),
}
    :component("threshed_buckwheat", 1)
    :quality("WINNOW", 1, 1)
    :batch_discount(25, 1)
    :byproduct("chaff", 1)
)

-- qualities aren't inherited for some reason
content.add(content.Recipe {
    id = "buckwheat_bulk_win1",
    result = "buckwheat",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 232700,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    result_multiplier = 20,
    name = content.text("bulk %s with winnowing"),
}
    :component("threshed_buckwheat", 10)
    :quality("WINNOW", 1, 1)
    :batch_setup(30200, 10)
    :byproduct("chaff", 10)
)

content.add(content.Recipe {
    id = "buckwheat_win2",
    result = "buckwheat",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    result_multiplier = 2,
    name = content.text("%s with fan"),
}
    :component("threshed_buckwheat", 1)
    :quality("WINNOW", 2, 1)
    :batch_discount(80, 1)
    :byproduct("chaff", 1)
)

-- qualities aren't inherited for some reason
content.add(content.Recipe {
    id = "buckwheat_bulk_win2",
    result = "buckwheat",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 84200,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    result_multiplier = 20,
    name = content.text("bulk %s with fan"),
}
    :component("threshed_buckwheat", 10)
    :quality("WINNOW", 2, 1)
    :batch_setup(30200, 10)
    :byproduct("chaff", 10)
)

-- Not having a flail slows this down considerably.
content.add(content.Recipe {
    id = "threshed_canola",
    result = "threshed_canola",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 90000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "survival",
}
    :tool_any({
            { id = "stick", count = 1 },
            { id = "2x4", count = 1 },
            { id = "club_wooden", count = 1 },
            { id = "cudgel", count = 1 }
        })
    :component("dry_canola_stalks", 1)
    :batch_discount(90, 1)
    :byproduct("straw_pile", 1)
)

-- tools aren't inherited for some reason
content.add(content.Recipe {
    id = "threshed_canola_bulk",
    result = "threshed_canola",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 171300,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "survival",
    result_multiplier = 10,
    name = content.text("bulk %s"),
}
    :tool_any({
            { id = "stick", count = 1 },
            { id = "2x4", count = 1 },
            { id = "club_wooden", count = 1 },
            { id = "cudgel", count = 1 }
        })
    :component("dry_canola_stalks", 10)
    :batch_setup(81300, 10)
    :byproduct("straw_pile", 10)
)

content.add(content.Recipe {
    id = "threshed_canola_flail",
    result = "threshed_canola",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 60000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "survival",
    name = content.text("%s with flail"),
}
    :tool("2h_flail_wood", 1)
    :component("dry_canola_stalks", 1)
    :batch_discount(90, 1)
    :byproduct("straw_pile", 1)
)

-- tools aren't inherited for some reason
content.add(content.Recipe {
    id = "threshed_canola_flail_bulk",
    result = "threshed_canola",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 114200,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "survival",
    result_multiplier = 10,
    name = content.text("bulk %s with flail"),
}
    :tool("2h_flail_wood", 1)
    :component("dry_canola_stalks", 10)
    :batch_setup(54200, 10)
    :byproduct("straw_pile", 10)
)

content.add(content.Recipe {
    id = "seed_canola",
    result = "seed_canola",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
}
    :component("threshed_canola", 1)
    :batch_discount(20, 1)
    :byproduct("chaff", 1)
)

content.add(content.Recipe {
    id = "seed_canola_win1",
    result = "seed_canola",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    name = content.text("%s with winnowing"),
}
    :component("threshed_canola", 1)
    :quality("WINNOW", 1, 1)
    :batch_discount(25, 1)
    :byproduct("chaff", 1)
)

-- qualities aren't inherited for some reason
content.add(content.Recipe {
    id = "seed_canola_bulk_win1",
    result = "seed_canola",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 232700,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    result_multiplier = 10,
    name = content.text("bulk %s with winnowing"),
}
    :component("threshed_canola", 10)
    :quality("WINNOW", 1, 1)
    :batch_setup(30200, 10)
    :byproduct("chaff", 10)
)

content.add(content.Recipe {
    id = "seed_canola_win2",
    result = "seed_canola",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    name = content.text("%s with fan"),
}
    :component("threshed_canola", 1)
    :quality("WINNOW", 2, 1)
    :batch_discount(80, 1)
    :byproduct("chaff", 1)
)

-- qualities aren't inherited for some reason
content.add(content.Recipe {
    id = "seed_canola_bulk_win2",
    result = "seed_canola",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 84200,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    result_multiplier = 10,
    name = content.text("bulk %s with fan"),
}
    :component("threshed_canola", 10)
    :quality("WINNOW", 2, 1)
    :batch_setup(30200, 10)
    :byproduct("chaff", 10)
)
