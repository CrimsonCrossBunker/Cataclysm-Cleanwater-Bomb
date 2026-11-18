local ccb = require("ccb")
local content = ccb.content

do
    -- Volume based on https://www.amazon.com/dp/B0CBLV98KP with the assumption that it's a cylinder with a 6.5cm diameter - using 13cm would give ridiculously high volume, and the 13cm assumption on the website includes only half of the collapsed length.
    local item = content.Item {
        id = "butterfly_net_collapsible",
        name = ccb.content.plural_text("collapsible butterfly net", "collapsible butterfly nets"),
        description = ccb.content.text("A piece of canvas on a collapsible aluminum frame.  Used to catch bugs or fish, but might not be as useful for the mutated ones.  It must be extended to use."),
        mass_milligrams = 247000,
        volume_ml = 780,
        longest_side_mm = 235,
        color = "light_gray",
        symbol = "P",
        melee_to_hit = -1,
        price_cents = 1800,
        price_postapoc_cents = 15,
    }
    item:material("aluminum", 7)
    item:material("canvas", 3)
    item:clear_flags()
    item:flag("FRAGILE_MELEE")
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "butterfly_net_collapsible_extended" },
        menu_text = ccb.content.text("Extend"),
        message = ccb.content.text("You snap open your butterfly net."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "butterfly_net_collapsible_extended",
        name = ccb.content.plural_text("collapsible butterfly net (extended)", "collapsible butterfly nets (extended)"),
        description = ccb.content.text("A piece of canvas on a collapsible aluminum frame.  Used to catch bugs or fish, but might not be as useful for the mutated ones."),
        copy_from = "butterfly_net_collapsible",
        looks_like = "butterfly_net_collapsible",
        longest_side_mm = 920,
        melee_to_hit = 1,
    }
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "butterfly_net_collapsible" },
        menu_text = ccb.content.text("Collapse"),
        message = ccb.content.text("You collapse your butterfly net."),
    }
    content.add(item)
end
