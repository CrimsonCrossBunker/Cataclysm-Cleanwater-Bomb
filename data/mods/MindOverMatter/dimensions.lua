local content = require("ccb").content

content.add(content.Dimension { id = "mom_innawood", region_layout = "mom_innawood" })

content.add(content.DimensionRegionLayout {
    id = "mom_innawood",
    generation_mode = "UNIFORM",
    uniform_region = "mom_innawood",
})

content.add(content.Dimension { id = "mom_innawood_rainy", region_layout = "mom_innawood_rainy" })

content.add(content.DimensionRegionLayout {
    id = "mom_innawood_rainy",
    generation_mode = "UNIFORM",
    uniform_region = "mom_innawood_rainy",
})

content.add(content.Dimension { id = "mom_mycus_world", region_layout = "mom_mycus_world" })

content.add(content.DimensionRegionLayout {
    id = "mom_mycus_world",
    generation_mode = "UNIFORM",
    uniform_region = "mom_mycus_world",
})

content.add(content.Dimension { id = "mom_shoggothed_world", region_layout = "mom_shoggothed_world" })

content.add(content.DimensionRegionLayout {
    id = "mom_shoggothed_world",
    generation_mode = "UNIFORM",
    uniform_region = "mom_shoggothed_world",
})
