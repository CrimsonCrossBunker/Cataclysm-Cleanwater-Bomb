local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "press",
        name = ccb.content.plural_text("hand press", "hand presses"),
        description = ccb.content.text("A small hand press for hand loading firearm ammunition.  It comes with everything you need to start hand loading your own munitions."),
        mass_milligrams = 6350000,
        volume_ml = 500,
        longest_side_mm = 300,
        price_cents = 10000,
        price_postapoc_cents = 2000,
        symbol = ";",
        color = "dark_gray",
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "press_dowel",
        name = ccb.content.plural_text("makeshift shotshell 'press'", "makeshift shotshell 'presses'"),
        description = ccb.content.text("A collection of items improvised for field reloading of shotshells.  A plank with a hole cut in the center, a medium-sized nail, and a whittled dowel are used to seat wads, decap primers, and (carefully!) reprime hulls.  Powder and shot are measured with a cut-down shotshell hull.  The opposite side of the plank has been shaped to allow for roll-crimping of the plastic hulls.  There's no provision for resizing, so reloaded hulls will fire best in the firearm they were fired from."),
        mass_milligrams = 348000,
        volume_ml = 250,
        longest_side_mm = 300,
        price_cents = 600,
        price_postapoc_cents = 1500,
        symbol = ";",
        color = "dark_gray",
    }
    item:material("wood", 1)
    item:material("plastic", 1)
    item:material("brass", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "puller",
        name = ccb.content.plural_text("kinetic bullet puller", "kinetic bullet pullers"),
        description = ccb.content.text("A tool used for properly disassembling firearm ammunition."),
        mass_milligrams = 489000,
        volume_ml = 250,
        longest_side_mm = 350,
        price_cents = 1000,
        price_postapoc_cents = 2000,
        symbol = ";",
        color = "green",
        replace_qualities = true,
    }
    item:material("plastic", 1)
    item:quality("PULL", 2)
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "arbor_press",
        name = ccb.content.plural_text("arbor press", "arbor presses"),
        description = ccb.content.text("A small hand operated press, it can be used for staking, rivetting, or various other small jobs.  If you had a swage and die, you could use it to make copper jackets for handloading."),
        mass_milligrams = 6350000,
        volume_ml = 12000,
        longest_side_mm = 290,
        price_cents = 30000,
        price_postapoc_cents = 1000,
        symbol = ";",
        color = "dark_gray",
    }
    item:material("iron", 1)
    item:material("plastic", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 10)
    item:tool()
    content.add(item)
end
