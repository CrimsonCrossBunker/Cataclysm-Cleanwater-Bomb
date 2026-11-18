local ccb = require("ccb")
local content = ccb.content

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
