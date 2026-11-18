local ccb = require("ccb")
local content = ccb.content

do
    -- NO_I18N
    -- NO_I18N
    local item = content.Item {
        id = "spare_part",
        abstract = true,
        category = "spare_parts",
        name = content.plural_text("spare parts", "spare parts"),
        description = content.text("Items which are not themselves useful but are instead requirements for crafting or repairs"),
        symbol = ";",
        color = "dark_gray",
        stackable = true,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "drivebelt",
        copy_from = "spare_part",
        name = ccb.content.plural_text("drive belt", "drive belts"),
        description = ccb.content.text("A synthetic rubber V-belt with steel reinforcement fibers.  Commonly fitted to engines or other industrial equipment."),
        mass_milligrams = 850000,
        volume_ml = 500,
        price_cents = 1200,
        price_postapoc_cents = 500,
    }
    item:material("rubber", 1)
    item:material("steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "drivebelt_makeshift",
        copy_from = "spare_part",
        name = ccb.content.plural_text("makeshift drive belt", "makeshift drive belts"),
        description = ccb.content.text("An improvised belt useful for repairing engines or other industrial equipment when no better alternative is available."),
        mass_milligrams = 1250000,
        volume_ml = 750,
        price_cents = 200,
        price_postapoc_cents = 50,
    }
    item:material("cotton", 1)
    item:material("leather", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "five-point_harness",
        copy_from = "spare_part",
        name = ccb.content.plural_text("5-point harness", "5-point harnesses"),
        description = ccb.content.text("A harness made of five belts meant to be mounted on vehicle to fasten a passenger securely to their seat."),
        mass_milligrams = 2204000,
        volume_ml = 750,
        price_cents = 10000,
        price_postapoc_cents = 5000,
    }
    item:material("nylon", 1)
    item:material("steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "filter_air",
        copy_from = "spare_part",
        name = ccb.content.plural_text("air filter", "air filters"),
        description = ccb.content.text("A plastic box containing creped paper used to filter the air supply for combustion engines or other industrial equipment."),
        mass_milligrams = 360000,
        volume_ml = 500,
        price_cents = 1900,
        price_postapoc_cents = 200,
    }
    item:material("plastic", 1)
    item:material("paper", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "filter_air_makeshift",
        copy_from = "spare_part",
        name = ccb.content.plural_text("makeshift air filter", "makeshift air filters"),
        description = ccb.content.text("An improvised air filter useful for repairing engines or other industrial equipment when no better alternative is available."),
        mass_milligrams = 480000,
        volume_ml = 750,
        price_cents = 200,
        price_postapoc_cents = 50,
    }
    item:material("plastic", 1)
    item:material("paper", 1)
    content.add(item)
end

do
    -- wix 51333
    local item = content.Item {
        id = "filter_liquid",
        copy_from = "spare_part",
        name = ccb.content.plural_text("automotive filter", "automotive filters"),
        description = ccb.content.text("A steel can containing filter paper designed for automotive use."),
        mass_milligrams = 644000,
        volume_ml = 1225,
        price_cents = 1900,
        price_postapoc_cents = 250,
    }
    item:material("steel", 1)
    item:material("paper", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "filter_liquid_makeshift",
        copy_from = "spare_part",
        name = ccb.content.plural_text("makeshift automotive filter", "makeshift automotive filters"),
        description = ccb.content.text("An improvised automotive filter useful for repairing engines or other industrial equipment when no better alternative is available."),
        mass_milligrams = 690000,
        volume_ml = 750,
        price_cents = 200,
        price_postapoc_cents = 50,
    }
    item:material("steel", 1)
    item:material("paper", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "glowplug",
        copy_from = "spare_part",
        name = ccb.content.plural_text("glow plug", "glow plugs"),
        description = ccb.content.text("A cylindrical heating device designed to be screwed in to a diesel engine to aid starting in cold weather."),
        mass_milligrams = 260000,
        volume_ml = 250,
        price_cents = 2300,
        price_postapoc_cents = 500,
    }
    item:material("plastic", 1)
    item:material("copper", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "pump_complex",
        copy_from = "spare_part",
        name = ccb.content.plural_text("high-pressure pump", "high-pressure pumps"),
        description = ccb.content.text("A complex mechanical pump capable of achieving high pressures.  Far beyond anything you could reasonably improvise."),
        mass_milligrams = 2800000,
        volume_ml = 1250,
        price_cents = 28900,
        price_postapoc_cents = 750,
    }
    item:material("iron", 1)
    item:clear_flags()
    item:flag("IRREPLACEABLE_CONSUMABLE")
    content.add(item)
end

do
    local item = content.Item {
        id = "well_pump",
        copy_from = "spare_part",
        name = ccb.content.plural_text("mechanical pump", "mechanical pumps"),
        description = ccb.content.text("A simple cast iron mechanical impeller pump.  It's not good for much of anything on its own."),
        mass_milligrams = 2400000,
        volume_ml = 1000,
        price_cents = 1800,
        price_postapoc_cents = 500,
    }
    item:material("iron", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "compressor",
        copy_from = "spare_part",
        name = ccb.content.plural_text("compressor", "compressors"),
        description = ccb.content.text("An electrically-powered device which compresses gas to increase pressure.  Used in fridges, air conditioners and many other appliances."),
        mass_milligrams = 7000000,
        volume_ml = 3000,
        melee_to_hit = -4,
        price_cents = 10000,
        price_postapoc_cents = 2000,
    }
    item:material("steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    content.add(item)
end

do
    local item = content.Item {
        id = "nitrogen_membrane_filter",
        copy_from = "spare_part",
        name = ccb.content.plural_text("nitrogen membrane filter", "nitrogen membrane filters"),
        description = ccb.content.text("A straight pipe with high-tech membrane filter inside it, designed to separate nitrogen from compressed air that is pumped through it."),
        mass_milligrams = 2000000,
        volume_ml = 500,
        longest_side_mm = 600,
        price_cents = 40000,
        price_postapoc_cents = 2000,
    }
    item:material("steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 12)
    content.add(item)
end

do
    local item = content.Item {
        id = "magnet",
        category = "spare_parts",
        name = ccb.content.plural_text("magnet", "magnets"),
        description = ccb.content.text("A small but strong permanent magnet made from alnico alloy, which produces a magnetic field that attracts ferromagnetic materials such as steel.  Useful for crafting."),
        mass_milligrams = 180000,
        volume_ml = 25,
        price_cents = 500,
        price_postapoc_cents = 10,
        symbol = ",",
        color = "light_gray",
        stackable = true,
    }
    item:material("iron", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "hd_pipe",
        copy_from = "spare_part",
        name = ccb.content.plural_text("heavy duty pipe", "heavy duty pipes"),
        description = ccb.content.text("A section of steel pipe with very thick walls built to contain very high pressure, probably intended to be a part of industrial equipment."),
        mass_milligrams = 4000000,
        volume_ml = 500,
        price_cents = 5000,
        price_postapoc_cents = 2000,
    }
    item:material("steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 16)
    content.add(item)
end

do
    local item = content.Item {
        id = "hd_pipe_fittings",
        copy_from = "spare_part",
        name = ccb.content.plural_text("set of heavy duty pipe fittings", "sets of heavy duty pipe fittings"),
        description = ccb.content.text("A loose assortment of very thick-walled steel pipe fittings - end caps, pipe junctions, and similar items.  Probably intended to be a part of industrial equipment."),
        mass_milligrams = 2000000,
        volume_ml = 1500,
        price_cents = 5000,
        price_postapoc_cents = 2000,
    }
    item:material("steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "hd_valve",
        copy_from = "spare_part",
        name = ccb.content.plural_text("heavy duty valve", "heavy duty valves"),
        description = ccb.content.text("A short section of thick-walled pipe with a valve integrated into it, allowing an operator to regulate the flow of gas or liquid through it."),
        mass_milligrams = 5000000,
        volume_ml = 2000,
        price_cents = 10000,
        price_postapoc_cents = 2000,
    }
    item:material("steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "pressure_gauge",
        copy_from = "spare_part",
        name = ccb.content.plural_text("pressure gauge", "pressure gauges"),
        description = ccb.content.text("A short section of thick-walled pipe with a device which shows the internal pressure built into it."),
        mass_milligrams = 2000000,
        volume_ml = 1000,
        price_cents = 10000,
        price_postapoc_cents = 2000,
    }
    item:material("steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "pyrometer",
        copy_from = "spare_part",
        name = ccb.content.plural_text("pyrometer", "pyrometers"),
        description = ccb.content.text("A small electronic device used for measuring high temperatures."),
        mass_milligrams = 500000,
        volume_ml = 250,
        price_cents = 10000,
        price_postapoc_cents = 2000,
    }
    item:material("steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "hd_compressor",
        copy_from = "spare_part",
        name = ccb.content.plural_text("industrial compressor", "industrial compressors"),
        description = ccb.content.text("A bulky and very powerful compressor which can produce very high pressure if fitted to a pipe.  Much more powerful than whatever you'd find in common household appliances."),
        mass_milligrams = 30000000,
        volume_ml = 6000,
        price_cents = 60000,
        price_postapoc_cents = 2000,
    }
    item:material("steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "large_pressure_vessel",
        copy_from = "spare_part",
        name = ccb.content.plural_text("large pressure vessel", "large pressure vessels"),
        description = ccb.content.text("An enormously bulky and heavy steel vessel with thick walls.  Likely meant to be a reaction chamber for industrial processes requiring high pressure."),
        mass_milligrams = 300000000,
        volume_ml = 200000,
        longest_side_mm = 3000,
        price_cents = 200000,
        price_postapoc_cents = 2000,
    }
    item:material("steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "small_pressure_vessel",
        copy_from = "spare_part",
        name = ccb.content.plural_text("small pressure vessel", "small pressure vessels"),
        description = ccb.content.text("A rather small steel vessel with thick walls designed to contain high pressure.  Quite heavy for its size."),
        mass_milligrams = 30000000,
        volume_ml = 10000,
        longest_side_mm = 400,
        price_cents = 200000,
        price_postapoc_cents = 2000,
    }
    item:material("steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "pipe_fittings",
        copy_from = "spare_part",
        name = ccb.content.plural_text("set of pipe fittings", "sets of pipe fittings"),
        description = ccb.content.text("A loose assortment of metal pipe fittings - end caps, pipe junctions, and similar items.  They can be used in a variety of projects."),
        mass_milligrams = 500000,
        volume_ml = 1000,
        price_cents = 1800,
        price_postapoc_cents = 25,
    }
    item:material("iron", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "simple_crank",
        copy_from = "spare_part",
        name = ccb.content.plural_text("simple crank mechanism", "simple crank mechanisms"),
        description = ccb.content.text("A simple cranking mechanism, consisting of a bent metal arm attached at a right angle to a rotating shaft.  It can be used to convert circular motion into reciprocating motion, or vice versa, by means of muscle power."),
        mass_milligrams = 750000,
        volume_ml = 1000,
        price_cents = 2400,
        price_postapoc_cents = 700,
    }
    item:material("iron", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "tire_repair_kit",
        copy_from = "spare_part",
        name = ccb.content.plural_text("tire repair kit", "tire repair kits"),
        description = ccb.content.text("A set of tools: cords/patches with strong glue, and some soapy water for locating puncture, all designed to save your punctured tire and make it back on track.  It supposed to last only for a day or two, and change of the tire is strongly advised by the manufacturer."),
        mass_milligrams = 270000,
        volume_ml = 300,
        price_cents = 2300,
        price_postapoc_cents = 500,
    }
    item:material("plastic", 1)
    content.add(item)
end
