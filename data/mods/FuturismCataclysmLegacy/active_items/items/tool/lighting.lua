local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "fcl_atomic_lamp",
        category = "tools",
        name = ccb.content.plural_text("atomic lamp", "atomic lamps"),
        looks_like = "ap_standing_lamp",
        description = ccb.content.text("Powered by the magic of nuclear decay and low-energy LEDs, this very expensive lamp will emit a small amount of light for at least a decade.  Before the Cataclysm, it was mostly an expensive way to show off your preparedness.  Now, it's actually really useful.  Use it to close the cover and hide the light."),
        mass_milligrams = 6000000,
        volume_ml = 2000,
        price_cents = 175000,
        price_postapoc_cents = 4000,
        symbol = ",",
        color = "light_green",
        light = 15,
    }
    item:material("plastic", 1)
    item:material("aluminum", 1)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "fcl_atomic_lamp_off" },
        message = ccb.content.text("You close the lamp's cover."),
        menu_text = ccb.content.text("Close cover"),
    }
    item:clear_flags()
    item:flag("LEAK_DAM")
    item:flag("RADIOACTIVE")
    item:flag("ALLOWS_REMOTE_USE")
    item:flag("DURABLE_MELEE")
    item:flag("SPAWN_ACTIVE")
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    content.add(item)
end

do
    local item = content.Item {
        id = "fcl_atomic_lamp_off",
        copy_from = "fcl_atomic_lamp",
        looks_like = "fcl_atomic_lamp",
        category = "tools",
        name = ccb.content.plural_text("atomic lamp (covered)", "atomic lamps (covered)"),
        description = ccb.content.text("Powered by the magic of nuclear decay and low-energy LEDs, this very expensive lamp will emit a small amount of light for at least a decade.  Before the Cataclysm, it was mostly an expensive way to show off your preparedness.  Now, it's actually really useful.  The cover is closed.  Use it to open the cover and show the light."),
        light = 0,
    }
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "fcl_atomic_lamp" },
        message = ccb.content.text("You open the lamp's cover."),
        menu_text = ccb.content.text("Open cover"),
    }
    item:clear_flags()
    item:flag("LEAK_DAM")
    item:flag("RADIOACTIVE")
    item:flag("ALLOWS_REMOTE_USE")
    item:flag("DURABLE_MELEE")
    content.add(item)
end

do
    local item = content.Item {
        id = "fcl_atomic_light",
        category = "tools",
        name = ccb.content.plural_text("atomic reading light", "atomic reading lights"),
        description = ccb.content.text("Powered by the magic of nuclear decay and low-energy LEDs, this extremely expensive little light will provide just enough light to read by for at least a decade.  It is also available with a cute cartoon bear cover to turn it into a nightlight for a very wealthy child with a fear of the dark.  Use it to close the cover and hide the light."),
        mass_milligrams = 214000,
        volume_ml = 250,
        price_cents = 125000,
        price_postapoc_cents = 4000,
        symbol = ",",
        color = "light_green",
        light = 10,
    }
    item:material("plastic", 1)
    item:material("aluminum", 1)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "fcl_atomic_light_off" },
        message = ccb.content.text("You close the lamp's cover."),
        menu_text = ccb.content.text("Close cover"),
    }
    item:clear_flags()
    item:flag("LEAK_DAM")
    item:flag("RADIOACTIVE")
    item:flag("DURABLE_MELEE")
    item:flag("ALLOWS_REMOTE_USE")
    item:flag("SPAWN_ACTIVE")
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    content.add(item)
end

do
    local item = content.Item {
        id = "fcl_atomic_light_off",
        copy_from = "fcl_atomic_light",
        looks_like = "fcl_atomic_light",
        category = "tools",
        name = ccb.content.plural_text("atomic reading light (covered)", "atomic reading lights (covered)"),
        description = ccb.content.text("Powered by the magic of nuclear decay and low-energy LEDs, this extremely expensive little light will provide just enough light to read by for at least a decade.  It is also available with a cute cartoon bear cover to turn it into a nightlight for a very wealthy child with a fear of the dark.  The cover is closed.  Use it to open the cover and show the light."),
        light = 0,
    }
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "fcl_atomic_light" },
        message = ccb.content.text("You open the lamp's cover."),
        menu_text = ccb.content.text("Open cover"),
    }
    item:clear_flags()
    item:flag("LEAK_DAM")
    item:flag("RADIOACTIVE")
    item:flag("DURABLE_MELEE")
    item:flag("ALLOWS_REMOTE_USE")
    content.add(item)
end
