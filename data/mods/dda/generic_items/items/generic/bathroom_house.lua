local ccb = require("ccb")
local content = ccb.content

do
    -- Based on https://www.amazon.com/dp/B09QGPWJPX
    local item = content.Item {
        id = "soap_holder",
        name = ccb.content.plural_text("soap dish", "soap dishes"),
        description = ccb.content.text("A shallow dish for holding a bar of soap.  It has ridges to help drain water away from the dish.  Not the most exciting of items."),
        symbol = "-",
        mass_milligrams = 65000,
        volume_ml = 221,
        longest_side_mm = 130,
        price_cents = 250,
        copy_from = "base_toiletries",
    }
    content.add(item)
end

do
    -- the end of the world doesn't mean everyone is okay with having ZZ Top beards.  disposable razors are a hot commodity.  The razor also loses the Cutting 1 quality.  Don't ask how we confirmed this.
    local item = content.Item {
        id = "razor_shaving",
        name = ccb.content.plural_text("shaving razor", "shaving razors"),
        description = ccb.content.text("A razor blade on a comfortable handle.  Much easier to shave with than a loose razor."),
        symbol = "t",
        copy_from = "base_toiletries",
        price_cents = 800,
        price_postapoc_cents = 50,
        mass_milligrams = 110000,
    }
    item:material("plastic", 1)
    item:material("steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    item:melee_damage("cut", 2)
    content.add(item)
end

do
    -- Makes a decent trade commodity.
    local item = content.Item {
        id = "menstrual_cup",
        name = ccb.content.plural_text("menstrual cup", "menstrual cups"),
        description = ccb.content.text("A tiny, washable, flexible plastic cup about the size of a medicine cup for catching menstrual flow."),
        symbol = "v",
        color = "pink",
        looks_like = "bottle_plastic_small",
        default_container = "bag_plastic_small",
        price_cents = 1000,
        price_postapoc_cents = 500,
        mass_milligrams = 10000,
        volume_ml = 50,
    }
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "curler_hair",
        name = ccb.content.plural_text("hair curler", "hair curlers"),
        description = ccb.content.text("A soft plastic cylinder you can wrap a lock of your hair around to curl it."),
        copy_from = "base_toiletries",
        symbol = ",",
        mass_milligrams = 20000,
        volume_ml = 25,
        default_container = "box_small",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "string_floss",
        name = ccb.content.plural_text("dental floss", "rolls of dental floss"),
        description = ccb.content.text("Twenty-five yards of finely waxed thread wound up inside a plastic container.  Perfect for picking bits of smoked meat out of your teeth.  Disassemble to use the thread for something else."),
        mass_milligrams = 28000,
        copy_from = "base_toiletries",
        symbol = "~",
    }
    item:material("plastic", 1)
    item:material("cotton", 1)
    content.add(item)
end

do
    -- the volume is pretty bulky, but this is an old fashioned model.
    local item = content.Item {
        id = "plunger_toilet",
        name = ccb.content.plural_text("toilet plunger", "toilet plungers"),
        description = ccb.content.text("A rubber-tipped tool for unclogging pipes, or a club for an immature survivor."),
        symbol = "p",
        color = "red",
        price_cents = 800,
        price_postapoc_cents = 10,
        mass_milligrams = 590000,
        volume_ml = 2100,
        melee_to_hit = 0,
    }
    item:material("wood", 1)
    item:material("rubber", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    content.add(item)
end

do
    local item = content.Item {
        id = "plunger_futuristic",
        name = ccb.content.plural_text("professional plunger", "professional plungers"),
        description = ccb.content.text("This hollow plastic toilet plunger's bell compresses like an accordion.  It is efficient at its intended purpose, and complete rubbish as a weapon."),
        symbol = "p",
        color = "dark_gray",
        price_cents = 1590,
        price_postapoc_cents = 10,
        mass_milligrams = 680000,
        volume_ml = 2400,
    }
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "curling_iron",
        name = ccb.content.plural_text("curling iron", "curling irons"),
        description = ccb.content.text("A wand made of heat-resistant ceramics.  When plugged into an outlet, it is hot enough to shape your hair into curls.  Too bad the power's out."),
        symbol = "/",
        color = "magenta",
        price_cents = 2500,
        price_postapoc_cents = 0,
        volume_ml = 250,
        mass_milligrams = 590000,
        melee_to_hit = -2,
    }
    item:material("ceramic", 1)
    item:material("steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    content.add(item)
end

do
    local item = content.Item {
        id = "brush_toilet",
        name = ccb.content.plural_text("toilet brush", "toilet brushes"),
        description = ccb.content.text("Zombies cannot be intimidated or humiliated, so this stiff brush is only useful for scouring toilet bowls."),
        symbol = "p",
        color = "white",
        price_cents = 1700,
        price_postapoc_cents = 0,
        volume_ml = 500,
        mass_milligrams = 160000,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "comb_lice",
        name = ccb.content.plural_text("lice comb", "lice combs"),
        description = ccb.content.text("A stainless-steel comb with spiral grooved teeth designed to remove pesky parasites from hair.  Even just thinking about it makes you itch."),
        symbol = "c",
        mass_milligrams = 9000,
        volume_ml = 20,
        longest_side_mm = 100,
        copy_from = "base_toiletries",
    }
    item:material("steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "dentures",
        name = ccb.content.plural_text("set of dentures", "sets of dentures"),
        description = ccb.content.text("A standard set of prosthetic teeth.  Pretty useless to anyone aside from its owner."),
        symbol = "c",
        color = "pink",
        mass_milligrams = 124,
        volume_ml = 5,
        copy_from = "base_toiletries",
    }
    item:material("plastic", 1)
    content.add(item)
end
