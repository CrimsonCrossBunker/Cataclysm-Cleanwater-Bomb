local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "rebar_plate",
        category = "veh_parts",
        name = ccb.content.plural_text("rebar grate", "rebar grates"),
        description = ccb.content.text("Several interlocked rods of rebar serving as makeshift armor, allowing for light and effective reinforcement of vehicle sections."),
        mass_milligrams = 2200000,
        volume_ml = 3000,
        price_cents = 750,
        price_postapoc_cents = 500,
        melee_to_hit = -2,
        symbol = "]",
        color = "light_cyan",
    }
    item:material("lc_steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    content.add(item)
end

do
    local item = content.Item {
        id = "spring_plate",
        category = "veh_parts",
        name = ccb.content.plural_text("shock absorber", "shock absorbers"),
        description = ccb.content.text("A makeshift combination of springs and scrap that protects a particular section of a vehicle from the shock of impacts.  The springs can absorb a surprising amount of damage."),
        mass_milligrams = 20800000,
        volume_ml = 3000,
        price_cents = 1300,
        price_postapoc_cents = 750,
        melee_to_hit = -2,
        symbol = "]",
        color = "light_cyan",
    }
    item:material("hc_steel", 1)
    item:material("lc_steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    content.add(item)
end
