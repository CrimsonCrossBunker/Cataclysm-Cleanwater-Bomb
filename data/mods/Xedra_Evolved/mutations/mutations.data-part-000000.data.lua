local ccb = require("ccb")

ccb.content.define_mutation {
    id = "EGGSAC_SURVIVABLE",
    name = ccb.content.text_without_extraction("Spider egg host"),
    points = 0,
    player_display = false,
    starting_trait = false,
    purifiable = false,
    valid = false,
    description = ccb.content.text_without_extraction("You don't feel very well.  On an existential level."),
}

ccb.content.define_mutation {
    id = "EGGSAC_FATAL",
    name = ccb.content.text_without_extraction("Spider egg host"),
    points = 0,
    player_display = false,
    starting_trait = false,
    purifiable = false,
    valid = false,
    description = ccb.content.text_without_extraction("You don't feel very well.  On an existential level."),
}

ccb.content.define_mutation {
    id = "DREAMLESS",
    name = ccb.content.text("Dreamless"),
    points = -1,
    starting_trait = true,
    valid = false,
    description = ccb.content.text("You live firmly in reality and never experience extremely vivid dreams about choices that have real world consequences.  ( You will be unable to gain Dream magicks from sleeping after strange events)"),
    cancels = { "DREAMER", "DREAMSMITH", "EATER", "INVENTOR" },
}

ccb.content.define_mutation {
    id = "MANIFEST_DESTINY_GOBLIN",
    name = ccb.content.text_without_extraction("Transforming into Goblin"),
    points = 0,
    player_display = false,
    starting_trait = false,
    purifiable = false,
    valid = false,
    description = ccb.content.text_without_extraction("You don't feel very well.  On an existential level."),
}

ccb.content.define_mutation {
    id = "MANIFESTED_DESTINY_GOBLIN",
    name = ccb.content.text("Transformed into Goblin"),
    points = 0,
    starting_trait = false,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You feel like you've left behind your old life and form."),
}

ccb.content.define_mutation {
    id = "MANIFEST_DESTINY_SPIDER",
    name = ccb.content.text_without_extraction("Transforming into Spider"),
    points = 0,
    starting_trait = false,
    purifiable = false,
    valid = false,
    player_display = false,
    description = ccb.content.text_without_extraction("You don't feel very well.  On an existential level."),
}

ccb.content.define_mutation {
    id = "MANIFESTED_DESTINY_SPIDER",
    name = ccb.content.text("Transformed into Spider"),
    points = 0,
    starting_trait = false,
    purifiable = false,
    valid = false,
    description = ccb.content.text("You feel like you've left behind your old life and form."),
}

ccb.content.define_mutation {
    id = "DRUNKEN",
    name = ccb.content.text("Drunken Master"),
    points = 1,
    description = ccb.content.text("The ancient arts of drunken brawling come naturally to you!  While under the influence of alcohol, your melee skill will rise considerably, especially unarmed combat."),
    starting_trait = true,
    valid = false,
    cancels = { "LIGHTWEIGHT" },
    enchantments = { "DRUNKEN_ARMED", "DRUNKEN_UNARMED" },
}

ccb.content.define_mutation {
    id = "KI_STRIKE",
    name = ccb.content.text("Ki Strike"),
    points = 2,
    description = ccb.content.text("Who needs weapons?  You deal more melee damage while fighting barehanded and without gloves.  This damage improves as your unarmed skill increases."),
    starting_trait = true,
    valid = false,
    enchantments = { "KI_STRIKE" },
}

-- For now life extenders such as this one grant MEND_ALL.  When the new wound system will be implemented, their function will be to always allow you to fully heal from your wounds (no scars, etc).
ccb.content.define_mutation {
    id = "EXTEND_LIFE",
    name = ccb.content.text("Extended Life"),
    points = 10,
    description = ccb.content.text("You swallow the potion and feel younger already.  Though the taste lingers long past when you'd hope it would pass."),
    valid = false,
    flags = { "MEND_ALL" },
}

ccb.content.define_mutation {
    id = "NIGHTMARE_CHIMERAS",
    name = ccb.content.text_without_extraction("Haunted by your dreams made flesh"),
    points = 0,
    starting_trait = false,
    purifiable = false,
    valid = false,
    player_display = false,
    description = ccb.content.text_without_extraction("Your dreams can change reality."),
    vitamin_intervals = { dream = -8640000 },
}

ccb.content.define_mutation {
    id = "FRIENDLY_CHIMERAS",
    name = ccb.content.text_without_extraction("Accompanied by your dreams made flesh"),
    points = 0,
    starting_trait = false,
    purifiable = false,
    valid = false,
    player_display = false,
    description = ccb.content.text_without_extraction("Your dreams can change reality."),
    vitamin_intervals = { dream = -8640000 },
}

ccb.content.define_mutation { id = "INFRESIST", copy_from = "INFRESIST", add = { categories = { "LILIN" } } }

ccb.content.define_mutation { id = "INFIMMUNE", copy_from = "INFIMMUNE", add = { categories = { "LILIN" } } }

ccb.content.define_mutation { id = "DEFT", copy_from = "DEFT", add = { categories = { "LILIN" } } }

ccb.content.define_mutation {
    id = "GENERIC_UNCANNY_DODGE_TRAIT",
    name = ccb.content.text_without_extraction("The Trait That Gives you Uncanny Dodge"),
    description = ccb.content.text_without_extraction("The uncanny dodge flag now works in effects, but preserve this trait for conditional logic such as with lilin."),
    points = 1,
    starting_trait = false,
    purifiable = false,
    valid = false,
    player_display = false,
    flags = { "UNCANNY_DODGE" },
}

-- Dhampirs not getting Cannibal is deliberate.  The struggle over their own humanity is a core part of the dhampir theme.
ccb.content.define_mutation {
    id = "DHAMPIR_TRAIT",
    name = ccb.content.text("Dhampir"),
    points = 0,
    description = ccb.content.text("You are a dhampir, the child of a vampire.  You have inherited a portion of their vampiric power, as well as the ability to drink blood.  Hopefully you can keep your urges under control.\n\nAs a dhampir, your blood naturally slowly fills with power over time, which you can use to fuel your abilities."),
    types = { "HERITAGE" },
    starting_trait = false,
    purifiable = false,
    valid = false,
    mixed_effect = true,
    vitamin_intervals = { mutagen = 600, mutagenic_slurry = 1 },
    enchantments = {
        "INLINE_ENCH_DHAMPIR_TRAIT_0", "INLINE_ENCH_DHAMPIR_TRAIT_1", "INLINE_ENCH_DHAMPIR_TRAIT_2",
        "INLINE_ENCH_DHAMPIR_TRAIT_3", "INLINE_ENCH_DHAMPIR_TRAIT_4", "INLINE_ENCH_DHAMPIR_TRAIT_5",
    },
    flags = { "HEMOVORE", "HERITAGE" },
    cancels = { "DREAMER", "DREAMSMITH", "EATER", "INVENTOR" },
}

ccb.content.define_mutation {
    id = "DHAMPIR_DETECT_VAMPIRES",
    name = ccb.content.text("Blood Calls to Blood"),
    points = 1,
    description = ccb.content.text("You can use the connection of your heritage to sense nearby vampires and their minions."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    active = true,
    activation_setup_only = true,
    activation_message = ccb.content.text("You open your senses to the presence of the night-hunters."),
    enchantments = { "INLINE_ENCH_DHAMPIR_DETECT_VAMPIRES_0" },
}
