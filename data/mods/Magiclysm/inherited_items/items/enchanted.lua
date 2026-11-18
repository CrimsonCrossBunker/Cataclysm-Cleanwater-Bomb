local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "bleed_staff_minor",
        copy_from = "magi_staff_minor",
        looks_like = "magi_staff_minor",
        symbol = "/",
        color = "red",
        name = ccb.content.plural_text("sinister minor staff of bleeding", "sinister minor staves of bleeding"),
        description = ccb.content.text("A sinister looking staff, made of wood and with a red orb of crystallized mana at the handle.  The orb and its rune faintly glow with magic when you cast spells.  Wielding it slightly increases your mana regeneration and allows you to cast the bleed spell."),
        price_cents = 15000,
        replace_pockets = true,
    }
    item:clear_use_actions()
    item:cast_spell { spell = "bleed", no_fail = true, level = 5, need_wielding = true }
    item:tool { charges_per_use = 1 }
    item:magazine_pocket { ammo_capacities = { crystallized_mana = 5 }, holster = true, rigid = true }
    content.add(item)
end
