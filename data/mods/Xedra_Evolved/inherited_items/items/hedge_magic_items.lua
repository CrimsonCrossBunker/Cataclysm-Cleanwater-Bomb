local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "hedge_fire_starter",
        name = ccb.content.plural_text("To Kindle the Flames", "To Kindle the Flames"),
        description = ccb.content.text("The item that starts fires when using To Kindle the Flames.  This should be summoned and deleted as part of the spell, so you should never actually see it."),
        mass_milligrams = 0,
        volume_ml = 0,
        symbol = ",",
        color = "red",
    }
    item:clear_use_actions()
    item:firestarter { moves = 5, moves_slow = 5 }
    item:clear_flags()
    item:flag("FIRE")
    item:flag("ZERO_WEIGHT")
    item:tool()
    content.add(item)
end
