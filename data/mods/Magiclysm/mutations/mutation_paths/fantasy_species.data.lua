local ccb = require("ccb")

ccb.content.define_mutation_type {
    id = "HERITAGE",
}

ccb.content.define_mutation {
    id = "HUMAN_BUILD",
    name = ccb.content.text("Human"),
    types = { "HERITAGE" },
    purifiable = false,
    mixed_effect = false,
    points = 1,
    visibility = 2,
    description = ccb.content.text("Elves might say you are short-lived, and goblins might say you are strong, but the one thing humans really are is tenacious.  Hopefully that will serve you well after the Cataclysm."),
    empathize_with = { "GOBLIN", "RAVENFOLK", "LIZARDFOLK", "ELF", "DWARF", "HUMAN" },
    flags = { "HERITAGE" },
}

ccb.content.define_mutation {
    id = "THRESH_SPECIES_DWARF",
    name = ccb.content.text("Child of the Stone"),
    points = 1,
    description = ccb.content.text("Trust the humans to make a mess of the world.  Trust a dwarf to rebuild it better than they found it."),
    valid = false,
    purifiable = false,
    threshold = true,
}

ccb.content.define_mutation {
    id = "THRESH_SPECIES_ELF",
    name = ccb.content.text("Firstborn"),
    points = 1,
    description = ccb.content.text("The first elves sprang forth from magic and moonlight before the ancestors of humanity stopped scurrying through the underbrush to avoid the dinosaurs.  You won't let that legacy die with you."),
    valid = false,
    purifiable = false,
    threshold = true,
}

ccb.content.define_mutation {
    id = "THRESH_SPECIES_GOBLIN",
    name = ccb.content.text("Night Stalker"),
    points = 1,
    description = ccb.content.text("Long ago, the others feared your people as hunters in the night.  In this new world, it's time to revive that legacy."),
    valid = false,
    purifiable = false,
    threshold = true,
}

ccb.content.define_mutation {
    id = "THRESH_SPECIES_LIZARDFOLK",
    name = ccb.content.text("Scaled One"),
    points = 1,
    description = ccb.content.text("The old world was nothing like your home swamps, but this new world is something you understand."),
    valid = false,
    purifiable = false,
    threshold = true,
}

ccb.content.define_mutation {
    id = "THRESH_SPECIES_RAVENFOLK",
    name = ccb.content.text("Thought and Memory"),
    points = 1,
    description = ccb.content.text("In the ruins of the old world, you're sure there are plenty of new places to go and new things to find."),
    valid = false,
    purifiable = false,
    threshold = true,
}

-- Slightly better version of STOCKY_TROGLO since dwarves are born this way
ccb.content.define_mutation {
    id = "DWARVEN_BUILD",
    name = ccb.content.text("Dwarf"),
    types = { "HERITAGE" },
    purifiable = false,
    mixed_effect = true,
    points = 1,
    visibility = 3,
    ugliness = 0,
    description = ccb.content.text("Dwarves are smaller than humans, the better to deal with confined spaces underground, but as solid as the mountains (+2 STR, -1 DEX)."),
    categories = { "SPECIES_DWARF" },
    empathize_with = { "GOBLIN", "RAVENFOLK", "LIZARDFOLK", "ELF", "DWARF", "HUMAN" },
    enchantments = { "INLINE_ENCH_DWARVEN_BUILD_0" },
    flags = { "HERITAGE", "SMALL" },
}

ccb.content.define_mutation {
    id = "BORN_ARTISAN",
    name = ccb.content.text("Earthborn Artisan"),
    description = ccb.content.text("Born from the living earth, your people are naturally adept at the manipulation of the physical world.  Your crafting speed is 10% faster, and you can even craft in darkness."),
    points = 3,
    starting_trait = false,
    purifiable = false,
    categories = { "SPECIES_DWARF" },
    enchantments = { "INLINE_ENCH_BORN_ARTISAN_0" },
    flags = { "CRAFT_IN_DARKNESS" },
}

ccb.content.define_mutation {
    id = "DARKSIGHT",
    name = ccb.content.text("Darksight"),
    description = ccb.content.text("Long ages underground or under the night boughs have made your people capable of seeing into the infrared spectrum."),
    points = 5,
    starting_trait = false,
    purifiable = false,
    enchantments = { "THERMAL_VISION_GOOD_PASSIVE" },
    categories = { "SPECIES_DWARF", "SPECIES_GOBLIN" },
}

ccb.content.define_mutation { id = "TOLERANCE", copy_from = "TOLERANCE", add = { categories = { "SPECIES_DWARF" } } }

ccb.content.define_mutation {
    id = "ALCMET",
    copy_from = "ALCMET",
    add = { categories = { "SPECIES_DWARF" }, secondary_prerequisites = { "DWARVEN_BUILD" } },
}

ccb.content.define_mutation {
    id = "TROGLO",
    copy_from = "TROGLO",
    add = { categories = { "SPECIES_DWARF", "SPECIES_GOBLIN" } },
}

ccb.content.define_mutation {
    id = "TROGLO2",
    copy_from = "TROGLO2",
    add = { categories = { "SPECIES_DWARF", "SPECIES_GOBLIN" } },
}

ccb.content.define_mutation {
    id = "THICKSKIN",
    copy_from = "THICKSKIN",
    add = { categories = { "SPECIES_DWARF", "SPECIES_GOBLIN" } },
}

ccb.content.define_mutation {
    id = "TUNNEL_FIGHTER",
    copy_from = "TUNNEL_FIGHTER",
    add = { categories = { "SPECIES_DWARF", "SPECIES_GOBLIN" } },
}

ccb.content.define_mutation { id = "GOURMAND", copy_from = "GOURMAND", add = { categories = { "SPECIES_DWARF" } } }

ccb.content.define_mutation {
    id = "NIGHTVISION",
    copy_from = "NIGHTVISION",
    add = { categories = { "SPECIES_DWARF", "SPECIES_GOBLIN" } },
}

ccb.content.define_mutation {
    id = "NIGHTVISION2",
    copy_from = "NIGHTVISION2",
    add = { categories = { "SPECIES_DWARF", "SPECIES_GOBLIN" } },
}

ccb.content.define_mutation {
    id = "NIGHTVISION3",
    copy_from = "NIGHTVISION3",
    add = { categories = { "SPECIES_DWARF", "SPECIES_GOBLIN" } },
}

ccb.content.define_mutation { id = "SMELLY", copy_from = "SMELLY", add = { categories = { "SPECIES_DWARF" } } }

ccb.content.define_mutation { id = "HIRSUTE", copy_from = "HIRSUTE", add = { categories = { "SPECIES_DWARF" } } }

ccb.content.define_mutation {
    id = "GOODCARDIO",
    copy_from = "GOODCARDIO",
    add = { categories = { "SPECIES_DWARF", "SPECIES_GOBLIN" } },
}

ccb.content.define_mutation { id = "HEAVYSLEEPER", copy_from = "HEAVYSLEEPER", add = { categories = { "SPECIES_DWARF" } } }

ccb.content.define_mutation { id = "HEAVYSLEEPER2", copy_from = "HEAVYSLEEPER2", add = { categories = { "SPECIES_DWARF" } } }

ccb.content.define_mutation {
    id = "INFRESIST",
    copy_from = "INFRESIST",
    add = { categories = { "SPECIES_DWARF", "SPECIES_GOBLIN" } },
}

-- Opposite of Dwarven Build!
ccb.content.define_mutation {
    id = "ELVEN_BUILD",
    name = ccb.content.text("Elf"),
    types = { "HERITAGE" },
    purifiable = false,
    mixed_effect = true,
    points = 1,
    visibility = 3,
    ugliness = 0,
    description = ccb.content.text("Elves are more lithe and frail than humans, but possess an almost otherworldly grace (-1 STR, +2 DEX)."),
    categories = { "SPECIES_ELF" },
    threshold_requirements = { "THRESH_SPECIES_ELF" },
    empathize_with = { "GOBLIN", "RAVENFOLK", "LIZARDFOLK", "ELF", "DWARF", "HUMAN" },
    enchantments = { "INLINE_ENCH_ELVEN_BUILD_0", "INLINE_ENCH_ELVEN_BUILD_1" },
    flags = { "HERITAGE" },
}

ccb.content.define_mutation {
    id = "ELVEN_BEAUTY",
    name = ccb.content.text("Passing Fair"),
    purifiable = false,
    points = 4,
    visibility = 8,
    ugliness = -8,
    description = ccb.content.text("The elves are often called the \"Fair Folk\" due to their preternatural beauty, and you are no exception to this custom."),
    types = { "ATTRACTIVENESS" },
    categories = { "SPECIES_ELF" },
    threshold_requirements = { "THRESH_SPECIES_ELF" },
}

ccb.content.define_mutation {
    id = "ELVEN_SIGHT",
    name = ccb.content.text("Elvensight"),
    points = 2,
    description = ccb.content.text("Like a cat, elven eyes are well-attuned to low levels of light, able to pick up even the slightest glimmer.  You have greatly-enhanced night vision.  However, you have no additional vision while in complete darkness."),
    types = { "EYES" },
    categories = { "SPECIES_ELF" },
    enchantments = {
        "INLINE_ENCH_ELVEN_SIGHT_0", "INLINE_ENCH_ELVEN_SIGHT_1", "INLINE_ENCH_ELVEN_SIGHT_2",
        "INLINE_ENCH_ELVEN_SIGHT_3",
    },
}

ccb.content.define_mutation {
    id = "ELVEN_HEARING",
    name = ccb.content.text("Elven Hearing"),
    purifiable = false,
    points = 2,
    description = ccb.content.text("Your delicate pointed ears allow you to hear all the sounds of the world."),
    types = { "HEARING" },
    categories = { "SPECIES_ELF" },
    flags = { "SAFECRACK_NO_TOOL" },
    enchantments = { "INLINE_ENCH_ELVEN_HEARING_0" },
}

ccb.content.define_mutation {
    id = "ELVEN_SLEEP",
    name = ccb.content.text("Reverie"),
    points = 4,
    description = ccb.content.text("Rather than sleep insensate like humans do, you blend living night and dreams into a harmonious whole.  You are not bothered by light levels, and need much less sleep per night."),
    purifiable = false,
    types = { "SLEEP" },
    categories = { "SPECIES_ELF" },
    flags = { "SEESLEEP" },
    enchantments = { "INLINE_ENCH_ELVEN_SLEEP_0" },
}

-- terrains below copied from the druid caster level boost.
ccb.content.define_mutation {
    id = "WILDWALKER",
    name = ccb.content.text("Natural Stride"),
    purifiable = false,
    points = 3,
    description = ccb.content.text("The elves were born of nature and the elements, and long ages under the trees allow them to quickly pass through their forest homes."),
    categories = { "SPECIES_ELF" },
    enchantments = { "INLINE_ENCH_WILDWALKER_0" },
}

ccb.content.define_mutation {
    id = "ELVEN_NEED_FOR_WILDERNESS",
    name = ccb.content.text("The Longing"),
    points = -4,
    description = ccb.content.text("Elves are tied to the wilderness in a literal sense, and being away from the wilds too long makes them weak and frail.  Spending too long underground, indoors, or in the remnants of the cities will reduce your health stat; spending time in the wilderness will restore it.  Being indoors in magically-created natural buildings or in public parks can hold the Longing at bay, but it is no substitute for the wilderness."),
    purifiable = false,
    categories = { "SPECIES_ELF" },
    enchantments = {
        "INLINE_ENCH_ELVEN_NEED_FOR_WILDERNESS_0", "INLINE_ENCH_ELVEN_NEED_FOR_WILDERNESS_1",
        "INLINE_ENCH_ELVEN_NEED_FOR_WILDERNESS_2",
    },
}

ccb.content.define_mutation { id = "LIGHTEATER", copy_from = "LIGHTEATER", add = { categories = { "SPECIES_ELF" } } }

ccb.content.define_mutation { id = "QUICK", copy_from = "QUICK", add = { categories = { "SPECIES_ELF" } } }

ccb.content.define_mutation { id = "DEFT", copy_from = "DEFT", add = { categories = { "SPECIES_ELF" } } }

ccb.content.define_mutation { id = "ANIMALEMPATH", copy_from = "ANIMALEMPATH", add = { categories = { "SPECIES_ELF" } } }

ccb.content.define_mutation { id = "ANIMALEMPATH2", copy_from = "ANIMALEMPATH2", add = { categories = { "SPECIES_ELF" } } }

ccb.content.define_mutation { id = "ANTIJUNK", copy_from = "ANTIJUNK", add = { categories = { "SPECIES_ELF" } } }

ccb.content.define_mutation {
    id = "DEX_UP",
    copy_from = "DEX_UP",
    add = { categories = { "SPECIES_ELF", "SPECIES_LIZARDFOLK", "SPECIES_RAVENFOLK" } },
}

ccb.content.define_mutation {
    id = "DEX_UP_2",
    copy_from = "DEX_UP_2",
    add = { categories = { "SPECIES_ELF", "SPECIES_RAVENFOLK" } },
}

ccb.content.define_mutation {
    id = "PER_UP",
    copy_from = "PER_UP",
    add = { categories = { "SPECIES_ELF", "SPECIES_LIZARDFOLK", "SPECIES_RAVENFOLK" } },
}

ccb.content.define_mutation { id = "FLIMSY", copy_from = "FLIMSY", add = { categories = { "SPECIES_ELF" } } }

ccb.content.define_mutation {
    id = "DISRESISTANT",
    copy_from = "DISRESISTANT",
    add = { categories = { "SPECIES_ELF", "SPECIES_DWARF" } },
}

ccb.content.define_mutation { id = "DISIMMUNE", copy_from = "DISIMMUNE", add = { categories = { "SPECIES_ELF" } } }

ccb.content.define_mutation { id = "PICKYEATER", copy_from = "PICKYEATER", add = { categories = { "SPECIES_ELF" } } }

ccb.content.define_mutation { id = "LIGHTSTEP", copy_from = "LIGHTSTEP", add = { categories = { "SPECIES_ELF" } } }

ccb.content.define_mutation {
    id = "GOBLIN_BUILD",
    name = ccb.content.text("Goblin"),
    types = { "HERITAGE" },
    purifiable = false,
    mixed_effect = true,
    points = 1,
    visibility = 8,
    ugliness = 5,
    description = ccb.content.text("Goblins are much smaller than humans, often no more than half the height.  You have a harder time carrying things and can't eat as much, but you're better at dodging and make very little noise when you move."),
    categories = { "SPECIES_GOBLIN" },
    species_anger = { WARG = -90 },
    spells_learned = { goblin_tame_warg_spell = 1 },
    empathize_with = { "GOBLIN", "RAVENFOLK", "LIZARDFOLK", "ELF", "DWARF", "HUMAN" },
    enchantments = { "INLINE_ENCH_GOBLIN_BUILD_0" },
    flags = { "HERITAGE", "TINY" },
}

ccb.content.define_mutation {
    id = "NOCTURNAL",
    name = ccb.content.text("Nocturnal"),
    points = -2,
    ugliness = 0,
    visibility = 0,
    description = ccb.content.text("Your people have always had an easier time operating at night, away from the hated light of the sun."),
    mixed_effect = true,
    valid = false,
    flags = { "MYOPIC_IN_LIGHT_SUPERNATURAL" },
    categories = { "SPECIES_GOBLIN" },
    enchantments = { "INLINE_ENCH_NOCTURNAL_0", "INLINE_ENCH_NOCTURNAL_1" },
}

ccb.content.define_mutation {
    id = "GOBLIN_TEETH",
    valid = false,
    name = ccb.content.text("Goblin Teeth"),
    points = 2,
    visibility = 2,
    ugliness = 2,
    description = ccb.content.text("Your teeth are longer and more pointed than not.  Before the Cataclysm it was considered extremely gauche to bite anything in a fight; it was a mark of the goblins' uncivilized past.  But, needs must."),
    types = { "TEETH" },
    categories = { "SPECIES_GOBLIN" },
    integrated_armor = { "integrated_goblin_teeth" },
}

ccb.content.define_mutation {
    id = "GOBLIN_EYES",
    valid = false,
    name = ccb.content.text("Nocturnal Vision"),
    points = 2,
    visibility = 2,
    ugliness = 1,
    types = { "EYES" },
    description = ccb.content.text("While your reddish eyes have been known to give other people a start, they help you see in the dark.  You have much better night vision than a human, even being able to craft in the dark."),
    categories = { "SPECIES_GOBLIN" },
    enchantments = { "INLINE_ENCH_GOBLIN_EYES_0" },
    flags = { "CRAFT_IN_DARKNESS" },
}

ccb.content.define_mutation { id = "SAPROVORE", copy_from = "SAPROVORE", add = { categories = { "SPECIES_GOBLIN" } } }

ccb.content.define_mutation {
    id = "EATPOISON",
    copy_from = "EATPOISON",
    add = {
        categories = { "SPECIES_GOBLIN" },
        threshold_requirements = { "THRESH_SPECIES_GOBLIN" },
        prerequisites = { "GOBLIN_BUILD" },
    },
}

ccb.content.define_mutation { id = "PADDED_FEET", copy_from = "PADDED_FEET", add = { categories = { "SPECIES_GOBLIN" } } }

ccb.content.define_mutation { id = "ANIMALDISCORD", copy_from = "ANIMALDISCORD", add = { categories = { "SPECIES_GOBLIN" } } }

ccb.content.define_mutation {
    id = "LIZARDFOLK_BUILD",
    name = ccb.content.text("Lizardfolk"),
    types = { "HERITAGE" },
    purifiable = false,
    mixed_effect = true,
    points = 1,
    visibility = 3,
    ugliness = 0,
    description = ccb.content.text("Lizardfolk are taller and stronger than humans but not much thicker and are surprisingly fast for their size (+1 STR, +1 DEX)."),
    categories = { "SPECIES_LIZARDFOLK" },
    empathize_with = { "GOBLIN", "RAVENFOLK", "LIZARDFOLK", "ELF", "DWARF", "HUMAN" },
    enchantments = {
        "INLINE_ENCH_LIZARDFOLK_BUILD_0",
        "INLINE_ENCH_LIZARDFOLK_BUILD_1",
        "INLINE_ENCH_LIZARDFOLK_BUILD_2",
    },
    flags = { "HERITAGE", "LARGE" },
}

-- Alternate so webbed hands are not a prerequisite
ccb.content.define_mutation {
    id = "WEBBED_LIZ_FEET",
    name = ccb.content.text("Lizardfolk Feet"),
    points = 1,
    types = { "FEET" },
    description = ccb.content.text("Your feet are heavily webbed, with three large scaled toes and a dewclaw in the back, allowing you to swim faster.  However, your feet are not designed for human footwear."),
    categories = { "SPECIES_LIZARDFOLK" },
    restricts_gear = { "foot_l", "foot_r" },
    flags = { "WEBBED_FEET", "TOUGH_FEET" },
    wet_protection = { { part = "foot_l", good = 6 }, { part = "foot_r", good = 6 } },
}

ccb.content.define_mutation {
    id = "GILLS",
    copy_from = "GILLS",
    add = {
        categories = { "SPECIES_LIZARDFOLK" },
        threshold_requirements = { "THRESH_SPECIES_LIZARDFOLK" },
    },
}

ccb.content.define_mutation {
    id = "COLDBLOOD4_LIZ",
    flags = { "ECTOTHERM" },
    name = ccb.content.text("Ectothermia"),
    points = -3,
    description = ccb.content.text("Your body has become permanently cold-blooded.  Your speed lowers or raises 1% for every 2 (1.1) degrees below or above 65 F (18.3 C).  All this and you need even more food to maintain your energy."),
    purifiable = false,
    types = { "METABOLISM" },
    categories = { "SPECIES_LIZARDFOLK" },
    enchantments = { "INLINE_ENCH_COLDBLOOD4_LIZ_0" },
}

ccb.content.define_mutation {
    id = "PRED_LIZ",
    name = ccb.content.text("Scalefolk Mindset"),
    description = ccb.content.text("While not completely predatory, the lizardfolk are generally not particularly invested in the welfare of warmbloods.  Their death does not affect you greatly, and your ability to maintain combat skills is enhanced."),
    points = 2,
    purifiable = false,
    categories = { "SPECIES_LIZARDFOLK" },
    types = { "PREDATION" },
    flags = { "PRED2" },
    enchantments = { "INLINE_ENCH_PRED_LIZ_0" },
}

ccb.content.define_mutation {
    id = "CARNIVORE_FAKE",
    copy_from = "CARNIVORE_FAKE",
    add = { categories = { "SPECIES_LIZARDFOLK" } },
}

ccb.content.define_mutation { id = "TAIL_STUB", copy_from = "TAIL_STUB", add = { categories = { "SPECIES_LIZARDFOLK" } } }

ccb.content.define_mutation { id = "TAIL_THICK", copy_from = "TAIL_THICK", add = { categories = { "SPECIES_LIZARDFOLK" } } }

ccb.content.define_mutation { id = "RESISTWARM", copy_from = "RESISTWARM", add = { categories = { "SPECIES_LIZARDFOLK" } } }

ccb.content.define_mutation {
    id = "SNOUT",
    copy_from = "SNOUT",
    add = { categories = { "SPECIES_GOBLIN", "SPECIES_LIZARDFOLK", "SPECIES_RAVENFOLK" } },
}

ccb.content.define_mutation {
    id = "MUZZLE_LONG_LIZ",
    name = ccb.content.text("Lizardfolk Muzzle"),
    points = 0,
    visibility = 8,
    ugliness = 8,
    mixed_effect = true,
    description = ccb.content.text("Your face and jaws are those of a predatory lizard, with a set of sharp teeth to go with them.  They look NASTY--as do the bite wounds they can inflict--but prevent wearing mouthgear."),
    types = { "TEETH" },
    prerequisites = { "SNOUT" },
    restricts_gear = { "mouth" },
    social_modifiers = { intimidate = 10 },
    integrated_armor = { "integrated_lizardfolk_teeth" },
    enchantments = { "INLINE_ENCH_MUZZLE_LONG_LIZ_0" },
}

ccb.content.define_mutation {
    id = "NAILS",
    copy_from = "NAILS",
    add = { categories = { "SPECIES_LIZARDFOLK", "SPECIES_GOBLIN", "SPECIES_RAVENFOLK" } },
}

ccb.content.define_mutation {
    id = "TALONS",
    copy_from = "TALONS",
    add = { categories = { "SPECIES_LIZARDFOLK", "SPECIES_RAVENFOLK" } },
}

ccb.content.define_mutation {
    id = "RAVENFOLK_BUILD",
    name = ccb.content.text("Ravenfolk"),
    types = { "HERITAGE" },
    purifiable = false,
    mixed_effect = true,
    points = 1,
    visibility = 4,
    ugliness = 1,
    description = ccb.content.text("Ravenfolk are about the same size as humans, though their feathers and wings obviously set them apart."),
    categories = { "SPECIES_RAVENFOLK" },
    enchantments = { "INLINE_ENCH_RAVENFOLK_BUILD_0" },
    empathize_with = { "GOBLIN", "RAVENFOLK", "LIZARDFOLK", "ELF", "DWARF", "HUMAN" },
    flags = { "HERITAGE" },
}

ccb.content.define_mutation {
    id = "RAVENFOLK_LEGS",
    copy_from = "BIRD_LEGS",
    name = ccb.content.text("Ravenfolk Legs"),
    description = ccb.content.text("Your legs and feet are those of a raven, with three long talons at the front and one at the back, ending in wicked claws and preventing you from wearing shoes.  Fortunately they don't impede your movement, and you could use them as part of a leaping attack."),
    categories = { "SPECIES_RAVENFOLK" },
    purifiable = false,
    add = { prerequisites = { "RAVEN_BONES" } },
    threshold_requirements = { "THRESH_SPECIES_RAVENFOLK" },
    restricts_gear = { "foot_l", "foot_r" },
    activation_message = "",
    enchantments = { "INLINE_ENCH_RAVENFOLK_LEGS_0" },
}

ccb.content.define_mutation {
    id = "RAVENFOLK_EYES",
    name = ccb.content.text("Ravenfolk Eyes"),
    description = ccb.content.text("Your vision is particularly acute, and you can pick out zombies much farther away.  Perception +2, as well as increased vision and reaction limb scores."),
    categories = { "SPECIES_RAVENFOLK" },
    types = { "EYES" },
    prerequisites = { "PER_UP_3" },
    points = 5,
    vitamin_cost = 210,
    visibility = 1,
    enchantments = { "INLINE_ENCH_RAVENFOLK_EYES_0", "INLINE_ENCH_RAVENFOLK_EYES_1" },
}

ccb.content.define_mutation {
    id = "RAVENFOLK_WINGS",
    name = ccb.content.text("Ravenfolk Wings"),
    points = 0,
    visibility = 6,
    ugliness = 2,
    purifiable = false,
    mixed_effect = true,
    description = ccb.content.text("You have a pair of large raven wings projecting from your shoulderblades.  Your body is too heavy to be able to fly, but if you're not too weighed down, you might be able to glide from a ledge or lessen the impact of a fall."),
    categories = { "SPECIES_RAVENFOLK" },
    types = { "WINGS" },
    strict_threshold_requirements = true,
    restricts_gear = { "torso" },
    allowed_item_flags = { "ALLOWS_WINGS" },
    enchantments = { "INLINE_ENCH_RAVENFOLK_WINGS_0" },
    allow_soft_gear = true,
    active = true,
    activation_setup_only = false,
    activation_message = "",
    on_activate = "activate_ravenfolk_leap",
}

ccb.content.define_mutation {
    id = "BEAK_RAVEN",
    name = ccb.content.text("Raven Beak"),
    points = 0,
    visibility = 10,
    ugliness = 5,
    description = ccb.content.text("Your large beak allows you to imitate nearly every sound humans can make, as well as let out very loud screeches.  And also rip into flesh, if it comes to that."),
    purifiable = false,
    types = { "TEETH", "MUZZLE" },
    cancels = { "MOUTH_TENTACLES" },
    categories = { "SPECIES_RAVENFOLK" },
    wet_protection = { { part = "mouth", ignored = 2 } },
    restricts_gear = { "mouth" },
    destroys_gear = true,
    active = true,
    activation_setup_only = false,
    activation_message = "",
    on_activate = "activate_ravenfolk_screech",
    enchantments = { "INLINE_ENCH_BEAK_RAVEN_0" },
}

ccb.content.define_mutation {
    id = "RAVEN_BONES",
    copy_from = "HOLLOW_BONES",
    description = ccb.content.text("Your bones are nearly hollow, a remnant of your people's past as creatures of the air.  Your body is very light as a result, enabling you to move and attack 20% faster, but also frail; you can carry 40% less, and bashing attacks injure you more."),
    categories = { "SPECIES_RAVENFOLK" },
}

ccb.content.define_mutation { id = "FLEET", copy_from = "FLEET", add = { categories = { "SPECIES_RAVENFOLK" } } }

-- Name just means 'lover of gold' but at least it fits the format of other negative traits
ccb.content.define_mutation {
    id = "LOVES_SHINY_OBJECTS",
    name = ccb.content.text("Chrysophilia"),
    points = -3,
    description = ccb.content.text("You need to have shiny objects on your person or you just can't concentrate very well.  You suffer a morale penalty unless you're wearing at least six items made of gold or silver."),
    purifiable = false,
    categories = { "SPECIES_RAVENFOLK", "DRAGON_BLACK" },
}

ccb.content.define_mutation { id = "SKIN_ROUGH", copy_from = "SKIN_ROUGH", add = { categories = { "SPECIES_RAVENFOLK" } } }

ccb.content.define_mutation {
    id = "RAVEN_FEATHERS",
    name = ccb.content.text("Feathers"),
    description = ccb.content.text("Dark feathers cover your entire body, providing a marginal protection against attacks and minor protection from cold.  They also provide a natural waterproofing."),
    categories = { "SPECIES_RAVENFOLK" },
    types = { "SKIN" },
    prerequisites = { "SKIN_ROUGH" },
    additions = { "DOWN" },
    points = 2,
    vitamin_cost = 160,
    visibility = 10,
    ugliness = 0,
    body_temperature = { 50, 100 },
    integrated_armor = { "integrated_raven_feathers" },
}

ccb.content.define_mutation { id = "NOMAD", copy_from = "NOMAD", add = { categories = { "SPECIES_RAVENFOLK" } } }

ccb.content.define_mutation { id = "EAGLEEYED", copy_from = "EAGLEEYED", add = { categories = { "SPECIES_RAVENFOLK" } } }

ccb.content.define_mutation {
    id = "DOWN",
    copy_from = "DOWN",
    prerequisites = { "FEATHERS", "RAVEN_FEATHERS" },
    add = {
        categories = { "SPECIES_RAVENFOLK" },
        threshold_requirements = { "THRESH_SPECIES_RAVENFOLK" },
    },
}

ccb.content.define_mutation { id = "PER_UP_2", copy_from = "PER_UP_2", add = { categories = { "SPECIES_RAVENFOLK" } } }

ccb.content.define_mutation {
    id = "PER_UP_3",
    copy_from = "PER_UP_3",
    add = {
        categories = { "SPECIES_RAVENFOLK" },
        threshold_requirements = { "THRESH_SPECIES_RAVENFOLK" },
    },
}

ccb.content.define_mutation {
    id = "PER_UP_4",
    copy_from = "PER_UP_4",
    add = {
        categories = { "SPECIES_RAVENFOLK" },
        threshold_requirements = { "THRESH_SPECIES_RAVENFOLK" },
    },
}

ccb.content.define_mutation {
    id = "BIRD_EYE",
    copy_from = "BIRD_EYE",
    add = {
        categories = { "SPECIES_RAVENFOLK" },
        threshold_requirements = { "THRESH_SPECIES_RAVENFOLK" },
    },
}
