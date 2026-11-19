local ccb = require("ccb")
local content = ccb.content

content.add(content.TerrainTransform { id = "summoned_brambles" }
    :furniture {
        inputs = {
            "f_null", "f_cattails", "t_grass_tall", "t_grass_long", "f_burdock", "f_lotus",
            "f_japanese_knotweed", "f_golden_reed", "f_barnacle_weed", "f_lilypad", "f_whiskflower",
            "f_bluebell", "f_lily", "f_salsify", "f_wild_sarsaparilla",
        },
        results = { "f_magic_brambles" },
        message = ccb.content.text("The ground churns as thick, tangled brambles burst forth and grow in moments."),
        optional_ids = { "t_grass_tall", "t_grass_long", "f_golden_reed", "f_barnacle_weed", "f_whiskflower" },
    })
