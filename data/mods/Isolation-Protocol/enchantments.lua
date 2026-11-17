local content = require("ccb").content

-- enchantments.json
content.add(content.Enchantment { id = "iso_ranged_adjust", condition = "ALWAYS" }
    :value("RANGED_DAMAGE", { multiply = -0.25 }))

content.add(content.Enchantment { id = "iso_eldritch_sorcery_buff", name = content.text("Scion of the Dreaming City"), description = content.text("Your people may be gone, but you survive.") }
    :value("NIGHT_VIS", { add = 3 })
    :value("MAX_HP", { multiply = -0.25 }))
