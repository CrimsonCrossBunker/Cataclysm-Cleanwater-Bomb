local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "wheel_mount_wood",
        category = "veh_parts",
        name = ccb.content.plural_text("wooden wheel mount", "wooden wheel mounts"),
        description = ccb.content.text("A piece of wood with holes suitable for a bike wheel."),
        mass_milligrams = 100000,
        volume_ml = 250,
        longest_side_mm = 77,
        price_cents = 5,
        price_postapoc_cents = 10,
        symbol = ";",
        color = "brown",
    }
    item:material("wood", 1)
    content.add(item)
end

do
    -- Wheel axles are commonly made out of 1040 steel (which is a medium steel) or similar: see https://www.iforgeiron.com/topic/4526-axles-what-metal/ and https://www.randysworldwide.com/blogs/common-steel-groups-for-axles-2
    local item = content.Item {
        id = "wheel_mount_light",
        category = "veh_parts",
        name = ccb.content.plural_text("light wheel mount", "light wheel mounts"),
        description = ccb.content.text("A piece of metal with holes suitable for a bike or motorbike wheel."),
        mass_milligrams = 150000,
        volume_ml = 250,
        longest_side_mm = 102,
        price_cents = 10,
        price_postapoc_cents = 10,
        symbol = ";",
        color = "dark_gray",
    }
    item:material("mc_steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "wheel_mount_medium",
        category = "veh_parts",
        name = ccb.content.plural_text("medium wheel hub assembly", "medium wheel hub assemblies"),
        description = ccb.content.text("A metal assembly that allows bolting a wheel onto a car.  Fit for a car wheel."),
        mass_milligrams = 5000000,
        volume_ml = 6000,
        longest_side_mm = 204,
        price_cents = 3000,
        price_postapoc_cents = 500,
        symbol = ";",
        color = "dark_gray",
    }
    item:material("mc_steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 14)
    content.add(item)
end

do
    local item = content.Item {
        id = "wheel_mount_heavy",
        category = "veh_parts",
        name = ccb.content.plural_text("heavy wheel hub assembly", "heavy wheel hub assemblies"),
        description = ccb.content.text("A heavy metal assembly that allows bolting a wheel onto a car.  Fit for a large car wheel."),
        mass_milligrams = 6000000,
        volume_ml = 7000,
        longest_side_mm = 254,
        price_cents = 5000,
        price_postapoc_cents = 500,
        symbol = ";",
        color = "dark_gray",
    }
    item:material("mc_steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 14)
    content.add(item)
end

do
    local item = content.Item {
        id = "wheel_mount_skateboard",
        category = "veh_parts",
        name = ccb.content.plural_text("skateboard trucks (pair)", "skateboard trucks (pair)"),
        description = ccb.content.text("A pair metal skateboard trucks, for attaching wheels to."),
        mass_milligrams = 600000,
        volume_ml = 250,
        longest_side_mm = 200,
        price_cents = 200,
        price_postapoc_cents = 20,
        symbol = "]",
        color = "dark_gray",
    }
    item:material("lc_steel", 1)
    item:material("aluminum", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    content.add(item)
end

do
    -- Steel grade is a guess: I couldn't find anything, so I chose the same material as wheel axles
    local item = content.Item {
        id = "wheel_rim_medium",
        category = "veh_parts",
        name = ccb.content.plural_text("medium steel rim", "medium steel rims"),
        description = ccb.content.text("A medium-size steel rim for a car tire."),
        mass_milligrams = 5245000,
        volume_ml = 28000,
        melee_to_hit = -3,
        longest_side_mm = 432,
        price_cents = 5000,
        price_postapoc_cents = 500,
        symbol = "]",
        color = "dark_gray",
    }
    item:material("mc_steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    content.add(item)
end

do
    local item = content.Item {
        id = "wheel_rim_motorbike",
        category = "veh_parts",
        name = ccb.content.plural_text("steel motorbike rim", "steel motorbike rims"),
        description = ccb.content.text("A steel rim for a motorbike tire."),
        mass_milligrams = 3000000,
        volume_ml = 12000,
        melee_to_hit = -3,
        longest_side_mm = 508,
        price_cents = 5000,
        price_postapoc_cents = 500,
        symbol = "]",
        color = "dark_gray",
    }
    item:material("mc_steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    content.add(item)
end

do
    local item = content.Item {
        id = "wheel_rim_wide",
        category = "veh_parts",
        name = ccb.content.plural_text("wide steel rim", "wide steel rims"),
        description = ccb.content.text("A wide steel rim for a larger tire."),
        mass_milligrams = 7600000,
        volume_ml = 70000,
        melee_to_hit = -3,
        longest_side_mm = 610,
        price_cents = 5000,
        price_postapoc_cents = 500,
        symbol = "]",
        color = "dark_gray",
    }
    item:material("mc_steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 10)
    content.add(item)
end

do
    local item = content.Item {
        id = "wheel_rim_bicycle",
        category = "veh_parts",
        name = ccb.content.plural_text("bicycle rim", "bicycle rims"),
        description = ccb.content.text("A large, spoked rim for a bicycle tire."),
        mass_milligrams = 750000,
        volume_ml = 11000,
        longest_side_mm = 686,
        price_cents = 5000,
        price_postapoc_cents = 500,
        symbol = "]",
        color = "dark_gray",
    }
    item:material("aluminum", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    content.add(item)
end

do
    local item = content.Item {
        id = "tire_medium",
        category = "veh_parts",
        looks_like = "wheel",
        name = ccb.content.plural_text("17\" car tire", "17\" car tires"),
        description = ccb.content.text("A standard 17\" car tire for fitting to a medium steel rim."),
        mass_milligrams = 3600000,
        volume_ml = 10000,
        longest_side_mm = 432,
        price_cents = 5000,
        price_postapoc_cents = 500,
        symbol = "]",
        color = "dark_gray",
    }
    item:material("rubber", 1)
    item:clear_flags()
    item:flag("NONCONDUCTIVE")
    content.add(item)
end

do
    local item = content.Item {
        id = "tire_medium_slick",
        category = "veh_parts",
        looks_like = "wheel_slick",
        name = ccb.content.plural_text("16\" racing tire", "16\" racing tires"),
        description = ccb.content.text("A slick 16\" racing car tire for fitting to a medium steel rim."),
        mass_milligrams = 7355000,
        volume_ml = 13750,
        longest_side_mm = 407,
        price_cents = 20000,
        price_postapoc_cents = 500,
        symbol = "]",
        color = "dark_gray",
    }
    item:material("rubber", 1)
    item:clear_flags()
    item:flag("NONCONDUCTIVE")
    content.add(item)
end

do
    local item = content.Item {
        id = "tire_motorbike",
        category = "veh_parts",
        looks_like = "wheel_motorbike",
        name = ccb.content.plural_text("16\" motorbike tire", "16\" motorbike tires"),
        description = ccb.content.text("A 16\" motorbike tire for fitting to a steel motorbike rim."),
        mass_milligrams = 2443000,
        volume_ml = 8250,
        longest_side_mm = 407,
        price_cents = 10000,
        price_postapoc_cents = 300,
        symbol = "]",
        color = "dark_gray",
    }
    item:material("rubber", 1)
    item:clear_flags()
    item:flag("NONCONDUCTIVE")
    content.add(item)
end

do
    local item = content.Item {
        id = "tire_motorbike_or",
        copy_from = "tire_motorbike",
        looks_like = "tire_motorbike",
        name = ccb.content.plural_text("20\" off-road motorbike tire", "20\" off-road motorbike tires"),
        description = ccb.content.text("A 20\" off-road motorbike tire for fitting to a steel motorbike rim."),
        longest_side_mm = 508,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "tire_wide",
        category = "veh_parts",
        looks_like = "wheel_wide",
        name = ccb.content.plural_text("24\" wide tire", "24\" wide tires"),
        description = ccb.content.text("A wide tire for fitting to a wide steel rim."),
        mass_milligrams = 15000000,
        volume_ml = 17500,
        longest_side_mm = 610,
        price_cents = 27000,
        price_postapoc_cents = 550,
        symbol = "]",
        color = "dark_gray",
    }
    item:material("rubber", 1)
    item:clear_flags()
    item:flag("NONCONDUCTIVE")
    content.add(item)
end

do
    local item = content.Item {
        id = "tire_wide_or",
        copy_from = "tire_wide",
        looks_like = "tire_wide",
        name = ccb.content.plural_text("24\" off-road wide tire", "24\" off-road wide tires"),
        description = ccb.content.text("A wide tire for fitting to a wide steel rim.  It's studded to provide better grip off-road at the cost of some performance on pavement."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "tire_bicycle",
        category = "veh_parts",
        looks_like = "wheel_bicycle",
        name = ccb.content.plural_text("27\" bicycle tire", "27\" bicycle tires"),
        description = ccb.content.text("A bicycle tire for fitting to a bicycle rim."),
        mass_milligrams = 750000,
        volume_ml = 2000,
        longest_side_mm = 686,
        price_cents = 2000,
        price_postapoc_cents = 125,
        symbol = "]",
        color = "dark_gray",
    }
    item:material("rubber", 1)
    item:clear_flags()
    item:flag("NONCONDUCTIVE")
    content.add(item)
end

do
    local item = content.Item {
        id = "tire_bicycle_or",
        copy_from = "tire_bicycle",
        looks_like = "tire_bicycle",
        name = ccb.content.plural_text("27\" off-road bicycle tire", "27\" off-road bicycle tires"),
        description = ccb.content.text("A wide, studded bicycle tire intended to be fitted to a bicycle rim for off-road biking."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "deflated_wheel",
        category = "veh_parts",
        looks_like = "wheel",
        name = ccb.content.plural_text("deflated 17\" wheel", "deflated 17\" wheels"),
        description = ccb.content.text("A car wheel.  It is currently deflated and will need to be inflated to be used on a vehicle."),
        mass_milligrams = 8845000,
        volume_ml = 28000,
        longest_side_mm = 432,
        price_cents = 10000,
        price_postapoc_cents = 750,
        melee_to_hit = -3,
        symbol = "]",
        color = "dark_gray",
    }
    item:material("mc_steel", 1)
    item:material("rubber", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 12)
    content.add(item)
end

do
    local item = content.Item {
        id = "deflated_wheel_slick",
        category = "veh_parts",
        looks_like = "wheel_slick",
        name = ccb.content.plural_text("deflated 16\" racing wheel", "deflated 16\" racing wheels"),
        description = ccb.content.text("A wide, smooth wheel intended for racing.  It is currently deflated and will need to be inflated to be used on a vehicle."),
        mass_milligrams = 12600000,
        volume_ml = 28000,
        longest_side_mm = 407,
        price_cents = 24000,
        price_postapoc_cents = 500,
        melee_to_hit = -3,
        symbol = "]",
        color = "dark_gray",
    }
    item:material("mc_steel", 1)
    item:material("rubber", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 14)
    content.add(item)
end

do
    local item = content.Item {
        id = "deflated_wheel_motorbike",
        category = "veh_parts",
        name = ccb.content.plural_text("deflated 16\" motorbike wheel", "deflated 16\" motorbike wheels"),
        description = ccb.content.text("A motorbike wheel.  It is currently deflated and will need to be inflated to be used on a vehicle."),
        mass_milligrams = 5443000,
        volume_ml = 12000,
        longest_side_mm = 407,
        price_cents = 14000,
        price_postapoc_cents = 500,
        melee_to_hit = -3,
        symbol = "]",
        color = "dark_gray",
    }
    item:material("mc_steel", 1)
    item:material("rubber", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    content.add(item)
end

do
    local item = content.Item {
        id = "deflated_wheel_motorbike_or",
        copy_from = "deflated_wheel_motorbike",
        looks_like = "deflated_wheel_motorbike",
        name = ccb.content.plural_text("deflated 20\" off-road motorbike wheel", "deflated 20\" off-road motorbike wheels"),
        longest_side_mm = 508,
        description = ccb.content.text("A motorbike wheel, studded for improved off-road performance.  It is currently deflated and will need to be inflated to be used on a vehicle."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "deflated_wheel_wide",
        category = "veh_parts",
        name = ccb.content.plural_text("deflated 24\" wide wheel", "deflated 24\" wide wheels"),
        description = ccb.content.text("A wide wheel.  \\o/ This wide.  It is currently deflated and will need to be inflated to be used on a vehicle."),
        mass_milligrams = 22600000,
        volume_ml = 70000,
        longest_side_mm = 610,
        price_cents = 34000,
        price_postapoc_cents = 750,
        melee_to_hit = -3,
        symbol = "]",
        color = "dark_gray",
    }
    item:material("mc_steel", 1)
    item:material("rubber", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 17)
    content.add(item)
end

do
    local item = content.Item {
        id = "deflated_wheel_wide_or",
        copy_from = "deflated_wheel_wide",
        looks_like = "deflated_wheel_wide",
        name = ccb.content.plural_text("deflated 24\" off-road wide wheel", "deflated 24\" off-road wide wheels"),
        description = ccb.content.text("A wide wheel.  \\o/ This wide.  It's studded to provide better grip off-road at the cost of some performance on pavement.  It is currently deflated and will need to be inflated to be used on a vehicle."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "deflated_wheel_bicycle",
        category = "veh_parts",
        name = ccb.content.plural_text("deflated 27\" bicycle wheel", "deflated 27\" bicycle wheels"),
        description = ccb.content.text("A bicycle wheel.  It is currently deflated and will need to be inflated to be used on a vehicle."),
        mass_milligrams = 1500000,
        volume_ml = 11000,
        longest_side_mm = 686,
        price_cents = 4000,
        price_postapoc_cents = 250,
        melee_to_hit = -3,
        symbol = "]",
        color = "dark_gray",
    }
    item:material("aluminum", 1)
    item:material("rubber", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    content.add(item)
end

do
    local item = content.Item {
        id = "deflated_wheel_bicycle_or",
        copy_from = "deflated_wheel_bicycle",
        looks_like = "deflated_wheel_bicycle",
        name = ccb.content.plural_text("deflated 27\" off-road bicycle wheel", "deflated 27\" off-road bicycle wheels"),
        description = ccb.content.text("A wide, studded, bicycle wheel intended for off-road biking.  It is currently deflated and will need to be inflated to be used on a vehicle."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "wheel_mount_concrete_mix",
        name = ccb.content.plural_text("concrete mixer wheel mounts", "concrete mixer wheel mounts"),
        description = ccb.content.text("A set of two small wheel mounts from a concrete mixer."),
        copy_from = "wheel_mount_light",
        looks_like = "wheel_mount_light",
        mass_milligrams = 300000,
        volume_ml = 500,
    }
    content.add(item)
end
