local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_feral_human_magician",
    name = ccb.content.plural_text("feral wizard", "feral wizards"),
    copy_from = "mon_feral_wizard_default",
    description = ccb.content.text("Stumbling about with strange ravings and odd motions, this crazed individual walks among the dead as one of their own.  Occasional flashes and sparks erupt from their twisted and grimy fingers as they perform arcane motions."),
    materials = { "flesh" },
    symbol = "@",
    color = "magenta",
    inheritance = {
        add = {
            attacks = {
                {
                    spell = { id = "spell_feral_wizard_base" },
                    casting_message = ccb.content.text("%1$s chants and gestures erratically!"),
                    cooldown = 10,
                    kind = "spell",
                    when = "allow_feral_human_magician_spell",
                },
            },
        },
    },
    death = {
        drops = {
            kind = "distribution",
            items = {
                { group = "enchanted_small_items", probability = 5 },
                { group = "feral_humans_death_drops_pipe", probability = 100 },
                { group = "enchanted_wands_lesser", probability = 3 },
            },
        },
    },
}

ccb.content.define_monster {
    id = "mon_feral_lab_magician",
    copy_from = "mon_feral_wizard_default",
    name = ccb.content.plural_text("feral thaumaturgical researcher", "feral thaumaturgical researchers"),
    description = ccb.content.text("A researcher with the look of the stereotypical academic mage, their lab coat bearing an arcane sigil on the breast pocket.  The bloodshot eyes and constant muttering, accompanied by the occasional gesture that releases a burst of sparks, tell you that research is currently far from their minds."),
    symbol = "@",
    color = "cyan",
    inheritance = {
        add = {
            attacks = {
                {
                    id = "feral_thaum_sci_spell_magicmissile",
                    cooldown = 10,
                    move_cost = 100,
                    range = 12,
                    damage = { { type = "nether", amount = 7 } },
                    dodgeable = false,
                    blockable = false,
                    avatar_hit = ccb.content.text("%1$s screams words of magic and an eldritch bolt impacts your %2$s!"),
                    npc_hit = ccb.content.text("%1$s screams words of magic and an eldritch bolt impacts <npcname>'s %2$s!"),
                    avatar_miss = ccb.content.text("%1$s screams words of magic and you narrowly avoid an eldritch bolt!"),
                    npc_miss = ccb.content.text("%1$s screams words of magic and <npcname> narrowly avoids an eldritch bolt!"),
                    avatar_no_damage = ccb.content.text("%1$s screams words of magic and your %2$s is impacted by an eldritch bolt, but it does no damage."),
                    npc_no_damage = ccb.content.text("%1$s screams words of magic and <npcname>'s %2$s is impacted by an eldritch bolt, but it does no damage."),
                    kind = "melee",
                    when = "allow_feral_human_magician_spell",
                },
                {
                    id = "feral_thaum_sci_spell_blindflash",
                    spell = { id = "blinding_flash", min_level = 0 },
                    cooldown = 15,
                    casting_message = ccb.content.text("%1$s gestures and light explodes everywhere!"),
                    kind = "spell",
                    when = "allow_feral_lab_magician_feral_thaum_sci_spell_blindflash",
                },
                {
                    id = "smash",
                    move_cost = 80,
                    cooldown = 10,
                    accuracy = 5,
                    damage = { { type = "bash", amount = 15, penetration = 10 } },
                    minimum_hit_size = 12,
                    range = 8,
                    throw_strength = 40,
                    blockable = false,
                    avatar_hit = ccb.content.text_without_extraction("%1$s gestures at you and a powerful force hurls you through the air!"),
                    npc_hit = ccb.content.text_without_extraction("%1$s gestures at <npcname> and a powerful force hurls them through the air!"),
                    avatar_miss = ccb.content.text_without_extraction("%s gestures at you, and you feel a crushing pressure for a moment before the feeling vanishes!"),
                    npc_miss = ccb.content.text_without_extraction("%s gestures at <npcname> but nothing happens!"),
                    when = "allow_feral_lab_magician_smash",
                },
            },
        },
    },
    death = { drops = "mon_zombie_research_thaumaturge_death_drops" },
}
