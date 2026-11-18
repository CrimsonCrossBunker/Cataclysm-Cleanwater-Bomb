local ccb = require("ccb")
local content = ccb.content

content.add(
    content.Item {
        id = "warp_druid_wood_floor_tokens",
        name = ccb.content.plural_text("sapwood-floor tokens", "sapwood-floor tokens"),
        description = ccb.content.text("A group of small squares of living wood, rough and unpolished.  You can use them to transform a section of flooring into living wood."),
        category = "other",
        symbol = ".",
        color = "light_gray",
        looks_like = "seed_wild_herbs",
        mass_grams = 5,
        volume_ml = 5,
    }
        :material("veggy", 1)
        :flag("UNBREAKABLE")
        :ammunition {
            type = "components",
            count = 50,
            stack_size = 50,
        }
)
