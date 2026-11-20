local ccb = require("ccb")

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
