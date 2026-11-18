local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "wind_turbine",
        name = ccb.content.plural_text("wind turbine", "wind turbines"),
        description = ccb.content.text("A small turbine that can convert wind into electric power."),
        mass_milligrams = 50000000,
        melee_to_hit = -3,
        color = "yellow",
        symbol = "T",
        volume_ml = 20000,
        category = "veh_parts",
        price_cents = 60000,
        price_postapoc_cents = 1000,
    }
    item:material("lc_steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "xl_wind_turbine",
        name = ccb.content.plural_text("large wind turbine", "large wind turbines"),
        description = ccb.content.text("A large turbine that can convert wind into electric power."),
        mass_milligrams = 150000000,
        melee_to_hit = -3,
        symbol = "Y",
        volume_ml = 60000,
        price_cents = 150000,
        price_postapoc_cents = 1500,
        copy_from = "wind_turbine",
        looks_like = "wind_turbine",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "water_wheel",
        name = ccb.content.plural_text("water wheel", "water wheels"),
        description = ccb.content.text("A water wheel that will slowly recharge electrical power when built over shallow moving water."),
        mass_milligrams = 80000000,
        melee_to_hit = -3,
        symbol = "*",
        volume_ml = 30000,
        price_cents = 120000,
        price_postapoc_cents = 1000,
        copy_from = "wind_turbine",
        looks_like = "wind_turbine",
    }
    item:material("wood", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    content.add(item)
end

do
    local item = content.Item {
        id = "xl_water_wheel",
        name = ccb.content.plural_text("large water wheel", "large water wheels"),
        description = ccb.content.text("A large water wheel with wooden supports.  It will recharge electrical power when built over shallow moving water."),
        mass_milligrams = 210000000,
        symbol = "o",
        volume_ml = 60000,
        price_cents = 200000,
        price_postapoc_cents = 1500,
        copy_from = "water_wheel",
        looks_like = "water_wheel",
    }
    content.add(item)
end
