local ccb = require("ccb")

-- Catch-all dummy trait for Magiclysm mutations.
ccb.content.define_mutation {
    id = "HUMAN_MAGIC",
    name = ccb.content.text_without_extraction("Human Magic"),
    points = 0,
    player_display = false,
    dummy = true,
    categories = { "HUMAN" },
    types = { "MANA_ADD", "MANA_MULT", "MANA_REGEN", "MANA_SIPHON" },
    cancels = {
        "FASTREADER", "HOARDER", "LOVES_BOOKS", "SAVANT", "WEAK", "MIRROR_DISPLACEMENT",
        "MANA_CRYST_MANA", "MANA_SEEKER_BOLTS", "MANA_SUBTLE_SPELL", "MANA_SILENT_SPELL", "MANA_LUM",
        "MANA_LUM_FLASH", "MANA_LUM_EXTERNAL", "OVERLY_ACID_GUT", "DRAGON_BREATH_BLACK", "DRAGON_SPELLS",
        "CHIMERIC_BREATH", "SLIME_BREATH",
    },
    description = ccb.content.text_without_extraction("Your body is depressingly mundane."),
}

ccb.content.define_mutation {
    id = "MANA_ADD1",
    name = ccb.content.text("Lesser Mana Efficiency"),
    points = 1,
    description = ccb.content.text("You are able to store a little more mana in your body than usual."),
    cancels = { "MANA_SUB1", "MANA_SUB2", "MANA_SUB3" },
    replacements = { "MANA_ADD2" },
    types = { "MANA_ADD" },
    categories = { "DRAGON_BLACK", "MANATOUCHED", "SPECIES_ELF", "SPECIES_RAVENFOLK" },
    starting_trait = true,
    flags = { "NON_THRESH" },
    enchantments = { "INLINE_ENCH_MANA_ADD1_0" },
}

ccb.content.define_mutation {
    id = "MANA_ADD2",
    name = ccb.content.text("Mana Efficiency"),
    points = 3,
    description = ccb.content.text("You are able to store more mana in your body than usual."),
    cancels = { "MANA_SUB1", "MANA_SUB2", "MANA_SUB3" },
    replacements = { "MANA_ADD3" },
    types = { "MANA_ADD" },
    categories = { "DRAGON_BLACK", "MANATOUCHED", "SPECIES_ELF" },
    starting_trait = true,
    prerequisites = { "MANA_ADD1" },
    flags = { "NON_THRESH" },
    enchantments = { "INLINE_ENCH_MANA_ADD2_0" },
}

ccb.content.define_mutation {
    id = "MANA_ADD3",
    name = ccb.content.text("Greater Mana Efficiency"),
    points = 8,
    description = ccb.content.text("You are able to store a lot more mana in your body than usual."),
    cancels = { "MANA_SUB1", "MANA_SUB2", "MANA_SUB3" },
    types = { "MANA_ADD" },
    categories = { "DRAGON_BLACK", "MANATOUCHED" },
    replacements = { "MANA_ADD_MANATOUCHED" },
    prerequisites = { "MANA_ADD2" },
    flags = { "NON_THRESH" },
    enchantments = { "INLINE_ENCH_MANA_ADD3_0" },
}

ccb.content.define_mutation {
    id = "MANA_SUB1",
    name = ccb.content.text("Lesser Mana Inefficiency"),
    points = -1,
    description = ccb.content.text("You are able to store a little less mana in your body than usual."),
    cancels = { "MANA_ADD1", "MANA_ADD2", "MANA_ADD3" },
    replacements = { "MANA_SUB2" },
    categories = { "SPECIES_DWARF", "SPECIES_GOBLIN" },
    types = { "MANA_ADD" },
    flags = { "NON_THRESH" },
    enchantments = { "INLINE_ENCH_MANA_SUB1_0" },
}

ccb.content.define_mutation {
    id = "MANA_SUB2",
    name = ccb.content.text("Mana Inefficiency"),
    points = -2,
    description = ccb.content.text("You are able to store less mana in your body than usual."),
    cancels = { "MANA_ADD1", "MANA_ADD2", "MANA_ADD3" },
    replacements = { "MANA_SUB3" },
    types = { "MANA_ADD" },
    prerequisites = { "MANA_SUB1" },
    flags = { "NON_THRESH" },
    enchantments = { "INLINE_ENCH_MANA_SUB2_0" },
}

ccb.content.define_mutation {
    id = "MANA_SUB3",
    name = ccb.content.text("Greater Mana Inefficiency"),
    points = -3,
    description = ccb.content.text("You are able to store a lot less mana in your body than usual."),
    cancels = { "MANA_ADD1", "MANA_ADD2", "MANA_ADD3" },
    types = { "MANA_ADD" },
    prerequisites = { "MANA_SUB2" },
    flags = { "NON_THRESH" },
    enchantments = { "INLINE_ENCH_MANA_SUB3_0" },
}

ccb.content.define_mutation {
    id = "MANA_REGEN1",
    name = ccb.content.text("Lesser Mana Regeneration"),
    points = 1,
    description = ccb.content.text("Your natural mana regeneration is slightly faster than normal."),
    cancels = { "BAD_MANA_REGEN1", "BAD_MANA_REGEN2", "BAD_MANA_REGEN3" },
    replacements = { "MANA_REGEN2" },
    types = { "MANA_REGEN" },
    categories = {
        "FISH", "ELFA", "ALPHA", "PLANT", "CEPHALOPOD", "MANATOUCHED", "DRAGON_BLACK", "SPECIES_ELF",
        "SPECIES_LIZARDFOLK",
    },
    starting_trait = true,
    flags = { "NON_THRESH" },
    enchantments = { "INLINE_ENCH_MANA_REGEN1_0" },
}

ccb.content.define_mutation {
    id = "MANA_REGEN2",
    name = ccb.content.text("Mana Regeneration"),
    points = 3,
    description = ccb.content.text("Your natural mana regeneration is faster than normal."),
    prerequisites = { "MANA_REGEN1" },
    cancels = { "BAD_MANA_REGEN1", "BAD_MANA_REGEN2", "BAD_MANA_REGEN3" },
    replacements = { "MANA_REGEN3", "MANA_REGEN_MANATOUCHED" },
    types = { "MANA_REGEN" },
    categories = { "FISH", "ELFA", "PLANT", "MANATOUCHED", "DRAGON_BLACK", "SPECIES_ELF" },
    starting_trait = true,
    flags = { "NON_THRESH" },
    enchantments = { "INLINE_ENCH_MANA_REGEN2_0" },
}

ccb.content.define_mutation {
    id = "MANA_REGEN3",
    name = ccb.content.text("Greater Mana Regeneration"),
    points = 8,
    description = ccb.content.text("Your natural mana regeneration is much faster than normal."),
    prerequisites = { "MANA_REGEN2" },
    cancels = { "BAD_MANA_REGEN1", "BAD_MANA_REGEN2", "BAD_MANA_REGEN3" },
    types = { "MANA_REGEN" },
    threshold_requirements = { "THRESH_PLANT", "THRESH_MANA", "THRESH_DRAGON_BLACK", "THRESH_SPECIES_ELF" },
    categories = { "PLANT", "DRAGON_BLACK", "SPECIES_ELF" },
    flags = { "NON_THRESH" },
    enchantments = { "INLINE_ENCH_MANA_REGEN3_0" },
}

ccb.content.define_mutation {
    id = "BAD_MANA_REGEN1",
    name = ccb.content.text("Poor Mana Regeneration"),
    points = -1,
    description = ccb.content.text("Your natural mana regeneration is slightly slower than normal."),
    cancels = { "MANA_REGEN1", "MANA_REGEN2", "MANA_REGEN3" },
    replacements = { "BAD_MANA_REGEN2" },
    types = { "MANA_REGEN" },
    categories = {
        "LIZARD",
        "BEAST",
        "LUPINE",
        "URSINE",
        "CATTLE",
        "SLIME",
        "MEDICAL",
        "CHIMERA",
        "SPECIES_GOBLIN",
    },
    starting_trait = true,
    flags = { "NON_THRESH" },
    enchantments = { "INLINE_ENCH_BAD_MANA_REGEN1_0" },
}

ccb.content.define_mutation {
    id = "BAD_MANA_REGEN2",
    name = ccb.content.text("Very Poor Mana Regeneration"),
    points = -3,
    description = ccb.content.text("Your natural mana regeneration is slower than normal."),
    prerequisites = { "BAD_MANA_REGEN1" },
    cancels = { "MANA_REGEN1", "MANA_REGEN2", "MANA_REGEN3" },
    replacements = { "BAD_MANA_REGEN3" },
    types = { "MANA_REGEN" },
    categories = { "BEAST", "CATTLE", "SLIME", "MEDICAL", "CHIMERA" },
    flags = { "NON_THRESH" },
    enchantments = { "INLINE_ENCH_BAD_MANA_REGEN2_0" },
}

ccb.content.define_mutation {
    id = "BAD_MANA_REGEN3",
    name = ccb.content.text("Abysmal Mana Regeneration"),
    points = -6,
    description = ccb.content.text("Your natural mana regeneration is much slower than normal."),
    prerequisites = { "BAD_MANA_REGEN2" },
    cancels = { "MANA_REGEN1", "MANA_REGEN2", "MANA_REGEN3" },
    types = { "MANA_REGEN" },
    categories = { "BEAST", "MEDICAL" },
    flags = { "NON_THRESH" },
    enchantments = { "INLINE_ENCH_BAD_MANA_REGEN3_0" },
}

ccb.content.define_mutation {
    id = "MANA_MULT1",
    name = ccb.content.text("Lesser Mana Sensitivity"),
    points = 1,
    description = ccb.content.text("You can sense the mana in your body slightly better than normal, allowing you to tap into more of your reserves."),
    cancels = { "BAD_MANA_MULT1", "BAD_MANA_MULT2", "BAD_MANA_MULT3" },
    replacements = { "MANA_MULT2" },
    types = { "MANA_MULT" },
    categories = {
        "BIRD", "LIZARD", "SLIME", "FELINE", "CATTLE", "URSINE", "PLANT", "CEPHALOPOD", "ALPHA", "ELFA",
        "MANATOUCHED", "DRAGON_BLACK", "SPECIES_ELF", "SPECIES_RAVENFOLK",
    },
    starting_trait = true,
    flags = { "NON_THRESH" },
    enchantments = { "INLINE_ENCH_MANA_MULT1_0" },
}

ccb.content.define_mutation {
    id = "MANA_MULT2",
    name = ccb.content.text("Mana Sensitivity"),
    points = 3,
    description = ccb.content.text("You can sense the mana in your body better than normal, allowing you to tap into more of your reserves."),
    cancels = { "BAD_MANA_MULT1", "BAD_MANA_MULT2", "BAD_MANA_MULT3" },
    replacements = { "MANA_MULT3" },
    types = { "MANA_MULT" },
    categories = {
        "BIRD",
        "SLIME",
        "CATTLE",
        "PLANT",
        "CEPHALOPOD",
        "ELFA",
        "MANATOUCHED",
        "DRAGON_BLACK",
        "SPECIES_ELF",
    },
    prerequisites = { "MANA_MULT1" },
    starting_trait = true,
    flags = { "NON_THRESH" },
    enchantments = { "INLINE_ENCH_MANA_MULT2_0" },
}

ccb.content.define_mutation {
    id = "MANA_MULT3",
    name = ccb.content.text("Greater Mana Sensitivity"),
    points = 8,
    description = ccb.content.text("You can sense the mana in your body much better than normal, allowing you to tap into more of your reserves."),
    cancels = { "BAD_MANA_MULT1", "BAD_MANA_MULT2", "BAD_MANA_MULT3" },
    types = { "MANA_MULT" },
    replacements = { "MANA_MULT_MANATOUCHED" },
    categories = { "SLIME", "CATTLE", "CEPHALOPOD", "MANATOUCHED", "DRAGON_BLACK" },
    prerequisites = { "MANA_MULT2" },
    flags = { "NON_THRESH" },
    enchantments = { "INLINE_ENCH_MANA_MULT3_0" },
}

ccb.content.define_mutation {
    id = "BAD_MANA_MULT1",
    name = ccb.content.text("Poor Mana Sensitivity"),
    points = -1,
    description = ccb.content.text("You have a hard time sensing the mana in your body, making less of your reserves available for use."),
    cancels = { "MANA_MULT1", "MANA_MULT2", "MANA_MULT3" },
    replacements = { "BAD_MANA_MULT2" },
    types = { "MANA_MULT" },
    categories = {
        "BEAST", "FISH", "LUPINE", "INSECT", "TROGLOBITE", "SPIDER", "RAT", "MOUSE", "MEDICAL",
        "CHIMERA", "RAPTOR", "SPECIES_DWARF",
    },
    starting_trait = true,
    flags = { "NON_THRESH" },
    enchantments = { "INLINE_ENCH_BAD_MANA_MULT1_0" },
}

ccb.content.define_mutation {
    id = "BAD_MANA_MULT2",
    name = ccb.content.text("Very Poor Mana Sensitivity"),
    points = -3,
    description = ccb.content.text("You have a hard time sensing the mana in your body, making less of your reserves available for use."),
    cancels = { "MANA_MULT1", "MANA_MULT2", "MANA_MULT3" },
    replacements = { "BAD_MANA_MULT3" },
    types = { "MANA_MULT" },
    categories = { "BEAST", "INSECT", "TROGLOBITE", "MOUSE", "MEDICAL", "CHIMERA", "RAPTOR", "SPECIES_DWARF" },
    prerequisites = { "BAD_MANA_MULT1" },
    flags = { "NON_THRESH" },
    enchantments = { "INLINE_ENCH_BAD_MANA_MULT2_0" },
}

ccb.content.define_mutation {
    id = "BAD_MANA_MULT3",
    name = ccb.content.text("Abysmal Mana Sensitivity"),
    points = -6,
    description = ccb.content.text("You have a hard time sensing the mana in your body, making less of your reserves available for use."),
    cancels = { "MANA_MULT1", "MANA_MULT2", "MANA_MULT3" },
    types = { "MANA_MULT" },
    categories = { "INSECT", "MEDICAL", "CHIMERA" },
    prerequisites = { "BAD_MANA_MULT2" },
    flags = { "NON_THRESH" },
    enchantments = { "INLINE_ENCH_BAD_MANA_MULT3_0" },
}

-- This is a stub mutation that others can expand upon and also solves Magiclysm's thresh test problem for Slime.
ccb.content.define_mutation {
    id = "SLIME_BREATH",
    name = ccb.content.text("Slime Breath"),
    points = 0,
    description = ccb.content.text("Your breath is sticky and slimy somehow.  This won't damage your interactions with people but it's definitely noticeable."),
    categories = { "SLIME" },
}

-- This is a stub mutation that others can expand upon and also solves Magiclysm's thresh test problem for Chimera and Slime.
ccb.content.define_mutation {
    id = "CHIMERIC_BREATH",
    name = ccb.content.text("Chimeric Breath"),
    points = -3,
    description = ccb.content.text("Your breath could metaphorically melt lead.  It's horrible.  It's so bad that it can actually distract from your attempts to intimidate someone."),
    social_modifiers = { lie = -5, persuade = -5, intimidate = -5 },
    categories = { "CHIMERA", "SLIME" },
}

ccb.content.define_mutation {
    id = "DEBUG_spell_mutation",
    name = ccb.content.text("Debug Spell Mutation"),
    points = 20,
    valid = false,
    description = ccb.content.text("Gives all of the debug spells at max level."),
    debug = true,
    spells_learned = { example_template = 10, debug_stamina = 0, debug_hp = 0, debug_bionic = 0, debug_effect = 0 },
}

ccb.content.define_mutation {
    id = "WILDSHAPE:FISH",
    name = ccb.content.text("Wildshape: Fish"),
    points = 0,
    valid = false,
    description = ccb.content.text("You are fish-like.  Just keep swimming!"),
}

ccb.content.define_mutation {
    id = "WILDSHAPE:BEAR",
    name = ccb.content.text("Wildshape: Bear"),
    points = 0,
    valid = false,
    description = ccb.content.text("You are bear-like, granting you raw bestial power in exchange for intelligence."),
}

ccb.content.define_mutation {
    id = "WILDSHAPE:DEER",
    name = ccb.content.text("Wildshape: Deer"),
    points = 0,
    valid = false,
    description = ccb.content.text("You are deer-like, giving you the ability to move quickly and escape danger.  It is hard to use your arms in combat, however."),
    encumbrance = { hand_r = 50, hand_l = 50, arm_r = 50, arm_l = 50 },
}

ccb.content.define_mutation {
    id = "MIRROR_DISPLACEMENT",
    name = ccb.content.text("Mirror Displacement"),
    points = 9,
    description = ccb.content.text("You aren't where you seem to be."),
    starting_trait = false,
    categories = { "CHIMERA" },
    flags = { "UNCANNY_DODGE" },
}

-- This is intended to prevent magical spellcasting.  Psionics don't need mana, so they can be used even as an Empty.
ccb.content.define_mutation {
    id = "MAGIC_EMPTY",
    name = ccb.content.text("Empty"),
    points = -10,
    description = ccb.content.text("You are one of the Empty, the rare few unable to cast even the simplest spells.  Your complete lack of mana prevents you from ever casting any magic, no matter how well you know it.  At least it doesn't prevent the use of magical items and potions."),
    purifiable = false,
    valid = false,
    starting_trait = true,
    types = { "MANA_ADD", "MANA_REGEN", "MANA_MULT" },
    flags = { "NO_SPELLCASTING" },
    enchantments = { "INLINE_ENCH_MAGIC_EMPTY_0" },
}

-- This trait does nothing by itself.  An EOC detects if you're starting the game with this trait and makes you wear a mana-leech shackle if it's the case.  It's not a scenario because of the long list of reasons that could make someone have to wear one.
-- Said EOC removes the trait without a message.  This is why the trait isn't visible.
ccb.content.define_mutation {
    id = "WEARING_MANA_LEECH",
    name = ccb.content.text("Mana-Shackled"),
    points = -10,
    description = ccb.content.text("For a reason or another you are wearing a mana-leech shackle, leaving you constantly empty of mana.  Should you get rid of it you will regain the ability to use your mana, but this is much easier said than done.  You know that these shackles are often used in prisons, so maybe you could find a way to remove it in there?"),
    purifiable = false,
    valid = false,
    starting_trait = true,
    player_display = false,
}

-- NO_I18N
ccb.content.define_mutation {
    id = "MANA_LEECH_EFFECT",
    name = ccb.content.text_without_extraction("Mana-Shackled effect"),
    points = -1,
    description = ccb.content.text_without_extraction("The trait that allows mana-leech shackles to prevent spellcasting.  You're not supposed to see this."),
    flags = { "NO_SPELLCASTING" },
    purifiable = false,
    valid = false,
    starting_trait = false,
    player_display = false,
}

ccb.content.define_mutation {
    id = "IRON_ALLERGY",
    name = ccb.content.text("Iron Intolerance"),
    points = -4,
    description = ccb.content.text("You were born with an allergy to iron and, to a lesser extent, steel.  Wearing or touching anything made of iron or steel will cause you pain and discomfort."),
    starting_trait = true,
}
