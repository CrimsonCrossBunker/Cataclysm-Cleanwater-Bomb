local ccb = require("ccb")

ccb.content.define_mutation {
    id = "BIOKINETIC",
    name = ccb.content.text("Awakened Biokinetic"),
    points = 0,
    description = ccb.content.text("Mental control over bodily processes."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    cancels = { "PSYCHIC_KNACK" },
    flags = { "ATTUNEMENT" },
    spells_learned = {
        biokin_physical_enhance = 2,
        biokin_overcome_pain = 2,
        classless_toggleable_concentration_end = 1,
        classless_specific_concentration_end = 1,
    },
}

ccb.content.define_mutation {
    id = "CLAIRSENTIENT",
    name = ccb.content.text("Awakened Clairsentient"),
    points = 0,
    description = ccb.content.text("The ability to extend the senses beyond the body."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    cancels = { "PSYCHIC_KNACK" },
    flags = { "ATTUNEMENT" },
    spells_learned = {
        clair_better_senses = 2,
        clair_speed_reading = 2,
        classless_toggleable_concentration_end = 1,
        classless_specific_concentration_end = 1,
    },
}

ccb.content.define_mutation {
    id = "ELECTROKINETIC",
    name = ccb.content.text("Awakened Electrokinetic"),
    points = 0,
    description = ccb.content.text("Mental control of lightning and electricity."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    cancels = { "PSYCHIC_KNACK" },
    spells_learned = {
        electrokinetic_see_electric = 2,
        electrokinetic_shock_touch = 2,
        classless_toggleable_concentration_end = 1,
        classless_specific_concentration_end = 1,
    },
    flags = { "ATTUNEMENT" },
}

ccb.content.define_mutation {
    id = "PHOTOKINETIC",
    name = ccb.content.text("Awakened Photokinetic"),
    points = 0,
    description = ccb.content.text("Mental control of visible light and electromagnetic waves."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    cancels = { "PSYCHIC_KNACK" },
    flags = { "PHOTOKINETIC", "ATTUNEMENT" },
    spells_learned = {
        photokinetic_create_light = 2,
        photokinetic_light_local = 2,
        classless_toggleable_concentration_end = 1,
        classless_specific_concentration_end = 1,
    },
}

ccb.content.define_mutation {
    id = "PYROKINETIC",
    name = ccb.content.text("Awakened Pyrokinetic"),
    points = 0,
    description = ccb.content.text("Mental control of heat and flame."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    cancels = { "PSYCHIC_KNACK" },
    flags = { "ATTUNEMENT" },
    spells_learned = {
        pyrokinetic_intensify_flames = 2,
        pyrokinetic_flash = 2,
        classless_toggleable_concentration_end = 1,
        classless_specific_concentration_end = 1,
    },
}

ccb.content.define_mutation {
    id = "TELEPATH",
    name = ccb.content.text("Awakened Telepath"),
    points = 0,
    description = ccb.content.text("The ability to read thoughts and influence others' minds."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    cancels = { "PSYCHIC_KNACK" },
    flags = { "ATTUNEMENT" },
    spells_learned = {
        telepathic_concentration = 2,
        telepathic_mind_sense = 2,
        classless_toggleable_concentration_end = 1,
        classless_specific_concentration_end = 1,
    },
}

ccb.content.define_mutation {
    id = "TELEKINETIC",
    name = ccb.content.text("Awakened Telekinetic"),
    points = 0,
    description = ccb.content.text("Mental control over the motion of objects and people at a distance."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    cancels = { "PSYCHIC_KNACK" },
    flags = { "ATTUNEMENT" },
    spells_learned = {
        telekinetic_pull = 2,
        telekinetic_push = 2,
        classless_toggleable_concentration_end = 1,
        classless_specific_concentration_end = 1,
    },
}

ccb.content.define_mutation {
    id = "TELEPORTER",
    name = ccb.content.text("Awakened Teleporter"),
    points = 0,
    description = ccb.content.text("The ability to move without crossing the intervening space, as well as some control over space itself."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    cancels = { "PSYCHIC_KNACK" },
    flags = { "ATTUNEMENT" },
    spells_learned = {
        teleport_blink = 2,
        teleport_slow = 2,
        classless_toggleable_concentration_end = 1,
        classless_specific_concentration_end = 1,
    },
}

ccb.content.define_mutation {
    id = "VITAKINETIC",
    name = ccb.content.text("Awakened Vitakinetic"),
    points = 0,
    description = ccb.content.text("Mental control over health and vitality."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    cancels = { "PSYCHIC_KNACK" },
    flags = { "ATTUNEMENT" },
    spells_learned = {
        vita_slow_bleeding = 2,
        vita_health_power = 2,
        classless_toggleable_concentration_end = 1,
        classless_specific_concentration_end = 1,
    },
}

ccb.content.define_mutation {
    id = "CANNOT_GAIN_PSIONICS",
    name = ccb.content.text("Headblind"),
    points = -4,
    description = ccb.content.text("You've seen people do some crazy things after the Cataclysm, but you've never managed to figure out how they do it.  You can never learn psionic powers."),
    valid = false,
    player_display = true,
    starting_trait = true,
    purifiable = false,
    cancels = {
        "BIOKINETIC", "CLAIRSENTIENT", "ELECTROKINETIC", "PHOTOKINETIC", "PYROKINETIC", "TELEPATH",
        "TELEKINETIC", "TELEPORTER", "VITAKINETIC", "ALWAYS_GAIN_PSIONICS", "PSYCHIC_KNACK",
    },
}

ccb.content.define_mutation {
    id = "ALWAYS_GAIN_PSIONICS",
    name = ccb.content.text("Latent Psion"),
    points = 3,
    description = ccb.content.text("Before the Cataclysm, you were lucky in some way.  Maybe you never lost your keys, or maybe you always made that last green light before getting home, or maybe you never had to take a sick day in your life.  Now after the Cataclysm, you have the potential for even more power.  Your first attempt to awaken psionic powers will always be successful."),
    valid = false,
    player_display = true,
    starting_trait = true,
    purifiable = false,
    cancels = {
        "BIOKINETIC", "CLAIRSENTIENT", "ELECTROKINETIC", "PHOTOKINETIC", "PYROKINETIC", "TELEPATH",
        "TELEKINETIC", "TELEPORTER", "VITAKINETIC", "CANNOT_GAIN_PSIONICS", "PSYCHIC_KNACK",
    },
}

ccb.content.define_mutation {
    id = "PSYCHIC_KNACK",
    name = ccb.content.text_without_extraction("Psychic Knacks"),
    points = 0,
    description = ccb.content.text_without_extraction("The school trait for knacks.  It shouldn't be visible."),
    valid = false,
    player_display = false,
    starting_trait = false,
    purifiable = false,
    cancels = {
        "BIOKINETIC", "CLAIRSENTIENT", "ELECTROKINETIC", "PHOTOKINETIC", "PYROKINETIC", "TELEPATH",
        "TELEKINETIC", "TELEPORTER", "VITAKINETIC", "ALWAYS_GAIN_PSIONICS", "CANNOT_GAIN_PSIONICS",
    },
    spells_learned = { classless_toggleable_concentration_end = 1, classless_specific_concentration_end = 1 },
}

ccb.content.define_mutation {
    id = "LIMITED_PSIONICS",
    name = ccb.content.text("Limited Awakening"),
    points = -2,
    description = ccb.content.text("You managed to awaken psionic powers, but it was a struggle and you're not sure you'll be able to do it again.  You are subject to the random odds of awakening new powers."),
    valid = false,
    player_display = false,
    starting_trait = true,
    purifiable = false,
    cancels = { "CANNOT_GAIN_PSIONICS", "PSYCHIC_KNACK", "ALWAYS_GAIN_PSIONICS" },
}

ccb.content.define_mutation {
    id = "FIFTH_SUN_PEOPLE",
    name = ccb.content.text("Fifth Sun People"),
    points = 0,
    description = ccb.content.text("You were born in the Ēxcān Tlahtōlōyān, maybe on Tlalticpactli, perhaps even in Anáhuac, or maybe on one of the colony worlds like Demeter or Yathrib or Tài Suì.  You enlisted in the Imperial Navy for your own reasons.  Perhaps you are a scion of the Huey Calpulli following in your ancestors' footsteps, or perhaps you are one of the mācēhualtin seeking the social benefits of a completed tour of military service.  Regardless, now you are here, in the ashes of a dying world, and have to find a way to survive."),
    valid = false,
    purifiable = false,
    flags = { "HERITAGE" },
}

ccb.content.define_mutation {
    id = "MOM_PSYCHIC_VAMPIRE",
    name = ccb.content.text("Psychic Vampire"),
    points = 1,
    description = ccb.content.text("You can drain a bit of vital energy from victims when attacking their minds with telepathy or their bodies with vitakinesis."),
    valid = false,
    starting_trait = true,
    purifiable = false,
}

ccb.content.define_mutation {
    id = "VERDANT_HAND_PROTOCOLS",
    name = ccb.content.text("VERDANT HAND Combat Protocols"),
    points = 2,
    description = ccb.content.text("Who needs weapons?  Thanks to your biokinesis, you deal more melee damage while fighting with your bare hands.  This damage improves as your unarmed skill and biokinetic prowess increase."),
    starting_trait = false,
    valid = false,
    purifiable = false,
    enchantments = { "INLINE_ENCH_VERDANT_HAND_PROTOCOLS_0", "INLINE_ENCH_VERDANT_HAND_PROTOCOLS_1" },
}

ccb.content.define_mutation {
    id = "CONCENTRATION_GOOD",
    name = ccb.content.text("Improved Concentration"),
    points = 2,
    description = ccb.content.text("You can keep your mind on something even if there are plenty of distractions.  The number of psionic powers you can maintain at once is increased by 1."),
    starting_trait = true,
    valid = true,
    categories = { "PLANT", "TROGLOBITE", "ALPHA", "ELFA" },
    cancels = { "CONCENTRATION_BAD" },
}

ccb.content.define_mutation {
    id = "CONCENTRATION_BAD",
    name = ccb.content.text("Easily Distracted"),
    points = -2,
    description = ccb.content.text("Any day now you're going to buckle down and oh hey is that a butterfly?  The number of psionic powers you can maintain at once is reduced by 1."),
    starting_trait = true,
    valid = true,
    categories = { "MOUSE", "LUPINE", "BIRD", "RABBIT", "FELINE", "CHIMERA", "BEAST" },
    cancels = { "CONCENTRATION_GOOD" },
}

ccb.content.define_mutation {
    id = "CONCENTRATION_DEBUG",
    name = ccb.content.text("Debug Concentration"),
    points = 99,
    description = ccb.content.text("You could keep every single bug in the game in mind simultaneously with this one."),
    starting_trait = false,
    valid = false,
    debug = true,
}

ccb.content.define_mutation {
    id = "PSI_EXTENDED_CHANNELING",
    name = ccb.content.text("Extended Channeling"),
    points = 0,
    description = ccb.content.text("You can take more time and care in channeling your powers.  It will take 5x as long to evoke them, but it will be much easier to activate them and you will be less likely to gain Nether Attunement while doing so."),
    active = true,
    activation_setup_only = true,
    valid = false,
    purifiable = false,
    on_activate = "toggle_psi_extended_channeling",
    on_deactivate = "toggle_psi_extended_channeling",
}

ccb.content.define_mutation {
    id = "PSI_EXTENDED_CHANNELING_active",
    name = ccb.content.text_without_extraction("Extended Channeling Active"),
    points = 0,
    description = ccb.content.text_without_extraction("The active trait for Extended Channeling.  It's a bug if you can see it."),
    valid = false,
    player_display = false,
}

ccb.content.define_mutation {
    id = "PSI_TORRENTIAL_CHANNELING",
    name = ccb.content.text("Torrential Channeling"),
    points = 0,
    description = ccb.content.text("You can draw deeply on the Nether, increasing the strength of your powers but making making them harder to initiate and control."),
    active = true,
    activation_setup_only = true,
    valid = false,
    purifiable = false,
    on_activate = "activate_psi_torrential_channeling",
    on_deactivate = "deactivate_psi_torrential_channeling",
}

ccb.content.define_mutation {
    id = "PSI_TORRENTIAL_CHANNELING_active",
    name = ccb.content.text_without_extraction("Torrential Channeling Active"),
    points = 0,
    description = ccb.content.text_without_extraction("The active trait for Torrential Channeling.  It's a bug if you can see it."),
    valid = false,
    player_display = false,
}

ccb.content.define_mutation {
    id = "FIFTH_SUN_CBM_INTERFACE",
    name = ccb.content.text("Tonallichicahualizmeya"),
    points = 0,
    description = ccb.content.text("You have a matrix in your central nervous system that acts as a universal control and installation bus for compact bionic modules."),
    valid = false,
    purifiable = false,
    types = { "Cybernetic" },
    cancels = { "NO_CBM_INSTALLATION" },
}

ccb.content.define_mutation {
    id = "STRONG_LEGS_MOM",
    name = ccb.content.text("Strong Legs"),
    description = ccb.content.text("Your legs have gained muscle mass to propel you across any terrain."),
    types = { "LEGS" },
    points = 1,
    vitamin_cost = 60,
    visibility = 1,
    enchantments = { "INLINE_ENCH_STRONG_LEGS_MOM_0" },
}

ccb.content.define_mutation {
    id = "WEAK_MOM",
    name = ccb.content.text("Weak"),
    enchantments = { "INLINE_ENCH_WEAK_MOM_0" },
    points = -1,
    description = ccb.content.text("Your body is unnaturally weak.  -1 Strength."),
    types = { "STR" },
}

ccb.content.define_mutation {
    id = "WEAK_MOM_2",
    name = ccb.content.text("Very Weak"),
    enchantments = { "INLINE_ENCH_WEAK_MOM_2_0" },
    points = -1,
    description = ccb.content.text("Your body is unnaturally very weak.  -2 Strength."),
    types = { "STR" },
}

ccb.content.define_mutation {
    id = "CLUMSY_MOM",
    name = ccb.content.text("Fumbling"),
    enchantments = { "INLINE_ENCH_CLUMSY_MOM_0" },
    points = -1,
    description = ccb.content.text("Your movements are unnaturally awkward.  -1 Dexterity."),
    types = { "STR" },
}

ccb.content.define_mutation {
    id = "CLUMSY_MOM_2",
    name = ccb.content.text("Weak"),
    enchantments = { "INLINE_ENCH_CLUMSY_MOM_2_0" },
    points = -1,
    description = ccb.content.text("Your  movements are unnaturally very awkward.  -2 Dexterity."),
    types = { "STR" },
}
