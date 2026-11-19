local ccb = require("ccb")

ccb.content.define_mutation {
    id = "WEREWOLF_SUMMON_FOG",
    name = ccb.content.text("Hunter's Haze"),
    points = 2,
    description = ccb.content.text("You can cause just enough change in a machine to confuse the rigid requirements of its programming, stunning it."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    spells_learned = { xe_werewolf_summon_fog_spell = 1 },
}

ccb.content.define_mutation {
    id = "WEREWOLF_MOON_ARMOR",
    name = ccb.content.text("Lucent Armor"),
    points = 6,
    description = ccb.content.text("Regeneration and battle rage are potent weapons but sometimes the People need more protection.  You can summon up tangible moonlight that will protect you from the fists, claws, and fangs of your enemies."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    consumes_mana = true,
    active = true,
    activation_setup_only = true,
    cost = 1,
    cooldown = 1,
    activation_message = ccb.content.text("A soft silvery glow springs forth around you."),
    enchantments = { "INLINE_ENCH_WEREWOLF_MOON_ARMOR_0" },
}
