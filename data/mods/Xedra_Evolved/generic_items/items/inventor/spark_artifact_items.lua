local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "xe_art_clock",
        name = ccb.content.plural_text("intricate and opulent clock", "intricate and opulent clocks"),
        description = ccb.content.text("An incredibly intricate clock where every visible surface appears to be gilded or chrome.\nIt may have unknown powers; try activating them."),
        symbol = "O",
        volume_ml = 1000,
        mass_milligrams = 1000000,
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    content.add(item)
end

do
    local item = content.Item {
        id = "xe_art_rod",
        name = ccb.content.plural_text("crystalline rod", "crystalline rods"),
        description = ccb.content.text("This crystal rod changes hue at random.\nIt may have unknown powers; try activating them."),
        symbol = "|",
        volume_ml = 235,
        mass_milligrams = 300000,
        longest_side_mm = 750,
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    content.add(item)
end

do
    local item = content.Item {
        id = "xe_art_monitor",
        name = ccb.content.plural_text("baroque monitor", "baroque monitors"),
        description = ccb.content.text("A strange monitor with a variety of knobs and dials.  When you turn it on, it crackles and then begins tracking things that either aren't there or aren't visible to the naked eye.\nIt may have unknown powers; try activating them."),
        symbol = "O",
        volume_ml = 35,
        mass_milligrams = 50000,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "xe_art_mess",
        name = ccb.content.plural_text("a mess of tubes and wires", "several messes of tubes and wires"),
        description = ccb.content.text("What is it for?  What could it do?\nIt may have unknown powers; try activating them."),
        symbol = "[",
        volume_ml = 1000,
        mass_milligrams = 80000,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "xe_art_sculpture",
        name = ccb.content.plural_text("abstract sculpture", "abstract sculptures"),
        description = ccb.content.text("It's a sculpture, but you can't identify what it depicts.\nIt may have unknown powers; try activating them."),
        symbol = "S",
        volume_ml = 215,
        mass_milligrams = 300000,
        longest_side_mm = 650,
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    content.add(item)
end

do
    local item = content.Item {
        id = "xe_art_disc",
        name = ccb.content.plural_text("humming disc", "humming discs"),
        description = ccb.content.text("It hums louder when you touch it.\nIt may have unknown powers; try activating them."),
        symbol = "O",
        volume_ml = 340,
        mass_milligrams = 575000,
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    content.add(item)
end

do
    local item = content.Item {
        id = "xe_art_instrument",
        name = ccb.content.plural_text("an instrument", "instruments"),
        description = ccb.content.text("This looks like a musical instrument.  But how would you play it?\nIt may have unknown powers; try activating them."),
        symbol = "O",
        volume_ml = 76,
        mass_milligrams = 125000,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "xe_art_napkin",
        name = ccb.content.plural_text("very thin sheet", "very thin sheets"),
        description = ccb.content.text("A sheet so light and thin that viewing it horizontally makes it almost invisible.\nIt may have unknown powers; try activating them."),
        symbol = "[",
        volume_ml = 2,
        mass_milligrams = 1000,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "xe_art_urchin",
        name = ccb.content.plural_text("spiked sphere", "spiked spheres"),
        description = ccb.content.text("A prickly ball that, no matter the force you apply, somehow never feels as if it could cut.\nIt may have unknown powers; try activating them."),
        symbol = "O",
        volume_ml = 1000,
        mass_milligrams = 800000,
    }
    item:clear_melee_damage()
    item:melee_damage("cut", 3)
    content.add(item)
end

do
    local item = content.Item {
        id = "xe_art_jelly",
        name = ccb.content.plural_text("malleable blob", "malleable blobs"),
        description = ccb.content.text("Despite its looseness, this mass of goo keeps its shape as you fold it in your hands.\nIt may have unknown powers; try activating them."),
        symbol = "O",
        volume_ml = 1000,
        mass_milligrams = 800000,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "xe_art_spiral",
        name = ccb.content.plural_text("spiraling rod", "spiraling rods"),
        description = ccb.content.text("A rod with a bulbous, spiralling knob on the end that seems to spin as you look.\nIt may have unknown powers; try activating them."),
        symbol = "@",
        volume_ml = 3400,
        mass_milligrams = 300000,
        longest_side_mm = 300,
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    content.add(item)
end

do
    local item = content.Item {
        id = "xe_art_pin",
        name = ccb.content.plural_text("small pin", "small pins"),
        description = ccb.content.text("One of those pins you wear on your shirt, but this one has indecipherable symbols in place of a witty slogan.\nIt may have unknown powers; try activating them."),
        symbol = "|",
        volume_ml = 1,
        mass_milligrams = 50,
        longest_side_mm = 20,
    }
    item:clear_melee_damage()
    item:melee_damage("cut", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "xe_art_tube",
        name = ccb.content.plural_text("hollow tube", "hollow tubes"),
        description = ccb.content.text("A tube of unknown material.  A strange noise from nowhere can be heard when you place it next to your ear, as if something's inside.\nIt may have unknown powers; try activating them."),
        symbol = "|",
        volume_ml = 188,
        mass_milligrams = 50,
        longest_side_mm = 150,
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    content.add(item)
end

do
    local item = content.Item {
        id = "xe_art_pyramid",
        name = ccb.content.plural_text("regular tetrahedron", "regular tetrahedrons"),
        description = ccb.content.text("A triangular pyramid, inconspicuous in every way.\nIt may have unknown powers; try activating them."),
        symbol = "A",
        volume_ml = 1000,
        mass_milligrams = 1000000,
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    content.add(item)
end

do
    local item = content.Item {
        id = "xe_art_crystal",
        name = ccb.content.plural_text("translucent crystal", "translucent crystals"),
        description = ccb.content.text("A beautiful crystal, which seems to suck in detail rather than merely obscuring it as light passes through.\nIt may have unknown powers; try activating them."),
        symbol = "A",
        volume_ml = 500,
        mass_milligrams = 400000,
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    content.add(item)
end

do
    local item = content.Item {
        id = "xe_art_knot",
        name = ccb.content.plural_text("twisted, knotted cord", "twisted, knotted cords"),
        description = ccb.content.text("A bit of spiralling rope, disorienting you as your eyes vainly try to complete following the loop.\nIt may have unknown powers; try activating them."),
        symbol = "b",
        volume_ml = 400,
        mass_milligrams = 400000,
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    content.add(item)
end

do
    local item = content.Item {
        id = "xe_art_crescent",
        name = ccb.content.plural_text("crescent-shaped stone", "crescent-shaped stones"),
        description = ccb.content.text("The sound of the tide can be heard from this stone, as if it were a miniature moon moving the oceans.\nIt may have unknown powers; try activating them."),
        symbol = "C",
        volume_ml = 35,
        mass_milligrams = 50000,
    }
    content.add(item)
end
