local ccb = require("ccb")
local content = ccb.content

do
    -- The stationary object needs a larger capacity than the portable base object
    -- A fake kiln used for basecamps.
    -- 250 liters of materials can produce 100 liters of charcoal.
    -- 50000 charges of charcoal is 250 liters, the size of the largest charcoal kiln.
    local item = content.Item {
        id = "fake_char_kiln",
        copy_from = "fake_crafting_tool",
        looks_like = "fake_crafting_tool",
        name = ccb.content.plural_text("basecamp kiln", "basecamp kilns"),
        replace_pockets = true,
    }
    item:ammo_pocket("charcoal", 50000)
    item:tool { ammo_types = { "charcoal" }, crafting_subtype = "char_kiln" }
    content.add(item)
end

do
    -- The stationary object needs a larger capacity than the portable base object
    -- A fake charcoal smoker used for basecamps.
    -- holds 450 liters of charcoal. a full smoking rack cycle of 20L of stuff would consume 15,000 charcoal (75 liters, 15.6kg of charcoal)
    local item = content.Item {
        id = "fake_char_smoker",
        copy_from = "fake_crafting_tool",
        looks_like = "fake_crafting_tool",
        name = ccb.content.plural_text("basecamp charcoal smoker", "basecamp charcoal smokers"),
        replace_pockets = true,
    }
    item:ammo_pocket("charcoal", 90000)
    item:tool { ammo_types = { "charcoal" }, crafting_subtype = "char_smoker" }
    content.add(item)
end

do
    -- The stationary object needs a larger capacity than the portable base object
    -- A fake charcoal forge used for basecamps.
    local item = content.Item {
        id = "fake_forge",
        name = ccb.content.plural_text("basecamp forge", "basecamp forges"),
        copy_from = "char_forge",
        looks_like = "char_forge",
        replace_pockets = true,
    }
    item:flag("ALLOWS_REMOTE_USE")
    item:flag("ZERO_WEIGHT")
    item:flag("PSEUDO")
    item:ammo_pocket("charcoal", 2000)
    item:ammo_pocket("coal", 10000)
    item:tool()
    content.add(item)
end

do
    -- A fake fireplace used for basecamps.
    local item = content.Item {
        id = "fake_fireplace",
        copy_from = "fake_crafting_tool",
        looks_like = "fake_crafting_tool",
        name = ccb.content.plural_text("basecamp fireplace", "basecamp fireplaces"),
        replace_pockets = true,
    }
    item:ammo_pocket("tinder", 50000)
    item:tool { charge_factor = 25, ammo_types = { "tinder" }, crafting_subtype = "hotplate" }
    content.add(item)
end

do
    -- A fake stove used for basecamps.
    local item = content.Item {
        id = "fake_woodstove",
        copy_from = "fake_crafting_tool",
        looks_like = "fake_crafting_tool",
        name = ccb.content.plural_text("basecamp stove", "basecamp stoves"),
        replace_pockets = true,
    }
    item:ammo_pocket("tinder", 50000)
    item:tool { charge_factor = 10, ammo_types = { "tinder" }, crafting_subtype = "hotplate" }
    content.add(item)
end

do
    -- A fake drop hammer used for basecamps.
    local item = content.Item {
        id = "fake_drop_hammer",
        copy_from = "fake_item",
        name = ccb.content.plural_text("basecamp drop hammer", "basecamp drop hammers"),
        replace_qualities = true,
    }
    item:quality("HAMMER", 5)
    item:quality("ANVIL", 3)
    item:tool()
    content.add(item)
end

do
    -- A fake parkour gym used for parkour training in basecamps.
    local item = content.Item {
        id = "parkour_practice",
        copy_from = "fake_item",
        name = ccb.content.plural_text("basecamp parkour gym", "basecamp parkour gyms"),
    }
    item:tool()
    content.add(item)
end

do
    -- A fake tank for mixing biomass and water.
    local item = content.Item {
        id = "fake_digester_tank",
        copy_from = "fake_item",
        name = ccb.content.plural_text("small anaerobic digester tank", "small anaerobic digester tanks"),
    }
    item:tool()
    content.add(item)
end
