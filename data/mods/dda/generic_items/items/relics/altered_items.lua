local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "altered_exposed_wiring_prototype",
        category = "artifacts",
        symbol = ",",
        color = "light_gray",
        looks_like = "scrap",
        name = ccb.content.plural_text("exposed-wiring prototype", "exposed-wiring prototypes"),
        description = ccb.content.text("Some kind of prototypical electronic device with exposed wiring.  Some of the wires have bare ends that could be connected together."),
        price_cents = 1000,
        price_postapoc_cents = 100,
        mass_milligrams = 32000,
        volume_ml = 26,
    }
    item:material("plastic", 1)
    item:material("copper", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "altered_phone",
        category = "artifacts",
        symbol = ",",
        color = "light_red",
        looks_like = "toaster",
        name = ccb.content.plural_text("Bakelite phone", "Bakelite phones"),
        description = ccb.content.text("A vintage, bright-red Bakelite phone of famous Swedish design.  It would look almost normal, if not for the fact that its rotary dial has been replaced with a doorknob."),
        price_cents = 1000,
        price_postapoc_cents = 100,
        mass_milligrams = 725000,
        volume_ml = 750,
    }
    item:material("iron", 1)
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "altered_comb",
        category = "artifacts",
        symbol = ",",
        color = "yellow",
        looks_like = "comb_pocket",
        name = ccb.content.plural_text("golden comb", "golden combs"),
        description = ccb.content.text("A small, delicate golden comb.  It was once carefully engraved, but time has smoothed its designs to illegibility."),
        price_cents = 1000,
        price_postapoc_cents = 100,
        mass_milligrams = 650000,
        volume_ml = 40,
    }
    item:material("gold", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "altered_keyring",
        category = "artifacts",
        symbol = ",",
        color = "yellow",
        looks_like = "old_key",
        name = ccb.content.plural_text("shifting keyring", "shifting keyrings"),
        description = ccb.content.text("A smooth ring of steel, heavy under the weight of numerous keys.  The designs of the keys change over time, but none will fit any keyhole you have ever found."),
        price_cents = 1000,
        price_postapoc_cents = 10,
        mass_milligrams = 2000000,
        volume_ml = 750,
    }
    item:material("steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "altered_rubicks_cube",
        category = "artifacts",
        symbol = ",",
        color = "light_gray",
        looks_like = "art_lamp",
        name = ccb.content.plural_text("engraved cube", "engraved cubes"),
        description = ccb.content.text("A small cube of smooth rock.  A uniform grid of nine squares is engraved in each of its faces."),
        price_cents = 1000,
        price_postapoc_cents = 10,
        mass_milligrams = 510000,
        volume_ml = 185,
    }
    item:material("stone", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "altered_teapot",
        category = "artifacts",
        copy_from = "clay_teapot",
        looks_like = "clay_teapot",
        color = "light_gray",
        name = ccb.content.plural_text("Utah teapot", "Utah teapots"),
        description = ccb.content.text("A squat teapot with a minimalist design.  Its surface shines under the glow of unseen light sources."),
        price_cents = 1000,
        price_postapoc_cents = 10,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "altered_stopwatch",
        category = "artifacts",
        symbol = ",",
        color = "blue",
        looks_like = "wristwatch",
        name = ccb.content.plural_text("glitching stopwatch", "glitching stopwatches"),
        description = ccb.content.text("A small digital stopwatch, looking slightly old by today's standards.  Its digital display prints ever-changing gibberish."),
        price_cents = 1000,
        price_postapoc_cents = 10,
        mass_milligrams = 165000,
        volume_ml = 165,
    }
    item:material("plastic", 1)
    content.add(item)
end
