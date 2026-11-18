local ccb = require("ccb")
local content = ccb.content

do
    -- 2 days
    local item = content.Item {
        id = "tanning_hide",
        category = "spare_parts",
        name = ccb.content.plural_text("tanning leather hide (obsolete)", "tanning leather hides (obsolete)"),
        description = ccb.content.text("A treated animal hide that is undergoing the chemical processes required to become leather.  You will be able to activate it to unroll and make use of it when it is done."),
        mass_milligrams = 600000,
        volume_ml = 1000,
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = ",",
        color = "brown",
    }
    item:material("flesh", 1)
    item:material("leather", 1)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "tanned_hide" },
        message = ccb.content.text("You carefully unfold the tanning leather hide and shake it clean."),
        moves = 150,
        minimum_age_turns = 28800,
        not_ready_message = ccb.content.text("The tanning leather hide isn't done yet."),
    }
    item:clear_flags()
    item:flag("NO_SALVAGE")
    item:tool()
    content.add(item)
end

do
    -- 2 days
    local item = content.Item {
        id = "tanning_pelt",
        category = "spare_parts",
        name = ccb.content.plural_text("tanning fur pelt (obsolete)", "tanning fur pelts (obsolete)"),
        description = ccb.content.text("A treated animal pelt that is undergoing the chemical processes required to become fur.  You will be able to activate it to unroll and make use of it when it is done."),
        mass_milligrams = 684000,
        volume_ml = 1000,
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = ",",
        color = "brown",
    }
    item:material("fur", 1)
    item:material("flesh", 1)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "tanned_pelt" },
        message = ccb.content.text("You carefully unfold the tanning fur pelt and shake it clean."),
        moves = 150,
        minimum_age_turns = 28800,
        not_ready_message = ccb.content.text("The tanning fur pelt isn't done yet."),
    }
    item:clear_flags()
    item:flag("NO_SALVAGE")
    item:tool()
    content.add(item)
end
