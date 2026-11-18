local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "magick_8_ball",
        category = "artifacts",
        looks_like = "magic_8_ball",
        name = ccb.content.plural_text("magick 8-Ball", "magick 8-Balls"),
        description = ccb.content.text("A fortune-telling device from the 1950s.  If you shake it and look at the bottom it will give you detailed step by step instructions on how to do… something."),
        mass_milligrams = 40000,
        volume_ml = 150,
        price_cents = 1000,
        price_postapoc_cents = 10,
        symbol = "o",
        color = "white",
    }
    item:material("forged_dreamstuff", 1)
    item:clear_flags()
    item:flag("SLING_PROJECTILE")
    item:clear_use_actions()
    item:teach_spells { "dream_armor" }
    content.add(item)
end

do
    local item = content.Item {
        id = "glass_dagger_paperweight",
        category = "artifacts",
        looks_like = "knife_paring",
        name = ccb.content.plural_text("glass dagger paperweight", "glass dagger paperweights"),
        description = ccb.content.text("This paperweight in the shape of a small glass dagger emits a wet wheeze like a punctured lung when held."),
        mass_milligrams = 40000,
        volume_ml = 150,
        longest_side_mm = 120,
        price_cents = 1000,
        price_postapoc_cents = 10,
        symbol = "t",
        color = "white",
    }
    item:material("forged_dreamstuff", 1)
    item:clear_use_actions()
    item:teach_spells { "dream_dagger" }
    content.add(item)
end

do
    local item = content.Item {
        id = "caravaggio_self_portrait",
        category = "artifacts",
        looks_like = "family_photo",
        name = ccb.content.plural_text("Caravaggio on his deathbed", "copies of Caravaggio on his deathbed"),
        description = ccb.content.text("A previously unknown painting in Caravaggio's style of the artist himself lying prone on his deathbed as black ichor seeps from a sword wound in his side.  His own sword rests near his hand and his ever dying breath asks you to take up his blade."),
        mass_milligrams = 40000,
        volume_ml = 150,
        longest_side_mm = 120,
        price_cents = 1000,
        price_postapoc_cents = 10,
        symbol = "C",
        color = "red_white",
    }
    item:material("forged_dreamstuff", 1)
    item:clear_use_actions()
    item:teach_spells { "dream_blade" }
    content.add(item)
end

do
    -- 'A small hand mirror.  Something wrong'.  I use https://www.messletters.com/en/mirrored/ (the third option) but I guess it doesn't work with non-Latin languages. Sorry translators.
    local item = content.Item {
        id = "mirror_artifact",
        symbol = "o",
        color = "light_cyan",
        name = ccb.content.plural_text("ɹoɹɹᴉɯ puɐɥ", "sɹoɹɹᴉɯ puɐɥ", "'hand mirror' but upside down"),
        description = ccb.content.text("·ɓuoɹʍ ɓuᴉɥʇǝɯoS  ·ɹoɹɹᴉɯ puɐɥ ʅʅɐɯs Ɐ"),
        looks_like = "mirror",
        price_cents = 15000,
        price_postapoc_cents = 10,
        mass_milligrams = 300000,
        volume_ml = 750,
    }
    item:material("forged_dreamstuff", 1)
    item:clear_use_actions()
    item:teach_spells { "spell_summon_twin" }
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    content.add(item)
end

do
    local item = content.Item {
        id = "artifact_dreamer_clairvoyance_eff",
        looks_like = "family_photo",
        category = "artifacts",
        name = ccb.content.plural_text("family photo", "family photos"),
        description = ccb.content.text("A photo of a smiling family on a camping trip.  The background is always the same, but people are not.  Do you recall them?"),
        mass_milligrams = 1000,
        volume_ml = 5,
        price_cents = 2000,
        price_postapoc_cents = 10,
        symbol = "*",
        color = "light_gray",
    }
    item:material("forged_dreamstuff", 1)
    item:clear_use_actions()
    item:teach_spells { "spell_dreamer_clairvoyance_eff" }
    content.add(item)
end

do
    local item = content.Item {
        id = "artifact_shifter",
        category = "artifacts",
        name = ccb.content.plural_text("sphere", "spheres"),
        description = ccb.content.text("A small, black sphere.  It constantly changes its position.  It even tries to roll out of corners you wedge it into."),
        looks_like = "golf_ball",
        mass_milligrams = 117000,
        volume_ml = 117,
        price_cents = 2000,
        price_postapoc_cents = 10,
        symbol = "0",
        color = "black",
    }
    item:material("forged_dreamstuff", 1)
    item:clear_flags()
    item:flag("SLING_PROJECTILE")
    item:clear_use_actions()
    item:teach_spells { "summon_shifter" }
    content.add(item)
end

do
    local item = content.Item {
        id = "artifact_sapient_light",
        category = "artifacts",
        name = ccb.content.plural_text("flashlight", "flashlights"),
        looks_like = "flashlight",
        description = ccb.content.text("This looks like a typical household flashlight.  It has no battery holder and it hums when you touch it."),
        mass_milligrams = 280000,
        volume_ml = 270,
        longest_side_mm = 140,
        price_cents = 2000,
        price_postapoc_cents = 10,
        symbol = "0",
        color = "black",
    }
    item:material("forged_dreamstuff", 1)
    item:clear_use_actions()
    item:teach_spells { "summon_sapient_light" }
    content.add(item)
end

do
    local item = content.Item {
        id = "artifact_constructed_hammer",
        category = "artifacts",
        name = ccb.content.plural_text("nail", "nails"),
        looks_like = "nail",
        description = ccb.content.text("A pin-shaped piece of iron.  You feel the need to hammer it."),
        mass_milligrams = 4000,
        volume_ml = 2,
        price_cents = 2000,
        price_postapoc_cents = 10,
        symbol = "0",
        color = "black",
    }
    item:material("forged_dreamstuff", 1)
    item:clear_use_actions()
    item:teach_spells { "make_constructed_hammer" }
    content.add(item)
end

do
    local item = content.Item {
        id = "artifact_bubble",
        category = "artifacts",
        looks_like = "marble",
        name = ccb.content.plural_text("bubble", "bubbles"),
        description = ccb.content.text("A small, transparent bubble.  It divides itself into two, then four, eight, sixteen, endlessly, before turning back to single bubble and repeating the process."),
        mass_milligrams = 1000,
        volume_ml = 150,
        price_cents = 2000,
        price_postapoc_cents = 10,
        symbol = "0",
        color = "white",
    }
    item:material("forged_dreamstuff", 1)
    item:clear_use_actions()
    item:teach_spells { "summon_duplicator" }
    content.add(item)
end

do
    local item = content.Item {
        id = "artifact_amber",
        category = "artifacts",
        name = ccb.content.plural_text("shard of amber", "shards of amber"),
        description = ccb.content.text("A small shard of amber.  Looking carefully, you think you see some manner of creature trapped within."),
        mass_milligrams = 1000,
        volume_ml = 150,
        price_cents = 2000,
        price_postapoc_cents = 10,
        symbol = "0",
        color = "red",
    }
    item:material("forged_dreamstuff", 1)
    item:clear_use_actions()
    item:teach_spells { "xedra_dreamer_time_bubble" }
    content.add(item)
end

do
    local item = content.Item {
        id = "artifact_ophanim",
        category = "artifacts",
        looks_like = "toy_figurine",
        name = ccb.content.plural_text("angel figurine", "angel figurines"),
        description = ccb.content.text("A delicate figurine of a renaissance angel.  It looks oddly human."),
        mass_milligrams = 45000,
        volume_ml = 90,
        price_cents = 2000,
        price_postapoc_cents = 10,
        symbol = "0",
        color = "black",
    }
    item:material("forged_dreamstuff", 1)
    item:clear_use_actions()
    item:teach_spells { "summon_ophanim" }
    content.add(item)
end

do
    local item = content.Item {
        id = "artifact_winch",
        category = "artifacts",
        looks_like = "toy_figurine",
        name = ccb.content.plural_text("action figurine", "action figurines"),
        description = ccb.content.text("A small action figurine of a man with an old computer.  It appears he is attempting to hack it."),
        mass_milligrams = 90000,
        volume_ml = 190,
        price_cents = 2000,
        price_postapoc_cents = 10,
        symbol = "0",
        color = "black",
    }
    item:material("forged_dreamstuff", 1)
    item:clear_use_actions()
    item:teach_spells { "summon_winch" }
    content.add(item)
end

do
    local item = content.Item {
        id = "artifact_ethereal_wings",
        category = "artifacts",
        looks_like = "marble",
        name = ccb.content.plural_text("stone feather", "stone feathers"),
        description = ccb.content.text("You see an incredibly detailed stone feather, almost lifelike in appearance."),
        mass_milligrams = 90000,
        volume_ml = 190,
        price_cents = 2000,
        price_postapoc_cents = 10,
        symbol = "o",
        color = "cyan",
    }
    item:material("forged_dreamstuff", 1)
    item:clear_use_actions()
    item:teach_spells { "spell_ethereal_wings" }
    content.add(item)
end

do
    local item = content.Item {
        id = "artifact_dreamer_accelerated_time",
        category = "artifacts",
        name = ccb.content.plural_text("monochrome arrow", "monochrome arrows"),
        description = ccb.content.text("You see a blocky arrow, unerringly pointed in some far off direction.  It is completely colorless."),
        mass_milligrams = 90000,
        volume_ml = 190,
        price_cents = 2000,
        price_postapoc_cents = 10,
        symbol = "o",
        color = "cyan",
    }
    item:material("forged_dreamstuff", 1)
    item:clear_use_actions()
    item:teach_spells { "xedra_dreamer_generate_accelerated_time" }
    content.add(item)
end

do
    local item = content.Item {
        id = "artifact_karma_arms",
        category = "artifacts",
        looks_like = "marble",
        name = ccb.content.plural_text("odd circle", "odd circles"),
        description = ccb.content.text("A circular unit of energy, surrounded by a few other circles that almost connect around the center."),
        mass_milligrams = 90000,
        volume_ml = 190,
        price_cents = 2000,
        price_postapoc_cents = 10,
        symbol = "o",
        color = "cyan",
    }
    item:material("forged_dreamstuff", 1)
    item:clear_use_actions()
    item:teach_spells { "spell_karma_arms" }
    content.add(item)
end

do
    local item = content.Item {
        id = "artifact_stalker_eyes",
        category = "artifacts",
        name = ccb.content.plural_text("presence", "presences"),
        description = ccb.content.text("You feel like something took a glance at this place, and it was so menacing that the world itself curled up."),
        mass_milligrams = 1000,
        volume_ml = 1,
        symbol = "o",
        color = "white",
    }
    item:material("forged_dreamstuff", 1)
    item:clear_use_actions()
    item:teach_spells { "spell_stalker_eyes" }
    content.add(item)
end

do
    local item = content.Item {
        id = "artifact_devil_tail",
        category = "artifacts",
        name = ccb.content.plural_text("lizard tail", "lizard tails"),
        looks_like = "fur_cat_tail",
        description = ccb.content.text("A small lizard tail that was ripped off.  Looks like someone's joke."),
        mass_milligrams = 3000,
        volume_ml = 3,
        symbol = "~",
        color = "green",
    }
    item:material("forged_dreamstuff", 1)
    item:clear_use_actions()
    item:teach_spells { "spell_devil_tail" }
    content.add(item)
end
