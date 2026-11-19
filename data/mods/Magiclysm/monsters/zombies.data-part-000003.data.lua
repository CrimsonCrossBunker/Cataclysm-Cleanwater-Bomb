local ccb = require("ccb")

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
