local ccb = require("ccb")

-- This is used to clear a tile of furniture used by 'rows' during mapgen
-- NO_I18N
-- NO_I18N
ccb.content.define_furniture {
    id = "f_clear",
    name = ccb.content.text_without_extraction("seeing this is a bug"),
    description = ccb.content.text_without_extraction("Seeing this is a bug.  If seen, please report and destroy."),
    symbol = "#",
    color = "black",
    move_cost_mod = 2,
    required_strength = -1,
    flags = { "NOITEM" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_furniture {
    id = "f_fake_bench_hands",
    name = ccb.content.text_without_extraction("fake workbench hands"),
    description = ccb.content.text_without_extraction("This fake workbench holds the stats for working on a wielded item."),
    symbol = "#",
    color = "red",
    move_cost_mod = 2,
    required_strength = -1,
    workbench = { multiplier = 1.0, mass = "5 kg", volume = "10 L" },
}

-- This furniture object also gets used as a fake workbench whenever a player crafts on the ground anywhere else.
ccb.content.define_furniture {
    id = "f_ground_crafting_spot",
    name = ccb.content.text("ground crafting spot"),
    looks_like = "tr_firewood_source",
    description = ccb.content.text("A cleared spot on the ground for crafting.  Slower than using a workbench or holding a project in your hands, but readily available."),
    symbol = "x",
    color = "white",
    move_cost_mod = 0,
    required_strength = 0,
    deconstruct = { drops = {} },
    bash = { minimum_strength = 0, maximum_strength = 0, drops = {} },
    flags = { "PLACE_ITEM", "TRANSPARENT", "EASY_DECONSTRUCT", "NOCOLLIDE" },
    builtin_examine = "workbench",
    workbench = { multiplier = 0.7, mass = "10000 kg", volume = "1000 L" },
}

-- This is used in a hack to clear furniture with the keg iexamine of all items except the stored liquid before usage.
-- NO_I18N
-- NO_I18N
ccb.content.define_furniture {
    id = "f_no_item",
    name = ccb.content.text_without_extraction("seeing this is a bug"),
    description = ccb.content.text_without_extraction("Seeing this is a bug.  If seen, please report and destroy."),
    symbol = "#",
    color = "black",
    move_cost_mod = 2,
    required_strength = -1,
    flags = { "NOITEM" },
}
