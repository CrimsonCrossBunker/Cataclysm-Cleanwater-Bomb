local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "omnicamera_reinforced",
        copy_from = "omnicamera",
        looks_like = "omnicamera",
        name = ccb.content.plural_text("reinforced security camera", "reinforced security cameras"),
        description = ccb.content.text("A security camera with a cage built around it to protect it from damage without reducing its effectiveness."),
        mass_milligrams = 1400000,
        melee_to_hit = -4,
        price_cents = 20000,
        price_postapoc_cents = 1500,
    }
    item:material("lc_steel", 1)
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "reins_tackle",
        name = ccb.content.plural_text("rein and tackle", "reins and tackles"),
        category = "veh_parts",
        description = ccb.content.text("A set of leather bindings to control a mountable creature."),
        mass_milligrams = 500000,
        volume_ml = 1200,
        price_cents = 30000,
        price_postapoc_cents = 1000,
        symbol = "W",
        color = "light_gray",
        looks_like = "rope_6",
    }
    item:material("leather", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "drive_by_wire_controls",
        name = ccb.content.plural_text("drive by wire controls", "sets of drive by wire controls"),
        description = ccb.content.text("A sophisticated set of electronic controls that allow you to control the vehicle from a vehicle remote while you are not in it."),
        mass_milligrams = 3000000,
        color = "red",
        volume_ml = 3750,
        price_cents = 200000,
        price_postapoc_cents = 1500,
        copy_from = "vehicle_controls",
        looks_like = "vehicle_controls",
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "robot_controls",
        name = ccb.content.plural_text("robot driving unit", "robot driving units"),
        description = ccb.content.text("A set of servos, microcontrollers, and other devices, to allow a vehicle to drive itself, or you to drive it remotely using a controller.  Its AI is not functional, but it should still have some sort of maintenance mode."),
        mass_milligrams = 2000000,
        color = "white",
        symbol = "&",
        volume_ml = 5000,
        price_cents = 20000,
        price_postapoc_cents = 1000,
        copy_from = "vehicle_controls",
        looks_like = "vehicle_controls",
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "turret_controls",
        name = ccb.content.plural_text("turret control unit", "turret control units"),
        description = ccb.content.text("A set of motors, cameras, and various electronic modules banded together to allow for tracking targets, friend-or-foe identification, and firing the connected turret in full automatic mode."),
        mass_milligrams = 4000000,
        color = "white",
        symbol = "&",
        volume_ml = 9000,
        price_cents = 500000,
        price_postapoc_cents = 3000,
        copy_from = "vehicle_controls",
        looks_like = "vehicle_controls",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "hand_controls",
        name = ccb.content.plural_text("hand controls", "hand controls"),
        description = ccb.content.text("A pair of adjustable rods with a simple trigger.  They easily can be easily installed on top of vehicle controls and will allow a car or similar vehicle to be driven by those who can't use their legs to do so, whether due to disability or small stature.  These are designed for automobiles and will not work on bicycle style foot pedals."),
        mass_milligrams = 1200000,
        melee_to_hit = 1,
        color = "light_gray",
        symbol = "/",
        volume_ml = 740,
        category = "veh_parts",
        price_cents = 40000,
        price_postapoc_cents = 40,
    }
    item:material("lc_steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    content.add(item)
end

do
    local item = content.Item {
        id = "pedal_extenders",
        name = ccb.content.plural_text("pedal extenders", "pedal extenders"),
        description = ccb.content.text("These thick rubber pads can clamp securely onto a vehicle's gas and brake pedals, allowing even very short people to drive a car."),
        mass_milligrams = 1200000,
        melee_to_hit = -3,
        color = "dark_gray",
        symbol = ",",
        volume_ml = 740,
        category = "veh_parts",
        price_cents = 10000,
        price_postapoc_cents = 40,
    }
    item:material("rubber", 1)
    item:material("lc_steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    content.add(item)
end

do
    local item = content.Item {
        id = "pedal_extenders_makeshift",
        name = ccb.content.plural_text("makeshift pedal extenders", "makeshift pedal extenders"),
        description = ccb.content.text("It is probably not a great idea, but if you wanted to, you could tape these blocks to a vehicle's gas and brake pedals so that a kid or very short adult could drive."),
        mass_milligrams = 388000,
        melee_to_hit = -2,
        color = "brown",
        symbol = ",",
        volume_ml = 656,
        category = "veh_parts",
        price_cents = 2000,
        price_postapoc_cents = 20,
    }
    item:material("wood", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    content.add(item)
end
