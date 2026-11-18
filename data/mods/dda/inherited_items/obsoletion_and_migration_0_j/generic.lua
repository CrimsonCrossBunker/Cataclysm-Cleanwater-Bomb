local ccb = require("ccb")
local content = ccb.content

do
    -- Should be about a week. Irl it's ten days, so make big batches.
    local item = content.Item {
        id = "adobe_pallet_full",
        name = ccb.content.plural_text("pallet of wet adobe bricks (obsolete)", "pallets of wet adobe bricks (obsolete)"),
        description = ccb.content.text("A pallet full of heavy mud bricks which need to dry slowly to be usable."),
        mass_milligrams = 220000000,
        volume_ml = 220000,
        longest_side_mm = 1800,
        price_cents = 100,
        price_postapoc_cents = 0,
        symbol = "#",
        color = "brown",
        looks_like = "frame_wood_light",
    }
    item:material("soil", 1)
    item:material("wood", 1)
    item:clear_flags()
    item:flag("NONCONDUCTIVE")
    item:flag("ALLOWS_REMOTE_USE")
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "adobe_pallet_done" },
        message = ccb.content.text("You test the bricks, and they're solid enough to use."),
        moves = 50,
        minimum_age_turns = 604800,
        not_ready_message = ccb.content.text("The bricks are still too damp to bear weight."),
    }
    item:tool()
    content.add(item)
end
