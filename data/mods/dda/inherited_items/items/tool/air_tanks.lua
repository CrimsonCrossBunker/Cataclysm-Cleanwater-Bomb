local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "scuba_tank",
        category = "tool",
        name = ccb.content.plural_text("diving cylinder", "diving cylinders"),
        looks_like = "oxygen_tank",
        description = ccb.content.text("A high-pressure 232 bar diving tank that can contain up to 12 L of a compressed mixture of oxygen and nitrogen.  Activate it to open it."),
        mass_milligrams = 16000000,
        volume_ml = 12000,
        price_cents = 6000,
        price_postapoc_cents = 500,
        melee_to_hit = -4,
        symbol = ";",
        color = "light_gray",
        replace_pockets = true,
    }
    item:clear_use_actions()
    item:native_use("SCBA_TANK_ACTIVATE")
    item:material("steel", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("STURDY")
    item:flag("NO_UNLOAD")
    item:flag("NO_RELOAD")
    item:flag("SCBA_TANK")
    item:clear_melee_damage()
    item:melee_damage("bash", 10)
    item:tool { ammo_types = { "nitrox" } }
    item:magazine_pocket { ammo_capacities = { nitrox = 60 }, airtight = true, rigid = true, watertight = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "scuba_tank_on",
        copy_from = "scuba_tank",
        looks_like = "scuba_tank",
        category = "tool",
        name = ccb.content.plural_text("diving cylinder (open)", "diving cylinders (open)"),
        description = ccb.content.text("A high-pressure 232 bar diving tank that can contain up to 12 L of a compressed mixture of oxygen and nitrogen.  It is currently open.  Activate it to close it."),
    }
    item:clear_flags()
    item:flag("STURDY")
    item:flag("NO_UNLOAD")
    item:flag("NO_RELOAD")
    item:flag("SCBA_TANK_ON")
    item:flag("SPAWN_ACTIVE")
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "scuba_tank" },
        menu_text = ccb.content.text("Close the valve"),
        message = ccb.content.text("You close the valve on the tank."),
    }
    item:transform_into { target = "scuba_tank" }
    item:tool { charges_per_use = 1, turns_per_charge = 60 }
    content.add(item)
end

do
    local item = content.Item {
        id = "small_scuba_tank",
        category = "tool",
        name = ccb.content.plural_text("small diving cylinder", "small diving cylinders"),
        description = ccb.content.text("A small, high-pressure 200 bar diving tank that can contain 4 L of a compressed mixture of oxygen and nitrogen.  Activate it to open it."),
        looks_like = "smoxygen_tank",
        mass_milligrams = 7000000,
        volume_ml = 4000,
        price_cents = 4000,
        price_postapoc_cents = 250,
        melee_to_hit = -4,
        symbol = ";",
        color = "light_gray",
        replace_pockets = true,
    }
    item:clear_use_actions()
    item:native_use("SCBA_TANK_ACTIVATE")
    item:material("aluminum", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("STURDY")
    item:flag("NO_UNLOAD")
    item:flag("NO_RELOAD")
    item:flag("SCBA_TANK")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:tool { ammo_types = { "nitrox" } }
    item:magazine_pocket { ammo_capacities = { nitrox = 20 }, airtight = true, rigid = true, watertight = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "small_scuba_tank_on",
        copy_from = "small_scuba_tank",
        looks_like = "small_scuba_tank",
        category = "tool",
        name = ccb.content.plural_text("small diving cylinder (open)", "small diving cylinders (open)"),
        description = ccb.content.text("A small, high-pressure 200 bar backup diving tank that can contain 4 L of a compressed mixture of oxygen and nitrogen.  It is currently open.  Activate it to close it."),
    }
    item:clear_flags()
    item:flag("STURDY")
    item:flag("NO_UNLOAD")
    item:flag("NO_RELOAD")
    item:flag("SCBA_TANK_ON")
    item:flag("SPAWN_ACTIVE")
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "small_scuba_tank" },
        menu_text = ccb.content.text("Close the valve"),
        message = ccb.content.text("You close the valve on the tank."),
    }
    item:transform_into { target = "small_scuba_tank" }
    item:tool { charges_per_use = 1, turns_per_charge = 60 }
    content.add(item)
end

do
    local item = content.Item {
        id = "firefighter_scba_tank",
        category = "tool",
        name = ccb.content.plural_text("firefighter SCBA cylinder", "firefighter SCBA cylinders"),
        description = ccb.content.text("A lightweight aluminum cylinder wrapped in carbon fiber, holding a highly compressed mixture of oxygen and nitrogen.  Activate it to open it."),
        looks_like = "smoxygen_tank",
        mass_milligrams = 4000000,
        volume_ml = 6800,
        price_cents = 4000,
        price_postapoc_cents = 250,
        melee_to_hit = -4,
        symbol = ";",
        color = "light_gray",
        replace_pockets = true,
    }
    item:clear_use_actions()
    item:native_use("SCBA_TANK_ACTIVATE")
    item:material("aluminum", 1)
    item:material("carbonfiber", 1)
    item:clear_flags()
    item:flag("STURDY")
    item:flag("NO_UNLOAD")
    item:flag("NO_RELOAD")
    item:flag("SCBA_TANK")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:tool { ammo_types = { "nitrox" } }
    item:magazine_pocket { ammo_capacities = { nitrox = 30 }, airtight = true, rigid = true, watertight = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "firefighter_scba_tank_on",
        copy_from = "firefighter_scba_tank",
        looks_like = "firefighter_scba_tank",
        category = "tool",
        name = ccb.content.plural_text("firefighter SCBA cylinder (open)", "firefighter SCBA cylinders (open)"),
        description = ccb.content.text("A lightweight aluminum cylinder wrapped in carbon fiber, holding a highly compressed mixture of oxygen and nitrogen.  It is currently open.  Activate it to close it."),
    }
    item:clear_flags()
    item:flag("STURDY")
    item:flag("NO_UNLOAD")
    item:flag("NO_RELOAD")
    item:flag("SCBA_TANK_ON")
    item:flag("SPAWN_ACTIVE")
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "firefighter_scba_tank" },
        menu_text = ccb.content.text("Close the valve"),
        message = ccb.content.text("You close the valve on the tank."),
    }
    item:transform_into { target = "firefighter_scba_tank" }
    item:tool { charges_per_use = 1, turns_per_charge = 60 }
    content.add(item)
end
