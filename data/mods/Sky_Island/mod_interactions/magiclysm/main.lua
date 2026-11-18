local content = require("ccb").content

content.add(content.ConstructionGroup {
    id = "floor_to_sapwood_floor",
    name = content.text("Warp floor into a living wood floor"),
})

content.add(content.ConstructionGroup {
    id = "wall_to_sapwood_wall",
    name = content.text("Warp wall into a living wood wall"),
})

content.add(
    content.Construction {
        id = "floor_to_sapwood_floor",
        group = "floor_to_sapwood_floor",
        category = "OTHER",
        post_terrain = "t_heartwood_floor",
        duration_moves = 500,
        activity_level = 1,
        requirements = content.Requirement {}
            :component("warp_druid_wood_floor_tokens", 1),
    }
        :requires_skill("survival", 0)
        :pre_flag("FLAT")
        :post_flag("keep_items")
)

content.add(
    content.Construction {
        id = "wall_to_sapwood_wall",
        group = "wall_to_sapwood_wall",
        category = "OTHER",
        post_terrain = "t_druid_wood_wall",
        duration_moves = 500,
        activity_level = 1,
        requirements = content.Requirement {}
            :component("warp_druid_wood_floor_tokens", 1),
    }
        :requires_skill("survival", 0)
        :pre_flag("WALL")
        :post_flag("keep_items")
)
