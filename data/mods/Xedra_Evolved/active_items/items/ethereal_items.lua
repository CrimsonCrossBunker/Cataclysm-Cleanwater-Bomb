local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "constructed_hammer",
        name = ccb.content.plural_text("constructed hammer", "constructed hammers"),
        description = ccb.content.text("A long handle ending in a two-sided head, one of which is hollow, and the other… does not exist.  Weirdly, both heads are equally useful, and the balance of hammer is pretty good to be useful as a weapon.  By activating and attacking with the hollow part, the hammer creates a tremendous force, able to break a thick tree (or someone's spine) in half, but will be destroyed afterwards."),
        copy_from = "mace",
        looks_like = "mace",
        mass_milligrams = 1250000,
        color = "dark_gray",
        symbol = "/",
        volume_ml = 1050,
        price_cents = 0,
        price_postapoc_cents = 0,
        replace_qualities = true,
    }
    item:material("forged_dreamstuff", 1)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("NONCONDUCTIVE")
    item:flag("BELT_CLIP")
    item:flag("TRADER_AVOID")
    item:flag("SINGLE_USE")
    item:clear_use_actions()
    item:cast_spell { spell = "constructed_hammer_attack", no_fail = true, level = 0, need_wielding = true }
    item:quality("PRY", 4)
    item:quality("HAMMER", 2)
    item:quality("PRYING_NAIL", 1)
    content.add(item)
end
