local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "peephole",
        symbol = ".",
        color = "yellow",
        name = ccb.content.plural_text("peephole", "peepholes"),
        category = "spare_parts",
        description = ccb.content.text("A metal cylinder with a small lens inside intended to be installed on a door."),
        price_cents = 12000,
        price_postapoc_cents = 50,
        mass_milligrams = 5000,
        volume_ml = 250,
        stackable = true,
    }
    item:material("brass", 1)
    item:material("glass", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "screen_mesh",
        symbol = "#",
        color = "brown",
        looks_like = "r_carpet",
        name = ccb.content.plural_text("mesh screen", "mesh screens"),
        category = "spare_parts",
        description = ccb.content.text("A roll of fine mesh screen for bug barriers on porches."),
        price_cents = 1200,
        price_postapoc_cents = 50,
        mass_milligrams = 25000,
        volume_ml = 1000,
        stackable = true,
    }
    item:material("plastic", 1)
    content.add(item)
end

do
    -- 1 inch schedule 80 CPVC, 0.44 lbs/ft., thickness 0.179 in., inner diameter 0.957 in., outer 1.315 in.
    local item = content.Item {
        id = "pipe_cpvc",
        symbol = "#",
        color = "brown",
        looks_like = "pipe",
        name = ccb.content.plural_text("PVC pipe", "PVC pipes"),
        description = ccb.content.text("White polyvinyl chloride pipe, commonly used for household plumbing, but also in many another applications."),
        category = "spare_parts",
        price_cents = 315,
        price_postapoc_cents = 1,
        mass_milligrams = 327000,
        volume_ml = 1750,
        stackable = true,
    }
    item:material("vinyl", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    content.add(item)
end
