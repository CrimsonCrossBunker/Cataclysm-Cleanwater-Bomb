local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "resin_chunk",
        category = "spare_parts",
        name = ccb.content.plural_text("alien resin chunk", "alien resin chunks"),
        description = ccb.content.text("A shattered fragment of alien resin.  It looks a bit like a large piece of sea glass, frosted and gritty with the edges rounded off.  It is somewhat warm to the touch."),
        mass_milligrams = 70000,
        volume_ml = 22,
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = ",",
        color = "light_gray",
        stackable = true,
    }
    item:material("alien_resin", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    content.add(item)
end

do
    local item = content.Item {
        id = "alien_fern",
        symbol = "y",
        color = "red_green",
        name = ccb.content.plural_text("alien fern branch", "alien fern branches"),
        description = ccb.content.text("A branching trunk of leaves from a massive fern, about two feet long and a couple of feet across in diameter when including the leaves.  Maybe one day you'll think of something to make with a giant fern."),
        mass_milligrams = 80000,
        volume_ml = 5000,
        longest_side_mm = 2600,
        looks_like = "stick",
        category = "spare_parts",
        stackable = true,
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("FIREWOOD")
    content.add(item)
end

do
    local item = content.Item {
        id = "exodii_chassis",
        name = ccb.content.plural_text("Exodii chassis", "Exodii chassis"),
        description = ccb.content.text("This roughly hexagonal frame and associated bodywork looks like it was constructed as a single piece.  The fitting holes and attachments are extremely durable, despite showing signs of heavy wear and repair.  The structure is versatile, and could probably be engineered to serve a number of different heavy combat roles."),
        symbol = "c",
        color = "light_gray",
        mass_milligrams = 500000000,
        volume_ml = 700000,
        price_cents = 1000000,
        category = "spare_parts",
        stackable = true,
    }
    item:material("qt_steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "exodii_drone_chassis",
        name = ccb.content.plural_text("Exodii drone chassis", "Exodii drone chassis"),
        description = ccb.content.text("This small, roughly hexagonal frame and associated bodywork looks like it was constructed as a single piece.  The fitting holes and attachments are extremely durable, despite showing signs of heavy wear and repair.  The structure is versatile, and could probably be engineered to serve a number of different heavy combat roles."),
        symbol = "c",
        color = "light_gray",
        mass_milligrams = 40000000,
        volume_ml = 150000,
        price_cents = 100000,
        category = "spare_parts",
        stackable = true,
    }
    item:material("qt_steel", 1)
    item:material("aluminum", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "cyborg_matrix",
        name = ccb.content.plural_text("cybernetic neural matrix", "cybernetic neural matrices"),
        description = ccb.content.text("A series of tanks and tubes with ports for fluids, electricity, and input and output, this complex arrangement is made to house a brain and spine, and the most difficult to replace organs for keeping them alive."),
        symbol = "m",
        color = "light_blue",
        mass_milligrams = 20000000,
        volume_ml = 10000,
        price_cents = 10000,
        category = "spare_parts",
        stackable = true,
    }
    item:material("plastic", 1)
    item:material("aluminum", 1)
    item:material("qt_steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "exodii_computer",
        name = ccb.content.plural_text("unfamiliar electronic thingy", "unfamiliar electronic thingies"),
        description = ccb.content.text("The wiring and general shape suggest to you that this is a computer, or at least some sort of electronic device, but what it is and what role it serves is lost on you.  It's heavy and sturdy in construction."),
        symbol = "p",
        color = "dark_gray",
        mass_milligrams = 10000000,
        volume_ml = 10000,
        price_cents = 10000,
        category = "spare_parts",
        stackable = true,
    }
    item:material("plastic", 1)
    item:material("qt_steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "exodii_module",
        name = ccb.content.plural_text("inscribed metal plates", "inscribed metal plates"),
        description = ccb.content.text("This device looks electronic, but is unfamiliar.  It is a series of tightly fitted coppery-looking rings, set concentrically.  Wires run from each ring to an axis in the middle."),
        symbol = "i",
        color = "dark_gray",
        mass_milligrams = 1000000,
        volume_ml = 1000,
        price_cents = 1000,
        category = "spare_parts",
        stackable = true,
    }
    item:material("copper", 1)
    item:material("qt_steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "exodii_micro_computer",
        name = ccb.content.plural_text("small unfamiliar electronic thingy", "small unfamiliar electronic thingies"),
        description = ccb.content.text("The wiring and general shape suggest to you that this is a tiny computer, or at least some sort of electronic device, but what it is and what role it serves is lost on you.  It's small enough to fit into your palm."),
        symbol = "p",
        color = "dark_gray",
        mass_milligrams = 100000,
        volume_ml = 250,
        price_cents = 10000,
        category = "spare_parts",
        stackable = true,
    }
    item:material("plastic", 1)
    item:material("qt_steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "exodii_micro_module",
        name = ccb.content.plural_text("inscribed metal rings", "inscribed metal rings"),
        description = ccb.content.text("This device looks electronic, but is unfamiliar.  It is a series of tightly fitted coppery-looking nuts, set concentrically.  Wires run from each nut to an axis in the middle."),
        symbol = "i",
        color = "dark_gray",
        mass_milligrams = 50000,
        volume_ml = 100,
        price_cents = 1000,
        category = "spare_parts",
        stackable = true,
    }
    item:material("copper", 1)
    item:material("qt_steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "exodii_sensor",
        name = ccb.content.plural_text("cybernetic sensor", "cybernetic sensors"),
        description = ccb.content.text("From the large glassy eye - the size of a small dinner plate - in the front, you deduce this is some sort of camera.  None of the inner workings make any sense to you nor resemble any camera you've seen before."),
        symbol = ")",
        color = "blue",
        mass_milligrams = 5000000,
        volume_ml = 3000,
        price_cents = 20000,
        category = "spare_parts",
        stackable = true,
    }
    item:material("qt_steel", 1)
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "exodii_motor",
        name = ccb.content.plural_text("rotary device", "rotary devices"),
        description = ccb.content.text("You assume from the coils of coppery wire and the protruding piston that this is some sort of motor or generator, but the design doesn't look similar to anything you've seen before, and you can't figure out how to get it to work."),
        symbol = "o",
        color = "blue",
        mass_milligrams = 2000000,
        volume_ml = 500,
        price_cents = 2000,
        category = "spare_parts",
        stackable = true,
    }
    item:material("qt_steel", 1)
    item:material("copper", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "exodii_scanner_dish",
        name = ccb.content.plural_text("engraved parabolic dish", "engraved parabolic dishes"),
        description = ccb.content.text("This hefty parabolic dish is engraved with an unrecognizable pattern of symbols that might, at a guess, be some sort of circuitry pattern - or maybe a religious incantation."),
        symbol = "o",
        color = "blue",
        mass_milligrams = 5000000,
        volume_ml = 1000,
        price_cents = 2000,
        category = "spare_parts",
        stackable = true,
    }
    item:material("qt_steel", 1)
    item:material("lead", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "exodii_portalizer",
        name = ccb.content.plural_text("oblong device", "oblong devices"),
        description = ccb.content.text("Perfectly smooth, cool to the touch, and a dull blue-gray color, this looks almost like a perfect riverstone at first glance.  Its artificial nature is betrayed upon closer inspection by a network of intricate patterns visible as a slight difference in the reflection of light off its surface."),
        symbol = "0",
        color = "blue",
        mass_milligrams = 2000000,
        volume_ml = 1500,
        price_cents = 2000,
        category = "spare_parts",
        stackable = true,
    }
    item:material("copper", 1)
    item:material("ceramic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "exodii_ingot_aluminum",
        category = "spare_parts",
        name = ccb.content.plural_text("enormous aluminum ingot", "enormous aluminum ingots"),
        description = ccb.content.text("A block of pure aluminum at least as big as a dishwasher."),
        mass_milligrams = 2160000000,
        volume_ml = 800000,
        price_cents = 5000,
        price_postapoc_cents = 100,
        symbol = "#",
        color = "light_gray",
        stackable = true,
    }
    item:material("aluminum", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "exodii_ingot_plastic",
        category = "spare_parts",
        name = ccb.content.plural_text("enormous plastic block", "enormous plastic blocks"),
        description = ccb.content.text("A single enormous brick of plastic, big enough for you to curl up inside if it were hollow."),
        mass_milligrams = 800000000,
        volume_ml = 800000,
        price_cents = 1000,
        price_postapoc_cents = 50,
        symbol = "#",
        color = "white",
        stackable = true,
    }
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "exodii_ingot_lc_steel",
        category = "spare_parts",
        name = ccb.content.plural_text("enormous steel ingot", "enormous steel ingots"),
        description = ccb.content.text("A monolithic block of low carbon steel."),
        mass_milligrams = 6400000000,
        volume_ml = 800000,
        price_cents = 10000,
        price_postapoc_cents = 500,
        symbol = "#",
        color = "light_gray",
        stackable = true,
    }
    item:material("lc_steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "exodii_ingot_tin",
        category = "spare_parts",
        name = ccb.content.plural_text("enormous tin ingot", "enormous tin ingots"),
        description = ccb.content.text("An enormous ingot of pure tin."),
        mass_milligrams = 5480000000,
        volume_ml = 800000,
        price_cents = 2000,
        price_postapoc_cents = 80,
        symbol = "#",
        color = "white",
        stackable = true,
    }
    item:material("tin", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "exodii_ingot_copper",
        category = "spare_parts",
        name = ccb.content.plural_text("enormous copper ingot", "enormous copper ingots"),
        description = ccb.content.text("A massive solid piece of copper, covered by a blue-green patina."),
        mass_milligrams = 7150000000,
        volume_ml = 800000,
        price_cents = 8000,
        price_postapoc_cents = 300,
        symbol = "#",
        color = "light_green",
        stackable = true,
    }
    item:material("copper", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "exodii_ingot_zinc",
        category = "spare_parts",
        name = ccb.content.plural_text("enormous zinc ingot", "enormous zinc ingots"),
        description = ccb.content.text("An absolutely massive block of pure zinc.  Bet you didn't expect that - nobody expects zinc."),
        mass_milligrams = 5680000000,
        volume_ml = 800000,
        price_cents = 1000,
        price_postapoc_cents = 20,
        symbol = "#",
        color = "white",
        stackable = true,
    }
    item:material("zinc", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "exodii_ingot_lead",
        category = "spare_parts",
        name = ccb.content.plural_text("enormous lead ingot", "enormous lead ingots"),
        description = ccb.content.text("A block of lead so huge you don't even want to think about how heavy it is."),
        mass_milligrams = 9000000000,
        volume_ml = 800000,
        price_cents = 9000,
        price_postapoc_cents = 400,
        symbol = "#",
        color = "dark_gray",
        stackable = true,
    }
    item:material("lead", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "exodii_wire_kit",
        symbol = ",",
        color = "light_gray",
        name = ccb.content.plural_text("CBM interface wire kit", "CBM interface wire kits"),
        category = "spare_parts",
        description = ccb.content.text("A collection of hand-soldered wires leading to plugs and what looks like an exotic micro controller.  The plugs look like they could be attached to you, assuming you have an SNI (Standard Neurobionic Interface)."),
        price_cents = 2000,
        price_postapoc_cents = 2000,
        mass_milligrams = 250000,
        volume_ml = 1000,
        stackable = true,
    }
    item:material("aluminum", 1)
    item:material("plastic", 1)
    item:material("copper", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "exodii_ac_kit",
        symbol = ",",
        color = "light_gray",
        name = ccb.content.plural_text("external climate control kit", "external climate control kits"),
        category = "spare_parts",
        description = ccb.content.text("A collection of mismatched pipes, wires, and a central device that looks like an exotic micro controller.  Almost looks like it could be used for some form of central cooling."),
        price_cents = 2000,
        price_postapoc_cents = 2000,
        mass_milligrams = 500000,
        volume_ml = 1000,
        stackable = true,
    }
    item:material("aluminum", 1)
    item:material("plastic", 1)
    item:material("copper", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "yrax_electronics",
        name = ccb.content.plural_text("woven metallics", "woven metallics"),
        description = ccb.content.text("Thin metallic strips with an ochre sheen, interlaid together into a flexible mesh.  You can't tell whether it's a circuit, a heat dissipation component, or a mechanical actuator."),
        symbol = "i",
        color = "yellow",
        mass_milligrams = 300000,
        volume_ml = 1000,
        price_cents = 1000,
        category = "spare_parts",
        stackable = true,
    }
    item:material("copper", 1)
    item:material("steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "yrax_metal",
        name = ccb.content.plural_text("alien metal plating", "alien metal plating"),
        description = ccb.content.text("A slightly curved plate of white metal.  It readily collects low amounts of static charge."),
        symbol = ")",
        color = "white",
        mass_milligrams = 1000000,
        volume_ml = 1000,
        price_cents = 1000,
        category = "spare_parts",
        stackable = true,
    }
    item:material("silver", 1)
    item:material("steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "yrax_scrap",
        name = ccb.content.plural_text("alien metal scrap", "alien metal scrap"),
        description = ccb.content.text("A collection of tiny metal strips, spheres, and other geometric primitives taken from a disassembled alien machine."),
        symbol = ",",
        color = "yellow",
        mass_milligrams = 150000,
        volume_ml = 100,
        price_cents = 1000,
        category = "spare_parts",
        stackable = true,
    }
    item:material("silver", 1)
    item:material("gold", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "yrax_computer",
        name = ccb.content.plural_text("monolithic machine", "monolithic machine"),
        description = ccb.content.text("A very heavy sphere, presumably made almost entirely of gold.  The complex pattern etched across its surface implies that it might serve some exotic function."),
        symbol = "o",
        color = "yellow",
        mass_milligrams = 14000000,
        volume_ml = 1000,
        price_cents = 1000,
        category = "spare_parts",
        stackable = true,
    }
    item:material("copper", 1)
    item:material("gold", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "yrax_robotics",
        name = ccb.content.plural_text("robotic innards", "robotic innards"),
        description = ccb.content.text("A robotic assembly of unknown function.  Entirely made from tight-fitting metal plates, it somewhat resembles the interior of a mechanical clock."),
        symbol = "o",
        color = "white",
        mass_milligrams = 3000000,
        volume_ml = 2000,
        price_cents = 1000,
        category = "spare_parts",
        stackable = true,
    }
    item:material("steel", 1)
    item:material("gold", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "yrax_sensor",
        name = ccb.content.plural_text("sensor assembly", "sensor assembly"),
        description = ccb.content.text("A carved sphere embedded with small black glass screens.  It's probably a sensor of some kind."),
        symbol = "o",
        color = "white",
        mass_milligrams = 1000000,
        volume_ml = 2000,
        price_cents = 1000,
        category = "spare_parts",
        stackable = true,
    }
    item:material("steel", 1)
    item:material("glass", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "nether_huntsman_spike",
        name = ccb.content.plural_text("undergrown alien spike", "undergrown alien spikes"),
        description = ccb.content.text("A flexible and sharp elongated rod that gets thinner on one end, weak and clearly underdeveloped.  It has been harvested from a dead alien creature."),
        symbol = ">",
        color = "light_gray",
        mass_milligrams = 400000,
        volume_ml = 700,
        longest_side_mm = 510,
        price_cents = 0,
        category = "spare_parts",
        stackable = true,
    }
    item:material("bone", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    item:flag("NO_REPAIR")
    content.add(item)
end

do
    local item = content.Item {
        id = "nether_huntsman_armorpiece_small",
        name = ccb.content.plural_text("alien armor fragment", "alien armor fragments"),
        description = ccb.content.text("A small chunk of alien armor, made of material that resembles bone.  Once being a part of a bigger structure, now crumbling in your hands."),
        symbol = ".",
        color = "light_gray",
        mass_milligrams = 140000,
        volume_ml = 200,
        price_cents = 0,
        category = "spare_parts",
        stackable = true,
    }
    item:material("bone", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    item:flag("NO_REPAIR")
    content.add(item)
end

do
    local item = content.Item {
        id = "nether_huntsman_armorpiece_big",
        name = ccb.content.plural_text("alien armor plate", "alien armor plates"),
        description = ccb.content.text("A big piece of alien armor plating, made of bone-like material.  The outer part is perforated with countless holes, reminiscent of some sort of twisted coral.  It has barbed hooks growing on the inner side."),
        symbol = "d",
        color = "light_gray",
        mass_milligrams = 2800000,
        volume_ml = 4000,
        price_cents = 0,
        category = "spare_parts",
        stackable = true,
    }
    item:material("bone", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    item:flag("NO_REPAIR")
    content.add(item)
end

do
    local item = content.Item {
        id = "nether_huntsman_statuette",
        category = "other",
        name = ccb.content.plural_text("strange statuette", "strange statuettes"),
        description = ccb.content.text("A small statuette of some kind of fantastical creature is carved out of a rough, unnatural material.  It seems remarkably well made."),
        mass_milligrams = 340000,
        volume_ml = 250,
        price_postapoc_cents = 200,
        symbol = "p",
        color = "dark_gray",
    }
    item:material("anomaly", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    item:flag("NO_REPAIR")
    content.add(item)
end

do
    local item = content.Item {
        id = "ephemeral_gem",
        symbol = "*",
        color = "black",
        name = ccb.content.plural_text("ephemeral gemstone", "ephemeral gemstones"),
        category = "other",
        description = ccb.content.text("You know it as a mesmerizing black gem with beautifully etched surfaces, despite only being able to see a pure void in its place when looked at.  You cannot gauge its weight or even feel it in your hands, but it's yours now."),
        mass_milligrams = 1000,
        volume_ml = 10,
        price_postapoc_cents = 0,
    }
    item:material("gemstone", 1)
    item:material("anomaly", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    item:flag("GEMSTONE")
    content.add(item)
end

do
    local item = content.Item {
        id = "yrax_trinket",
        symbol = ".",
        color = "yellow",
        name = ccb.content.plural_text("tiny golden plate", "tiny golden plates"),
        category = "other",
        price_postapoc_cents = 0,
        description = ccb.content.text("A very small rectangular strip of metal, presumably made of gold.  One side is etched with some barely noticeable but incredibly detailed artwork of something you don't recognize, possibly a diagram of sorts.  Sometimes you feel it resonating gently."),
        mass_milligrams = 385000,
        volume_ml = 20,
    }
    item:material("gold", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "string_dimension_computer",
        name = ccb.content.plural_text("otherworldly box", "otherworldly boxes"),
        description = ccb.content.text("An extremely heavy cube with rounded edges, made of a very dense metal.  It has a swing-open door that hides neatly packaged electronics of some unknown design."),
        symbol = "p",
        color = "dark_gray",
        mass_milligrams = 40000000,
        volume_ml = 10000,
        price_cents = 10000,
        category = "spare_parts",
        stackable = true,
    }
    item:material("plastic", 1)
    item:material("unobtanium", 1)
    content.add(item)
end
