local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "hoof_pick",
        name = ccb.content.plural_text("hoof pick", "hoof picks"),
        description = ccb.content.text("A simple brush and pick combination tool for a farrier to clean up the horse's hoof before working on it."),
        mass_milligrams = 240000,
        volume_ml = 240,
        longest_side_mm = 210,
        price_cents = 1000,
        price_postapoc_cents = 10,
        symbol = "/",
        color = "light_gray",
    }
    item:material("plastic", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "horseshoe_pliers",
        name = ccb.content.plural_text("horseshoe puller", "horseshoe pullers"),
        description = ccb.content.text("A large pliers used by farrier to take off horseshoes off horse's hooves."),
        ascii_picture = "pliers",
        mass_milligrams = 938000,
        volume_ml = 1066,
        longest_side_mm = 360,
        price_cents = 4000,
        price_postapoc_cents = 100,
        symbol = ";",
        color = "light_gray",
    }
    item:material("mc_steel", 1)
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "nail_puller",
        name = ccb.content.plural_text("nail puller", "nail pullers"),
        description = ccb.content.text("A tool used for pulling nails out of a surface.  While it is usually used by farriers to pull nails off horse's hooves, it can pull nails on other surface as well."),
        ascii_picture = "pliers",
        mass_milligrams = 938000,
        volume_ml = 1066,
        longest_side_mm = 360,
        price_cents = 3000,
        price_postapoc_cents = 100,
        replace_qualities = true,
        symbol = ";",
        color = "light_gray",
    }
    item:material("mc_steel", 1)
    item:quality("PRYING_NAIL", 1)
    item:quality("HAMMER", 1)
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "hoof_tester",
        name = ccb.content.plural_text("hoof tester", "hoof testers"),
        description = ccb.content.text("A two-pronged tool used by farriers to check if a horse's foot is sore.  It is used by putting some pressure on the horse's sole or heel and see how the horse react."),
        mass_milligrams = 621000,
        volume_ml = 1066,
        longest_side_mm = 320,
        price_cents = 2500,
        price_postapoc_cents = 100,
        symbol = ";",
        color = "light_gray",
    }
    item:material("mc_steel", 1)
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "hoof_nippers",
        name = ccb.content.plural_text("pair of nippers", "pairs of nippers"),
        description = ccb.content.text("A tool used for trimming around the hoof wall until the foot is in the right height, like a giant pair of nail clippers."),
        mass_milligrams = 621000,
        volume_ml = 1025,
        longest_side_mm = 320,
        price_cents = 2000,
        price_postapoc_cents = 100,
        symbol = ";",
        color = "light_gray",
    }
    item:material("mc_steel", 1)
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "hoof_rasp",
        name = ccb.content.plural_text("rasp", "rasps"),
        description = ccb.content.text("A large nail file used to trim and smoothen horse hoof edges."),
        mass_milligrams = 336000,
        volume_ml = 250,
        longest_side_mm = 360,
        price_cents = 300,
        price_postapoc_cents = 100,
        symbol = ";",
        color = "light_gray",
    }
    item:material("mc_steel", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "pritchel",
        name = ccb.content.plural_text("pritchel", "pritchels"),
        description = ccb.content.text("A punch used in creating nail holes for horseshoes."),
        mass_milligrams = 240000,
        volume_ml = 155,
        longest_side_mm = 210,
        price_cents = 1000,
        price_postapoc_cents = 10,
        symbol = "/",
        color = "light_gray",
    }
    item:material("mc_steel", 1)
    item:clear_melee_damage()
    item:melee_damage("stab", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "clinch_block",
        name = ccb.content.plural_text("clinch block", "clinch blocks"),
        description = ccb.content.text("A simple metal block with angled edge used to help with clinching the nails."),
        mass_milligrams = 240000,
        volume_ml = 155,
        longest_side_mm = 210,
        price_cents = 1000,
        price_postapoc_cents = 10,
        symbol = "/",
        color = "light_gray",
    }
    item:material("mc_steel", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "clinch_pliers",
        name = ccb.content.plural_text("pair of clinchers", "pairs of clinchers"),
        description = ccb.content.text("A plier-like tool used to lightly bend and flatten the nail down against the hoof wall to keep it in place."),
        ascii_picture = "pliers",
        mass_milligrams = 938000,
        volume_ml = 1066,
        longest_side_mm = 360,
        price_cents = 4000,
        price_postapoc_cents = 100,
        symbol = ";",
        color = "light_gray",
    }
    item:material("mc_steel", 1)
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "clinch_cutter",
        name = ccb.content.plural_text("clinch cutter", "clinch cutters"),
        description = ccb.content.text("A small hatchet looking tool used for cutting excess nail points once the nail has been clinched."),
        mass_milligrams = 938000,
        volume_ml = 1000,
        longest_side_mm = 360,
        price_cents = 2000,
        price_postapoc_cents = 100,
        symbol = "/",
        color = "light_gray",
    }
    item:material("mc_steel", 1)
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "hoof_stand",
        name = ccb.content.plural_text("hoof stand", "hoof stands"),
        description = ccb.content.text("A small stand for supporting the horse's foot in the final stages of the shoe job."),
        mass_milligrams = 938000,
        volume_ml = 900,
        longest_side_mm = 350,
        price_cents = 4000,
        price_postapoc_cents = 100,
        symbol = "/",
        color = "light_gray",
    }
    item:material("mc_steel", 1)
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "horseshoe",
        name = ccb.content.plural_text("horseshoe", "horseshoes"),
        description = ccb.content.text("An U-shaped band of iron fitted onto the horse's hoof to protect it from wear."),
        mass_milligrams = 938000,
        volume_ml = 1000,
        longest_side_mm = 350,
        price_cents = 4000,
        price_postapoc_cents = 10,
        symbol = "u",
        color = "light_gray",
    }
    item:material("mc_steel", 1)
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:tool()
    content.add(item)
end
