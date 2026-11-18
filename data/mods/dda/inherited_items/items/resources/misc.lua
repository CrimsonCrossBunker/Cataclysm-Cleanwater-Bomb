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
