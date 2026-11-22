local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_feral_technomancer_enhanced",
    name = "feral high technomancer",
    description = "This feral human has obvious bionic enhancements in what would have been the sign of a powerful technomancer before the Cataclysm.  They move with much more speed and grace than most feral humans you've seen.",
    copy_from = "mon_feral_wizard_default",
    symbol = "@",
    color = "dark_gray",
    dissect = "dissect_mon_feral_high_technomancer",
    death = {
        drops = {
            kind = "collection",
            items = {
                { group = "enchanted_combat_items", probability = 30 },
                { group = "mon_feral_technomancer_death_drops", probability = 100 },
            },
        },
    },
    inheritance = {
        add = {
            attacks = {
                {
                    kind = "spell",
                    id = "feral_high_technomancer_laze",
                    cooldown = 20,
                    spell = { id = "feral_laze", min_level = 5 },
                    casting_message = "%1$s points and fires a beam of light!",
                    when = "w16b_mon_when_magiclysm_140d572c6655",
                },
                {
                    kind = "spell",
                    id = "feral_technomancer_bless",
                    cooldown = 20,
                    spell = { id = "feral_technomancer_bless_spell", min_level = 2, hit_self = true },
                    casting_message = "%1$s mutters some words and their body is limned in light.",
                    when = "w16b_mon_when_magiclysm_9fe5f25f3a2f",
                },
                {
                    kind = "spell",
                    id = "feral_high_technomancer_invisibility",
                    cooldown = 20,
                    spell = { id = "feral_invisibility", min_level = 2, hit_self = true },
                    casting_message = "%1$s makes a gesture and disappears.",
                    when = "w16b_mon_when_magiclysm_a1b4a552975d",
                },
                {
                    kind = "spell",
                    id = "feral_high_technomancer_summon_blade",
                    cooldown = 65,
                    spell = { id = "feral_animated_blade", min_level = 10 },
                    casting_message = "%1$s gestures and swords appear out of thin air!",
                    when = "w16b_mon_when_magiclysm_d703c72ddb40",
                },
                {
                    kind = "spell",
                    id = "feral_high_technomancer_synaptic_stim",
                    cooldown = 40,
                    spell = { id = "feral_synaptic_stimulation", min_level = 4, hit_self = true },
                    casting_message = "%1$s mutters some words and begins moving much faster.",
                    when = "w16b_mon_when_magiclysm_73a01ef3ac0e",
                },
            },
        },
    },
}
