local ccb = require("ccb")
local content = ccb.content

do
    local snippets = content.SnippetCategory { id = "auto:toothbrush_plain" }
    snippets:entry {
        id = "tbrush1",
        text = ccb.content.text("A plastic brush with soft bristles for cleaning your teeth.  It has a cheap, blocky handle and is likely meant to be disposable."),
    }
    snippets:entry {
        id = "tbrush2",
        text = ccb.content.text("A combination toothbrush and gum massager.  It has an ergonomic silicone grip.  Luxurious!"),
    }
    snippets:entry {
        id = "tbrush3",
        text = ccb.content.text("A plastic brush with soft bristles for cleaning your teeth.  The blue and white pattern on the handle implies cleanliness."),
    }
    snippets:entry {
        id = "tbrush4",
        text = ccb.content.text("A short toothbrush designed for children.  It has a wide-eyed cartoon pony on the handle."),
    }
    snippets:entry {
        id = "tbrush5",
        text = ccb.content.text("A short toothbrush designed for children.  It has a grinning red racecar on the handle."),
    }
    content.add(snippets)
end

do
    -- Based on https://www.amazon.com/dp/B0BQ1FVGJM, volume calculated as a cylinder with the assumption of 7in length and 0.65in diameter - the dimensions on the listing are for the package, so I took a bit of length off.
    local item = content.Item {
        id = "toothbrush_plain",
        name = ccb.content.plural_text("toothbrush", "toothbrushes"),
        description = ccb.content.text("A plastic brush with soft bristles for cleaning your teeth."),
        symbol = "/",
        mass_milligrams = 18000,
        volume_ml = 38,
        longest_side_mm = 180,
        price_cents = 600,
        copy_from = "base_toiletries",
        snippet_category = "auto:toothbrush_plain",
    }
    content.add(item)
end

do
    local snippets = content.SnippetCategory { id = "auto:tampon" }
    snippets:entry {
        id = "tampon1",
        text = ccb.content.text("A small cotton tampon with a plastic applicator.  Useless for some, an invaluable commodity for others."),
    }
    snippets:entry {
        id = "tampon2",
        text = ccb.content.text("A 'light' cotton tampon with a plastic applicator rated for light flows."),
    }
    snippets:entry {
        id = "tampon3",
        text = ccb.content.text("A 'super' cotton tampon with a plastic applicator rated for heavy flows."),
    }
    snippets:entry {
        id = "tampon4",
        text = ccb.content.text("A small, lavender-scented cotton tampon with a plastic applicator."),
    }
    snippets:entry {
        id = "tampon5",
        text = ccb.content.text("A small cotton tampon with a plastic applicator proudly claiming to be anti-microbial.  Ultra-fine print indicates that this tampon has no noticeable health benefits compared to others."),
    }
    snippets:entry {
        id = "tampon6",
        text = ccb.content.text("An expensive-looking tampon with a fancy, smooth plastic applicator.  The ultra-soft cotton has the appearance of a fluffy cloud."),
    }
    snippets:entry {
        id = "tampon7",
        text = ccb.content.text("A cheap-looking tampon.  The cotton looks rough, the plastic applicator has a few sharp edges, and the string is somehow already knotted."),
    }
    content.add(snippets)
end

do
    -- Makes a decent trade commodity but can be acquired in bulk.
    local item = content.Item {
        id = "tampon",
        name = ccb.content.plural_text("tampon", "tampons"),
        description = ccb.content.text("A small cotton tampon with a plastic applicator."),
        symbol = "+",
        color = "white",
        looks_like = "cotton_ball",
        default_container = "bag_plastic_small",
        price_cents = 25,
        price_postapoc_cents = 200,
        mass_milligrams = 10000,
        volume_ml = 50,
        snippet_category = "auto:tampon",
    }
    item:material("plastic", 1)
    item:material("cotton", 1)
    content.add(item)
end

do
    local snippets = content.SnippetCategory { id = "auto:menstrual_pad" }
    snippets:entry {
        id = "menstrual_pad1",
        text = ccb.content.text("An absorbent menstrual pad.  Unfortunately, not as useful as a bandage as you'd think.  The adhesive is on the side opposite of the absorbent part."),
    }
    snippets:entry {
        id = "menstrual_pad2",
        text = ccb.content.text("A small panty-liner only meant for the lightest flows."),
    }
    snippets:entry { id = "menstrual_pad3", text = ccb.content.text("A large menstrual pad meant for use overnight.") }
    snippets:entry {
        id = "menstrual_pad4",
        text = ccb.content.text("An absorbent menstrual pad with racing stripes, for the fastest flows.  Probably."),
    }
    snippets:entry {
        id = "menstrual_pad5",
        text = ccb.content.text("An absorbent menstrual pad that smells strongly of essential oils."),
    }
    snippets:entry {
        id = "menstrual_pad6",
        text = ccb.content.text("A pride-themed menstrual pad in trans flag coloring.  'Men can bleed too!' is proudly written on the packaging."),
    }
    snippets:entry {
        id = "menstrual_pad7",
        text = ccb.content.text("A cheap menstrual pad.  The cotton somehow looks like sandpaper and is almost see-through thin."),
    }
    content.add(snippets)
end

do
    -- Makes a decent trade commodity but can be acquired in bulk.
    local item = content.Item {
        id = "menstrual_pad",
        name = ccb.content.plural_text("menstrual pad", "menstrual pads"),
        description = ccb.content.text("An absorbent pad."),
        symbol = "=",
        color = "white",
        looks_like = "bandages",
        default_container = "bag_plastic_small",
        price_cents = 25,
        price_postapoc_cents = 200,
        mass_milligrams = 10000,
        volume_ml = 50,
        snippet_category = "auto:menstrual_pad",
    }
    item:material("plastic", 1)
    item:material("cotton", 1)
    content.add(item)
end

do
    local snippets = content.SnippetCategory { id = "auto:hairbrush" }
    snippets:entry {
        id = "hbrush1",
        text = ccb.content.text("An instrument of hair torture.  There are round safety tips on the bristles."),
    }
    snippets:entry {
        id = "hbrush2",
        text = ccb.content.text("An old-fashioned hair-straightening device with a faux-wood handle."),
    }
    snippets:entry {
        id = "hbrush3",
        text = ccb.content.text("A soft, cushioned hairbrush.  The shiny chrome design appears modern."),
    }
    snippets:entry {
        id = "hbrush4",
        text = ccb.content.text("A tacky kid's hairbrush.  The cartoon whale on the handle seems friendly enough."),
    }
    content.add(snippets)
end

do
    -- Based on https://www.amazon.com/dp/B01LPO5JVE
    local item = content.Item {
        id = "hairbrush",
        name = ccb.content.plural_text("hairbrush", "hairbrushes"),
        description = ccb.content.text("An instrument of hair torture."),
        symbol = "/",
        copy_from = "base_toiletries",
        mass_milligrams = 91000,
        volume_ml = 400,
        longest_side_mm = 240,
        price_cents = 600,
        snippet_category = "auto:hairbrush",
    }
    content.add(item)
end

do
    local snippets = content.SnippetCategory { id = "auto:comb_pocket" }
    snippets:entry {
        id = "pcomb1",
        text = ccb.content.text("Somehow, a few teeth have already broken off the end of this otherwise pristine comb."),
    }
    snippets:entry {
        id = "pcomb2",
        text = ccb.content.text("A grooming tool with teeth for straightening your hair.  This one is narrow, black and austere."),
    }
    snippets:entry {
        id = "pcomb3",
        text = ccb.content.text("A comb made of soft plastic.  Its tortoiseshell pattern makes it seem antique."),
    }
    snippets:entry {
        id = "pcomb4",
        text = ccb.content.text("A comb which folds on a hinge, in case you want to look like a greaser."),
    }
    content.add(snippets)
end

do
    local item = content.Item {
        id = "comb_pocket",
        name = ccb.content.plural_text("comb", "combs"),
        description = ccb.content.text("A grooming tool with teeth for straightening your hair."),
        mass_milligrams = 9000,
        volume_ml = 30,
        longest_side_mm = 180,
        symbol = "/",
        copy_from = "base_toiletries",
        snippet_category = "auto:comb_pocket",
    }
    content.add(item)
end

do
    local snippets = content.SnippetCategory { id = "auto:toilet_paper" }
    snippets:entry {
        id = "tpaper1",
        text = ccb.content.text("Imagine the thinnest, most disposable paper you could possibly make.  Now imagine something thinner than that."),
    }
    snippets:entry {
        id = "tpaper2",
        text = ccb.content.text("This roll of toilet paper is two-ply and quilted, for vandalizing houses more comfortably than ever."),
    }
    snippets:entry {
        id = "tpaper3",
        text = ccb.content.text("This brand of toilet paper is designed to dissolve completely in water!"),
    }
    snippets:entry {
        id = "tpaper4",
        text = ccb.content.text("Images of your least favorite politician are printed on each individual sheet."),
    }
    snippets:entry {
        id = "tpaper5",
        text = ccb.content.text("A luxurious remnant of civilization.  The splinters of unprocessed wood visible in this one make it seem less luxurious, though."),
    }
    content.add(snippets)
end

do
    local item = content.Item {
        id = "toilet_paper",
        name = ccb.content.plural_text("toilet paper", "rolls of toilet paper"),
        description = ccb.content.text("A luxurious remnant of civilization."),
        symbol = "~",
        color = "white",
        default_container = "bag_plastic_small",
        price_cents = 89,
        price_postapoc_cents = 180,
        volume_ml = 250,
        mass_milligrams = 227000,
        snippet_category = "auto:toilet_paper",
    }
    item:material("paper", 1)
    content.add(item)
end

do
    local snippets = content.SnippetCategory { id = "auto:bath_toy" }
    snippets:entry { id = "btoy1", text = ccb.content.text("A plastic floating bath toy.") }
    snippets:entry { id = "btoy2", text = ccb.content.text("A yellow rubber duck.  Designed to dropped in the bath.") }
    snippets:entry {
        id = "btoy3",
        text = ccb.content.text("A black rubber duck with large white eyes.  Designed to be dropped in the bath."),
    }
    snippets:entry {
        id = "btoy4",
        text = ccb.content.text("A small green dinosaur with a wide grin.  Designed for bath time."),
    }
    content.add(snippets)
end

do
    local item = content.Item {
        id = "bath_toy",
        name = ccb.content.plural_text("bath toy", "bath toys"),
        description = ccb.content.text("A plastic floating bath toy."),
        symbol = "w",
        color = "yellow",
        copy_from = "base_toiletries",
        mass_milligrams = 55,
        volume_ml = 53,
        snippet_category = "auto:bath_toy",
    }
    item:material("rubber", 1)
    content.add(item)
end

do
    local snippets = content.SnippetCategory { id = "auto:bottle_bathroom" }
    snippets:entry { id = "bbottle_1", text = ccb.content.text("A bottle for special shampoo for dyed hair.") }
    snippets:entry {
        id = "bbottle_2",
        text = ccb.content.text("A plain white bottle made to contain the cheapest shampoo."),
    }
    snippets:entry {
        id = "bbottle_3",
        text = ccb.content.text("A bottle for body wash.  This one is called 'Afrika'."),
    }
    snippets:entry { id = "bbottle_4", text = ccb.content.text("A bottle for hair conditioner.") }
    snippets:entry {
        id = "bbottle_5",
        text = ccb.content.text("A colorful bottle of body and hair wash marketed for children."),
    }
    snippets:entry {
        id = "bbottle_6",
        text = ccb.content.text("A plain white bottle made to contain the cheapest hair conditioner."),
    }
    snippets:entry {
        id = "bbottle_7",
        text = ccb.content.text("A plain white bottle made to contain the cheapest shower gel."),
    }
    content.add(snippets)
end

do
    local item = content.Item {
        id = "bottle_bathroom",
        category = "container",
        name = ccb.content.plural_text("plastic soap bottle", "plastic soap bottles"),
        description = ccb.content.text("A squeezable bottle used to hold various liquid soaps."),
        looks_like = "bottle_plastic",
        mass_milligrams = 130000,
        volume_ml = 502,
        longest_side_mm = 180,
        replace_pockets = true,
        price_cents = 0,
        price_postapoc_cents = 10,
        symbol = ")",
        color = "light_cyan",
        snippet_category = "auto:bottle_bathroom",
    }
    item:container_pocket {
        max_volume_ml = 500,
        max_weight_milligrams = 1250000,
        airtight = true,
        watertight = true,
        rigid = true,
        max_item_volume_ml = 17,
        sealed_spoil_multiplier = 0.5,
        moves = 400,
    }
    item:material("plastic", 1)
    content.add(item)
end

do
    -- NO_I18N
    -- NO_I18N
    local item = content.Item {
        id = "base_toiletries",
        abstract = true,
        name = content.plural_text("generic grooming", "generic grooming"),
        description = content.text("generic item template"),
        symbol = "+",
        color = "blue",
        price_cents = 200,
        price_postapoc_cents = 0,
        mass_milligrams = 100000,
        volume_ml = 100,
    }
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "toothbrush_electric",
        name = ccb.content.plural_text("electric toothbrush", "electric toothbrushes"),
        description = ccb.content.text("A plastic electric toothbrush."),
        symbol = "/",
        copy_from = "base_toiletries",
        mass_milligrams = 140000,
        volume_ml = 107,
        replace_pockets = true,
    }
    item:material("plastic", 1)
    item:magazine_well {
        rigid = true,
        flags = { "BATTERY_LIGHT", "BATTERY_ULTRA_LIGHT" },
        default_magazine = "light_battery_cell",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "hair_dryer",
        name = ccb.content.plural_text("hair dryer", "hair dryers"),
        description = ccb.content.text("This tool dries your hair by pushing air through a coil of hot wires.  The heat can be toggled on and off."),
        symbol = "(",
        color = "dark_gray",
        price_cents = 2100,
        price_postapoc_cents = 0,
        volume_ml = 500,
        mass_milligrams = 680000,
        melee_to_hit = -3,
        charged_qualities = { { id = "WINNOW", level = 1 }, { id = "BLOW_HOT_AIR", level = 1 } },
    }
    item:material("plastic", 1)
    item:material("steel", 1)
    item:clear_flags()
    item:flag("WATER_BREAK")
    item:clear_use_actions()
    item:link_cable { cable_length = 2, charge_milliwatts = 1500000 }
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    item:tool { charges_per_use = 35, ammo_types = { "battery" } }
    content.add(item)
end
