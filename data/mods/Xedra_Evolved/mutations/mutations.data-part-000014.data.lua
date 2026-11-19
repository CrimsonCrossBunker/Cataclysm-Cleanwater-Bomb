local ccb = require("ccb")

ccb.content.define_mutation {
    id = "VAMPIRE_WALK_ON_WALLS",
    points = 3,
    starting_trait = false,
    purifiable = false,
    valid = false,
    name = ccb.content.text("Spider's Walk"),
    description = ccb.content.text("Gravity seems to have less of an effect than it used it.  With barely an effort you can ascend or descend even sheer walls, and you can fall any distance and land on your feet uninjured."),
    flags = { "CLIMB_NO_LADDER", "FEATHER_FALL", "WALL_CLING" },
}
