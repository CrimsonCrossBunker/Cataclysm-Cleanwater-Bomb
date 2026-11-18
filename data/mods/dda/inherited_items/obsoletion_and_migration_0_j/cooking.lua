local ccb = require("ccb")
local content = ccb.content

do
    -- 2 weeks for cristallizing sugar, based on the real-life example
    local item = content.Item {
        id = "crystallizing_sugar",
        symbol = "*",
        color = "white",
        category = "food",
        name = ccb.content.plural_text("crystallizing sugar (obsolete)", "crystallizing sugar (obsolete)"),
        description = ccb.content.text("Sweet, sweet sugar in the process of crystallizing.  It needs two weeks to form solid crystals."),
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 10000,
        volume_ml = 10,
    }
    item:material("sugar", 1)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "sugar" },
        message = ccb.content.text("You break up the crystallized sugar into a coarse powder."),
        not_ready_message = ccb.content.text("The sugar is still crystallizing."),
        moves = 300,
        minimum_age_turns = 1209600,
    }
    item:clear_flags()
    item:flag("NO_SALVAGE")
    item:flag("WATER_DISSOLVE")
    item:tool()
    content.add(item)
end
