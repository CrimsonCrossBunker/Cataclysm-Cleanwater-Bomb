local content = require("ccb").content

local LIGHT_EXERCISE = 2

-- 葳蕤木灵丹配方。autolearn:false——不靠技能自学；改由 EOC_immortal_path_bind_art_traits 的木行分支在学会养荣导引时 u_learn_recipe
-- 直接授予，演示「功法自带配方」。activity_level 是 recipe 的必填字段（见 recipe.cpp）。用 firstaid 技能与常见草木材料，门槛低。材料/产出待平衡。/ Verdant
-- pill recipe. Not autolearned; granted via u_learn_recipe in the Wood branch of
-- EOC_immortal_path_bind_art_traits. activity_level is mandatory on recipes.
content.add(content.Recipe {
    id = "immortal_path_evergreen_pill",
    result = "immortal_path_evergreen_pill",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_DRUGS",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "firstaid",
    difficulty = 1,
}
    :component_any({
            { id = "wild_herbs", count = 2 },
            { id = "medical_gauze", count = 1 }
        })
    :component_any({
            { id = "water_clean", count = 1 },
            { id = "water", count = 1 }
        })
    :quality("CONTAIN", 1, 1)
)

-- 基础聚气丹配方。autolearn:false；由 EOC_immortal_path_ensure_basic_elixir_recipe
-- 在角色踏入炼气后授予。材料沿用早期草木/清水路线，后续可替换为专属灵材。/ Basic Qi-Gathering Pill recipe. Not autolearned; granted by
-- EOC_immortal_path_ensure_basic_elixir_recipe once the character enters Qi Refining. Uses early herb/water
-- components for now; later replaceable with dedicated spirit materials.
content.add(content.Recipe {
    id = "immortal_path_qi_gathering_pill",
    result = "immortal_path_qi_gathering_pill",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_DRUGS",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "firstaid",
    difficulty = 1,
}
    :component_any({
            { id = "wild_herbs", count = 2 },
            { id = "tea_bark", count = 1 }
        })
    :component_any({
            { id = "water_clean", count = 1 },
            { id = "water", count = 1 }
        })
    :quality("CONTAIN", 1, 1)
)
