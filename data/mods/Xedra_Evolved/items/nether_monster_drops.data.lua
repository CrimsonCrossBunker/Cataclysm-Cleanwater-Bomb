local ccb = require("ccb")

ccb.content.define_item {
    id = "blank_blood",
    copy_from = "demihuman_blood",
    name = ccb.content.plural_text("blank blood", "blank blood"),
    description = ccb.content.text("Blood extracted from a blank body.  It's a pale red color with none of the luster of human blood."),
    comestible = {
        shelf_life = "9000 days",
        parasites = 0,
        vitamins = {
            { id = "calcium", amount = 0 },
            { id = "iron", amount = 0 },
            { id = "meat_allergen", amount = 0 },
            { id = "human_flesh_vitamin", amount = 0 },
        },
        calories = 0,
    },
}
