local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "light_detector",
        category = "spare_parts",
        name = ccb.content.plural_text("light detector", "light detectors"),
        description = ccb.content.text("A photodiode on a chip, designed to convert incoming light to electrical energy for quantification."),
        mass_milligrams = 5000,
        volume_ml = 20,
        price_cents = 400,
        price_postapoc_cents = 250,
        looks_like = "e_scrap",
        symbol = "#",
        color = "light_gray",
    }
    item:clear_flags()
    item:flag("WATER_BREAK")
    item:flag("ELECTRONIC")
    item:material("plastic", 1)
    item:fault_group("electronic_general", {  })
    content.add(item)
end

do
    -- Volume here is displacement volume of a corked 25mL test tube.
    local item = content.Item {
        id = "glass_tube_small",
        category = "spare_parts",
        name = ccb.content.plural_text("small glass tube", "small glass tubes"),
        description = ccb.content.text("A small glass tube.  Small, tube-shaped, and made of glass."),
        mass_milligrams = 9000,
        volume_ml = 30,
        price_cents = 10,
        price_postapoc_cents = 10,
        symbol = "|",
        color = "white",
        replace_pockets = true,
    }
    item:material("glass", 1)
    item:container_pocket { max_volume_ml = 25, max_weight_milligrams = 100000, rigid = true, watertight = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "barometer",
        category = "tools",
        name = ccb.content.plural_text("barometer", "barometers"),
        description = ccb.content.text("A plastic barometer that can read atmospheric pressure."),
        mass_milligrams = 10000,
        volume_ml = 50,
        price_cents = 100,
        price_postapoc_cents = 10,
        symbol = ";",
        color = "light_gray",
    }
    item:material("plastic", 1)
    item:clear_use_actions()
    item:native_use("WEATHER_TOOL")
    item:clear_flags()
    item:flag("BAROMETER")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "canister_goo",
        name = ccb.content.plural_text("goo canister", "goo canisters"),
        description = ccb.content.text("A metal canister with a label reading: \"Warning: contains highly toxic and corrosive materials.  Contents may be sentient.  Open at your own risk.\" You think you can feel something moving inside it."),
        mass_milligrams = 1596000,
        volume_ml = 270,
        price_cents = 35000,
        price_postapoc_cents = 1000,
        melee_to_hit = -5,
        symbol = ";",
        color = "dark_gray",
    }
    item:material("steel", 1)
    item:clear_use_actions()
    item:native_use("CAN_GOO")
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    item:tool { charges_per_use = 1, initial_charges = 1, max_charges = 1 }
    content.add(item)
end

do
    local item = content.Item {
        id = "chemistry_set_basic",
        category = "tools",
        name = ccb.content.plural_text("basic chemistry set", "basic chemistry sets"),
        description = ccb.content.text("A basic chemistry set including glass containers, hoses, and a pair of safety glasses.  It might be used to craft some chemistry projects if you're so inclined, but you'll need a source of heat."),
        mass_milligrams = 1884000,
        looks_like = "box_medium",
        volume_ml = 2750,
        price_cents = 3200,
        price_postapoc_cents = 500,
        symbol = ";",
        color = "light_gray",
        replace_qualities = true,
    }
    item:material("glass", 1)
    item:material("cotton", 1)
    item:quality("DISTILL", 1)
    item:quality("CHEM", 2)
    item:quality("BOIL", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "engineering_makerspace_kit",
        name = ccb.content.plural_text("makerspace kit for STEM", "makerspace kits for STEM"),
        description = ccb.content.text("A kit with hundreds of pieces and dozens of blueprints for small engineering projects designed for beginner learners.  Explore mechanics and hydraulics!"),
        mass_milligrams = 3200000,
        volume_ml = 1500,
        price_cents = 20000,
        price_postapoc_cents = 100,
        melee_to_hit = -4,
        symbol = "^",
        color = "dark_gray",
        replace_pockets = true,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("WATER_BREAK")
    item:flag("ELECTRONIC")
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    item:fault_group("electronic_general", {  })
    item:magazine_well { rigid = true, flags = { "BATTERY_MEDIUM" }, default_magazine = "medium_battery_cell" }
    item:tool { charges_per_use = 1, ammo_types = { "battery" } }
    content.add(item)
end

do
    local item = content.Item {
        id = "engineering_robotics_kit",
        name = ccb.content.plural_text("robotics kit for young learners", "robotics kits for young learners"),
        description = ccb.content.text("A complete robotics engineering system, for learning the basics of building and programming robots.  Using sensors, motors, a core controller, and hundreds of snap-together building pieces, you can follow the instructions to assemble 12 different robots.  The versatile parts also allow you to make robots according to your own designs."),
        mass_milligrams = 3200000,
        volume_ml = 1500,
        price_cents = 20000,
        price_postapoc_cents = 200,
        melee_to_hit = -4,
        symbol = ":",
        color = "dark_gray",
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("WATER_BREAK")
    item:flag("ELECTRONIC")
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    item:fault_group("electronic_general", {  })
    item:magazine_well { rigid = true, flags = { "BATTERY_MEDIUM" }, default_magazine = "medium_battery_cell" }
    item:tool { charges_per_use = 1, ammo_types = { "battery" } }
    content.add(item)
end

do
    local item = content.Item {
        id = "oil_extractor_crude",
        name = ccb.content.plural_text("makeshift essential oil extractor", "makeshift essential oil extractors"),
        description = ccb.content.text("A makeshift extraction system.  It's pretty much just a 55 gallon drum, a pipe to stir the solution, and a faucet at the bottom to drain the extractor.  Not the most ideal piece of equipment, but it will work."),
        symbol = "E",
        color = "dark_gray",
        looks_like = "55gal_drum",
        mass_milligrams = 22700000,
        volume_ml = 210000,
        price_cents = 10000,
        price_postapoc_cents = 200,
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:quality("EXTRACT", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "filter_paper_qualitative",
        name = ccb.content.plural_text("qualitative filter paper", "qualitative filter paper"),
        description = ccb.content.text("A piece of filter paper for separating solids from liquids.  This filter paper has a rating of 2 microns, separating more solids out than quantitative filter paper, but the process takes longer.  It's intended to be disposable, but you could probably use it for some time before it's unusable."),
        symbol = "E",
        color = "dark_gray",
        looks_like = "paper",
        mass_milligrams = 20000,
        volume_ml = 25,
        price_cents = 100,
        price_postapoc_cents = 100,
        replace_qualities = true,
    }
    item:material("paper", 1)
    item:quality("FILTER", 2)
    item:tool { initial_charges = 200, max_charges = 200 }
    content.add(item)
end

do
    local item = content.Item {
        id = "filter_paper_quantitative",
        copy_from = "filter_paper_qualitative",
        looks_like = "filter_paper_qualitative",
        name = ccb.content.plural_text("quantitative filter paper", "quantitative filter paper"),
        description = ccb.content.text("A piece of filter paper for separating solids from liquids.  This filter paper has a rating of 20 microns, separating less solids out than qualitative filter paper, but the process is much faster.  It's intended to be disposable, but you could probably use it for some time before it's unusable."),
        replace_qualities = true,
    }
    item:quality("FILTER", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "gasket_plastic_set",
        name = ccb.content.plural_text("plastic gasket set", "plastic gasket sets"),
        description = ccb.content.text("A set of three plastic gaskets.  They're intended to be single-use, but you could probably use it for some time before they're too worn out to use."),
        category = "spare_parts",
        symbol = "(",
        color = "dark_gray",
        looks_like = "plastic_chunk",
        mass_milligrams = 15000,
        volume_ml = 90,
        price_cents = 450,
        price_postapoc_cents = 150,
        melee_to_hit = -3,
    }
    item:material("plastic", 1)
    item:tool { initial_charges = 200, max_charges = 200 }
    content.add(item)
end

do
    local item = content.Item {
        id = "recovery_pump",
        name = ccb.content.plural_text("recovery pump", "recovery pumps"),
        description = ccb.content.text("A medium-sized vacuum pump designed to recover solvent (hydrocarbons) from extracted essential oils."),
        category = "tools",
        symbol = "E",
        color = "dark_gray",
        looks_like = "well_pump",
        mass_milligrams = 27240000,
        volume_ml = 8000,
        price_cents = 280000,
        price_postapoc_cents = 200,
        melee_to_hit = -4,
    }
    item:material("steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 10)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "hygrometer",
        category = "tools",
        name = ccb.content.plural_text("hygrometer", "hygrometers"),
        description = ccb.content.text("A plastic hygrometer that can read the relative humidity in the air."),
        mass_milligrams = 10000,
        volume_ml = 50,
        price_cents = 100,
        price_postapoc_cents = 500,
        symbol = ";",
        color = "light_blue",
    }
    item:material("plastic", 1)
    item:clear_use_actions()
    item:native_use("WEATHER_TOOL")
    item:clear_flags()
    item:flag("HYGROMETER")
    item:tool()
    content.add(item)
end

do
    -- NO_I18N
    -- NO_I18N
    local item = content.Item {
        id = "mws_weather_sensor_array",
        name = content.plural_text("ambient weather sensor array", "ambient weather sensor arrays"),
        description = content.text("Represents the hardware and software for displaying the weather.  You should not see this item in game."),
        mass_milligrams = 4000000,
        volume_ml = 80000,
        longest_side_mm = 550,
        price_cents = 40000,
        price_postapoc_cents = 50,
        symbol = "[",
        looks_like = "briefcase",
        color = "yellow",
    }
    item:material("plastic", 1)
    item:material("aluminum", 1)
    item:clear_flags()
    item:flag("THERMOMETER")
    item:flag("HYGROMETER")
    item:flag("BAROMETER")
    item:flag("ELECTRONIC")
    item:clear_use_actions()
    item:native_use("WEATHER_TOOL")
    item:tool { charges_per_use = 1, ammo_types = { "battery" } }
    content.add(item)
end

do
    -- NO_I18N
    -- NO_I18N
    local item = content.Item {
        id = "mws_advanced_weather_sensor_array",
        name = content.plural_text("ambient weather sensor array", "ambient weather sensor arrays"),
        description = content.text("Represents the hardware and software for displaying the weather in a HEW system.  You should not see this item in game."),
        mass_milligrams = 4000000,
        volume_ml = 80000,
        longest_side_mm = 550,
        price_cents = 40000,
        price_postapoc_cents = 50,
        symbol = "[",
        looks_like = "briefcase",
        color = "yellow",
    }
    item:material("plastic", 1)
    item:material("aluminum", 1)
    item:clear_flags()
    item:flag("THERMOMETER")
    item:flag("HYGROMETER")
    item:flag("BAROMETER")
    item:flag("ELECTRONIC")
    item:clear_use_actions()
    item:native_use("WEATHER_TOOL")
    item:tool { charges_per_use = 1, ammo_types = { "battery" } }
    content.add(item)
end

do
    local item = content.Item {
        id = "platinum_grille",
        name = ccb.content.plural_text("platinum grille", "platinum grilles"),
        category = "spare_parts",
        description = ccb.content.text("A metal grille with a layer of platinum plating, suitable for use as a catalyst for some chemical reactions."),
        mass_milligrams = 660000,
        volume_ml = 250,
        price_cents = 3000,
        price_postapoc_cents = 100,
        melee_to_hit = -4,
        symbol = ";",
        color = "light_gray",
        looks_like = "lc_link_sheet",
    }
    item:material("platinum", 1)
    item:clear_flags()
    item:flag("FRAGILE_MELEE")
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "portal",
        name = ccb.content.plural_text("portal generator", "portal generators"),
        description = ccb.content.text("A rare, bizarre, and arcane device of an otherworldly nature.  It's giving you a headache just looking at it.  It is covered in alien markings."),
        mass_milligrams = 1133000,
        volume_ml = 500,
        price_cents = 660000,
        price_postapoc_cents = 1000,
        melee_to_hit = -4,
        symbol = ";",
        color = "magenta",
    }
    item:material("superalloy", 1)
    item:material("plastic", 1)
    item:clear_use_actions()
    item:native_use("PORTAL")
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    item:tool { charges_per_use = 5, initial_charges = 10, max_charges = 10 }
    content.add(item)
end

do
    local item = content.Item {
        id = "teleporter",
        name = ccb.content.plural_text("teleporter", "teleporters"),
        description = ccb.content.text("An experimental device that will teleport you a short distance when activated."),
        mass_milligrams = 1360000,
        volume_ml = 2000,
        price_cents = 600000,
        price_postapoc_cents = 1000,
        melee_to_hit = -4,
        symbol = ";",
        color = "magenta",
    }
    item:material("plastic", 1)
    item:material("aluminum", 1)
    item:clear_use_actions()
    item:native_use("TELEPORT")
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    item:tool { charges_per_use = 1, initial_charges = 20, max_charges = 20 }
    content.add(item)
end

do
    local item = content.Item {
        id = "balance_small",
        category = "tools",
        name = ccb.content.plural_text("small weight scale", "small weight scales"),
        description = ccb.content.text("A simple scale that uses a set of steel weights on sliding bars to measure a sample's mass quite accurately."),
        mass_milligrams = 1000000,
        volume_ml = 2000,
        price_cents = 1600,
        price_postapoc_cents = 100,
        melee_to_hit = -5,
        symbol = ";",
        color = "light_gray",
    }
    item:material("steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "spectrophotometer",
        category = "tools",
        name = ccb.content.plural_text("spectrophotometer", "spectrophotometers"),
        description = ccb.content.text("A ubiquitous analytical chemistry tool that measures the light absorption of a liquid sample in a special tube called a cuvette."),
        mass_milligrams = 5000000,
        volume_ml = 2000,
        price_cents = 8000,
        price_postapoc_cents = 500,
        melee_to_hit = -4,
        symbol = ";",
        color = "light_gray",
        replace_pockets = true,
    }
    item:clear_flags()
    item:flag("WATER_BREAK")
    item:flag("ELECTRONIC")
    item:material("plastic", 1)
    item:material("steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    item:fault_group("electronic_general", {  })
    item:magazine_well { rigid = true, flags = { "BATTERY_MEDIUM" }, default_magazine = "medium_battery_cell" }
    item:tool { ammo_types = { "battery" } }
    content.add(item)
end

do
    local item = content.Item {
        id = "ph_meter",
        category = "tools",
        name = ccb.content.plural_text("pH meter", "pH meters"),
        description = ccb.content.text("A pair of glass probes attached to a voltmeter.  By putting one probe into a calibration solution (conveniently included) and the other in a substance, you can calculate the substance's acidity."),
        mass_milligrams = 3000000,
        volume_ml = 1500,
        price_cents = 6000,
        price_postapoc_cents = 250,
        melee_to_hit = -4,
        symbol = ";",
        color = "light_gray",
        replace_pockets = true,
    }
    item:clear_flags()
    item:flag("WATER_BREAK")
    item:material("plastic", 1)
    item:material("glass", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    item:magazine_well {
        rigid = true,
        flags = { "BATTERY_LIGHT", "BATTERY_ULTRA_LIGHT" },
        default_magazine = "light_battery_cell",
    }
    item:tool { ammo_types = { "battery" } }
    content.add(item)
end

do
    local item = content.Item {
        id = "voltmeter",
        category = "tools",
        name = ccb.content.plural_text("voltmeter", "voltmeters"),
        description = ccb.content.text("A device with two probes that let you measure the electrical potential between two points."),
        mass_milligrams = 500000,
        volume_ml = 1500,
        price_cents = 6000,
        price_postapoc_cents = 250,
        symbol = ";",
        color = "light_gray",
    }
    item:material("plastic", 1)
    item:clear_use_actions()
    item:native_use("VOLTMETER")
    item:clear_flags()
    item:flag("WATER_BREAK")
    item:tool()
    content.add(item)
end

do
    -- Dimensions from a sampling of consumer digital multimeter models online.
    local item = content.Item {
        id = "multimeter",
        category = "tools",
        name = ccb.content.plural_text("multimeter", "multimeters"),
        description = ccb.content.text("A gadget that is a little bigger than a handheld calculator, with a digital display and two pointed probes connected by wires.  It can measure not just voltage, but current in amps, and resistance in ohms, as well as test for electrical continuity."),
        mass_milligrams = 500000,
        volume_ml = 650,
        price_cents = 9000,
        price_postapoc_cents = 250,
        symbol = ";",
        color = "light_gray",
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:clear_use_actions()
    item:native_use("VOLTMETER")
    item:clear_flags()
    item:flag("WATER_BREAK")
    item:flag("ELECTRONIC")
    item:fault_group("electronic_general", {  })
    item:magazine_well {
        rigid = true,
        flags = { "BATTERY_LIGHT", "BATTERY_ULTRA_LIGHT" },
        default_magazine = "light_battery_cell",
    }
    item:tool { charges_per_use = 1, ammo_types = { "battery" } }
    content.add(item)
end

do
    local item = content.Item {
        id = "vortex",
        category = "tools",
        name = ccb.content.plural_text("vortex device", "vortex devices"),
        description = ccb.content.text("A small, hefty, boring-looking machine.  Its weighted trapezoidal frame has a single on-off switch and a speed dial, and on top of it sits a rubber receptacle.  Pressing a test tube into the receptacle would, with power, rapidly shake and mix the contents of the test tube.  It's surprisingly fun to use."),
        mass_milligrams = 3500000,
        volume_ml = 750,
        price_cents = 1000,
        price_postapoc_cents = 500,
        melee_to_hit = -4,
        symbol = "n",
        color = "light_blue",
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "microscope_dissecting",
        category = "tools",
        name = ccb.content.plural_text("dissecting microscope", "dissecting microscopes"),
        description = ccb.content.text("This microscope has less magnification than a standard one.  It's also stereoscopic and produces a neat 3-D image of the surface.  It was typically used for performing dissections and other fine-detail work on small creatures.  It still works pretty well with an added light source, but what would you do with it?"),
        mass_milligrams = 2200000,
        volume_ml = 4000,
        price_cents = 3000,
        price_postapoc_cents = 250,
        melee_to_hit = -4,
        symbol = "G",
        color = "white",
    }
    item:material("steel", 1)
    item:material("glass", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "funnel_separation",
        category = "tools",
        name = ccb.content.plural_text("separation funnel", "separation funnels"),
        description = ccb.content.text("This thing doesn't look much like a funnel.  It's a teardrop-shaped piece of glass with a stopper at the wide end and a valve at the other.  It can be used to wash one liquid with another, like water and an oil, and then draw off whichever of the two liquids contains a higher amount of whatever compound you're trying to isolate.  With a high level of skill, it can also be used to make juvenile farting noises."),
        mass_milligrams = 200000,
        volume_ml = 700,
        price_cents = 100,
        price_postapoc_cents = 100,
        looks_like = "flask_glass",
        symbol = "V",
        color = "light_blue",
        replace_qualities = true,
    }
    item:material("glass", 1)
    item:material("plastic", 1)
    item:quality("SEPARATE", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "still_lab",
        category = "tools",
        name = ccb.content.plural_text("fractional distillation apparatus", "fractional distillation apparatuses"),
        description = ccb.content.text("One of the classic pieces of mad science glassware, this is a small-volume still that passes vapor through a fractional distillation column and then condenses the distillate in a cooled collection column.  A grad student or a robot (is there really any difference?) collects the distillate in fractions so that specific contents can be analyzed.  Going a few milliliters at a time, it would not be very effective to try to distill whiskey in this thing."),
        mass_milligrams = 1000000,
        volume_ml = 5000,
        price_cents = 2000,
        price_postapoc_cents = 750,
        melee_to_hit = -4,
        looks_like = "glass_tube_small",
        symbol = "N",
        color = "light_blue",
        replace_qualities = true,
    }
    item:material("glass", 1)
    item:quality("FINE_DISTILL", 1)
    item:quality("CONCENTRATE", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "gelbox",
        category = "tools",
        name = ccb.content.plural_text("electrophoresis tray", "electrophoresis trays"),
        description = ccb.content.text("A set of plastic trays, electrodes, and a power supply designed to create an electric voltage gradient through a liquid solution containing a solid gel.  Stuff like proteins and DNA would then get separated on the gel according to electrical charge and size.  Pretty useless now for anything but salvage."),
        mass_milligrams = 1000000,
        volume_ml = 5000,
        price_cents = 500,
        price_postapoc_cents = 100,
        melee_to_hit = -2,
        looks_like = "geiger_off",
        symbol = "N",
        color = "light_blue",
    }
    item:material("plastic", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "sextant",
        category = "tools",
        name = ccb.content.plural_text("sextant", "sextants"),
        description = ccb.content.text("A tool for measuring angles of distant objects.  It can be used for measuring the altitude of the sun."),
        mass_milligrams = 500000,
        volume_ml = 500,
        price_cents = 100,
        price_postapoc_cents = 10,
        symbol = ";",
        color = "light_gray",
    }
    item:material("plastic", 1)
    item:clear_use_actions()
    item:native_use("SEXTANT")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "lux_meter",
        category = "tools",
        name = ccb.content.plural_text("lux meter", "lux meters"),
        description = ccb.content.text("A tool for measuring illuminance."),
        mass_milligrams = 100000,
        volume_ml = 300,
        price_cents = 100,
        price_postapoc_cents = 10,
        symbol = ";",
        color = "light_gray",
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:clear_use_actions()
    item:native_use("LUX_METER")
    item:clear_flags()
    item:flag("WATER_BREAK")
    item:flag("ELECTRONIC")
    item:fault_group("electronic_general", {  })
    item:magazine_well {
        rigid = true,
        flags = { "BATTERY_LIGHT", "BATTERY_ULTRA_LIGHT" },
        default_magazine = "light_battery_cell",
    }
    item:tool { charges_per_use = 10, ammo_types = { "battery" } }
    content.add(item)
end

do
    -- this is based on Hair tension hygrometers, https://en.wikipedia.org/wiki/Hygrometer
    local item = content.Item {
        id = "hygroscope",
        category = "tools",
        name = ccb.content.plural_text("hygroscope", "hygroscopes"),
        description = ccb.content.text("A small rectangular box.  Inside is a device that measures humidity by utilizing the hygroscopy of hair.  The hair's length changes with humidity as indicated on a dial."),
        mass_milligrams = 3000000,
        volume_ml = 2000,
        longest_side_mm = 400,
        price_cents = 100,
        price_postapoc_cents = 300,
        melee_to_hit = -4,
        symbol = ";",
        color = "light_red",
    }
    item:material("wood", 1)
    item:material("steel", 1)
    item:clear_use_actions()
    item:native_use("WEATHER_TOOL")
    item:clear_flags()
    item:flag("HYGROMETER")
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "glass_thermometer",
        category = "tools",
        name = ccb.content.plural_text("glass thermometer", "glass thermometers"),
        description = ccb.content.text("A device used to measure temperature.  This one is made entirely of glass.  Mercury is used as its temperature sensor.  You could use this to get accurate information on current air temperature."),
        mass_milligrams = 600000,
        volume_ml = 700,
        longest_side_mm = 150,
        price_cents = 100,
        price_postapoc_cents = 200,
        symbol = ";",
        color = "light_red",
    }
    item:material("glass", 1)
    item:clear_use_actions()
    item:native_use("WEATHER_TOOL")
    item:clear_flags()
    item:flag("THERMOMETER")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "engineering_engine_kit",
        name = ccb.content.plural_text("Stirling engine kit", "Stirling engine kits"),
        description = ccb.content.text("A Stirling engine kit that demonstrates the principles behind the generation of electricity through the use of hot air."),
        mass_milligrams = 3200000,
        volume_ml = 1500,
        price_cents = 20000,
        price_postapoc_cents = 50,
        melee_to_hit = -4,
        symbol = "^",
        color = "light_green",
        replace_pockets = true,
    }
    item:material("steel", 1)
    item:material("glass", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    item:tool { charges_per_use = 1, ammo_types = { "conc_alcohol" } }
    item:magazine_pocket { ammo_capacities = { conc_alcohol = 750 }, watertight = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "hydrogen_tank",
        name = ccb.content.plural_text("hydrogen tank", "hydrogen tanks"),
        description = ccb.content.text("A tank of compressed hydrogen gas.  If you need to make water from scratch, or lift a Zeppelin, it could come in handy."),
        category = "other",
        mass_milligrams = 2268000,
        volume_ml = 1500,
        price_cents = 1000,
        price_postapoc_cents = 500,
        melee_to_hit = -4,
        symbol = ";",
        color = "light_gray",
        looks_like = "oxygen_tank",
        replace_pockets = true,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("NO_UNLOAD")
    item:flag("NO_RELOAD")
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    item:tool { charges_per_use = 1 }
    item:magazine_pocket { ammo_capacities = { hydrogen = 24 }, rigid = true, airtight = true, watertight = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "nitrogen_tank",
        name = ccb.content.plural_text("nitrogen tank", "nitrogen tanks"),
        description = ccb.content.text("A tank of compressed nitrogen gas.  Nitrogen is useful for its lack of reactivity.  Don't try to breathe it."),
        category = "other",
        mass_milligrams = 2268000,
        volume_ml = 1500,
        price_cents = 1000,
        price_postapoc_cents = 250,
        melee_to_hit = -4,
        symbol = ";",
        color = "light_gray",
        looks_like = "oxygen_tank",
        replace_pockets = true,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("NO_UNLOAD")
    item:flag("NO_RELOAD")
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    item:tool { charges_per_use = 1 }
    item:magazine_pocket { ammo_capacities = { nitrogen = 24 }, rigid = true, airtight = true, watertight = true }
    content.add(item)
end
