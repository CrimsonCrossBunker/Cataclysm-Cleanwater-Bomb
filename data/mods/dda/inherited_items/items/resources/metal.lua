local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "gold_small",
        category = "spare_parts",
        name = ccb.content.plural_text("gold", "gold"),
        description = ccb.content.text("A soft, shiny metal.  Before the apocalypse this would've been worth a small fortune, but now its value is greatly diminished."),
        mass_milligrams = 19000,
        volume_ml = 1,
        price_cents = 32015,
        price_postapoc_cents = 10,
        symbol = "/",
        color = "yellow",
        display_type = "BY_WEIGHT",
        stackable = true,
    }
    item:material("gold", 1)
    content.add(item)
end

do
    -- Based on https://en.stainlesseurope.com/en_US/p/Stainless-steel-acid-resistant-seamless-tube-DN20-OD-28-mm-x-1%2C5-mm-1.4571-316Ti-60cm/13983
    local item = content.Item {
        id = "pipe",
        name = ccb.content.plural_text("pipe", "pipes"),
        description = ccb.content.text("A steel pipe; makes a good melee weapon.  Useful in a bunch of crafting recipes."),
        category = "spare_parts",
        mass_milligrams = 600000,
        longest_side_mm = 600,
        melee_to_hit = 0,
        color = "dark_gray",
        symbol = "/",
        replace_qualities = true,
        techniques = { "WBLOCK_2", "RAPID", "PRECISE", "MOUNTED_CHARGE" },
        weapon_categories = { "BATONS" },
        volume_ml = 370,
        price_cents = 3800,
        price_postapoc_cents = 10,
        stackable = true,
    }
    item:material("steel", 1)
    item:quality("HAMMER", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 10)
    item:mounted_charge { max_steps = 15, damage_type = "bash", multiplier_per_step = 0.06, max_multiplier = 1.25 }
    item:fault_group("steel_pipe_short", { weight_multiplier = 2 })
    content.add(item)
end
