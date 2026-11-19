local ccb = require("ccb")

-- I added a helmet to the summon
ccb.content.define_item {
    id = "bloody_cap",
    category = "armor",
    copy_from = "xl_mt_chainmail_hood",
    name = ccb.content.plural_text("bloody redcap", "bloody redcap"),
    description = ccb.content.text("The cap develops a fearsome aura as the blood pours back out of the fibers."),
    materials = { "moon_tears_fine_chain" },
    light = 2,
    flags = { "OVERSIZE", "PERSONAL", "VARSIZE", "STURDY", "NO_REPAIR", "NO_SALVAGE", "TRADER_AVOID" },
    max_worn = 1,
    subtype_order = { "armor", "artifact" },
    armor = {
        warmth = 0,
        thickness = 2,
        portions = {
            {
                encumbrance = 5,
                coverage = 100,
                covers = {
                    "head", "mouth", "eyes", "torso", "arm_l", "arm_r", "hand_l", "hand_r", "leg_l",
                    "leg_r", "foot_l", "foot_r",
                },
            },
        },
    },
    artifact = { enchantments = { "ITEM_ENCH_Xedra_Evolved_bloody_cap_0" } },
}
