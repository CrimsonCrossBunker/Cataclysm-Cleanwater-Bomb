local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "bolas",
        category = "weapons",
        name = ccb.content.plural_text("bolas", "bolases"),
        description = ccb.content.text("Some ropes with weights, designed to tangle the legs of a target when thrown, usually at an animal.  Used by the Gauchos of Argentina."),
        mass_milligrams = 400000,
        volume_ml = 750,
        price_cents = 600,
        price_postapoc_cents = 50,
        symbol = ";",
        color = "blue",
    }
    item:material("cotton", 1)
    item:material("stone", 1)
    item:clear_flags()
    item:flag("NOGIB")
    item:flag("TANGLE")
    item:flag("PRIMITIVE_RANGED_WEAPON")
    content.add(item)
end

do
    local item = content.Item {
        id = "frisbee",
        category = "other",
        price_cents = 1000,
        price_postapoc_cents = 10,
        name = ccb.content.plural_text("frisbee", "frisbees"),
        symbol = "o",
        color = "yellow",
        description = ccb.content.text("A plastic frisbee made for outdoor games."),
        volume_ml = 500,
        mass_milligrams = 175000,
    }
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "net",
        category = "weapons",
        name = ccb.content.plural_text("net", "nets"),
        description = ccb.content.text("A mesh of string and weights, traditionally used to catch fish and to entangle opponents in combat."),
        mass_milligrams = 1100000,
        volume_ml = 1500,
        price_cents = 650,
        price_postapoc_cents = 250,
        symbol = "H",
        color = "white",
    }
    item:material("cotton", 1)
    item:material("stone", 1)
    item:clear_flags()
    item:flag("NOGIB")
    item:flag("TANGLE")
    item:flag("PRIMITIVE_RANGED_WEAPON")
    content.add(item)
end
