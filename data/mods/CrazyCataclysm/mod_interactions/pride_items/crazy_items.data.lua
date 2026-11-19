local ccb = require("ccb")

ccb.content.define_item {
    id = "pride_flag",
    copy_from = "pride_flag",
    armor = {},
    inheritance = {
        add = {
            variants = {
                {
                    id = "newbrunswick_pride_flag",
                    name = ccb.content.text("NB flag"),
                    description = ccb.content.text("A yellow flag with a ship and lion, representing New Brunswick.  You have a feeling this might be the wrong NB flag."),
                    weight = 5,
                },
            },
        },
    },
}
