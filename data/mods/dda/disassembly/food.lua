local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2

local function disassembly(result, moves, activity, options)
    options = options or {}
    options.id = "uncraft_" .. result
    options.result = result
    options.uncraft = true
    options.reversible = true
    options.autolearn = false
    options.duration_moves = moves
    options.activity_level = activity
    return content.Recipe(options)
end

content.add(disassembly("watermelon", 6000, LIGHT_EXERCISE)
    :quality("CUT", 1, 1)
    :component("watermelon_wedge", 16)
    :component("seed_watermelon", 5)
)

content.add(disassembly("melon", 6000, LIGHT_EXERCISE)
    :quality("CUT", 1, 1)
    :component("melon_chunks", 4)
    :component("seed_melon", 3)
)

content.add(disassembly("pineapple", 6000, LIGHT_EXERCISE)
    :quality("CUT", 1, 1)
    :component("pineapple_chunks", 5)
)

content.add(disassembly("coconut", 12000, LIGHT_EXERCISE)
    :quality("CUT", 1, 1)
    :quality("HAMMER", 1, 1)
    :component("coconut_flesh", 4)
    :component("coconut_water", 1)
    :component("bowl_coconut", 2)
)

content.add(disassembly("rose_hips", 3000, LIGHT_EXERCISE)
    :quality("CUT", 1, 1)
    :component("seed_rose", 1)
    :component("rose_hips_cut", 1)
)

content.add(disassembly("grapes", 3000, NO_EXERCISE)
    :component("seed_grapes", 1)
)

content.add(disassembly("mayapple", 3000, LIGHT_EXERCISE)
    :quality("CUT", 1, 1)
    :component("seed_mayapple", 1)
)

content.add(disassembly("mulberries", 3000, NO_EXERCISE)
    :component("seed_mulberries", 1)
)

content.add(disassembly("raspberries", 3000, NO_EXERCISE)
    :component("seed_raspberries", 1)
)

content.add(disassembly("cranberries", 3000, NO_EXERCISE)
    :component("seed_cranberries", 1)
)

content.add(disassembly("blueberries", 3000, NO_EXERCISE)
    :component("seed_blueberries", 1)
)

content.add(disassembly("elderberries", 3000, NO_EXERCISE)
    :component("seed_elderberries", 1)
)

content.add(disassembly("strawberries", 3000, NO_EXERCISE)
    :component("seed_strawberries", 1)
)

content.add(disassembly("blackberries", 3000, NO_EXERCISE)
    :component("seed_blackberries", 1)
)

content.add(disassembly("huckleberries", 3000, NO_EXERCISE)
    :component("seed_huckleberries", 1)
)

content.add(disassembly("wintergreen_berry", 3000, NO_EXERCISE)
    :component("seed_wintergreen", 1)
)

content.add(disassembly("m_stellatum_berries", 3000, NO_EXERCISE)
    :component("seed_maianthemum_stellatum", 1)
)

content.add(disassembly("large_bone", 162000, LIGHT_EXERCISE)
    :quality("HAMMER", 1, 1)
    :quality("SAW_W", 1, 1)
    :component("bone", 61)
)

content.add(disassembly("pumpkin", 12000, LIGHT_EXERCISE)
    :quality("CUT", 1, 1)
    :component("pumpkin_cut", 4)
    :component("seed_pumpkin", 6)
)

content.add(disassembly("tomato", 3000, LIGHT_EXERCISE)
    :quality("CUT", 1, 1)
    :component("seed_tomato", 1)
    :component("tomato_cut", 1)
)

content.add(disassembly("zucchini", 3000, LIGHT_EXERCISE)
    :quality("CUT", 1, 1)
    :component("seed_zucchini", 2)
    :component("zucchini_cut", 1)
)

content.add(disassembly("cucumber", 3000, LIGHT_EXERCISE)
    :quality("CUT", 1, 1)
    :component("seed_cucumber", 2)
    :component("cucumber_cut", 1)
)

content.add(disassembly("gherkin", 3000, LIGHT_EXERCISE)
    :quality("CUT", 1, 1)
    :component("seed_gherkin", 2)
    :component("gherkin_cut", 1)
)

content.add(disassembly("chili_pepper", 3000, LIGHT_EXERCISE)
    :quality("CUT", 1, 1)
    :component("seed_chili_pepper", 2)
    :component("chili_pepper_cut", 1)
)

content.add(disassembly("bell_pepper", 3000, LIGHT_EXERCISE)
    :quality("CUT", 1, 1)
    :component("seed_bell_pepper", 2)
    :component("bell_pepper_cut", 1)
)

content.add(disassembly("raw_bottle_gourd", 3000, LIGHT_EXERCISE)
    :quality("CUT", 1, 1)
    :component("seed_bottle_gourd", 3)
)

content.add(disassembly("raw_edamame", 3000, NO_EXERCISE)
    :component("soybean", 1)
)

content.add(disassembly("eggplant", 3000, NO_EXERCISE)
    :quality("CUT", 1, 1)
    :component("seed_eggplant", 2)
    :component("eggplant_cut", 2)
)

content.add(disassembly("cattlefodder_medium", 3000, NO_EXERCISE)
    :component("cattlefodder", 7)
)

content.add(disassembly("cattlefodder_large", 3000, NO_EXERCISE)
    :component("cattlefodder", 36)
)

content.add(disassembly("lettuce_head", 3000, NO_EXERCISE)
    :quality("CUT", 1, 1)
    :component("lettuce", 7)
)

content.add(disassembly("cabbage_head", 3000, NO_EXERCISE)
    :quality("CUT", 1, 1)
    :component("cabbage", 13)
)

content.add(disassembly("cauliflower_head", 3000, LIGHT_EXERCISE)
    :quality("CUT", 1, 1)
    :component("cauliflower", 10)
)

content.add(disassembly("kale_head", 3000, LIGHT_EXERCISE)
    :quality("CUT", 1, 1)
    :component("kale", 10)
)

content.add(disassembly("raw_artichoke", 3000, LIGHT_EXERCISE)
    :quality("CUT", 1, 1)
    :component("seed_artichoke", 2)
    :component("artichoke_heart", 1)
)

content.add(disassembly("brussels_sprout_stalk", 3000, NO_EXERCISE)
    :quality("CUT", 1, 1)
    :component("brussels_sprout", 17)
)

content.add(disassembly("pea_pods", 3000, NO_EXERCISE)
    :quality("CUT", 1, 1)
    :component("pea", 8)
)
