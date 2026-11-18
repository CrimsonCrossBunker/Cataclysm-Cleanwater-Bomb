local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "mkey_opening",
        name = ccb.content.plural_text("skeleton key of opening", "skeleton keys of opening"),
        description = ccb.content.text("A small gold skeleton key.  You can activate it to unlock locked things."),
        mass_milligrams = 20000,
        volume_ml = 1,
        price_cents = 500000,
        symbol = "[",
        color = "yellow",
        replace_qualities = true,
    }
    item:material("gold", 1)
    item:quality("LOCKPICK", 50)
    item:clear_flags()
    item:flag("PERFECT_LOCKPICK")
    item:tool { charges_per_use = 1, initial_charges = 5, max_charges = 5 }
    content.add(item)
end
