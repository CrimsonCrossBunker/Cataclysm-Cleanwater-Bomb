local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "thermo_resin_chunk",
        category = "spare_parts",
        name = ccb.content.plural_text("thermoplastic resin chunk", "thermoplastic resin chunks"),
        description = ccb.content.text("A piece of tough thermoplastic resin that could be used to craft, repair, or reinforce items."),
        mass_milligrams = 50000,
        volume_ml = 100,
        price_cents = 0,
        price_postapoc_cents = 10,
        symbol = ",",
        color = "light_blue",
    }
    item:material("thermo_resin", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "epoxy_chunk",
        category = "spare_parts",
        name = ccb.content.plural_text("epoxy chunk", "epoxy chunks"),
        description = ccb.content.text("A hardy and durable piece of epoxy.  You could potentially craft items with it."),
        mass_milligrams = 50000,
        volume_ml = 100,
        price_cents = 0,
        price_postapoc_cents = 10,
        symbol = ",",
        color = "light_blue",
    }
    item:material("epoxy", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "polycarbonate_chunk",
        category = "spare_parts",
        name = ccb.content.plural_text("polycarbonate chunk", "polycarbonate chunks"),
        description = ccb.content.text("A hardy and durable piece of polycarbonate.  You could potentially craft items with it."),
        mass_milligrams = 50000,
        volume_ml = 100,
        price_cents = 0,
        price_postapoc_cents = 10,
        symbol = ",",
        color = "light_blue",
        stackable = true,
    }
    item:material("hard_plastic_transp", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    item:tool()
    content.add(item)
end

do
    -- Based on a density around 1.05 grams/mL, like PLA and ABS, + 100% for being rigid and probably oddly-shaped.
    local item = content.Item {
        id = "plastic_chunk",
        category = "spare_parts",
        name = ccb.content.plural_text("plastic chunk", "plastic chunks"),
        description = ccb.content.text("A piece of plastic.  It could be used to fabricate, repair, or reinforce plastic items."),
        mass_milligrams = 50000,
        volume_ml = 95,
        price_cents = 0,
        price_postapoc_cents = 10,
        symbol = ",",
        color = "light_blue",
        stackable = true,
    }
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    item:tool()
    content.add(item)
end

do
    -- .25mm thick, 288GSM
    local item = content.Item {
        id = "nylon",
        category = "spare_parts",
        name = ccb.content.plural_text("synthetic fabric patch", "synthetic fabric patches"),
        description = ccb.content.text("A six-inch square patch of synthetic fabric.  Unlike you and other natural materials, it won't degrade much with age.  Maybe that's less of a bad thing now."),
        mass_milligrams = 5750,
        volume_ml = 5,
        price_cents = 0,
        price_postapoc_cents = 10,
        symbol = ",",
        color = "white",
        stackable = true,
    }
    item:material("nylon", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    item:tool()
    content.add(item)
end

do
    -- 180GSM, .63mm thick
    local item = content.Item {
        id = "lycra_patch",
        category = "spare_parts",
        name = ccb.content.plural_text("Lycra patch", "Lycra patches"),
        description = ccb.content.text("A six-inch square patch of synthetic fabric blended with stretchy Lycra fibers.  It could be used to make flexible yet strong clothing.  Stylish, but bad for the environment; at least you're recycling it."),
        mass_milligrams = 4000,
        volume_ml = 15,
        price_cents = 0,
        price_postapoc_cents = 10,
        symbol = ",",
        color = "light_blue",
        stackable = true,
    }
    item:material("lycra", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    item:tool()
    content.add(item)
end
