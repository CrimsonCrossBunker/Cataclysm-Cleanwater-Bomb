local content = require("ccb").content

local LIGHT_EXERCISE = 2

content.add(content.Recipe {
    id = "wsurvivor_jumpsuit_nofur",
    result = "wsurvivor_jumpsuit_nofur",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 28800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 6,
}
    :component_any({
            { id = "sheet_cotton", count = 170 },
            { id = "sheet_cotton_patchwork", count = 170 }
        })
    :component_any({
            { id = "sheet_canvas", count = 20 },
            { id = "sheet_canvas_patchwork", count = 20 }
        })
    :component_any({
            { id = "sheet_faux_fur", count = 20 },
            { id = "sheet_faux_fur_patchwork", count = 20 }
        })
    :component_any({
            { id = "sheet_nylon", count = 5 },
            { id = "sheet_nylon_patchwork", count = 5 }
        })
    :component("thread_canvas", 300)
    :component("thread", 750)
    :component("zipper_short_plastic", 6)
    :component("zipper_long_plastic", 1)
    :component("snapfastener_steel", 8)
    :quality("SEW", 3, 1)
    :quality("FABRIC_CUT", 1, 1)
    :quality("LEATHER_AWL", 1, 1)
    :quality("CUT_FINE", 1, 1)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_furriery")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
)

content.add(content.Recipe {
    id = "xs_wsurvivor_jumpsuit_nofur",
    result = "xs_wsurvivor_jumpsuit_nofur",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 23040000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 6,
}
    :component_any({
            { id = "sheet_cotton", count = 130 },
            { id = "sheet_cotton_patchwork", count = 130 }
        })
    :component_any({
            { id = "sheet_canvas", count = 16 },
            { id = "sheet_canvas_patchwork", count = 16 }
        })
    :component_any({
            { id = "sheet_faux_fur", count = 16 },
            { id = "sheet_faux_fur_patchwork", count = 16 }
        })
    :component_any({
            { id = "sheet_nylon", count = 5 },
            { id = "sheet_nylon_patchwork", count = 5 }
        })
    :component("thread_canvas", 250)
    :component("thread", 600)
    :component("zipper_short_plastic", 6)
    :component("zipper_long_plastic", 1)
    :component("snapfastener_steel", 8)
    :quality("SEW", 3, 1)
    :quality("FABRIC_CUT", 1, 1)
    :quality("LEATHER_AWL", 1, 1)
    :quality("CUT_FINE", 1, 1)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_furriery")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
)

content.add(content.Recipe {
    id = "xl_wsurvivor_jumpsuit_nofur",
    result = "xl_wsurvivor_jumpsuit_nofur",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 36000000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 6,
}
    :component_any({
            { id = "sheet_cotton", count = 220 },
            { id = "sheet_cotton_patchwork", count = 220 }
        })
    :component_any({
            { id = "sheet_canvas", count = 25 },
            { id = "sheet_canvas_patchwork", count = 25 }
        })
    :component_any({
            { id = "sheet_faux_fur", count = 25 },
            { id = "sheet_faux_fur_patchwork", count = 25 }
        })
    :component_any({
            { id = "sheet_nylon", count = 5 },
            { id = "sheet_nylon_patchwork", count = 5 }
        })
    :component("thread_canvas", 400)
    :component("thread", 1000)
    :component("zipper_short_plastic", 6)
    :component("zipper_long_plastic", 2)
    :component("snapfastener_steel", 10)
    :quality("SEW", 3, 1)
    :quality("FABRIC_CUT", 1, 1)
    :quality("LEATHER_AWL", 1, 1)
    :quality("CUT_FINE", 1, 1)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_furriery")
    :proficiency("prof_articulation")
    :proficiency("prof_quilting")
)
