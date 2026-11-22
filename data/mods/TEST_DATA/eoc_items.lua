local ccb = require("ccb")
local content = ccb.content

ccb.runtime.handler("test_heavy_debug_backpack_use", function(context)
    if not context or not context.character then
        return 0
    end
    ccb.runtime.call_eoc("eoc:EOC_CANCEL_PORTAL_STORM", { u = context.character })
    return 0
end)

do
    local backpack = content.Item {
        id = "test_heavy_debug_backpack",
        name = content.text("debug pocket universe"),
        description = content.text("A pocket universe.  Can store approximately 384 * 10^6 bugs.  Still applies weight to the character"),
        mass_grams = 1,
        volume_ml = 1000,
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = "[",
        looks_like = "backpack",
        color = "yellow",
    }
    backpack:material("cotton", 1)
    backpack:flag("BELTED")
    backpack:flag("WATER_FRIENDLY")
    backpack:flag("TARDIS")
    backpack:flag("OVERSIZE")
    backpack:flag("WATCH")
    backpack:flag("THERMOMETER")
    backpack:armor { warmth = 0 }
    backpack:armor_portion {
        covers = { "torso" },
        sub_parts = { "torso_hanging_back" },
        encumbrance = 0,
        material_thickness = 0,
    }
    backpack:container_pocket {
        rigid = true,
        max_volume_ml = 100000000,
        max_weight_milligrams = 100000000000,
        moves = 1,
        max_item_length_mm = 1000000,
        weight_multiplier = 1,
        volume_multiplier = 0.01,
    }
    for _ = 1, 8 do
        backpack:container_pocket {
            rigid = true,
            max_volume_ml = 100000000,
            max_weight_milligrams = 100000000000,
            moves = 1,
            max_item_length_mm = 1000000,
            watertight = true,
            airtight = true,
            weight_multiplier = 1,
            volume_multiplier = 0.01,
        }
    end
    backpack:on_use(
        "test_heavy_debug_backpack_use",
        content.text("Activate"),
        content.text("Seems like it could calm local conditions.")
    )
    content.add(backpack)
end

-- Based on https://www.amazon.com/dp/B07CDR4KFM
do
    local carver = content.Item {
        id = "carver_off_test",
        name = content.plural_text("electric carver (off)", "electric carvers (off)"),
        description = content.text("An electric meat carver powered by cord.  It has two serrated blades that vibrate together to slice just about anything from turkey to ham… even zombies!"),
        melee_accuracy = { grip = "solid", length = "short", surface = "line", balance = "good" },
        mass_grams = 680,
        volume_ml = 1500,
        longest_side_mm = 482,
        price_cents = 2400,
        price_postapoc_cents = 1,
        symbol = "/",
        color = "yellow",
    }
    carver:material("steel", 1)
    carver:material("plastic", 1)
    carver:flag("SHEATH_SWORD")
    carver:flag("NONCONDUCTIVE")
    carver:flag("WATER_BREAK_ACTIVE")
    carver:melee_damage("bash", 2)
    carver:melee_damage("cut", 8)
    carver:tool { charges_per_use = 1, ammo_types = { "battery" } }
    carver:transform_on_use {
        result = { target = "carver_on" },
        message = content.text("The electric carver's serrated blades start buzzing!"),
        sound_volume = 20,
        menu_text = content.text("Turn on"),
        moves = 1,
    }
    carver:link_cable {
        cable_length = 2,
        charge_milliwatts = 120000,
    }
    content.add(carver)
end
