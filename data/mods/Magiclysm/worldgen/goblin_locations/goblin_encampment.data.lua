local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = {
        "goblin_1A", "goblin_2A", "goblin_3A", "goblin_4A", "goblin_5A", "goblin_1B", "goblin_2B",
        "goblin_3B", "goblin_4B", "goblin_5B", "goblin_1C", "goblin_2C", "goblin_3C", "goblin_4C",
        "goblin_5C", "goblin_1A_roof", "goblin_2A_roof", "goblin_3A_roof", "goblin_4A_roof",
        "goblin_5A_roof", "goblin_1B_roof", "goblin_2B_roof", "goblin_3B_roof", "goblin_4B_roof",
        "goblin_5B_roof", "goblin_1C_roof", "goblin_2C_roof", "goblin_3C_roof", "goblin_4C_roof",
        "goblin_5C_roof",
    },
    name = ccb.content.text("goblin encampment"),
    symbol = "#",
    color = "red",
    see_cost = "full_high",
    vision_levels = "large_building",
}
