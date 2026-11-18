local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "fighter_sting",
        name = ccb.content.plural_text("triffid stinger", "triffid stingers"),
        description = ccb.content.text("A short wooden dart grown from a mutated plant.  Makes a poor melee weapon."),
        mass_milligrams = 270000,
        melee_to_hit = -3,
        color = "green",
        symbol = ",",
        volume_ml = 250,
        weapon_categories = { "SHIVS" },
        price_cents = 0,
        price_postapoc_cents = 0,
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("SHEATH_KNIFE")
    item:flag("ALLOWS_BODY_BLOCK")
    item:flag("NPC_THROWN")
    item:clear_melee_damage()
    item:melee_damage("stab", 8)
    item:throwing_damage { { type = "stab", amount = 6 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "mattress",
        category = "spare_parts",
        name = ccb.content.plural_text("mattress", "mattresses"),
        description = ccb.content.text("A single, or twin, sized mattress."),
        mass_milligrams = 20000000,
        volume_ml = 300000,
        longest_side_mm = 1900,
        price_cents = 1000,
        price_postapoc_cents = 500,
        symbol = "0",
        color = "white",
        fall_damage_reduction = 20,
    }
    item:material("cotton", 1)
    item:material("steel", 1)
    item:clear_flags()
    item:flag("NONCONDUCTIVE")
    item:flag("SINGLE_USE")
    item:clear_use_actions()
    item:place_trap {
        trap = "tr_mattress",
        moves = 100,
        practice = 0,
        message = ccb.content.text("You lay the mattress flat on the ground."),
        allow_under_player = true,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "down_mattress",
        category = "spare_parts",
        name = ccb.content.plural_text("down mattress", "down mattresses"),
        description = ccb.content.text("A single, or twin, sized down-filled mattress."),
        mass_milligrams = 6000000,
        volume_ml = 300000,
        longest_side_mm = 1900,
        price_cents = 1000,
        price_postapoc_cents = 750,
        symbol = "0",
        color = "white",
        fall_damage_reduction = 15,
    }
    item:material("cotton", 1)
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:clear_use_actions()
    item:place_trap {
        trap = "tr_down_mattress",
        moves = 1000,
        practice = 0,
        message = ccb.content.text("You lay the mattress flat on the ground."),
        allow_under_player = true,
    }
    content.add(item)
end
