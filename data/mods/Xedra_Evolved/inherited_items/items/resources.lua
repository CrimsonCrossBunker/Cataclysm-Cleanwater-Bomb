local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "gossamer_patchwork",
        category = "spare_parts",
        name = ccb.content.plural_text("gossamer patch", "gossamer patches"),
        description = ccb.content.text("A 6-inch square gossamer patch, suitable for repairing and tailoring clothing."),
        mass_milligrams = 3000,
        volume_ml = 6,
        price_cents = 200,
        price_postapoc_cents = 2,
        symbol = ",",
        color = "white",
    }
    item:material("fae_cotton", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "elemental_gossamer_patchwork",
        category = "spare_parts",
        name = ccb.content.plural_text("elemental gossamer patch", "elemental gossamer patches"),
        description = ccb.content.text("A 6-inch square elemental gossamer patch, suitable for repairing and tailoring clothing."),
        mass_milligrams = 6000,
        volume_ml = 6,
        price_cents = 200,
        price_postapoc_cents = 2,
        symbol = ",",
        color = "white",
    }
    item:material("elemental_fae_cotton", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "gambeson_batting_gossamer",
        category = "spare_parts",
        name = ccb.content.plural_text("gossamer gambeson batting", "clumps of gossamer gambeson batting"),
        description = ccb.content.text("A pile of shredded gossamer, like wisps of solid moonlight, which could be used to stuff the fabric layers of a gambeson."),
        mass_milligrams = 33000,
        volume_ml = 50,
        price_cents = 0,
        price_postapoc_cents = 8,
        symbol = ",",
        color = "white",
    }
    item:material("fae_cotton", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    item:tool()
    content.add(item)
end

do
    -- 2 days
    local item = content.Item {
        id = "tanning_glimmer_pelt",
        category = "spare_parts",
        name = ccb.content.plural_text("tanning glimmer fur pelt", "tanning glimmer fur pelts"),
        description = ccb.content.text("A treated fae animal pelt that is undergoing the chemical processes required to become fur.  You will be able to activate it to unroll and make use of it when it is done."),
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
        result = { target = "tanned_glimmer_pelt" },
        message = ccb.content.text("You carefully unfold the tanning fae fur pelt and shake it clean."),
        moves = 150,
        minimum_age_turns = 28800,
        not_ready_message = ccb.content.text("The tanning fae fur pelt isn't done yet."),
    }
    item:clear_flags()
    item:flag("NO_SALVAGE")
    item:tool()
    content.add(item)
end
