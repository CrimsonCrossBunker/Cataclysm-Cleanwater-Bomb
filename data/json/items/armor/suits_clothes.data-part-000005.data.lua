local ccb = require("ccb")

ccb.content.define_item {
    id = "ski_bib_unzipped",
    copy_from = "ski_bib",
    name = ccb.content.plural_text("ski bib (unzipped)", "ski bib (unzipped)"),
    description = ccb.content.text("A heavy, waterproof ski bib that covers the legs and torso.  It is made of a thick, durable material and is designed to keep the wearer warm in cold conditions, and includes a boot clip to keep snow out of your feet.  Activate them to zip up the front legs for ventilation and clip on the gaiters."),
    flags = { "VARSIZE", "POCKETS" },
    looks_like = "denim_overalls",
    armor = {
        warmth = 35,
        environmental_protection = 2,
        portions = {
            {
                covers = { "torso" },
                materials = { { id = "nylon", coverage = 100, thickness = 0.4 } },
                coverage = 65,
                encumbrance = { 12, 14 },
            },
            {
                encumbrance = { 12, 14 },
                coverage = 100,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_knee_l", "leg_hip_r", "leg_knee_r" },
                materials = {
                    { id = "nylon", coverage = 100, thickness = 0.4 },
                    { id = "cotton", coverage = 100, thickness = 0.4 },
                },
            },
            {
                encumbrance = { 0, 0 },
                coverage = 100,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_l", "leg_upper_r" },
                materials = {
                    { id = "nylon", coverage = 100, thickness = 0.4 },
                    { id = "cotton", coverage = 80, thickness = 0.4 },
                },
                breathability = "GOOD",
            },
            {
                coverage = 100,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_lower_r", "leg_lower_l" },
                materials = {
                    { id = "nylon", coverage = 100, thickness = 0.4 },
                    { id = "vinyl", coverage = 60, thickness = 0.2 },
                },
                encumbrance = { 0, 0 },
                rigid_only = false,
            },
        },
    },
    use_actions = {
        {
            kind = "transform",
            menu_text = ccb.content.text("Close vents"),
            message = ccb.content.text("You close vents in the legs of the snow bib."),
            target = "ski_bib",
        },
    },
}
