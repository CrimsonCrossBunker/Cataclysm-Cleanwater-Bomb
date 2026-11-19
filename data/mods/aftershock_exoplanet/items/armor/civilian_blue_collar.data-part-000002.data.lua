local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_hi_vis_vest",
    copy_from = "vest",
    looks_like = "vest",
    name = ccb.content.text("hi-vis vest"),
    variants = {},
    description = ccb.content.text("A bright orange winter vest with several front facing pockets.  Not even close to warm enough."),
    materials = { "cotton", "plastic" },
    color = "red",
    armor = { warmth = 70, thickness = 2 },
}

ccb.content.define_item {
    id = "afs_company_jacket",
    copy_from = "jacket_windbreaker",
    looks_like = "jacket_windbreaker",
    name = ccb.content.text("company jacket"),
    variants = {},
    description = ccb.content.text("A synthetic jacket adorned with the logos and colors of some interstellar corporation.  Impermeable, but not very warm."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "afs_supervisor_jacket",
    copy_from = "jacket_windbreaker",
    looks_like = "jacket_windbreaker",
    name = ccb.content.text("supervisor jacket"),
    variants = {},
    description = ccb.content.text("A variant company jacket tailored to slightly recall a business suit, often issued to low level managers.  Some might think it looks nicer, but it's just as cheaply made."),
    color = "blue",
    armor = {},
}

ccb.content.define_item {
    id = "afs_work_tie",
    copy_from = "tie_skinny",
    looks_like = "tie_skinny",
    name = ccb.content.text("worker's tie"),
    variants = {},
    description = ccb.content.text("Calling this thin strip of dark fabric a tie would do it a favor."),
    armor = {},
}

ccb.content.define_item {
    id = "spacer_jumpsuit",
    copy_from = "jumpsuit",
    looks_like = "jumpsuit",
    name = ccb.content.text("crew jumpsuit"),
    description = ccb.content.text("A lightweight cloth jumpsuit adorned with the faded corporate regalia of some freight hauling association or another.  This one is a standard design favored by spacers, with ample, easy access pockets."),
    variants = {},
    color = "brown",
    armor = {},
}
