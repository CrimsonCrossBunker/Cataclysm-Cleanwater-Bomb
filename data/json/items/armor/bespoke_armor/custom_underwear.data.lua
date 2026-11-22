local ccb = require("ccb")

ccb.content.define_item {
    id = "nomad_bodyglove_2",
    copy_from = "nomad_bodyglove_1",
    name = ccb.content.plural_text("nomad bodymesh", "nomad bodymeshes"),
    description = "A simple, thin, skintight layer of breathable fabric that protects your skin.  It has integrated feet and precisely placed rubberized pads to protect critical points from impact and abrasion, and has been reinforced with a loose mesh of advanced polymer threads.",
    armor = {
        portions = {
            {
                covers = { "torso", "arm_l", "arm_r", "leg_l", "leg_r" },
                coverage = 100,
                breathability = "GOOD",
                encumbrance = 1,
                materials = {
                    { id = "lycra", thickness = 0.2, coverage = 100 },
                    { id = "rubber", thickness = 0.8, coverage = 80 },
                    { id = "kevlar", thickness = 0.54, coverage = 40 },
                },
            },
            {
                covers = { "foot_l", "foot_r" },
                coverage = 100,
                breathability = "GOOD",
                encumbrance = 1,
                materials = {
                    { id = "lycra", thickness = 0.2, coverage = 100 },
                    { id = "kevlar", thickness = 0.54, coverage = 40 },
                },
            },
        },
    },
    inheritance = {
        add = {
            materials = { "kevlar" },
        },
    },
}
