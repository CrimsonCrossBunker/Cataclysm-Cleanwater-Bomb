local ccb = require("ccb")

-- NO_I18N
ccb.content.define_monster {
    id = "mon_pseudo_dormant_zombie",
    name = ccb.content.plural_text("zombie", "zombies"),
    description = ccb.content.text_without_extraction("Fake zombie used for spawning dormant zombies.  If you see this, open an issue on GitHub."),
    copy_from = "mon_zombie",
    looks_like = "corpse_mon_zombie",
    hp = 5,
    speed = 1,
    flags = { "FILTHY", "REVIVES", "DORMANT", "QUIETDEATH", "NOT_HALLUCINATION" },
    zombify_into = "mon_zombie",
    attacks = {
        {
            id = "pseudo_dormant_trap_setup_attk",
            spell = { id = "pseudo_dormant_trap_setup", hit_self = true },
            cooldown = 1,
            allow_no_target = true,
            casting_message = "",
            kind = "spell",
        },
    },
}
