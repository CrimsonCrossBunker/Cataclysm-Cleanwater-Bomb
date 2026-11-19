local ccb = require("ccb")

ccb.content.define_mutation {
    id = "BOREAL_MAGE_COLD_AURA",
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Cold Aura"),
    points = 0,
    active = true,
    activation_setup_only = true,
    cost = 2,
    consumes_mana = true,
    cooldown = 5,
    description = ccb.content.text("Your presence is so dangerous you can freeze everything around yourself."),
    activation_message = ccb.content.text("Everything around you is covered in frost!"),
    enchantments = { "INLINE_ENCH_BOREAL_MAGE_COLD_AURA_0" },
    active_flags = { "NO_BODY_HEAT" },
}

ccb.content.define_mutation {
    id = "DUST_REBORN",
    name = ccb.content.text("Split"),
    description = ccb.content.text("Your body and soul were split in half, and part of it were left inside the ley-line, connected with your main body with tiniest, ethereal thread.  In danger situation, you will abandon your main body and turn back into copy, with all knowledge and skills you have."),
    points = 0,
    valid = false,
    purifiable = false,
}

ccb.content.define_mutation {
    id = "FROZEN_PRESSURE_OFF",
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Frozen Pressure"),
    points = 0,
    active = true,
    description = ccb.content.text("Your presence is so dangerous living creatures nearby are smashed.  You are currently suppressing this power."),
    transform = {
        target = "FROZEN_PRESSURE_ON",
        message = ccb.content.text("Living creatures around you are crushed!"),
        active = true,
        moves = 10,
    },
}

ccb.content.define_mutation {
    id = "FROZEN_PRESSURE_ON",
    starting_trait = false,
    purifiable = false,
    valid = false,
    active = true,
    name = ccb.content.text("Frozen Pressure (on)"),
    points = 0,
    description = ccb.content.text("Your presence is so dangerous living creatures nearby are smashed."),
    enchantments = { "INLINE_ENCH_FROZEN_PRESSURE_ON_0" },
    transform = {
        target = "FROZEN_PRESSURE_OFF",
        message = ccb.content.text("You suppress your frozen pressure."),
        active = false,
        moves = 10,
    },
}

ccb.content.define_mutation {
    id = "CLAIRVOYANCE_OFF",
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Rad Senses"),
    points = 0,
    active = true,
    description = ccb.content.text("You can perceive radiation being emitted in your surroundings with sufficient precision to see while totally blind.  You suppress it now."),
    transform = {
        target = "CLAIRVOYANCE_ON",
        message = ccb.content.text("You see everything!"),
        active = true,
        moves = 10,
    },
}

ccb.content.define_mutation {
    id = "CLAIRVOYANCE_ON",
    starting_trait = false,
    purifiable = false,
    valid = false,
    active = true,
    name = ccb.content.text("Rad Senses (on)"),
    points = 0,
    description = ccb.content.text("You can perceive radiation being emitted in your surroundings with sufficient precision to see while totally blind."),
    enchantments = { "INLINE_ENCH_CLAIRVOYANCE_ON_0" },
    transform = {
        target = "CLAIRVOYANCE_OFF",
        message = ccb.content.text("You suppress your rad senses."),
        active = false,
        moves = 10,
    },
}

ccb.content.define_mutation {
    id = "MIND_READ_OFF",
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Mind Reading"),
    points = 0,
    active = true,
    description = ccb.content.text("You can feel the living energy of creatures around you, which allows you to predict their movements or words.  You suppress it now."),
    transform = {
        target = "MIND_READ_ON",
        message = ccb.content.text("You reach out with your powers, seeking nearby living beings."),
        active = true,
        moves = 10,
    },
}

ccb.content.define_mutation {
    id = "MIND_READ_ON",
    starting_trait = false,
    purifiable = false,
    valid = false,
    active = true,
    name = ccb.content.text("Mind Reading (on)"),
    points = 0,
    description = ccb.content.text("You can feel the living energy of creatures around you, which allows you to predict their movements or words."),
    enchantments = { "INLINE_ENCH_MIND_READ_ON_0", "INLINE_ENCH_MIND_READ_ON_1", "INLINE_ENCH_MIND_READ_ON_2" },
    transform = {
        target = "MIND_READ_OFF",
        message = ccb.content.text("You suppress your mind abilities."),
        active = false,
        moves = 10,
    },
}

ccb.content.define_mutation {
    id = "SOUL_PRESSURE_OFF",
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Soul Pressure"),
    points = 0,
    active = true,
    description = ccb.content.text("Your presence is so dangerous you can burn living creatures around you.  You suppress it now."),
    transform = {
        target = "SOUL_PRESSURE_ON",
        message = ccb.content.text("Living creatures around you start to burn!"),
        active = true,
        moves = 10,
    },
}

ccb.content.define_mutation {
    id = "SOUL_PRESSURE_ON",
    starting_trait = false,
    purifiable = false,
    valid = false,
    active = true,
    name = ccb.content.text("Soul Pressure (on)"),
    points = -1,
    description = ccb.content.text("Your presence is so dangerous you can burn living creatures around you."),
    enchantments = { "INLINE_ENCH_SOUL_PRESSURE_ON_0" },
    transform = {
        target = "SOUL_PRESSURE_OFF",
        message = ccb.content.text("You suppress your soul pressure."),
        active = false,
        moves = 10,
    },
}

ccb.content.define_mutation {
    id = "FREEZING_AURA_OFF",
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Freezing Aura"),
    points = 0,
    active = true,
    description = ccb.content.text("Your body emits a large amount of cold energy, which freezes all enemies near you.  You suppress this ability now."),
    transform = {
        target = "FREEZING_AURA_ON",
        message = ccb.content.text("Living creatures around you freezes!"),
        active = true,
        moves = 10,
    },
}

ccb.content.define_mutation {
    id = "FREEZING_AURA_ON",
    starting_trait = false,
    purifiable = false,
    valid = false,
    active = true,
    name = ccb.content.text("Freezing Aura (on)"),
    points = 0,
    description = ccb.content.text("Your body emits a large amount of cold energy, which freezes all enemies near you."),
    enchantments = { "INLINE_ENCH_FREEZING_AURA_ON_0" },
    transform = {
        target = "FREEZING_AURA_OFF",
        message = ccb.content.text("You suppress your freezing aura."),
        active = false,
        moves = 10,
    },
}

ccb.content.define_mutation {
    id = "TOXIC_AURA_OFF",
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Toxic Aura"),
    points = 0,
    active = true,
    description = ccb.content.text("Your body can emit an aura of deadly toxins.  You suppress this ability now."),
    transform = {
        target = "TOXIC_AURA_ON",
        message = ccb.content.text("Living creatures around you are poisoned!"),
        active = true,
        moves = 10,
    },
}

ccb.content.define_mutation {
    id = "TOXIC_AURA_ON",
    starting_trait = false,
    purifiable = false,
    valid = false,
    active = true,
    name = ccb.content.text("Toxic Aura (on)"),
    points = 0,
    description = ccb.content.text("Your body can emit an aura of deadly toxins."),
    enchantments = { "INLINE_ENCH_TOXIC_AURA_ON_0" },
    transform = {
        target = "TOXIC_AURA_OFF",
        message = ccb.content.text("You suppress your toxic aura."),
        active = false,
        moves = 10,
    },
}
