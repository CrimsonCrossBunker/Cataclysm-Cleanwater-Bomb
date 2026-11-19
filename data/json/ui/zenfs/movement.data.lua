local ccb = require("ccb")

ccb.content.define_widget {
    id = "zenfs_move_count",
    label = ccb.content.text("<color_cyan>Count</color>"),
    variable = "move",
    width = 9,
    style = "number",
}

ccb.content.define_widget {
    id = "zenfs_move_cost",
    label = ccb.content.text("<color_cyan>Cost</color>"),
    style = "number",
    variable = "move_cost",
    colors = {
        "c_white_green",
        "h_light_green",
        "c_light_green",
        "c_light_gray",
        "c_light_red",
        "h_light_red",
        "c_white_red",
    },
}
