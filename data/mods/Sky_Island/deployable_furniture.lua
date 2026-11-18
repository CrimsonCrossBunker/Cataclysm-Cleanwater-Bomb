local ccb = require("ccb")
local content = ccb.content

content.add(content.Furniture {
    id = "f_infinitree1",
    name = ccb.content.text("infinity tree"),
    description = ccb.content.text("Purple-blue shimmers sparkle around the leaves of this small sapling.  New growth seems to spring up in seconds, as if in a timelapse, and yet there never seem to be too many branches.  It's always in equilibrium.  Its strange nature allows you to push it around like furniture.\n\nThe power of this tree allows you to produce raw wooden items from material tokens via the crafting menu.\nJust one of these could last forever."),
    looks_like = "t_tree",
    symbol = "7",
    color = "brown",
    move_cost_mod = -1,
    deployed_item = "warp_folded_infinitree",
    coverage = 80,
    required_str = 1,
    crafting_pseudo_item = "fakeitem_infinitree1",
    mass_grams = 1000000,
    builtin_examine = "deployed_furniture",
}
    :flag("NOITEM")
    :flag("BLOCK_WIND")
    :flag("TRANSPARENT"))

content.add(content.Furniture {
    id = "f_infinitystone",
    name = ccb.content.text("infinity stone"),
    description = ccb.content.text("Wisps of iridescent energy spark around this immense stone like miniature fireworks, leaving behind a satisfying showers of pebbles.  Clay and soil shift around its base, erupting in slow motion yet never overflowing.\n\nThe power of this stone allows you to produce rocks and natural earthen items from material tokens via the crafting menu.\nJust one of these could last forever."),
    looks_like = "f_boulder_medium",
    symbol = "o",
    color = "light_gray",
    move_cost_mod = -1,
    deployed_item = "warp_folded_infinitystone",
    coverage = 80,
    required_str = 1,
    crafting_pseudo_item = "fakeitem_infinitystone",
    mass_grams = 1000000,
    builtin_examine = "deployed_furniture",
}
    :flag("NOITEM")
    :flag("BLOCK_WIND")
    :flag("TRANSPARENT"))

content.add(content.Furniture {
    id = "f_infinityore",
    name = ccb.content.text("infinity ore"),
    description = ccb.content.text("A roiling, rattling mass of ever-churning metal.  Flares of purple energy arc around the formless pile like electricity, and in their wake, thin metal rods and struts jut out, before disappearing into the half-molten heap which never seems to grow or diminish.  Its strange nature allows you to shift it around like furniture.\n\nThe power of this ore allows you to produce raw and basic metal items from material tokens via the crafting menu.\nJust one of these could last forever."),
    looks_like = "f_wreckage",
    symbol = "#",
    color = "cyan",
    move_cost_mod = -1,
    deployed_item = "warp_folded_infinityore",
    coverage = 80,
    required_str = 1,
    crafting_pseudo_item = "fakeitem_infinityore",
    mass_grams = 1000000,
    builtin_examine = "deployed_furniture",
}
    :flag("NOITEM")
    :flag("BLOCK_WIND")
    :flag("TRANSPARENT"))
