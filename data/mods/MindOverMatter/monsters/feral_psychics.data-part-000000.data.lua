local ccb = require("ccb")

-- interstitial copy-from to edit flags and special attacks appropriately
ccb.content.define_monster {
    id = "mon_feral_psion_default",
    copy_from = "mon_feral_human_pipe",
    default_faction = "feral_psychic",
    attacks = { { reference = "BROWSE", cooldown = 100 }, { reference = "EAT_FOOD", cooldown = 100 } },
    flags = {
        "SEES", "HEARS", "SMELLS", "WARM", "BASHES", "GROUP_BASH", "HUMAN", "CAN_OPEN_DOORS",
        "PATH_AVOID_DANGER", "PATH_AVOID_FIRE", "PRIORITIZE_TARGETS", "EATS",
    },
}
