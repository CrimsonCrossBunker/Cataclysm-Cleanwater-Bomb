local ccb = require("ccb")

ccb.content.define_item {
    id = "hobo_stove",
    copy_from = "can_medium",
    name = "hobo stove",
    description = "A small, improvised wood stove, made from a metal can or similar container of the right size.  It's too small to fit anything much larger than splintered wood.  Activate it to deploy.",
    mass = "100 g",
    volume = "550 ml",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "400 ml",
            mass_limit = "1 kg",
            rigid = true,
            watertight = false,
            open_container = false,
        },
    },
    use_actions = {
        { kind = "deploy_furn", furn_type = "f_hobo_stove" },
    },
    tool = {},
}
