local ccb = require("ccb")
local content = ccb.content
local services = ccb.services

local NO_EXERCISE = 1
local MODERATE_EXERCISE = 4
local BRISK_EXERCISE = 6
local ACTIVE_EXERCISE = 8

-- Really, this recipe should work with any small, throwable object, but that would be tedious and bloat the
-- recipe
content.add(content.Recipe {
    id = "prac_throw_beg",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_RANGED",
    name = content.text("throwing (beginner)"),
    description = content.text("Practice your throwing by throwing something and trying to hit a spot on the wall."),
    skill = "throw",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 2, skill_limit = 3 },
    autolearn = true,
}
    :tool_any({
            { id = "basketball", count = 1 },
            { id = "indoor_volleyball", count = 1 },
            { id = "beach_volleyball", count = 1 },
            { id = "baseball", count = 1 },
            { id = "football", count = 1 },
            { id = "golf_ball", count = 1 },
            { id = "rock", count = 1 },
            { id = "sharp_rock", count = 1 },
            { id = "rock_flaking", count = 1 },
            { id = "brick", count = 1 },
            { id = "wood_block", count = 1 },
            { id = "lawn_dart", count = 1 },
            { id = "weighted_dart", count = 1 }
        })
    :learn_automatically("throw", 0)
)

-- shooting against a hard target should damage arrows
do
    local byproducts = content.ItemGroup { id = "recipe_byproducts_prac_archery_beg", kind = "collection" }
    byproducts:entry { item = "arrow_fire_hardened_fletched", probability = 100, count = { 0, 2 } }
    content.add(byproducts)
end

content.add(content.Recipe {
    id = "prac_archery_beg",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_RANGED",
    name = content.text("archery (beginner)"),
    description = content.text("Practice firing unfletched arrows at a spot on the wall."),
    skill = "archery",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 1, skill_limit = 2 },
    autolearn = true,
}
    :tool_any({
            { id = "selfbow", count = 1 },
            { id = "shortbow", count = 1 },
            { id = "compbow", count = 1 },
            { id = "compbow_high", count = 1 },
            { id = "compbow_low", count = 1 },
            { id = "compositebow", count = 1 },
            { id = "reflexbow", count = 1 },
            { id = "recurbow", count = 1 },
            { id = "takedown_recurbow", count = 1 },
            { id = "longbow", count = 1 },
            { id = "woodgreatbow", count = 1 },
            { id = "compgreatbow", count = 1 },
            { id = "reflexrecurvebow", count = 1 }
        })
    :component("arrow_fire_hardened_fletched", 10)
    :learn_automatically("archery", 1)
    :book("book_archery", 0)
    :book("manual_archery", 0)
    :book("mag_archery", 0)
    :byproducts_from_group("recipe_byproducts_prac_archery_beg")
)

-- shooting against a hard target should damage arrows
do
    local byproducts = content.ItemGroup { id = "recipe_byproducts_prac_crossbow_beg", kind = "collection" }
    byproducts:entry { item = "bolt_crude", probability = 100, count = { 0, 2 } }
    content.add(byproducts)
end

content.add(content.Recipe {
    id = "prac_crossbow_beg",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_RANGED",
    name = content.text("crossbows (beginner)"),
    description = content.text("Practice firing unfletched bolts at a spot on the wall."),
    skill = "rifle",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 1, skill_limit = 2 },
    autolearn = true,
}
    :tool_charges("crossbows", 1, true)
    :component("bolt_crude", 10)
    :learn_automatically("rifle", 1)
    :book("recipe_bows", 0)
    :book("manual_archery", 0)
    :book("book_archery", 0)
    :byproducts_from_group("recipe_byproducts_prac_crossbow_beg")
)

-- Ideally, this would accept multiple arrow types and return a portion of the arrows used
do
    local byproducts = content.ItemGroup { id = "recipe_byproducts_prac_archery_int", kind = "collection" }
    byproducts:entry { item = "arrow_wood_heavy", probability = 100, count = { 0, 4 } }
    content.add(byproducts)
end

content.add(content.Recipe {
    id = "prac_archery_int",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_RANGED",
    name = content.text("archery (intermediate)"),
    description = content.text("Practice the best ways of firing fletched arrows into a target.  Requires a decent quality bow."),
    skill = "archery",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    practice = { min_difficulty = 2, max_difficulty = 4, skill_limit = 5 },
    autolearn = true,
}
    :tool_any({
            { id = "shortbow", count = 1 },
            { id = "compbow", count = 1 },
            { id = "compbow_high", count = 1 },
            { id = "compbow_low", count = 1 },
            { id = "compositebow", count = 1 },
            { id = "reflexbow", count = 1 },
            { id = "recurbow", count = 1 },
            { id = "takedown_recurbow", count = 1 },
            { id = "longbow", count = 1 },
            { id = "woodgreatbow", count = 1 },
            { id = "compgreatbow", count = 1 },
            { id = "reflexrecurvebow", count = 1 }
        })
    :tool_any({
            { id = "pseudo_archery_target_box", count = 1 },
            { id = "pseudo_archery_target_bale", count = 1 }
        })
    :component("arrow_wood_heavy", 20)
    :learn_automatically("archery", 3)
    :book("book_archery", 2)
    :book("manual_archery", 2)
    :proficiency("prof_bow_basic", { time_multiplier = 1.5, skill_penalty = 0 })
    :byproducts_from_group("recipe_byproducts_prac_archery_int")
)

-- Ideally, this would accept multiple arrow types and return a portion of the arrows used
do
    local byproducts = content.ItemGroup { id = "recipe_byproducts_prac_crossbow_int", kind = "collection" }
    byproducts:entry { item = "bolt_wood", probability = 100, count = { 0, 4 } }
    content.add(byproducts)
end

content.add(content.Recipe {
    id = "prac_crossbow_int",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_RANGED",
    name = content.text("crossbows (intermediate)"),
    description = content.text("Practice the best ways of firing fletched bolts into a target.  Requires a decent quality crossbow."),
    skill = "rifle",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    practice = { min_difficulty = 2, max_difficulty = 4, skill_limit = 5 },
    autolearn = true,
}
    :tool_charges("crossbows", 1, true)
    :tool_any({
            { id = "pseudo_archery_target_box", count = 1 },
            { id = "pseudo_archery_target_bale", count = 1 }
        })
    :component("bolt_wood", 20)
    :learn_automatically("rifle", 3)
    :book("recipe_bows", 2)
    :book("manual_archery", 2)
    :book("book_archery", 2)
    :byproducts_from_group("recipe_byproducts_prac_crossbow_int")
)

content.add(content.Recipe {
    id = "prac_archery_form",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_RANGED",
    name = content.text("expert archer's form"),
    description = content.text("Improve your archery form by quickly and smoothly drawing a bowstring."),
    skill = "archery",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    practice = { min_difficulty = 2, max_difficulty = 3, skill_limit = 4 },
    autolearn = true,
    flags = { "BLIND_EASY" },
}
    :tool_any({
            { id = "shortbow", count = 1 },
            { id = "compbow", count = 1 },
            { id = "compbow_high", count = 1 },
            { id = "compbow_low", count = 1 },
            { id = "compositebow", count = 1 },
            { id = "reflexbow", count = 1 },
            { id = "recurbow", count = 1 },
            { id = "takedown_recurbow", count = 1 },
            { id = "longbow", count = 1 },
            { id = "woodgreatbow", count = 1 },
            { id = "compgreatbow", count = 1 },
            { id = "reflexrecurvebow", count = 1 }
        })
    :learn_automatically("archery", 3)
    :book("mag_archery", 2)
    :book("book_archery", 2)
    :book("manual_archery", 2)
    :proficiency("prof_bow_basic", { required = true })
    :proficiency("prof_bow_expert", { time_multiplier = 2, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "prac_master_archery_form",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_RANGED",
    name = content.text("master archer's form"),
    description = content.text("Refine your archery form by drawing and holding a heavy bow."),
    skill = "archery",
    duration_moves = 360000,
    activity_level = ACTIVE_EXERCISE,
    practice = { min_difficulty = 3, max_difficulty = 4, skill_limit = 5 },
    autolearn = true,
    flags = { "BLIND_EASY" },
}
    :tool_any({
            { id = "compbow", count = 1 },
            { id = "compbow_high", count = 1 },
            { id = "compositebow", count = 1 },
            { id = "reflexbow", count = 1 },
            { id = "recurbow", count = 1 },
            { id = "takedown_recurbow", count = 1 },
            { id = "longbow", count = 1 },
            { id = "woodgreatbow", count = 1 },
            { id = "compgreatbow", count = 1 }
        })
    :learn_automatically("archery", 4)
    :book("book_archery", 3)
    :book("manual_archery", 3)
    :proficiency("prof_bow_basic", { required = true })
    :proficiency("prof_bow_expert", { required = true })
    :proficiency("prof_bow_master", { time_multiplier = 2, skill_penalty = 0 })
)

-- simple intuitive practice to get comfortable with holding a gun
content.add(content.Recipe {
    id = "prac_marksmanship_beg",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_RANGED",
    name = content.text("marksmanship (beginner)"),
    description = content.text("Practice your shooting by dry firing a gun."),
    skill = "gun",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 1, skill_limit = 1 },
    autolearn = true,
}
    :quality("GUN", 1, 1)
    :learn_automatically("gun", 0)
)

-- practice using a targeting game
content.add(content.Recipe {
    id = "prac_handguns_beg",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_RANGED",
    name = content.text("handguns (beginner)"),
    description = content.text("Practice your shooting by using a set of practice targets and a laser aiming module."),
    skill = "pistol",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 2, skill_limit = 3 },
    autolearn = true,
}
    :tool_charges("aim_game", 5)
    :quality("PISTOL", 1, 1)
    :learn_automatically("pistol", 0)
)

-- practice using a targeting game
content.add(content.Recipe {
    id = "prac_rifles_beg",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_RANGED",
    name = content.text("rifles (beginner)"),
    description = content.text("Practice your shooting by using a set of practice targets and a laser aiming module."),
    skill = "rifle",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 2, skill_limit = 3 },
    autolearn = true,
}
    :tool_charges("aim_game", 5)
    :quality("RIFLE", 1, 1)
    :learn_automatically("rifle", 0)
)

-- practice using a targeting game
content.add(content.Recipe {
    id = "prac_shotgun_beg",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_RANGED",
    name = content.text("shotguns (beginner)"),
    description = content.text("Practice your shooting by using a set of practice targets and a laser aiming module."),
    skill = "shotgun",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 2, skill_limit = 3 },
    autolearn = true,
}
    :tool_charges("aim_game", 5)
    :quality("SHOTGUN", 1, 1)
    :learn_automatically("shotgun", 0)
)

-- practice using a targeting game
content.add(content.Recipe {
    id = "prac_smg_beg",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_RANGED",
    name = content.text("submachine guns (beginner)"),
    description = content.text("Practice your shooting by using a set of practice targets and a laser aiming module."),
    skill = "smg",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 2, skill_limit = 3 },
    autolearn = true,
}
    :tool_charges("aim_game", 5)
    :quality("SMG", 1, 1)
    :learn_automatically("smg", 0)
)

content.add(content.Recipe {
    id = "prac_launch_beg",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_RANGED",
    name = content.text("launchers (beginner)"),
    description = content.text("Use a compressed air launcher to safely practice aiming trajectories."),
    skill = "launcher",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 1, skill_limit = 2 },
    autolearn = true,
}
    :tool("air_launcher", 1)
    :tool_any({
            { id = "golf_ball", count = 1 },
            { id = "baseball", count = 1 },
            { id = "magic_8_ball", count = 1 },
            { id = "pool_ball", count = 1 }
        })
    :tool("hand_pump", 1)
    :tool("hose", 1)
    :tool_any({
            { id = "pseudo_archery_target_box", count = 1 },
            { id = "pseudo_archery_target_bale", count = 1 }
        })
    :learn_automatically("launcher", 0)
)

ccb.runtime.handler("start_target_practice", function(craft)
    for _ = 1, craft.batch do
        local result = services.activities.target_practice(craft.character)
        if not result.ok then
            error(result.error.message)
        end
    end
end, 1)

content.add(content.Recipe {
    id = "prac_target",
    name = ccb.content.text("target practice"),
    description = ccb.content.text("The best way to train firearm skill is to shoot a firearm.  Do exactly that."),
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_RANGED",
    duration_moves = 0,
    activity_level = NO_EXERCISE,
    autolearn = true,
    flags = { "SECRET", "ALWAYS_START_ON_GROUND" },
    scripted_output = true,
}:on_complete("start_target_practice"))
