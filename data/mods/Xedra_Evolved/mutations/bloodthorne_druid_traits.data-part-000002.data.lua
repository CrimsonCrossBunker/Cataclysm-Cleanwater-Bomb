local ccb = require("ccb")

ccb.content.define_mutation {
    id = "BLOODTHORNE_DRUID_REGAIN_BLOOD",
    name = ccb.content.text("Woodblood Restoration"),
    points = 2,
    description = ccb.content.text("The first principle of defeating the blood-drinkers is to avoid losing your blood.  While standing on natural foliage, you can use this spell to replenish any lost blood."),
    purifiable = false,
    valid = false,
    spells_learned = { bloodthorne_druid_regain_blood_spell = 1 },
}

ccb.content.define_mutation {
    id = "BLOODTHORNE_DRUID_STOP_BLEEDING",
    name = ccb.content.text("Thorn-sealed Wounds"),
    points = 2,
    description = ccb.content.text("When bleeding, your heartvines can pull the wound closed and stop it.  This is painful, but will prevent further bleeding.  If there are any vampires or their servants nearby, the heartvines will also lash out at them as they pull the wound closed."),
    purifiable = false,
    valid = false,
    spells_learned = { bloodthorne_druid_stop_bleeding_spell = 1 },
}

ccb.content.define_mutation {
    id = "BLOODTHORNE_DRUID_PREVENT_VAMPIRISM",
    name = ccb.content.text("Sanguinary Sapshield"),
    points = 2,
    description = ccb.content.text("The most insidious threat the blood-drinkers is that their condition is infectious, and so they convert those who would oppose them into their sympathizers.  Your heartvines will definitively prevent this outcome, but you still must defend yourself against the curse.  While in the wild, you can draw on the wild's power to protect yourself."),
    purifiable = false,
    valid = false,
    spells_learned = { bloodthorne_druid_prevent_vampirism_spell = 1 },
}

ccb.content.define_mutation {
    id = "BLOODTHORNE_DRUID_WHIP_TARGETS_IN_NATURE",
    name = ccb.content.text("Verdant Scourge"),
    points = 2,
    description = ccb.content.text("You can bring the fury of nature to bear on your enemies.  When a target is in thick foliage, you can cause the plants to grow long thorns and pierce them."),
    purifiable = false,
    valid = false,
    spells_learned = { bloodthorne_druid_whip_targets_in_nature_spell = 1 },
}

ccb.content.define_mutation {
    id = "BLOODTHORNE_DRUID_GAIN_STRENGTH_DEXTERITY_BUFF",
    name = ccb.content.text("Verdurous Prowess"),
    points = 2,
    description = ccb.content.text("The forest spirits gain constant power through their connection to the wild, and while the bloodthorne druids do not have that level of connection they can borrow it for a time.  You may increase your strength, dexterity, and hit points.  This bonus is <color_green>increased in the wilderness</color>."),
    purifiable = false,
    valid = false,
    spells_learned = { bloodthorne_druid_gain_strength_dexterity_buff_spell = 1 },
}

ccb.content.define_mutation {
    id = "BLOODTHORNE_DRUID_REDUCED_PAIN_PENALTIES",
    name = ccb.content.text("Balm of Nature"),
    points = 3,
    description = ccb.content.text("Your heartvines frequently cause you pain on their own, to say nothing of the wounds you suffer fighting the vampires, but now it doesn't seem to affect you as much.  Your strength, dexterity, and speed are penalized less by the pain you feel."),
    purifiable = false,
    valid = false,
    enchantments = { "INLINE_ENCH_BLOODTHORNE_DRUID_REDUCED_PAIN_PENALTIES_0" },
}

ccb.content.define_mutation {
    id = "BLOODTHORNE_DRUID_BONUS_MANA_REGEN",
    name = ccb.content.text("In Tune with the Wild"),
    points = 2,
    description = ccb.content.text("Thornwitchery draws its power from the wild places, and while there you grow stronger.  Your mana recovery is increased when in the wilderness away from civilization."),
    purifiable = false,
    valid = false,
    enchantments = { "INLINE_ENCH_BLOODTHORNE_DRUID_BONUS_MANA_REGEN_0" },
}
