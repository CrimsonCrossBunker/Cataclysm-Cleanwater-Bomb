local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "deck_of_tarot_cards_xe",
        category = "artifacts",
        looks_like = "deck_of_cards",
        name = ccb.content.plural_text("deck of esoteric tarot cards", "decks of esoteric tarot cards"),
        description = ccb.content.text("A deck of intricately designed tarot cards.  When you lay out your future they seem to be trying to tell you to take a leap of faith."),
        mass_milligrams = 50000,
        volume_ml = 50,
        price_cents = 2000,
        price_postapoc_cents = 10,
        symbol = ",",
        color = "brown",
    }
    item:material("forged_dreamstuff", 1)
    item:clear_use_actions()
    item:teach_spells { "spring_heeled_leap" }
    content.add(item)
end

do
    local item = content.Item {
        id = "occult_seal",
        category = "artifacts",
        name = ccb.content.plural_text("occult seal", "occult seals"),
        description = ccb.content.text("An intricate occult seal.  When you glance at the bottom left corner you hear the sound of the ocean and smell the salty air of the sea, and sense a river flowing through each point of the seal."),
        mass_milligrams = 50000,
        volume_ml = 50,
        price_cents = 2000,
        price_postapoc_cents = 10,
        symbol = "%",
        color = "dark_gray",
    }
    item:material("forged_dreamstuff", 1)
    item:clear_use_actions()
    item:teach_spells { "banish_nether_monsters" }
    content.add(item)
end

do
    local item = content.Item {
        id = "hurricane_lamp_thorns",
        category = "artifacts",
        looks_like = "oil_lamp",
        name = ccb.content.plural_text("hurricane lamp with thorns", "hurricane lamps with thorns"),
        description = ccb.content.text("An old style hurricane lamp.  The handle appears to made of vines covered in sharp thorns."),
        mass_milligrams = 50000,
        volume_ml = 50,
        price_cents = 2000,
        price_postapoc_cents = 10,
        symbol = "a",
        color = "green",
    }
    item:material("forged_dreamstuff", 1)
    item:clear_use_actions()
    item:teach_spells { "banish_dark_monsters" }
    content.add(item)
end

do
    local item = content.Item {
        id = "glass_berries",
        category = "artifacts",
        looks_like = "marble",
        name = ccb.content.plural_text("box of glass berries", "boxes of glass berries"),
        description = ccb.content.text("A box full of glass berries, when you get distracted you find yourself crunching them in your mouth.  Each one tastes like a mouthful of blood that slowly changes to espresso."),
        mass_milligrams = 50000,
        volume_ml = 50,
        price_cents = 2000,
        price_postapoc_cents = 10,
        symbol = "o",
        color = "light_cyan",
    }
    item:material("forged_dreamstuff", 1)
    item:clear_use_actions()
    item:teach_spells { "blood_boil" }
    content.add(item)
end

do
    local item = content.Item {
        id = "polaroid_of_missing_person",
        category = "artifacts",
        looks_like = "polaroid_photo",
        name = ccb.content.plural_text("polaroid of a missing person", "polaroids of a missing person"),
        description = ccb.content.text("A polaroid of someone you remember going missing before the Cataclysm.  It caught a ton of media attention due to them being seen near what was shortly after identified as a thin place between dimensions.  The more you stare at the picture, the more you begin to see wounds appear and disappear on the person.  Sometimes they match your old scars."),
        mass_milligrams = 50000,
        volume_ml = 50,
        price_cents = 2000,
        price_postapoc_cents = 10,
        symbol = "O",
        color = "white_magenta",
    }
    item:material("forged_dreamstuff", 1)
    item:clear_use_actions()
    item:teach_spells { "self_healing" }
    content.add(item)
end

do
    local item = content.Item {
        id = "strange_coffee",
        category = "artifacts",
        looks_like = "ceramic_mug",
        name = ccb.content.plural_text("strange cup of coffee", "strange cups of coffee"),
        description = ccb.content.text("A small jar with coffee, moving in weird patterns with no apparent cause.  After watching the swirls for some time, you are sure that it loops back on its movements, like some sort of message."),
        mass_milligrams = 90000,
        volume_ml = 100,
        price_cents = 2000,
        price_postapoc_cents = 10,
        symbol = "C",
        color = "white_magenta",
    }
    item:material("forged_dreamstuff", 1)
    item:clear_use_actions()
    item:teach_spells { "supercoffee" }
    content.add(item)
end

do
    local item = content.Item {
        id = "artifact_heart",
        category = "artifacts",
        looks_like = "jabberwock_heart",
        name = ccb.content.plural_text("mother of pearl heart", "mother of pearl hearts"),
        description = ccb.content.text("A human heart grown in mother of pearl.  It beats loudly when you raise it to your ear."),
        mass_milligrams = 310000,
        volume_ml = 345,
        longest_side_mm = 150,
        price_cents = 1000,
        price_postapoc_cents = 10,
        symbol = "o",
        color = "red",
    }
    item:material("forged_dreamstuff", 1)
    item:clear_use_actions()
    item:teach_spells { "spell_stamina_wonder" }
    content.add(item)
end

do
    local item = content.Item {
        id = "artifact_eye_right",
        category = "artifacts",
        looks_like = "petrified_eye",
        name = ccb.content.plural_text("right eye", "right eyes"),
        description = ccb.content.text("A tiny human eye.  You can clearly see the green iris and red capillaries.  While holding it in the dark you feel it watching you."),
        mass_milligrams = 9000,
        volume_ml = 12,
        price_cents = 1000,
        price_postapoc_cents = 10,
        symbol = "o",
        color = "green",
    }
    item:material("forged_dreamstuff", 1)
    item:clear_use_actions()
    item:teach_spells { "spell_night_vision" }
    content.add(item)
end

do
    local item = content.Item {
        id = "artifact_cerebellum",
        category = "artifacts",
        looks_like = "human_brain",
        name = ccb.content.plural_text("cerebellum", "cerebellums"),
        description = ccb.content.text("A small, smooth part of the human brain.  Looks slippery.  Feels like rubber."),
        mass_milligrams = 131000,
        volume_ml = 126,
        price_cents = 1000,
        price_postapoc_cents = 10,
        symbol = "o",
        color = "red",
    }
    item:material("forged_dreamstuff", 1)
    item:clear_use_actions()
    item:teach_spells { "spell_dodge" }
    content.add(item)
end

do
    local item = content.Item {
        id = "artifact_skull",
        category = "artifacts",
        looks_like = "skull_human",
        name = ccb.content.plural_text("skull", "skulls"),
        description = ccb.content.text("A tiny human skull.  His empty orbits are watching you."),
        mass_milligrams = 1133000,
        volume_ml = 1386,
        price_cents = 1000,
        price_postapoc_cents = 10,
        symbol = "@",
        color = "red",
    }
    item:material("forged_dreamstuff", 1)
    item:clear_use_actions()
    item:teach_spells { "spell_endurance" }
    content.add(item)
end

do
    local item = content.Item {
        id = "artifact_eye_left",
        category = "artifacts",
        looks_like = "petrified_eye",
        name = ccb.content.plural_text("left eye", "left eyes"),
        description = ccb.content.text("A tiny human eye.  You can clearly see it has a blue iris and red capillaries.  You feel it can see you no matter how you hide."),
        mass_milligrams = 9000,
        volume_ml = 12,
        price_cents = 1000,
        price_postapoc_cents = 10,
        symbol = "o",
        color = "white",
    }
    item:material("forged_dreamstuff", 1)
    item:clear_use_actions()
    item:teach_spells { "spell_clairvoyance" }
    content.add(item)
end

do
    local item = content.Item {
        id = "artifact_horn",
        category = "artifacts",
        name = ccb.content.plural_text("horn", "horns"),
        looks_like = "bone",
        description = ccb.content.text("A large, straight horn of some unknown creature.  It could easily injure a careless person."),
        mass_milligrams = 239000,
        volume_ml = 315,
        longest_side_mm = 330,
        price_cents = 1000,
        price_postapoc_cents = 10,
        melee_to_hit = -5,
        techniques = { "RAPID" },
        weapon_categories = { "KNIVES" },
        symbol = "l",
        color = "red",
    }
    item:clear_flags()
    item:material("forged_dreamstuff", 1)
    item:clear_use_actions()
    item:teach_spells { "spell_spear" }
    item:clear_melee_damage()
    item:melee_damage("stab", 12)
    content.add(item)
end

do
    local item = content.Item {
        id = "artifact_muscle",
        category = "artifacts",
        looks_like = "arm",
        name = ccb.content.plural_text("muscles", "muscles"),
        description = ccb.content.text("A long fleshy tendon with joints on both sides.  They contract from time to time."),
        mass_milligrams = 9000,
        volume_ml = 12,
        price_cents = 1000,
        price_postapoc_cents = 10,
        symbol = "0",
        color = "red",
    }
    item:material("forged_dreamstuff", 1)
    item:clear_use_actions()
    item:teach_spells { "spell_speed_wonder" }
    content.add(item)
end

do
    local item = content.Item {
        id = "artifact_weakening",
        category = "artifacts",
        name = ccb.content.plural_text("pile of pain", "pile of pains"),
        description = ccb.content.text("There is nothing here.  It's uncomfortable to hold it."),
        mass_milligrams = 1000,
        volume_ml = 66,
        price_cents = 1000,
        price_postapoc_cents = 10,
        symbol = "0",
        color = "red",
    }
    item:material("forged_dreamstuff", 1)
    item:clear_use_actions()
    item:teach_spells { "spell_weak" }
    content.add(item)
end

do
    -- unstoppable and immovable
    local item = content.Item {
        id = "artifact_unbreakable",
        category = "artifacts",
        name = ccb.content.plural_text("pair of spheres", "pairs of spheres"),
        looks_like = "marble",
        description = ccb.content.text("Two perfect spheres.  The first does not move at all, and the second constantly rotates around.  You feel a connection to both of them."),
        mass_milligrams = 240000,
        volume_ml = 1150,
        price_cents = 1000,
        price_postapoc_cents = 10,
        symbol = "0",
        color = "dark_gray",
    }
    item:material("forged_dreamstuff", 1)
    item:clear_use_actions()
    item:teach_spells { "spell_unbreakable" }
    content.add(item)
end

do
    local item = content.Item {
        id = "artifact_point_blank",
        category = "artifacts",
        looks_like = "ch_mitten_gaunt",
        name = ccb.content.plural_text("fist", "fists"),
        description = ccb.content.text("A solid, full size cast of a human fist, made out of some gray metal.  Looks menacing."),
        mass_milligrams = 560000,
        volume_ml = 280,
        price_cents = 1000,
        price_postapoc_cents = 10,
        symbol = "0",
        color = "dark_gray",
    }
    item:material("forged_dreamstuff", 1)
    item:clear_use_actions()
    item:teach_spells { "point_blank" }
    content.add(item)
end

do
    local item = content.Item {
        id = "artifact_anchor",
        category = "artifacts",
        name = ccb.content.plural_text("anchor", "anchors"),
        description = ccb.content.text("A miniature anchor with an earthly sheen.  You feel more stable looking at it."),
        mass_milligrams = 560000,
        volume_ml = 280,
        price_cents = 1000,
        price_postapoc_cents = 10,
        symbol = "0",
        color = "dark_gray",
    }
    item:material("forged_dreamstuff", 1)
    item:clear_use_actions()
    item:teach_spells { "xedra_eater_stabilize_reality" }
    content.add(item)
end

do
    local item = content.Item {
        id = "artifact_sand",
        category = "artifacts",
        name = ccb.content.plural_text("clumped sand", "clumped sands"),
        description = ccb.content.text("A pile of gray sand that is clumped together.  When you separate the pieces they seem to flow back together."),
        mass_milligrams = 100000,
        volume_ml = 100,
        price_cents = 1000,
        price_postapoc_cents = 10,
        symbol = "0",
        color = "dark_gray",
    }
    item:material("forged_dreamstuff", 1)
    item:clear_use_actions()
    item:teach_spells { "xedra_eater_erosion" }
    content.add(item)
end
