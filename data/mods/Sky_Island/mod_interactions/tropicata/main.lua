local ccb = require("ccb")
local content = ccb.content

content.add(
    content.Construction {
        id = "grow_warped_mango_tree",
        group = "warped_mango_tree",
        category = "OTHER",
        post_terrain = "t_tree_mango",
        duration_moves = 720000,
        activity_level = 2,
        requirements = content.Requirement {}
            :component("warptoken", 2)
            :component_any {
                { id = "stick_long", count = 1 },
                { id = "stick", count = 2 },
                { id = "twig", count = 6 },
            }
            :component_any {
                { id = "leaves", count = 8 },
                { id = "young_leaves", count = 8 },
            }
            :component("mango", 3),
    }
        :requires_skill("survival", 4)
        :precheck("check_empty")
)

content.add(content.ConstructionGroup {
    id = "warped_mango_tree",
    name = ccb.content.text("Grow a Warped Mango Tree"),
})

content.add(
    content.Construction {
        id = "grow_warped_papaya_tree",
        group = "warped_papaya_tree",
        category = "OTHER",
        post_terrain = "t_tree_papaya",
        duration_moves = 720000,
        activity_level = 2,
        requirements = content.Requirement {}
            :component("warptoken", 2)
            :component_any {
                { id = "stick_long", count = 1 },
                { id = "stick", count = 2 },
                { id = "twig", count = 6 },
            }
            :component_any {
                { id = "leaves", count = 8 },
                { id = "young_leaves", count = 8 },
            }
            :component("papaya", 3),
    }
        :requires_skill("survival", 4)
        :precheck("check_empty")
)

content.add(content.ConstructionGroup {
    id = "warped_papaya_tree",
    name = ccb.content.text("Grow a Warped Papaya Tree"),
})

content.add(
    content.Construction {
        id = "grow_warped_pomegranate_tree",
        group = "warped_pomegranate_tree",
        category = "OTHER",
        post_terrain = "t_tree_pomegranate",
        duration_moves = 720000,
        activity_level = 2,
        requirements = content.Requirement {}
            :component("warptoken", 2)
            :component_any {
                { id = "stick_long", count = 1 },
                { id = "stick", count = 2 },
                { id = "twig", count = 6 },
            }
            :component_any {
                { id = "leaves", count = 8 },
                { id = "young_leaves", count = 8 },
            }
            :component("pomegranate", 3),
    }
        :requires_skill("survival", 4)
        :precheck("check_empty")
)

content.add(content.ConstructionGroup {
    id = "warped_pomegranate_tree",
    name = ccb.content.text("Grow a Warped Pomegranate Tree"),
})

content.add(
    content.Construction {
        id = "grow_warped_coconut_tree",
        group = "warped_coconut_tree",
        category = "OTHER",
        post_terrain = "t_tree_coconut",
        duration_moves = 720000,
        activity_level = 2,
        requirements = content.Requirement {}
            :component("warptoken", 3)
            :component_any {
                { id = "stick_long", count = 1 },
                { id = "stick", count = 2 },
                { id = "twig", count = 6 },
            }
            :component_any {
                { id = "leaves", count = 8 },
                { id = "young_leaves", count = 8 },
            }
            :component("coconut", 2),
    }
        :requires_skill("survival", 5)
        :precheck("check_empty")
)

content.add(content.ConstructionGroup {
    id = "warped_coconut_tree",
    name = ccb.content.text("Grow a Warped Coconut Tree"),
})

content.add(
    content.Construction {
        id = "grow_warped_orange_tree",
        group = "warped_orange_tree",
        category = "OTHER",
        post_terrain = "t_tree_orange",
        duration_moves = 720000,
        activity_level = 2,
        requirements = content.Requirement {}
            :component("warptoken", 2)
            :component_any {
                { id = "stick_long", count = 1 },
                { id = "stick", count = 2 },
                { id = "twig", count = 6 },
            }
            :component_any {
                { id = "leaves", count = 8 },
                { id = "young_leaves", count = 8 },
            }
            :component("orange", 3),
    }
        :requires_skill("survival", 3)
        :precheck("check_empty")
)

content.add(content.ConstructionGroup {
    id = "warped_orange_tree",
    name = ccb.content.text("Grow a Warped Orange Tree"),
})

content.add(
    content.Construction {
        id = "grow_warped_lemon_tree",
        group = "warped_lemon_tree",
        category = "OTHER",
        post_terrain = "t_tree_lemon",
        duration_moves = 720000,
        activity_level = 2,
        requirements = content.Requirement {}
            :component("warptoken", 2)
            :component_any {
                { id = "stick_long", count = 1 },
                { id = "stick", count = 2 },
                { id = "twig", count = 6 },
            }
            :component_any {
                { id = "leaves", count = 8 },
                { id = "young_leaves", count = 8 },
            }
            :component("lemon", 3),
    }
        :requires_skill("survival", 3)
        :precheck("check_empty")
)

content.add(content.ConstructionGroup {
    id = "warped_lemon_tree",
    name = ccb.content.text("Grow a Warped Lemon Tree"),
})

content.add(
    content.Construction {
        id = "grow_warped_grapefruit_tree",
        group = "warped_grapefruit_tree",
        category = "OTHER",
        post_terrain = "t_tree_grapefruit",
        duration_moves = 720000,
        activity_level = 2,
        requirements = content.Requirement {}
            :component("warptoken", 2)
            :component_any {
                { id = "stick_long", count = 1 },
                { id = "stick", count = 2 },
                { id = "twig", count = 6 },
            }
            :component_any {
                { id = "leaves", count = 8 },
                { id = "young_leaves", count = 8 },
            }
            :component("grapefruit", 3),
    }
        :requires_skill("survival", 3)
        :precheck("check_empty")
)

content.add(content.ConstructionGroup {
    id = "warped_grapefruit_tree",
    name = ccb.content.text("Grow a Warped Grapefruit Tree"),
})

content.add(
    content.Construction {
        id = "grow_warped_cactus",
        group = "warped_cactus",
        category = "OTHER",
        post_terrain = "t_cholla_cactus",
        duration_moves = 720000,
        activity_level = 2,
        requirements = content.Requirement {}
            :component("warptoken", 3)
            :component("plant_stalk", 8)
            :component("twig", 10)
            :component("carrot_wild", 4)
            :component("cactus_pad", 1),
    }
        :requires_skill("survival", 5)
        :precheck("check_empty")
)

content.add(content.ConstructionGroup {
    id = "warped_cactus",
    name = ccb.content.text("Grow a Warped Cholla Cactus"),
})
