local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_march_lord_winter",
    copy_from = "mon_march_lord",
    speed = 130,
    attacks = {
        { id = "march_lord_sword_winter" },
        {
            spell = { id = "hoary_blast_march_lord", min_level = 5 },
            cooldown = 15,
            casting_message = ccb.content.text("%1$s takes a deep breath and blows out freezing air!"),
            kind = "spell",
        },
        {
            id = "xe_winter_silence_spell",
            spell = { id = "winter_silence_spell_monster" },
            cooldown = 30,
            casting_message = ccb.content.text("Snow forms around %1$s's hand as they gesture towards %3$s."),
            kind = "spell",
        },
    },
    death = { drops = "changeling_lord_winter_death_drops" },
}
