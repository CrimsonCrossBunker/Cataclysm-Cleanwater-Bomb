local ccb = require("ccb")

ccb.content.define_mutation {
    id = "BLOODTHORNE_DRUID_AURA_OF_VINES_TRAIT",
    name = ccb.content.text_without_extraction("Entanglement of Vines"),
    points = 2,
    visibility = 10,
    ugliness = 6,
    description = ccb.content.text_without_extraction("The active trait for Entanglement of Vines.  You shouldn't see this."),
    purifiable = false,
    valid = false,
    player_display = false,
    enchantments = { "INLINE_ENCH_BLOODTHORNE_DRUID_AURA_OF_VINES_TRAIT_0" },
    flags = { "SUBTLE_SPELL", "VINE_RAPPEL" },
}

ccb.content.define_mutation {
    id = "BLOODTHORNE_DRUID_HEAL_FROM_SPILLED_BLOOD",
    name = ccb.content.text("Drinking Crimson Rain"),
    points = 4,
    description = ccb.content.text("Vampires are known for drinking blood, but plants will drink anything that sinks into the soil.  This spell draws all blood spilled onto the earth in the area around you through the roots to be absorbed by your heartvines, healing you."),
    purifiable = false,
    valid = false,
    spells_learned = { bloodthorne_druid_heal_from_spilled_blood_spell = 1 },
}

ccb.content.define_mutation {
    id = "BLOODTHORNE_DRUID_SUMMON_THORNHOUND",
    name = ccb.content.text("Thornhound's Beacon"),
    points = 5,
    description = ccb.content.text("The forest spirits will not answer your call but your heartvine will.  When standing on verdant ground, you may animate a twisted mass of thorns to attack your enemies."),
    purifiable = false,
    valid = false,
    spells_learned = { bloodthorne_druid_summon_thornwight_spell = 1 },
}

ccb.content.define_mutation {
    id = "BLOODTHORNE_DRUID_SLOWER_BLEEDING",
    name = ccb.content.text("Bramble Ichor"),
    points = 3,
    description = ccb.content.text("The sap that flows through your veins has thickened, and your heartvines do their keep to keep it in your body.  You bleed more slowly."),
    purifiable = false,
    valid = false,
    enchantments = { "INLINE_ENCH_BLOODTHORNE_DRUID_SLOWER_BLEEDING_0" },
}

ccb.content.define_mutation {
    id = "BLOODTHORNE_DRUID_CREATE_THORN_PRISON",
    name = ccb.content.text("Henge of Iron Thorns"),
    points = 6,
    description = ccb.content.text("When one of the blood-drinkers or their servants is on verdant ground, you can cause a massive tangle of thorns to grow and imprison them."),
    purifiable = false,
    valid = false,
    spells_learned = { bloodthorne_druid_create_thorn_prison_spell = 1 },
}
