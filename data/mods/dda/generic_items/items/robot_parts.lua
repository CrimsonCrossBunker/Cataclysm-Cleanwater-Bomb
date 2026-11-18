local ccb = require("ccb")
local content = ccb.content

do
    -- NO_I18N
    -- NO_I18N
    local item = content.Item {
        id = "robot_module_abstract",
        abstract = true,
        name = content.plural_text("module template", "module templates"),
        description = content.text("This is a template for robot module.  If found in a game it is a bug."),
        symbol = "%",
        color = "cyan",
        mass_milligrams = 250000,
        volume_ml = 500,
        price_cents = 32000,
        price_postapoc_cents = 100,
        category = "spare_parts",
    }
    item:material("plastic", 1)
    item:material("steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "targeting_module",
        name = ccb.content.plural_text("targeting module", "targeting modules"),
        description = ccb.content.text("A module that integrates visual and proprioceptive information from peripheric sensors and outputs information necessary for accurate aiming."),
        copy_from = "robot_module_abstract",
        stackable = true,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "identification_module",
        name = ccb.content.plural_text("identification module", "identification modules"),
        description = ccb.content.text("A module that continuously runs image recognition algorithms to differentiate friend from foe."),
        copy_from = "robot_module_abstract",
        stackable = true,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "pathfinding_module",
        name = ccb.content.plural_text("pathfinding module", "pathfinding modules"),
        description = ccb.content.text("A module that uses a combination of vector integration and egocentric mapping to find the best path available."),
        copy_from = "robot_module_abstract",
        stackable = true,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "memory_module",
        name = ccb.content.plural_text("memory banks module", "memory banks modules"),
        description = ccb.content.text("A module that allows for the storage and recovery of information."),
        copy_from = "robot_module_abstract",
        stackable = true,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "sensor_module",
        name = ccb.content.plural_text("sensor array", "sensor arrays"),
        description = ccb.content.text("A wide range of sensors meant to give the ability to perceive the surrounding world."),
        copy_from = "robot_module_abstract",
        stackable = true,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "self_monitoring_module",
        name = ccb.content.plural_text("self monitoring sensors", "self monitoring sensors"),
        description = ccb.content.text("An array of sensors and diagnostic modules allowing a robot to perceive itself."),
        copy_from = "robot_module_abstract",
        stackable = true,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "ai_module",
        name = ccb.content.plural_text("AI core", "AI cores"),
        description = ccb.content.text("A module that is responsible for decision-making, it basically runs the AI of a robot."),
        copy_from = "robot_module_abstract",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "ai_module_basic",
        name = ccb.content.plural_text("basic AI core", "basic AI cores"),
        description = ccb.content.text("A very basic AI core with minimal cognitive abilities."),
        mass_milligrams = 125000,
        copy_from = "ai_module",
        looks_like = "ai_module",
        stackable = true,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "ai_module_advanced",
        name = ccb.content.plural_text("advanced AI core", "advanced AI cores"),
        description = ccb.content.text("An advanced AI core with impressive cognitive abilities."),
        copy_from = "ai_module",
        looks_like = "ai_module",
        stackable = true,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "gun_module",
        name = ccb.content.plural_text("gun operating system", "gun operating systems"),
        description = ccb.content.text("A system that can operate most conventional weapons."),
        copy_from = "robot_module_abstract",
        stackable = true,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "spidery_legs_small",
        name = ccb.content.plural_text("set of tiny spidery legs", "sets of tiny spidery legs"),
        description = ccb.content.text("A set of tiny, pointy legs, like the ones found under a skitterbot."),
        symbol = "w",
        color = "light_gray",
        mass_milligrams = 1200000,
        volume_ml = 1500,
        price_cents = 50000,
        price_postapoc_cents = 100,
        category = "spare_parts",
        stackable = true,
    }
    item:material("steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "omni_wheel",
        name = ccb.content.plural_text("set of omni wheels", "sets of omni wheels"),
        description = ccb.content.text("A set of omni wheels, like the ones found under a police bot."),
        symbol = "o",
        color = "light_gray",
        mass_milligrams = 10000000,
        volume_ml = 10000,
        price_cents = 100000,
        price_postapoc_cents = 100,
        category = "spare_parts",
        stackable = true,
    }
    item:material("steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "quad_rotors",
        name = ccb.content.plural_text("set of rotors", "sets of rotors"),
        description = ccb.content.text("A set of rotors able to lift a small drone."),
        symbol = "#",
        color = "light_gray",
        mass_milligrams = 130000,
        volume_ml = 500,
        price_cents = 40000,
        price_postapoc_cents = 100,
        category = "spare_parts",
        stackable = true,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "android_legs",
        name = ccb.content.plural_text("set of android legs", "sets of android legs"),
        description = ccb.content.text("A set of human-like legs."),
        symbol = "M",
        color = "light_gray",
        mass_milligrams = 10000000,
        volume_ml = 10000,
        price_cents = 100000,
        price_postapoc_cents = 250,
        category = "spare_parts",
        stackable = true,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "android_arms",
        name = ccb.content.plural_text("set of android arms", "sets of android arms"),
        description = ccb.content.text("A set of human-like arms."),
        symbol = "m",
        color = "light_gray",
        mass_milligrams = 5000000,
        volume_ml = 5000,
        price_cents = 100000,
        price_postapoc_cents = 250,
        category = "spare_parts",
        stackable = true,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "tank_tread",
        name = ccb.content.plural_text("set of small tank treads", "sets of small tank treads"),
        description = ccb.content.text("A set of small tank treads, like the ones used by the \"Beagle\" mini-tank."),
        symbol = "=",
        color = "light_gray",
        mass_milligrams = 60000000,
        volume_ml = 30000,
        price_cents = 600000,
        price_postapoc_cents = 250,
        category = "spare_parts",
        stackable = true,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "turret_chassis",
        name = ccb.content.plural_text("turret interior chassis", "turret interior chassis"),
        description = ccb.content.text("What's left when you remove all moving parts and electronics.  It's the skeleton of a turret."),
        symbol = "c",
        color = "light_gray",
        mass_milligrams = 10000000,
        volume_ml = 10000,
        price_cents = 100000,
        price_postapoc_cents = 100,
        category = "spare_parts",
        stackable = true,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "copbot_chassis",
        name = ccb.content.plural_text("police bot chassis", "police bot chassis"),
        description = ccb.content.text("What's left when you remove all moving parts and electronics.  It's the skeleton and armor of a police bot."),
        symbol = "c",
        color = "light_gray",
        mass_milligrams = 20000000,
        volume_ml = 40000,
        price_cents = 100000,
        price_postapoc_cents = 100,
        category = "spare_parts",
        stackable = true,
    }
    item:material("steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "android_chassis",
        name = ccb.content.plural_text("android skeleton", "android skeletons"),
        description = ccb.content.text("What's left when you strip an android body from its components."),
        symbol = "c",
        color = "light_gray",
        mass_milligrams = 20000000,
        volume_ml = 40000,
        price_cents = 100000,
        price_postapoc_cents = 100,
        category = "spare_parts",
        stackable = true,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    content.add(item)
end
