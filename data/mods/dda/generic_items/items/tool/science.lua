local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "glass_prism",
        category = "spare_parts",
        name = ccb.content.plural_text("glass prism", "glass prisms"),
        description = ccb.content.text("A high-quality crystal glass prism for separating and redirecting light."),
        mass_milligrams = 50000,
        volume_ml = 20,
        price_cents = 50,
        price_postapoc_cents = 50,
        symbol = "^",
        color = "white",
        stackable = true,
    }
    item:material("glass", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "stopcock",
        category = "spare_parts",
        name = ccb.content.plural_text("plastic stopcock", "plastic stopcocks"),
        description = ccb.content.text("Stop giggling.  This is a tiny plastic valve, get your mind out of the gutter."),
        mass_milligrams = 1000,
        volume_ml = 1,
        price_cents = 5,
        price_postapoc_cents = 10,
        looks_like = "plastic_chunk",
        symbol = "T",
        color = "white",
        stackable = true,
    }
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "rack_test_tube",
        category = "spare_parts",
        name = ccb.content.plural_text("test tube rack", "test tube racks"),
        description = ccb.content.text("A plastic box with holes in it.  Not that exciting, unless you're desperate for a place to store a test tube.  Then it's great."),
        mass_milligrams = 90000,
        volume_ml = 250,
        price_cents = 25,
        price_postapoc_cents = 10,
        looks_like = "plastic_chunk",
        symbol = "#",
        color = "yellow",
        stackable = true,
    }
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "rack_test_tube_micro",
        category = "spare_parts",
        name = ccb.content.plural_text("microcentrifuge tube tray", "microcentrifuge tube trays"),
        description = ccb.content.text("A plastic tray riddled with small holes, for storing microcentrifuge tubes."),
        mass_milligrams = 70000,
        volume_ml = 150,
        price_cents = 25,
        price_postapoc_cents = 10,
        looks_like = "plastic_chunk",
        symbol = "#",
        color = "yellow",
        stackable = true,
    }
    item:material("plastic", 1)
    content.add(item)
end

do
    -- The volume is lowered. The volume of the package of the attached amazon article is 5l+ but a lot of the parts are small enough to actually not take up much space. Yes, the number is relatively an asspull, but I refuse to believe a ring stand would be larger than a cooking pot in volume.
    -- Based on https://www.amazon.com/dp/B08ZSC1H5F
    local item = content.Item {
        id = "stand_ring",
        category = "spare_parts",
        name = ccb.content.plural_text("ring stand", "ring stands"),
        description = ccb.content.text("A heavy metal plate and a sturdy rod, for clamping lab stuff to."),
        mass_milligrams = 1100000,
        volume_ml = 3000,
        longest_side_mm = 410,
        price_cents = 1900,
        price_postapoc_cents = 10,
        melee_to_hit = -3,
        looks_like = "rebar",
        symbol = "l",
        color = "light_gray",
        stackable = true,
    }
    item:material("steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    content.add(item)
end

do
    local item = content.Item {
        id = "stand_ring_clamps",
        category = "spare_parts",
        name = ccb.content.plural_text("set of ring stand clamps", "sets of ring stand clamps"),
        description = ccb.content.text("A small box with a jumbled assortment of clamps for mounting on ring stands.  There seems to be some sort of rule that all of them are missing at least one wing nut for tightening; twist ties, duct tape, and other random stuff has been used to compensate."),
        mass_milligrams = 300000,
        volume_ml = 450,
        price_cents = 75,
        price_postapoc_cents = 10,
        melee_to_hit = -4,
        looks_like = "scrap",
        symbol = "[",
        color = "light_gray",
        stackable = true,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    content.add(item)
end

do
    -- this is based on Wikipedia's page on barometers, in section 'water barometers'
    local item = content.Item {
        id = "weather_glass",
        category = "TOOL",
        name = ccb.content.plural_text("weather glass", "weather glass"),
        description = ccb.content.text("Also called storm glass or 'Goethe barometer', The weather glass barometer consists of a glass container with a sealed body, half filled with water.  A narrow spout connects to the body below the water level and rises above the water level.  The difference between the sealed water level in the body and the narrow open spout determines the atmospheric pressure.  Activate to get current atmospheric pressure."),
        mass_milligrams = 6000000,
        volume_ml = 4000,
        longest_side_mm = 500,
        melee_to_hit = -4,
        price_cents = 500,
        price_postapoc_cents = 100,
        symbol = "W",
        color = "light_blue",
    }
    item:material("glass", 1)
    item:clear_use_actions()
    item:native_use("WEATHER_TOOL")
    item:clear_flags()
    item:flag("BAROMETER")
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    content.add(item)
end
