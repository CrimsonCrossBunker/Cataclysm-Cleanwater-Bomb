local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_zombie_thaumic",
    name = "thaumic zombie",
    description = "A human body, swaying as it moves, an unstoppable rage visible in its oily black eyes.  Faint blue lines are visible beneath parts of its exposed skin, letting off an eldritch glow.",
    copy_from = "mon_zombie_base",
    symbol = "Z",
    color = "cyan",
    luminance = 4,
    upgrade = { half_life = 120, monster_group = "GROUP_ZOMBIE_THAUMIC" },
    attacks = {
        { reference = "PARROT", cooldown = 400 },
        { reference = "PARROT_AT_DANGER", cooldown = 0 },
        { id = "grab", on_hit = "w16b_mon_hit_magiclysm_f48b3c5ac470" },
        { id = "bite_humanoid", cooldown = 5, on_hit = "w16b_mon_hit_magiclysm_4d961aaef11f" },
        {
            kind = "melee",
            id = "thaumic_zombie_drain_hit",
            move_cost = 100,
            dodgeable = true,
            blockable = true,
            cooldown = 0,
            damage = {
                { type = "bash", amount = 6 },
            },
            avatar_hit = "%1$s hits your %2$s!",
            avatar_miss = "%1$s misses you.",
            avatar_no_damage = "%1$s hits your %2$s, but your armor protects you.",
            npc_hit = "%1$s hits <npcname>!",
            npc_miss = "%1$s misses <npcname>.",
            npc_no_damage = "%1$s hits <npcname>, but their armor protects them.",
            when = "w16b_mon_when_magiclysm_90a8f9dfaf08",
            on_hit = "w16b_mon_hit_magiclysm_f48b3c5ac470",
        },
    },
    inheritance = {
        add = {
            armor = { poison = 14, nether = 10, psionic = 14 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_leyspark",
    name = ccb.content.plural_text("leyspark zombie", "leyspark zombies"),
    description = ccb.content.text("This zombie's ley lines are visibly glowing beneath its skin, casting a blue light on its surroundings.  A stronger burst of light, almost blinding, occasionally flashes from one of the ley lines."),
    copy_from = "mon_zombie_thaumic",
    melee_damage = { { type = "nether", amount = 5 } },
    emissions = { { id = "emit_glimmer_thaumic", delay = "10 s" } },
    attacks = {
        { reference = "PARROT", cooldown = 400 },
        { reference = "PARROT_AT_DANGER", cooldown = 0 },
        { id = "grab" },
        { id = "bite_humanoid", cooldown = 5 },
    },
    luminance = 10,
    upgrade = { half_life = 120, monster = "mon_zombie_levinbolt" },
    inheritance = { offset = { armor = { nether = 6 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_levinbolt",
    name = ccb.content.plural_text("levinbolt zombie", "levinbolt zombies"),
    description = ccb.content.text("A strong blue glow surrounds this zombie, frequently letting off bright sparks.  Occasionally, it makes an awkward gesture and a series of magical bolts flash from its fingers into the scenery."),
    copy_from = "mon_zombie_thaumic",
    melee_damage = { { type = "nether", amount = 6 } },
    emissions = { { id = "emit_glimmer_thaumic", delay = "4 s" } },
    attacks = {
        { reference = "PARROT", cooldown = 400 },
        { reference = "PARROT_AT_DANGER", cooldown = 0 },
        { id = "grab" },
        { id = "bite_humanoid", cooldown = 5 },
        {
            id = "levinbolt_zombie_spell_attack",
            spell = { id = "seeker_bolts_levinbolt_spell" },
            cooldown = 20,
            casting_message = ccb.content.text("%1$s flings its arms out and glowing bolts erupt from them."),
            kind = "spell",
            when = "allow_zombie_levinbolt_levinbolt_zombie_spell_attack",
        },
    },
    luminance = 20,
    upgrade = { half_life = 120, monster = "mon_zombie_manastorm" },
    inheritance = { offset = { armor = { nether = 15 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_manastorm",
    name = ccb.content.plural_text("manastorm zombie", "manastorm zombies"),
    description = ccb.content.text("This zombie is barely visible behind the bright blue glow and constantly flashes of light.  When it can be seen, its body is covered in a bright tracery of active ley lines."),
    copy_from = "mon_zombie_thaumic",
    melee_damage = { { type = "nether", amount = 8 } },
    emissions = { { id = "emit_glimmer_thaumic", delay = "1 s" } },
    attacks = {
        { reference = "PARROT", cooldown = 400 },
        { reference = "PARROT_AT_DANGER", cooldown = 0 },
        { id = "grab" },
        { id = "bite_humanoid", cooldown = 5 },
        {
            id = "levinbolt_zombie_spell_attack",
            spell = { id = "seeker_bolts_levinbolt_spell" },
            cooldown = 15,
            casting_message = ccb.content.text("%1$s flings its arms out and glowing bolts erupt from them."),
            kind = "spell",
            when = "allow_zombie_levinbolt_levinbolt_zombie_spell_attack",
        },
        {
            id = "manastorm_zombie_spell_attack",
            spell = { id = "manastorm_zombie_spell" },
            cooldown = 35,
            casting_message = ccb.content.text("%1$s makes a jerky motion and eldritch blue fire explodes from its arm."),
            kind = "spell",
            when = "allow_zombie_levinbolt_levinbolt_zombie_spell_attack",
        },
    },
    luminance = 40,
    inheritance = { offset = { armor = { nether = 25, necrotic = 15 } } },
}

ccb.content.define_monster {
    id = "mon_zombie_queller",
    name = ccb.content.plural_text("zombie queller", "zombie quellers"),
    description = ccb.content.text("This zombie's ley lines are glowing beneath its skin, but very dimly.  They seem to absorb nearby light."),
    copy_from = "mon_zombie_thaumic",
    melee_damage = { { type = "nether", amount = 5 } },
    attack_effects = { { id = "effect_thaumic_zombie_magical_disruption", duration = 5, chance = 100 } },
    luminance = 2,
    upgrade = { half_life = 120, monster = "mon_zombie_disruptor" },
    inheritance = {
        offset = {
            armor = {
                nether = 50,
                sonic = 50,
                necrotic = 50,
                psionic = 50,
                electric = 50,
                cold = 50,
                heat = 50,
                light = 50,
            },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_disruptor",
    name = ccb.content.plural_text("zombie disruptor", "zombie disruptors"),
    description = ccb.content.text("The light seems to grow dim around this zombie's hands, in contrast to the blue glow of its eyes.  Barely-visible blue paths on its visible skin, like traceries of veins, mark the site of its ley lines."),
    copy_from = "mon_zombie_thaumic",
    melee_damage = { { type = "nether", amount = 5 } },
    attack_effects = {
        { id = "effect_thaumic_zombie_magical_disruption", duration = 12, chance = 100 },
        { id = "effect_dispel_magic", duration = 2, chance = 75 },
    },
    upgrade = { half_life = 120, monster = "mon_zombie_magebreaker" },
    inheritance = {
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
