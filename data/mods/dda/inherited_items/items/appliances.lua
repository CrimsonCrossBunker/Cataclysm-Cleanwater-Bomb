local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "mill_vertical",
        name = ccb.content.plural_text("disconnected vertical mill", "disconnected vertical mills"),
        description = ccb.content.text("A vertical milling machine commonly known as a Bridgeport.  Needs to be placed and plugged into a power source."),
        looks_like = "f_heavy_lathe",
        symbol = "M",
        color = "cyan_red",
        longest_side_mm = 1070,
        volume_ml = 275000,
        mass_milligrams = 1134000000,
    }
    item:material("iron", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "oven",
        looks_like = "f_oven",
        symbol = "#",
        description = ccb.content.text("A disconnected electric convection-based oven, commonly used for heating and cooking food.  Plug it into a vehicle or power grid to get cooking."),
        color = "dark_gray_white",
        name = ccb.content.plural_text("disconnected oven", "disconnected ovens"),
        longest_side_mm = 690,
        insulation = 3,
        volume_ml = 290000,
        mass_milligrams = 77000000,
        replace_pockets = true,
    }
    item:material("budget_steel", 1)
    item:container_pocket { max_volume_ml = 120000, max_weight_milligrams = 200000000, rigid = true }
    item:tool()
    content.add(item)
end

do
    -- Based off DEWALT 12-Inch Sliding Compound Miter Saw
    local item = content.Item {
        id = "mitresaw",
        looks_like = "f_machinery_light",
        symbol = "7",
        description = ccb.content.text("A circular sawblade on an arm that can slide and rotate in several directions, this is a staple tool for nearly any carpentry.  Needs to be placed and plugged into a power source."),
        color = "yellow_cyan",
        name = ccb.content.plural_text("disconnected mitre saw", "disconnected mitre saws"),
        longest_side_mm = 1200,
        volume_ml = 170000,
        mass_milligrams = 30000000,
    }
    item:material("steel", 85)
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "autoclave",
        name = ccb.content.plural_text("disconnected autoclave", "disconnected autoclaves"),
        description = ccb.content.text("An autoclave, used to sterilize equipment with pressurized steam.  It requires a massive amount of power, so it will need to be plugged into a power grid."),
        mass_milligrams = 34500000,
        volume_ml = 76000,
        price_cents = 162654,
        price_postapoc_cents = 2000,
        melee_to_hit = -3,
        symbol = "A",
        color = "yellow",
        looks_like = "microwave",
        replace_pockets = true,
    }
    item:material("steel", 1)
    item:container_pocket {
        max_volume_ml = 20000,
        max_weight_milligrams = 15000000,
        rigid = true,
        watertight = true,
        allowed_flags = { "CBM" },
        allowed_items = { "water_clean", "water" },
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 10)
    item:tool()
    content.add(item)
end
