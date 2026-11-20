local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_zombie_magebreaker",
    name = ccb.content.plural_text("magebreaker", "magebreakers"),
    description = ccb.content.text("The air continuously wavers around this zombie's hands and its eyes are a luminous shining blue.  It occasionally gestures at some of the nearby scenery and light warps, like you're looking at it through a kaleidoscope.  You can't tell a difference after it turns to normal, but you still don't want to end up inside it."),
    copy_from = "mon_zombie_thaumic",
    melee_damage = { { type = "nether", amount = 5 } },
    attack_effects = { { id = "effect_thaumic_zombie_magical_disruption", duration = 25, chance = 100 } },
    emissions = { { id = "emit_magic_disjunction", delay = "2 s" } },
    inheritance = {
        add = {
            attacks = {
                {
                    id = "magebreaker_spell_disjunction",
                    spell = { id = "disjunction_monster", min_level = 12 },
                    cooldown = 25,
                    casting_message = ccb.content.text("%1$s raises both of its hands toward %3$s."),
                    kind = "spell",
                    when = "monster_attack_spellcasting_available",
                },
            },
        },
        offset = {
            armor = {
                nether = 500,
                sonic = 500,
                necrotic = 500,
                psionic = 500,
                electric = 500,
                cold = 500,
                heat = 500,
                light = 500,
            },
        },
    },
}
