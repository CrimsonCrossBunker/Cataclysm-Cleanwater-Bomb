local ccb = require("ccb")

ccb.content.define_furniture {
    id = "f_55gal_firebarrel",
    copy_from = "f_55gal_firebarrel",
    looks_like = "f_55gal_firebarrel",
    symbol = "#",
    color = "red",
    flags = { "PLACE_ITEM", "TRANSPARENT", "FIRE_CONTAINER", "EASY_DECONSTRUCT", "CONTAINER" },
    deployed_item = "55gal_firebarrel",
    builtin_examine = "fireplace",
}

ccb.content.define_furniture {
    id = "f_30gal_firebarrel",
    copy_from = "f_30gal_firebarrel",
    symbol = "#",
    color = "red",
    flags = { "PLACE_ITEM", "TRANSPARENT", "FIRE_CONTAINER", "EASY_DECONSTRUCT", "CONTAINER" },
    deployed_item = "30gal_firebarrel",
    builtin_examine = "fireplace",
}

ccb.content.define_furniture {
    id = "f_dryer_o",
    copy_from = "f_dryer",
    symbol = "{",
    background_color = "white",
    flags = { "CONTAINER", "PLACE_ITEM", "BLOCKSDOOR", "FLAT_SURF", "MINEABLE", "TRANSPARENT" },
    close = "f_dryer",
}

ccb.content.define_furniture {
    id = "f_dryer",
    copy_from = "f_dryer",
    symbol = "{",
    background_color = "white",
    flags = { "CONTAINER", "PLACE_ITEM", "BLOCKSDOOR", "FLAT_SURF", "MINEABLE", "TRANSPARENT", "SEALED" },
    open = "f_dryer_o",
}

ccb.content.define_furniture {
    id = "f_fridge_o",
    copy_from = "f_fridge",
    symbol = "{",
    color = "light_cyan",
    flags = { "CONTAINER", "PLACE_ITEM", "BLOCKSDOOR", "MINEABLE", "NO_SELF_CONNECT" },
    close = "f_fridge",
}

ccb.content.define_furniture {
    id = "f_fridge",
    copy_from = "f_fridge",
    symbol = "{",
    color = "light_cyan",
    flags = { "CONTAINER", "PLACE_ITEM", "BLOCKSDOOR", "MINEABLE", "NO_SELF_CONNECT", "SEALED" },
    open = "f_fridge_o",
}

ccb.content.define_furniture {
    id = "f_glass_fridge_o",
    copy_from = "f_glass_fridge",
    symbol = "{",
    color = "light_cyan",
    flags = { "CONTAINER", "PLACE_ITEM", "BLOCKSDOOR", "TRANSPARENT" },
    close = "f_glass_fridge",
}

ccb.content.define_furniture {
    id = "f_glass_fridge",
    copy_from = "f_glass_fridge",
    symbol = "{",
    color = "light_cyan",
    flags = { "CONTAINER", "PLACE_ITEM", "BLOCKSDOOR", "TRANSPARENT", "SEALED" },
    open = "f_glass_fridge_o",
}

ccb.content.define_furniture {
    id = "f_washer_o",
    copy_from = "f_washer",
    symbol = "{",
    background_color = "white",
    flags = { "CONTAINER", "PLACE_ITEM", "BLOCKSDOOR", "FLAT_SURF", "MINEABLE", "TRANSPARENT" },
    close = "f_washer",
}

ccb.content.define_furniture {
    id = "f_washer",
    copy_from = "f_washer",
    symbol = "{",
    background_color = "white",
    flags = { "CONTAINER", "PLACE_ITEM", "BLOCKSDOOR", "FLAT_SURF", "MINEABLE", "TRANSPARENT", "SEALED" },
    open = "f_washer_o",
}

ccb.content.define_furniture {
    id = "f_oven_o",
    copy_from = "f_oven",
    symbol = "#",
    color = "dark_gray",
    flags = { "PLACE_ITEM", "TRANSPARENT", "FIRE_CONTAINER", "CONTAINER", "BLOCKSDOOR", "MOUNTABLE" },
    builtin_examine = "fireplace",
    close = "f_oven",
}

ccb.content.define_furniture {
    id = "f_oven",
    copy_from = "f_oven",
    symbol = "#",
    color = "dark_gray",
    flags = {
        "PLACE_ITEM",
        "TRANSPARENT",
        "FIRE_CONTAINER",
        "CONTAINER",
        "BLOCKSDOOR",
        "MOUNTABLE",
        "FLAMMABLE_HARD",
        "SEALED",
    },
    open = "f_oven_o",
}

ccb.content.define_furniture {
    id = "f_shredder_o",
    copy_from = "f_shredder",
    symbol = "H",
    background_color = "white",
    max_volume = "18 L",
    flags = { "TRANSPARENT", "CONTAINER", "PLACE_ITEM", "BLOCKSDOOR", "SHORT" },
    close = "f_shredder",
}

ccb.content.define_furniture {
    id = "f_shredder",
    copy_from = "f_shredder",
    symbol = "H",
    background_color = "white",
    max_volume = "18 L",
    flags = { "TRANSPARENT", "CONTAINER", "PLACE_ITEM", "BLOCKSDOOR", "SHORT", "SEALED" },
    open = "f_shredder_o",
}

ccb.content.define_furniture {
    id = "f_sample_freezer_o",
    copy_from = "f_sample_freezer",
    symbol = "[",
    background_color = "white",
    flags = { "CONTAINER", "PLACE_ITEM", "BLOCKSDOOR", "HIDE_PLACE", "NO_SIGHT" },
    close = "f_sample_freezer",
}

ccb.content.define_furniture {
    id = "f_sample_freezer",
    copy_from = "f_sample_freezer",
    symbol = "[",
    background_color = "white",
    flags = { "CONTAINER", "PLACE_ITEM", "BLOCKSDOOR", "SEALED" },
    open = "f_sample_freezer_o",
}

ccb.content.define_furniture {
    id = "f_hay",
    copy_from = "f_hay",
    symbol = "#",
    background_color = "brown",
    coverage = 30,
    flags = {
        "TRANSPARENT",
        "CONTAINER",
        "FLAMMABLE_ASH",
        "ORGANIC",
        "MOUNTABLE",
        "SHORT",
        "EASY_DECONSTRUCT",
        "HIDE_PLACE",
        "NO_SIGHT",
    },
}

ccb.content.define_furniture {
    id = "f_bookcase",
    copy_from = "f_bookcase",
    symbol = "{",
    color = "brown",
    max_volume = "200 L",
    flags = { "FLAMMABLE", "PLACE_ITEM", "ORGANIC", "BLOCKSDOOR", "CONTAINER" },
}

ccb.content.define_furniture {
    id = "f_crate_o",
    copy_from = "f_crate_o",
    symbol = "O",
    background_color = "brown",
    move_cost_mod = 3,
    flags = {
        "TRANSPARENT",
        "CONTAINER",
        "FLAMMABLE",
        "PLACE_ITEM",
        "ORGANIC",
        "MOUNTABLE",
        "SHORT",
        "HIDE_PLACE",
        "NO_SIGHT",
    },
}

ccb.content.define_furniture {
    id = "f_cardboard_box_o",
    copy_from = "f_cardboard_box",
    symbol = "X",
    background_color = "brown",
    flags = {
        "TRANSPARENT",
        "FLAMMABLE_ASH",
        "PLACE_ITEM",
        "ORGANIC",
        "EASY_DECONSTRUCT",
        "BASHABLE",
        "HIDE_PLACE",
        "NO_SIGHT",
        "CONTAINER",
    },
    deployed_item = "box_large",
    builtin_examine = "deployed_furniture",
    close = "f_cardboard_box",
}

ccb.content.define_furniture {
    id = "f_cardboard_box",
    copy_from = "f_cardboard_box",
    symbol = "X",
    background_color = "brown",
    flags = {
        "TRANSPARENT",
        "FLAMMABLE_ASH",
        "PLACE_ITEM",
        "ORGANIC",
        "EASY_DECONSTRUCT",
        "BASHABLE",
        "CONTAINER",
        "SEALED",
    },
    deployed_item = "box_large",
    builtin_examine = "deployed_furniture",
    open = "f_cardboard_box_o",
}

ccb.content.define_furniture {
    id = "f_dresser_o",
    copy_from = "f_dresser",
    symbol = "{",
    color = "brown",
    max_volume = "250 L",
    flags = { "TRANSPARENT", "CONTAINER", "FLAMMABLE", "PLACE_ITEM", "ORGANIC", "BLOCKSDOOR", "MOUNTABLE" },
    close = "f_dresser",
}

ccb.content.define_furniture {
    id = "f_dresser",
    copy_from = "f_dresser",
    symbol = "{",
    color = "brown",
    max_volume = "250 L",
    flags = {
        "TRANSPARENT",
        "CONTAINER",
        "FLAMMABLE",
        "PLACE_ITEM",
        "ORGANIC",
        "BLOCKSDOOR",
        "MOUNTABLE",
        "SEALED",
    },
    open = "f_dresser_o",
}

ccb.content.define_furniture {
    id = "f_glass_cabinet_o",
    copy_from = "f_glass_cabinet",
    symbol = "[",
    color = "light_gray",
    flags = { "PLACE_ITEM", "TRANSPARENT", "BLOCKSDOOR", "CONTAINER" },
    close = "f_glass_cabinet",
}

ccb.content.define_furniture {
    id = "f_glass_cabinet",
    copy_from = "f_glass_cabinet",
    symbol = "[",
    color = "light_gray",
    flags = { "PLACE_ITEM", "TRANSPARENT", "BLOCKSDOOR", "CONTAINER", "SEALED" },
    open = "f_glass_cabinet_o",
}

ccb.content.define_furniture {
    id = "f_locker_o",
    copy_from = "f_locker",
    symbol = "{",
    color = "light_gray",
    move_cost_mod = 2,
    flags = { "CONTAINER", "PLACE_ITEM", "BLOCKSDOOR", "HIDE_PLACE", "NO_SIGHT" },
    close = "f_locker",
}

ccb.content.define_furniture {
    id = "f_locker",
    copy_from = "f_locker",
    symbol = "{",
    color = "light_gray",
    flags = { "CONTAINER", "PLACE_ITEM", "BLOCKSDOOR", "SEALED" },
    open = "f_locker_o",
}

ccb.content.define_furniture {
    id = "f_recycle_bin_o",
    copy_from = "f_recycle_bin",
    symbol = "{",
    color = "light_green",
    move_cost_mod = 3,
    max_volume = "800 L",
    flags = {
        "TRANSPARENT",
        "FLAMMABLE_ASH",
        "CONTAINER",
        "PLACE_ITEM",
        "MOUNTABLE",
        "SHORT",
        "HIDE_PLACE",
        "NO_SIGHT",
    },
    close = "f_recycle_bin",
}

ccb.content.define_furniture {
    id = "f_recycle_bin",
    copy_from = "f_recycle_bin",
    symbol = "{",
    color = "light_green",
    max_volume = "800 L",
    flags = { "TRANSPARENT", "FLAMMABLE_ASH", "CONTAINER", "PLACE_ITEM", "MOUNTABLE", "SHORT", "SEALED" },
    open = "f_recycle_bin_o",
}

ccb.content.define_furniture {
    id = "f_trashcan_o",
    copy_from = "f_trashcan",
    symbol = "&",
    color = "light_cyan",
    flags = { "TRANSPARENT", "FLAMMABLE_ASH", "CONTAINER", "PLACE_ITEM", "MOUNTABLE", "SHORT" },
    close = "f_trashcan",
}

ccb.content.define_furniture {
    id = "f_trashcan",
    copy_from = "f_trashcan",
    symbol = "&",
    color = "light_cyan",
    flags = { "TRANSPARENT", "FLAMMABLE_ASH", "CONTAINER", "PLACE_ITEM", "MOUNTABLE", "SHORT", "SEALED" },
    open = "f_trashcan_o",
}

ccb.content.define_furniture {
    id = "f_wardrobe_o",
    copy_from = "f_wardrobe",
    symbol = "{",
    color = "i_brown",
    move_cost_mod = 2,
    flags = {
        "CONTAINER",
        "FLAMMABLE",
        "PLACE_ITEM",
        "ORGANIC",
        "BLOCKSDOOR",
        "MOUNTABLE",
        "HIDE_PLACE",
        "NO_SIGHT",
    },
    close = "f_wardrobe",
}

ccb.content.define_furniture {
    id = "f_wardrobe",
    copy_from = "f_wardrobe",
    symbol = "{",
    color = "i_brown",
    flags = { "CONTAINER", "FLAMMABLE", "PLACE_ITEM", "ORGANIC", "BLOCKSDOOR", "MOUNTABLE", "SEALED" },
    open = "f_wardrobe_o",
}

ccb.content.define_furniture {
    id = "f_filing_cabinet_o",
    copy_from = "f_filing_cabinet",
    symbol = "}",
    color = "dark_gray",
    flags = { "PLACE_ITEM", "TRANSPARENT", "CONTAINER", "BLOCKSDOOR", "MOUNTABLE" },
    close = "f_filing_cabinet",
}

ccb.content.define_furniture {
    id = "f_filing_cabinet",
    copy_from = "f_filing_cabinet",
    symbol = "}",
    color = "dark_gray",
    flags = { "PLACE_ITEM", "TRANSPARENT", "CONTAINER", "BLOCKSDOOR", "MOUNTABLE", "SEALED" },
    open = "f_filing_cabinet_o",
}

ccb.content.define_furniture {
    id = "f_dumpster_o",
    copy_from = "f_dumpster",
    symbol = "{",
    color = "green",
    flags = { "CONTAINER", "PLACE_ITEM", "BLOCKSDOOR", "HIDE_PLACE", "NO_SIGHT" },
    close = "f_dumpster",
}

ccb.content.define_furniture {
    id = "f_dumpster",
    copy_from = "f_dumpster",
    symbol = "{",
    color = "green",
    flags = { "CONTAINER", "PLACE_ITEM", "BLOCKSDOOR", "HIDE_PLACE", "NO_SIGHT", "SEALED" },
    open = "f_dumpster_o",
}

ccb.content.define_furniture {
    id = "f_cupboard_o",
    copy_from = "f_cupboard",
    symbol = "#",
    color = "blue",
    move_cost_mod = 2,
    flags = {
        "TRANSPARENT",
        "FLAMMABLE_ASH",
        "CONTAINER",
        "PLACE_ITEM",
        "ORGANIC",
        "MOUNTABLE",
        "FLAT_SURF",
        "HIDE_PLACE",
        "NO_SIGHT",
    },
    connect_groups = "COUNTER",
    connects_to = "COUNTER",
    max_volume = "350 L",
    builtin_examine = "workbench",
    workbench = { multiplier = 1.1, mass = 200000, volume = "75L" },
    close = "f_cupboard",
}

ccb.content.define_furniture {
    id = "f_cupboard",
    copy_from = "f_cupboard",
    symbol = "#",
    color = "blue",
    flags = {
        "TRANSPARENT",
        "FLAMMABLE_ASH",
        "CONTAINER",
        "PLACE_ITEM",
        "ORGANIC",
        "MOUNTABLE",
        "FLAT_SURF",
        "SEALED",
    },
    connect_groups = "COUNTER",
    connects_to = "COUNTER",
    max_volume = "350 L",
    builtin_examine = "workbench",
    workbench = { multiplier = 1.1, mass = 200000, volume = "75L" },
    open = "f_cupboard_o",
}
