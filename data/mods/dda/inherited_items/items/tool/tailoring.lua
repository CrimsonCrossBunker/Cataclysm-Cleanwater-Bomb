local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "tanning_hide_active",
        category = "spare_parts",
        name = ccb.content.plural_text("tanning leather hide", "tanning leather hides"),
        description = ccb.content.text("A treated animal hide that is undergoing the chemical processes required to become leather.  The process takes about 8 hours."),
        mass_milligrams = 600000,
        volume_ml = 1000,
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = ",",
        color = "brown",
        countdown_turns = 28800,
    }
    item:material("flesh", 1)
    item:material("leather", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    item:flag("SPAWN_ACTIVE")
    item:transform_into { target = "tanned_hide" }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "tanning_pelt_active",
        category = "spare_parts",
        name = ccb.content.plural_text("tanning fur pelt", "tanning fur pelts"),
        description = ccb.content.text("A treated animal pelt that is undergoing the chemical processes required to become fur.  The process takes about 8 hours."),
        mass_milligrams = 684000,
        volume_ml = 1000,
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = ",",
        color = "brown",
        countdown_turns = 28800,
    }
    item:material("fur", 1)
    item:material("flesh", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    item:flag("SPAWN_ACTIVE")
    item:transform_into { target = "tanned_pelt" }
    item:tool()
    content.add(item)
end

do
    -- Based roughly off an Ashford E-Spinner 3 because that was the first thing I looked at.
    local item = content.Item {
        id = "electric_spinwheel",
        name = ccb.content.plural_text("electric spinwheel", "electric spinwheels"),
        description = ccb.content.text("A device for spinning thread or yarn from fibers.  This particular model is electrically-powered and easily portable."),
        looks_like = "box_medium",
        mass_milligrams = 5200000,
        volume_ml = 2700,
        longest_side_mm = 430,
        price_cents = 800,
        price_postapoc_cents = 50,
        melee_to_hit = -4,
        symbol = ";",
        color = "light_gray",
    }
    item:material("plastic", 1)
    item:material("steel", 1)
    item:clear_use_actions()
    item:link_cable { cable_length = 2, charge_milliwatts = 1800000 }
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    item:tool { ammo_types = { "battery" } }
    content.add(item)
end

do
    -- Based on https://www.singer.com/products/singer-heavy-duty-4452-sewing-machine
    local item = content.Item {
        id = "sewing_machine",
        name = ccb.content.plural_text("sewing machine", "sewing machines"),
        description = ccb.content.text("An absolutely essential tool for any modern tailor.  It works much faster than manual tailoring tools, but it must be plugged into a power grid to function."),
        symbol = ">",
        color = "red",
        mass_milligrams = 6600000,
        volume_ml = 10000,
        price_cents = 25000,
        price_postapoc_cents = 1000,
        charged_qualities = { { id = "SEW", level = 3, speed = 0.25 } },
    }
    item:material("aluminum", 95)
    item:material("plastic", 5)
    item:clear_use_actions()
    item:link_cable { cable_length = 2, charge_milliwatts = 84000 }
    item:clear_flags()
    item:flag("ALLOWS_REMOTE_USE")
    item:tool { charges_per_use = 1 }
    content.add(item)
end
