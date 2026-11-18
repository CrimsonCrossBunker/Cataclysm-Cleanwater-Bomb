local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "shark_plushie",
        name = ccb.content.plural_text("shark plushie", "shark plushies"),
        description = ccb.content.text("A somewhat large, mass produced shark plushie.  Meant to provide comfort to people of all ages."),
        category = "other",
        mass_milligrams = 625000,
        volume_ml = 30000,
        longest_side_mm = 1030,
        price_cents = 600,
        price_postapoc_cents = 20,
        symbol = "s",
        color = "cyan",
    }
    item:material("cotton", 1)
    item:clear_flags()
    item:flag("SLEEP_AID")
    content.add(item)
end

do
    -- yes this is a Dorohedoro reference
    local item = content.Item {
        id = "toy_figurine_large",
        name = ccb.content.plural_text("large figurine", "large figurines"),
        description = ccb.content.text("A large manufactured figurine.  This is the default variant, if you see it something went wrong."),
        category = "other",
        mass_milligrams = 500000,
        volume_ml = 1000,
        price_cents = 2000,
        price_postapoc_cents = 20,
        symbol = "f",
        color = "cyan",
        variant_kind = "generic",
    }
    item:material("plastic", 1)
    item:variants {
        { id = "toy_figure_trex", name = ccb.content.plural_text("T-rex figurine", "T-rex figurines"), description = ccb.content.text("A relatively large plastic figurine of a T-rex.") },
        { id = "toy_figure_mech", name = ccb.content.plural_text("mech figurine", "mech figurines"), description = ccb.content.text("A large figurine of a humanoid robot, armed with a rifle, with a smaller figure sitting inside the head.") },
        { id = "toy_figure_knight", name = ccb.content.plural_text("knight figurine", "knight figurines"), description = ccb.content.text("A large figurine of a knight in shining armor standing watch, with its sword planted at the ground at its feet.") },
        { id = "toy_figure_t800", name = ccb.content.plural_text("robot figurine", "robot figurines"), description = ccb.content.text("A very intricate looking model of a robotic skeleton with red eyes and a futuristic weapon in its hand.") },
        { id = "toy_figure_caiman", name = ccb.content.plural_text("lizardman figurine", "lizardman figurines"), description = ccb.content.text("An expensive figurine of a buff man in streetwear with a lizard head, holding a pair of knives in his hands.") },
        { id = "toy_figure_anime", name = ccb.content.plural_text("anime figurine", "anime figurines"), description = ccb.content.text("An expensive figurine of a cartoon woman in flashy clothing.") },
        { id = "toy_figure_heavyweapons", name = ccb.content.plural_text("video game figurine", "video game figurines"), description = ccb.content.text("A large figurine of a video game character, holding a massive Gatling gun in his giant arms.") },
        { id = "toy_figurine_smoker", name = ccb.content.plural_text("zombie figurine", "zombie figurines"), description = ccb.content.text("A nasty looking figurine of a mutant zombie, with a large tongue sprouting from its face.  You thankfully haven't encountered something like that yet.") },
        { id = "toy_figure_alien", name = ccb.content.plural_text("alien figurine", "alien figurines"), description = ccb.content.text("An expensive looking figurine of a gnarly, jet-black alien covered in menacing looking spines.") },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "toy_figurine",
        name = ccb.content.plural_text("figurine", "figurines"),
        description = ccb.content.text("A normal-sized manufactured figurine.  This is the default variant, if you see it something went wrong."),
        category = "other",
        mass_milligrams = 125000,
        volume_ml = 200,
        price_cents = 2000,
        price_postapoc_cents = 10,
        symbol = "f",
        color = "cyan",
        variant_kind = "generic",
    }
    item:material("plastic", 1)
    item:variants {
        { id = "toy_figure_swordsman", name = ccb.content.plural_text("swordsman figurine", "swordsman figurines"), description = ccb.content.text("A figurine of some unnamed swordsman, covered with scars and equipped with sturdy leather armor.  Seems to be ready to fight.") },
        { id = "toy_figure_female", name = ccb.content.plural_text("fashionable doll", "fashionable dolls"), description = ccb.content.text("A plastic figurine of a young woman.  She's meant to be dressed up and accessorized with a wide variety of clothing, sold separately.") },
        { id = "toy_figure_krueger", name = ccb.content.plural_text("nightmare figurine", "nightmare figurines"), description = ccb.content.text("A plastic figurine with a nightmarish, scarred face.  He wears a hat and has three long blades extending from a glove on the back of his hand.") },
        { id = "toy_figure_unicorn", name = ccb.content.plural_text("unicorn figurine", "unicorn figurines"), description = ccb.content.text("A figurine of a blue unicorn.  It is in a sitting position, shyly covering both eyes with its front hooves.") },
        { id = "toy_figure_swampman", name = ccb.content.plural_text("swamp monster figurine", "swamp monster figurines"), description = ccb.content.text("A figurine of a scaly green swamp monster emerging from some fetid lagoon.") },
        { id = "toy_figure_reaper", name = ccb.content.plural_text("reaper figurine", "reaper figurines"), description = ccb.content.text("Your heart leaps to your throat as you see the face of Death itself staring back at you, scythe raised for the harvest!  You relax significantly once you realize it's only a few inches tall and made of plastic.") },
        { id = "toy_figure_mermaid", name = ccb.content.plural_text("mermaid figurine", "mermaid figurines"), description = ccb.content.text("A figurine of a redheaded mermaid sitting on a rock.  Like in the film this toy is based on, she gazes longingly out to a world she wants to be a part of - or she would be, but the face isn't drawn very well and doesn't express much emotion at all.") },
        { id = "toy_figure_avocado", name = ccb.content.plural_text("avocado figurine", "avocado figurines"), description = ccb.content.text("A plastic figurine of an anthropomorphic avocado, holding a salt shaker and a spoon.  Makes a great gift for the guacamole lover in your life, or as a decoration for your kitchen.") },
        { id = "toy_figure_superhero", name = ccb.content.plural_text("superhero figurine", "superhero figurines"), description = ccb.content.text("A superhero action figure.  Its limbs can be adjusted for different poses, and it is designed to do battle against a wide variety of crooks and supervillains, sold separately.") },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "yoyo",
        name = ccb.content.plural_text("yoyo", "yoyos"),
        description = ccb.content.text("A simple yoyo on a string.  Now you can be bored with style."),
        category = "other",
        mass_milligrams = 50000,
        volume_ml = 70,
        longest_side_mm = 70,
        price_cents = 200,
        price_postapoc_cents = 5,
        symbol = "q",
        color = "light_gray",
    }
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "imperfect_doll_legs",
        name = ccb.content.plural_text("floppy cotton legs", "floppy cotton legs"),
        description = ccb.content.text("They're different colors and different lengths.  It would be hard to run away with these."),
        category = "other",
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = "i",
        color = "dark_gray",
    }
    item:material("cotton", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    item:flag("INTEGRATED")
    item:flag("ZERO_WEIGHT")
    item:flag("MISSION_ITEM")
    content.add(item)
end

do
    local item = content.Item {
        id = "imperfect_doll_arms",
        name = ccb.content.plural_text("threadbare cotton arms", "threadbare cotton arms"),
        description = ccb.content.text("The spun cloth fingers are fraying away.  There's nothing that they could hold on to."),
        category = "other",
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = "i",
        color = "cyan",
    }
    item:material("cotton", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    item:flag("INTEGRATED")
    item:flag("ZERO_WEIGHT")
    item:flag("MISSION_ITEM")
    content.add(item)
end

do
    local item = content.Item {
        id = "imperfect_doll_features",
        name = ccb.content.plural_text("buttons and thread", "buttons and thread"),
        description = ccb.content.text("A pair of mismatched buttons and some dull yellow thread, to put on a brave face with."),
        category = "other",
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = "i",
        color = "dark_gray",
    }
    item:material("cotton", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    item:flag("INTEGRATED")
    item:flag("ZERO_WEIGHT")
    item:flag("MISSION_ITEM")
    content.add(item)
end
