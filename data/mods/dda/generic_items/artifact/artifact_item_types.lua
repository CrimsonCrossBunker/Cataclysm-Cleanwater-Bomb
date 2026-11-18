local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "art_sphere",
        category = "artifacts",
        name = ccb.content.plural_text("smooth sphere", "smooth spheres"),
        description = ccb.content.text("It is the only one of its kind.\nIt may have unknown powers; try activating them."),
        symbol = "O",
        volume_ml = 1000,
        mass_milligrams = 1000000,
        melee_to_hit = -2,
    }
    item:material("anomaly", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    content.add(item)
end

do
    local item = content.Item {
        id = "art_rod",
        category = "artifacts",
        name = ccb.content.plural_text("slim rod", "slim rods"),
        description = ccb.content.text("It is the only one of its kind.\nIt may have unknown powers; try activating them."),
        symbol = "|",
        volume_ml = 235,
        mass_milligrams = 300000,
        longest_side_mm = 750,
        melee_to_hit = 1,
    }
    item:material("anomaly", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    content.add(item)
end

do
    local item = content.Item {
        id = "art_book",
        category = "artifacts",
        looks_like = "philosophy_book",
        name = ccb.content.plural_text("ancient codex", "ancient codices"),
        description = ccb.content.text("Vellum pages bound in bark.  The strange symbols within seem to have been overwritten hundreds of times."),
        symbol = "?",
        color = "light_blue",
        volume_ml = 500,
        mass_milligrams = 300000,
        melee_to_hit = -1,
    }
    item:variants {
        { id = "uklm_si", name = ccb.content.plural_text("In Uklm-si", "In Uklm-si"), description = ccb.content.text("The text is written in English, but every word takes incredible effort to comprehend."), weight = 300 },
        { id = "borges1", name = ccb.content.plural_text("Perfect Index", "Perfect Indices"), description = ccb.content.text("The book describes a curious heximal library classification system, and purports to be a perfect index for all possible written works."), weight = 100 },
        { id = "borges2", name = ccb.content.plural_text("MCV", "MCV"), description = ccb.content.text("The book contains nothing but the letters MCV perversely repeated from the first line to the last."), weight = 500 },
        { id = "infinite", name = ccb.content.plural_text("Kybernetika", "copies of Kybernetika"), description = ccb.content.text("A postmodern novel where the protagonist finds a copy of this very book, and reads it to find a copy of this very book, and reads it to find a copy of this very book, and…"), weight = 300 },
        { id = "codex", name = ccb.content.plural_text("ancient codex", "ancient codices"), description = ccb.content.text("Vellum pages bound in bark.  The strange symbols within seems to have been overwritten hundreds of times."), weight = 1500 },
        { id = "stars", name = ccb.content.plural_text("celestial atlas", "celestial atlases"), description = ccb.content.text("Its pages are filled with star charts and diagrams of fanciful constellations."), weight = 500 },
        { id = "faeries", name = ccb.content.plural_text("book of fairy tales", "books of fairy tales"), description = ccb.content.text("Any glance given to this book is survived by the drone of flapping wings."), weight = 300 },
        { id = "blank", name = ccb.content.plural_text("blank book", "blank books"), description = ccb.content.text("This book is blank and perfectly immaculate."), weight = 300 },
    }
    item:material("anomaly", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 10)
    content.add(item)
end

do
    local item = content.Item {
        id = "art_teardrop",
        category = "artifacts",
        name = ccb.content.plural_text("teardrop-shaped stone", "teardrop-shaped stones"),
        description = ccb.content.text("It is the only one of its kind.\nIt may have unknown powers; try activating them."),
        symbol = "O",
        volume_ml = 35,
        mass_milligrams = 50000,
    }
    item:material("anomaly", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "art_lamp",
        category = "artifacts",
        name = ccb.content.plural_text("hollow, transparent cube", "hollow, transparent cubes"),
        description = ccb.content.text("It is the only one of its kind.\nIt may have unknown powers; try activating them."),
        symbol = "[",
        volume_ml = 1000,
        mass_milligrams = 80000,
    }
    item:material("anomaly", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "art_snake",
        category = "artifacts",
        name = ccb.content.plural_text("winding, flexible rod", "winding, flexible rods"),
        description = ccb.content.text("It is the only one of its kind.\nIt may have unknown powers; try activating them."),
        symbol = "S",
        volume_ml = 215,
        mass_milligrams = 300000,
        longest_side_mm = 650,
        melee_to_hit = 1,
    }
    item:material("anomaly", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    content.add(item)
end

do
    local item = content.Item {
        id = "art_disc",
        category = "artifacts",
        name = ccb.content.plural_text("smooth disc", "smooth discs"),
        description = ccb.content.text("It is the only one of its kind.\nIt may have unknown powers; try activating them."),
        symbol = "O",
        volume_ml = 340,
        mass_milligrams = 575000,
        melee_to_hit = -2,
    }
    item:material("anomaly", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    content.add(item)
end

do
    local item = content.Item {
        id = "art_beads",
        category = "artifacts",
        name = ccb.content.plural_text("string of beads", "strings of beads"),
        description = ccb.content.text("It is the only one of its kind.\nIt may have unknown powers; try activating them."),
        symbol = "O",
        volume_ml = 76,
        mass_milligrams = 125000,
    }
    item:material("anomaly", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "art_napkin",
        category = "artifacts",
        name = ccb.content.plural_text("very thin sheet", "very thin sheets"),
        description = ccb.content.text("It is the only one of its kind.\nIt may have unknown powers; try activating them."),
        symbol = "[",
        volume_ml = 2,
        mass_milligrams = 1000,
        melee_to_hit = -4,
    }
    item:material("anomaly", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "art_urchin",
        category = "artifacts",
        name = ccb.content.plural_text("spiked sphere", "spiked spheres"),
        description = ccb.content.text("It is the only one of its kind.\nIt may have unknown powers; try activating them."),
        symbol = "O",
        volume_ml = 1000,
        mass_milligrams = 800000,
    }
    item:material("anomaly", 1)
    item:clear_melee_damage()
    item:melee_damage("cut", 3)
    content.add(item)
end

do
    local item = content.Item {
        id = "art_jelly",
        category = "artifacts",
        name = ccb.content.plural_text("malleable blob", "malleable blobs"),
        description = ccb.content.text("It is the only one of its kind.\nIt may have unknown powers; try activating them."),
        symbol = "O",
        volume_ml = 1000,
        mass_milligrams = 800000,
        melee_to_hit = -2,
    }
    item:material("anomaly", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "art_spiral",
        category = "artifacts",
        name = ccb.content.plural_text("spiraling rod", "spiraling rods"),
        description = ccb.content.text("It is the only one of its kind.\nIt may have unknown powers; try activating them."),
        symbol = "@",
        volume_ml = 3400,
        mass_milligrams = 300000,
        longest_side_mm = 300,
        melee_to_hit = -2,
    }
    item:material("anomaly", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    content.add(item)
end

do
    local item = content.Item {
        id = "art_pin",
        category = "artifacts",
        name = ccb.content.plural_text("small pin", "small pins"),
        description = ccb.content.text("It is the only one of its kind.\nIt may have unknown powers; try activating them."),
        symbol = "|",
        volume_ml = 1,
        mass_milligrams = 50,
        longest_side_mm = 20,
        melee_to_hit = -5,
    }
    item:material("anomaly", 1)
    item:clear_melee_damage()
    item:melee_damage("cut", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "art_tube",
        category = "artifacts",
        name = ccb.content.plural_text("hollow tube", "hollow tubes"),
        description = ccb.content.text("It is the only one of its kind.\nIt may have unknown powers; try activating them."),
        symbol = "|",
        volume_ml = 188,
        mass_milligrams = 50,
        longest_side_mm = 150,
    }
    item:material("anomaly", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    content.add(item)
end

do
    local item = content.Item {
        id = "art_pyramid",
        category = "artifacts",
        name = ccb.content.plural_text("regular tetrahedron", "regular tetrahedrons"),
        description = ccb.content.text("It is the only one of its kind.\nIt may have unknown powers; try activating them."),
        symbol = "A",
        volume_ml = 1000,
        mass_milligrams = 1000000,
        melee_to_hit = -2,
    }
    item:material("anomaly", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    content.add(item)
end

do
    local item = content.Item {
        id = "art_crystal",
        category = "artifacts",
        name = ccb.content.plural_text("translucent crystal", "translucent crystals"),
        description = ccb.content.text("It is the only one of its kind.\nIt may have unknown powers; try activating them."),
        symbol = "A",
        volume_ml = 500,
        mass_milligrams = 400000,
        melee_to_hit = -2,
    }
    item:material("anomaly", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    content.add(item)
end

do
    local item = content.Item {
        id = "art_knot",
        category = "artifacts",
        name = ccb.content.plural_text("twisted, knotted cord", "twisted, knotted cords"),
        description = ccb.content.text("It is the only one of its kind.\nIt may have unknown powers; try activating them."),
        symbol = "b",
        volume_ml = 400,
        mass_milligrams = 400000,
    }
    item:material("anomaly", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    content.add(item)
end

do
    local item = content.Item {
        id = "art_crescent",
        category = "artifacts",
        name = ccb.content.plural_text("crescent-shaped stone", "crescent-shaped stones"),
        description = ccb.content.text("It is the only one of its kind.\nIt may have unknown powers; try activating them."),
        symbol = "C",
        volume_ml = 35,
        mass_milligrams = 50000,
    }
    item:material("anomaly", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "art_bomorrean",
        copy_from = "art_ring",
        looks_like = "art_ring",
        name = ccb.content.plural_text("set of oddly interlocked rings", "sets of oddly interlocked rings"),
        description = ccb.content.text("A set of three rings linked together.  There's something about the way the rings connect to each other that gives you a headache.  It is the only one of its kind.\nIt may have unknown powers; try activating them."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "art_penrose",
        copy_from = "art_pyramid",
        looks_like = "art_pyramid",
        name = ccb.content.plural_text("strange triangle", "strange triangles"),
        description = ccb.content.text("A large triangle made out of three thick rectangles that connect to each other in an angle.  No matter how much you turn it around, you can't seem to comprehend how it links together.  It is the only one of its kind.\nIt may have unknown powers; try activating them."),
        volume_ml = 2000,
        mass_milligrams = 2000000,
    }
    content.add(item)
end

do
    -- The bacteria can't find a way inside!
    local item = content.Item {
        id = "art_klein",
        copy_from = "art_tube",
        looks_like = "art_tube",
        name = ccb.content.plural_text("self-crossing flask", "self-crossing flasks"),
        description = ccb.content.text("A transparent flask with a neck that connects directly to its bottom without overlapping itself, even though it clearly does.  You can put things in it, but attempting to follow their path through the neck is impossible.  It is the only one of its kind.\nIt may have unknown powers; try activating them."),
        replace_pockets = true,
        volume_ml = 1500,
        mass_milligrams = 0,
    }
    item:container_pocket {
        max_volume_ml = 500,
        max_weight_milligrams = 1000000,
        airtight = true,
        watertight = true,
        rigid = true,
        max_item_volume_ml = 25,
        weight_multiplier = 0,
        spoil_multiplier = 0.5,
        moves = 5000,
    }
    item:clear_flags()
    item:flag("TARDIS")
    item:flag("ZERO_WEIGHT")
    content.add(item)
end

do
    local item = content.Item {
        id = "art_tesseract",
        copy_from = "art_lamp",
        looks_like = "art_lamp",
        name = ccb.content.plural_text("four-dimensional cube", "four-dimensional cubes"),
        description = ccb.content.text("It's a cube that constantly shrinks and grows in size.  It's two cubes linked by the vertices, with ever-shifting sides folding onto each other, over and over.  It's four cubes in the exact same position.  It's a cube fading to ash then reverting to pristine form repeatedly.  It's all of these at once, and none of them at all.  It is the only one of its kind.\nIt may have unknown powers; try activating them."),
        volume_ml = 1000,
        mass_milligrams = 8000000,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "art_irrational",
        copy_from = "art_lamp",
        looks_like = "art_lamp",
        name = ccb.content.plural_text("irrational cube", "irrational cubes"),
        description = ccb.content.text("A large wire-frame cube.  The interior wires somehow appear to be over the exterior wires, no matter which angle you look at the cube from.  Trying to trace the lines with your finger is probably not a good idea.  It is the only one of its kind.\nIt may have unknown powers; try activating them."),
        volume_ml = 1000,
        mass_milligrams = 0,
        longest_side_mm = 300,
    }
    item:clear_flags()
    item:flag("ZERO_WEIGHT")
    content.add(item)
end

do
    local item = content.Item {
        id = "art_duocylinder",
        copy_from = "art_urchin",
        looks_like = "art_urchin",
        name = ccb.content.plural_text("wobbly ring", "wobbly rings"),
        description = ccb.content.text("A chunky ring that folds onto itself continuously, preventing its use as an esoteric piece of jewelry.  It is the only one of its kind.\nIt may have unknown powers; try activating them."),
        volume_ml = 5,
        mass_milligrams = 8000000,
        longest_side_mm = 50,
    }
    content.add(item)
end
