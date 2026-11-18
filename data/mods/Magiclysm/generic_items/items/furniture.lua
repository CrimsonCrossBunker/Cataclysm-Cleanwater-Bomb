local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "everburning_torch_candelabra",
        name = ccb.content.plural_text("everburning torch candelabra", "everburning torch candelabras"),
        description = ccb.content.text("A tall, homemade candelabra that holds multiple everburning torches.  You could set it up somewhere to kindle the torches and provide light."),
        symbol = "Y",
        color = "brown",
        price_cents = 0,
        price_postapoc_cents = 100000,
        longest_side_mm = 1500,
        volume_ml = 200000,
        mass_milligrams = 48000000,
        melee_to_hit = -3,
    }
    item:clear_flags()
    item:flag("NO_SALVAGE")
    item:flag("FRAGILE_MELEE")
    item:material("wood", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "everburning_sconce",
        name = ccb.content.plural_text("everburning sconce", "everburning sconces"),
        description = ccb.content.text("This is a high quality engraved wooden torch, placed into a wood and metal sconce and ready to be attached to a wall.  It will burn forever with a smokeless light.  Now you can light your wizard's ritual room in the traditional fashion."),
        mass_milligrams = 1531000,
        volume_ml = 2250,
        price_cents = 0,
        price_postapoc_cents = 15000,
        longest_side_mm = 600,
        melee_to_hit = 1,
        symbol = "/",
        color = "brown",
    }
    item:material("wood", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    content.add(item)
end

do
    local item = content.Item {
        id = "orrery_item",
        name = ccb.content.plural_text("orrery", "orreries"),
        description = ccb.content.text("This is a beautiful, non-scale model of the solar system.  A complex series of gears allows the relative motions of the planets to be studied at the turn of a crank.  You could set this up somewhere to decorate."),
        mass_milligrams = 15000000,
        volume_ml = 20000,
        longest_side_mm = 800,
        melee_to_hit = 1,
        symbol = "@",
        color = "brown",
    }
    item:material("steel", 1)
    item:material("wood", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    content.add(item)
end

do
    local item = content.Item {
        id = "druid_chair_item",
        name = ccb.content.plural_text("gnarled chair", "gnarled chairs"),
        description = ccb.content.text("A simple wooden chair with four legs, a seat, and a back, all seemingly grown out of a single solid piece of wood.  Despite the twisted lines, it still looks extremely comfortable."),
        symbol = "#",
        color = "green",
        price_cents = 3000,
        price_postapoc_cents = 250,
        longest_side_mm = 950,
        volume_ml = 30000,
        mass_milligrams = 12000000,
        melee_to_hit = -3,
    }
    item:clear_flags()
    item:flag("NO_SALVAGE")
    item:flag("FRAGILE_MELEE")
    item:material("wood", 1)
    content.add(item)
end
