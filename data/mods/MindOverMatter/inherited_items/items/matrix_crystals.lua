local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item { id = "matrix_crystal_biokinesis", copy_from = "matrix_crystal_biokinesis" }
    item:on_use("awaken_from_biokinesis_crystal", ccb.content.text("Activate"), ccb.content.text("The pink glow calls to you."))
    content.replace(item)
end

do
    local item = content.Item { id = "matrix_crystal_pyrokinesis", copy_from = "matrix_crystal_pyrokinesis" }
    item:on_use("awaken_from_pyrokinesis_crystal", ccb.content.text("Activate"), ccb.content.text("The red glow calls to you."))
    content.replace(item)
end

do
    local item = content.Item {
        id = "matrix_crystal_drained",
        name = ccb.content.plural_text("strange crystal, black", "strange crystal, black"),
        description = ccb.content.text("A strange-looking, surprisingly-heavy crystal.  In total darkness, there is a faint light visible in its depths."),
        color = "dark_gray",
        symbol = "+",
        volume_ml = 10,
        mass_milligrams = 150000,
        longest_side_mm = 21,
        looks_like = "art_crystal",
    }
    item:material("nether_crystal", 1)
    item:tool()
    item:clear_use_actions()
    item:on_use("use_drained_matrix", ccb.content.text("Activate"), ccb.content.text("The faint light calls to you."))
    content.add(item)
end

do
    local item = content.Item {
        id = "matrix_shard",
        symbol = ",",
        color = "white",
        name = ccb.content.plural_text("strange crystal shard", "strange crystal shards"),
        category = "other",
        description = ccb.content.text("A very heavy chunk of a strange crystalline outcropping.  You could use it as a weapon, but you might want to wear gloves."),
        mass_milligrams = 450000,
        volume_ml = 30,
        melee_to_hit = -1,
    }
    item:material("nether_crystal", 1)
    item:clear_melee_damage()
    item:melee_damage("cut", 6)
    item:clear_flags()
    item:flag("HURT_WHEN_WIELDED")
    item:flag("TRADER_AVOID")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "matrix_crystal_clairsentience",
        name = ccb.content.plural_text("strange crystal, gray", "strange crystal, gray"),
        copy_from = "matrix_crystal_biokinesis",
        looks_like = "matrix_crystal_biokinesis",
        description = ccb.content.text("A strange-looking, surprisingly-heavy crystal with a faintly-glowing gray light in its depths.  Holding it, you feel more perceptive."),
        color = "dark_gray",
    }
    item:clear_flags()
    item:flag("MATRIX_CRYSTAL_CLAIRSENTIENCE")
    item:flag("RELIC_PINK")
    item:tool()
    item:clear_use_actions()
    item:on_use("awaken_from_clairsentience_crystal", ccb.content.text("Activate"), ccb.content.text("The gray glow calls to you."))
    content.add(item)
end

do
    local item = content.Item {
        id = "matrix_crystal_electrokinesis",
        name = ccb.content.plural_text("strange crystal, cyan", "strange crystal, cyan"),
        copy_from = "matrix_crystal_biokinesis",
        looks_like = "matrix_crystal_biokinesis",
        description = ccb.content.text("A strange-looking, surprisingly-heavy crystal with a faintly-glowing cyan light in its depths.  Holding it, you feel more energetic."),
        color = "cyan",
    }
    item:clear_flags()
    item:flag("MATRIX_CRYSTAL_ELECTROKINESIS")
    item:flag("RELIC_PINK")
    item:tool()
    item:clear_use_actions()
    item:on_use("awaken_from_electrokinesis_crystal", ccb.content.text("Activate"), ccb.content.text("The cyan glow calls to you."))
    content.add(item)
end

do
    local item = content.Item {
        id = "matrix_crystal_photokinesis",
        name = ccb.content.plural_text("strange crystal, golden", "strange crystal, golden"),
        copy_from = "matrix_crystal_biokinesis",
        looks_like = "matrix_crystal_biokinesis",
        description = ccb.content.text("A strange-looking, surprisingly-heavy crystal with a faintly-glowing golden light in its depths.  Holding it, you feel radiant."),
        color = "yellow",
    }
    item:clear_flags()
    item:flag("MATRIX_CRYSTAL_PHOTOKINESIS")
    item:flag("RELIC_PINK")
    item:tool()
    item:clear_use_actions()
    item:on_use("awaken_from_photokinesis_crystal", ccb.content.text("Activate"), ccb.content.text("The golden glow calls to you."))
    content.add(item)
end

do
    local item = content.Item {
        id = "matrix_crystal_telekinesis",
        name = ccb.content.plural_text("strange crystal, yellow", "strange crystal, yellow"),
        copy_from = "matrix_crystal_biokinesis",
        looks_like = "matrix_crystal_biokinesis",
        description = ccb.content.text("A strange-looking, surprisingly-heavy crystal with a faintly-glowing yellow light in its depths.  Holding it, you feel lighter."),
        color = "yellow",
    }
    item:clear_flags()
    item:flag("MATRIX_CRYSTAL_TELEKINESIS")
    item:flag("RELIC_PINK")
    item:tool()
    item:clear_use_actions()
    item:on_use("awaken_from_telekinesis_crystal", ccb.content.text("Activate"), ccb.content.text("The yellow glow calls to you."))
    content.add(item)
end

do
    local item = content.Item {
        id = "matrix_crystal_telepathy",
        name = ccb.content.plural_text("strange crystal, white", "strange crystal, white"),
        copy_from = "matrix_crystal_biokinesis",
        looks_like = "matrix_crystal_biokinesis",
        description = ccb.content.text("A strange-looking, surprisingly-heavy crystal with a faintly-glowing white light in its depths.  Holding it, you feel pensive."),
        color = "white",
    }
    item:clear_flags()
    item:flag("MATRIX_CRYSTAL_TELEPATHY")
    item:flag("RELIC_PINK")
    item:tool()
    item:clear_use_actions()
    item:on_use("awaken_from_telepathy_crystal", ccb.content.text("Activate"), ccb.content.text("The white glow calls to you."))
    content.add(item)
end

do
    local item = content.Item {
        id = "matrix_crystal_teleportation",
        name = ccb.content.plural_text("strange crystal, blue", "strange crystal, blue"),
        copy_from = "matrix_crystal_biokinesis",
        looks_like = "matrix_crystal_biokinesis",
        description = ccb.content.text("A strange-looking, surprisingly-heavy crystal with a faintly-glowing blue light in its depths.  Holding it, you feel more mobile."),
        color = "blue",
    }
    item:clear_flags()
    item:flag("MATRIX_CRYSTAL_TELEPORTATION")
    item:flag("RELIC_PINK")
    item:tool()
    item:clear_use_actions()
    item:on_use("awaken_from_teleportation_crystal", ccb.content.text("Activate"), ccb.content.text("The blue glow calls to you."))
    content.add(item)
end

do
    local item = content.Item {
        id = "matrix_crystal_vitakinesis",
        name = ccb.content.plural_text("strange crystal, green", "strange crystal, green"),
        copy_from = "matrix_crystal_biokinesis",
        looks_like = "matrix_crystal_biokinesis",
        description = ccb.content.text("A strange-looking, surprisingly-heavy crystal with a faintly-glowing green light in its depths.  Holding it, you feel healthier."),
        color = "green",
    }
    item:clear_flags()
    item:flag("MATRIX_CRYSTAL_VITAKINESIS")
    item:flag("RELIC_PINK")
    item:tool()
    item:clear_use_actions()
    item:on_use("awaken_from_vitakinesis_crystal", ccb.content.text("Activate"), ccb.content.text("The green glow calls to you."))
    content.add(item)
end

do
    local item = content.Item {
        id = "matrix_crystal_coruscating",
        name = ccb.content.plural_text("strange crystal, coruscating", "strange crystal, coruscating"),
        description = ccb.content.text("A strange-looking, surprisingly-heavy crystal.  In total darkness, multicolored lights churn and swirl within its depths."),
        copy_from = "matrix_crystal_biokinesis",
        looks_like = "matrix_crystal_biokinesis",
        color = "brown",
    }
    item:clear_flags()
    item:flag("MATRIX_CRYSTAL_CORUSCATING")
    item:tool()
    item:clear_use_actions()
    item:on_use("use_coruscating_matrix", ccb.content.text("Activate"), ccb.content.text("The coruscating light calls to you."))
    content.add(item)
end
