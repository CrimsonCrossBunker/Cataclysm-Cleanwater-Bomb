local ccb = require("ccb")

-- volume encumber set high since the whole vest is already scaled. This equals .4 overall
-- volume encumber set high since the whole vest is already scaled. This equals .4 overall
ccb.content.define_item {
    id = "afs_ilbe",
    copy_from = "load_bearing_vest",
    name = ccb.content.plural_text("U3s ILBE", "U3s ILBE"),
    description = ccb.content.text("Load bearing equipment that can be configured to attach PALS compatible pouches, meant to be worn in conjunction with armor.  It has two magnetic attachment points for a rifle and a sidearm.  Standard issue in UICA forces."),
    mass = "1500 g",
    variants = {},
    pockets = {
        {
            description = ccb.content.text("Rifle attachment point."),
            kind = "CONTAINER",
            holster = true,
            min_item_length = "40 cm",
            capacity = "8 L",
            mass_limit = "8200 g",
            max_item_length = "120 cm",
            volume_encumbrance = 1.6,
            moves = 30,
        },
        {
            description = ccb.content.text("Sidearm attachment point."),
            kind = "CONTAINER",
            holster = true,
            min_item_length = "10 cm",
            capacity = "1 L",
            mass_limit = "3000 g",
            max_item_length = "40 cm",
            volume_encumbrance = 1.2,
            moves = 30,
        },
    },
    armor = {
        portions = {
            {
                encumbrance = 2,
                coverage = 85,
                covers = { "torso" },
                subparts = { "torso_upper", "torso_hanging_front" },
                volume_encumbrance = 0.25,
            },
        },
    },
    use_actions = { { kind = "holster" }, { kind = "attach_molle", size = 8 }, { kind = "detach_molle" } },
}
