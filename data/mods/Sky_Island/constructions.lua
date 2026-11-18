local content = require("ccb").content

content.add(content.ItemGroup {
    id = "skyisland_autodoc_copy_byproducts",
    kind = "collection",
}:entry { item = "warp_autodoc_active", count = { 1, 1 } })

content.add(
    content.Construction {
        id = "copy_autodoc_with_plate",
        group = "autodoc_copy",
        category = "OTHER",
        post_terrain = "f_wreckage",
        duration_moves = 30000,
        activity_level = 1,
        byproducts = "skyisland_autodoc_copy_byproducts",
        requirements = content.Requirement {}
            :component("warp_autodoc_inert", 1),
    }
        :requires_skill("survival", 0)
        :pre_terrain("f_autodoc")
)

content.add(
    content.Construction {
        id = "build_autodoc_from_plate",
        group = "autodoc_paste",
        category = "OTHER",
        post_terrain = "f_autodoc",
        duration_moves = 360000,
        activity_level = 2,
        requirements = content.Requirement {}
            :component("warp_autodoc_active", 1),
    }
        :requires_skill("survival", 0)
        :precheck("check_empty")
)

content.add(
    content.Construction {
        id = "upgrade_autodoc_1",
        group = "autodoc_paste",
        category = "OTHER",
        post_terrain = "f_si_autodoc_2",
        duration_moves = 360000,
        activity_level = 2,
        requirements = content.Requirement {}
            :component_any {
                { id = "warp_autodoc_active", count = 1 },
                { id = "warped_autodoc_upgrader_1", count = 1 },
            },
    }
        :requires_skill("survival", 0)
        :pre_terrain("f_autodoc")
)

content.add(
    content.Construction {
        id = "upgrade_autodoc_2",
        group = "autodoc_paste",
        category = "OTHER",
        post_terrain = "f_si_autodoc_3",
        duration_moves = 360000,
        activity_level = 2,
        requirements = content.Requirement {}
            :component_any {
                { id = "warp_autodoc_active", count = 1 },
                { id = "warped_autodoc_upgrader_2", count = 1 },
            },
    }
        :requires_skill("survival", 0)
        :pre_terrain("f_si_autodoc_2")
)

content.add(
    content.Construction {
        id = "constr_sofa",
        group = "build_sofa",
        category = "FURN",
        post_terrain = "f_sofa",
        duration_moves = 360000,
        activity_level = 4,
        requirements = content.Requirement {}
            :component("2x4", 10)
            :component("nail", 10)
            :component("cotton_patchwork", 100)
            :quality("HAMMER", 2, 1)
            :quality("SAW_W", 1, 1),
    }
        :requires_skill("fabrication", 4)
        :requires_skill("tailor", 4)
        :precheck("check_empty")
)

content.add(
    content.Construction {
        id = "couch_to_autodoc_couch",
        group = "autodoc_couch_conversion",
        category = "OTHER",
        post_terrain = "f_autodoc_couch",
        duration_moves = 720000,
        activity_level = 2,
        requirements = content.Requirement {}
            :component("nail", 10)
            :component("cable", 1)
            :component("plastic_chunk", 2)
            :component("circuit", 1),
    }
        :requires_skill("fabrication", 6)
        :requires_skill("electronics", 3)
        :pre_terrain("f_sofa")
)

content.add(
    content.Construction {
        id = "plant_grass",
        group = "sow_grass",
        category = "OTHER",
        post_terrain = "t_grass",
        duration_moves = 500,
        activity_level = 1,
        requirements = content.Requirement {}
            :component("warp_grassbag", 1),
    }
        :requires_skill("survival", 0)
        :pre_terrain("t_dirt")
        :post_flag("keep_items")
)

content.add(
    content.Construction {
        id = "floor_to_wood_floor",
        group = "floor_to_wood_floor",
        category = "OTHER",
        post_terrain = "t_floor",
        duration_moves = 500,
        activity_level = 1,
        requirements = content.Requirement {}
            :component("warp_wood_floor_tokens", 1),
    }
        :requires_skill("survival", 0)
        :pre_flag("FLAT")
        :post_flag("keep_items")
)

content.add(
    content.Construction {
        id = "wall_to_wood_wall",
        group = "wall_to_wood_wall",
        category = "OTHER",
        post_terrain = "t_wall",
        duration_moves = 500,
        activity_level = 1,
        requirements = content.Requirement {}
            :component("warp_wood_floor_tokens", 1),
    }
        :requires_skill("survival", 0)
        :pre_flag("WALL")
        :post_flag("keep_items")
)

content.add(
    content.Construction {
        id = "floor_to_flagstone_floor",
        group = "floor_to_flagstone_floor",
        category = "OTHER",
        post_terrain = "t_stone_masonry_floor",
        duration_moves = 500,
        activity_level = 1,
        requirements = content.Requirement {}
            :component("warp_flagstone_floor_tokens", 1),
    }
        :requires_skill("survival", 0)
        :pre_flag("FLAT")
        :post_flag("keep_items")
)

content.add(
    content.Construction {
        id = "wall_to_stone_wall",
        group = "wall_to_stone_wall",
        category = "OTHER",
        post_terrain = "t_rock_wall",
        duration_moves = 500,
        activity_level = 1,
        requirements = content.Requirement {}
            :component("warp_flagstone_floor_tokens", 1),
    }
        :requires_skill("survival", 0)
        :pre_flag("WALL")
        :post_flag("keep_items")
)

content.add(
    content.Construction {
        id = "floor_to_sand_floor",
        group = "floor_to_sand_floor",
        category = "OTHER",
        post_terrain = "t_sand",
        duration_moves = 500,
        activity_level = 1,
        requirements = content.Requirement {}
            :component("warp_sand_floor_tokens", 1),
    }
        :requires_skill("survival", 0)
        :pre_flag("FLAT")
        :post_flag("keep_items")
)

content.add(
    content.Construction {
        id = "floor_to_flesh_floor",
        group = "floor_to_flesh_floor",
        category = "OTHER",
        post_terrain = "t_thconc_floor_flesh",
        duration_moves = 500,
        activity_level = 1,
        requirements = content.Requirement {}
            :component("warp_flesh_floor_tokens", 1),
    }
        :requires_skill("survival", 0)
        :pre_flag("FLAT")
        :post_flag("keep_items")
)

content.add(
    content.Construction {
        id = "wall_to_flesh_wall",
        group = "wall_to_flesh_wall",
        category = "OTHER",
        post_terrain = "t_concrete_wall_flesh",
        duration_moves = 500,
        activity_level = 1,
        requirements = content.Requirement {}
            :component("warp_flesh_floor_tokens", 1),
    }
        :requires_skill("survival", 0)
        :pre_flag("WALL")
        :post_flag("keep_items")
)

content.add(
    content.Construction {
        id = "grow_warped_apple_tree",
        group = "warped_apple_tree",
        category = "OTHER",
        post_terrain = "t_tree_apple",
        duration_moves = 720000,
        activity_level = 2,
        requirements = content.Requirement {}
            :component("warptoken", 1)
            :component_any {
                { id = "stick_long", count = 1 },
                { id = "stick", count = 2 },
                { id = "twig", count = 6 },
            }
            :component_any {
                { id = "leaves", count = 8 },
                { id = "young_leaves", count = 8 },
            }
            :component("apple", 6),
    }
        :requires_skill("survival", 3)
        :precheck("check_empty")
)

content.add(
    content.Construction {
        id = "grow_warped_cherry_tree",
        group = "warped_cherry_tree",
        category = "OTHER",
        post_terrain = "t_tree_cherry",
        duration_moves = 720000,
        activity_level = 2,
        requirements = content.Requirement {}
            :component("warptoken", 1)
            :component_any {
                { id = "stick_long", count = 1 },
                { id = "stick", count = 2 },
                { id = "twig", count = 6 },
            }
            :component_any {
                { id = "leaves", count = 8 },
                { id = "young_leaves", count = 8 },
            }
            :component("cherries", 6),
    }
        :requires_skill("survival", 3)
        :precheck("check_empty")
)

content.add(
    content.Construction {
        id = "grow_warped_maple_tree",
        group = "warped_maple_tree",
        category = "OTHER",
        post_terrain = "t_tree_maple",
        duration_moves = 720000,
        activity_level = 2,
        requirements = content.Requirement {}
            :component("warptoken", 1)
            :component_any {
                { id = "stick_long", count = 1 },
                { id = "stick", count = 2 },
                { id = "twig", count = 6 },
            }
            :component_any {
                { id = "leaves", count = 8 },
                { id = "young_leaves", count = 8 },
            }
            :component("syrup", 24),
    }
        :requires_skill("survival", 3)
        :precheck("check_empty")
)

content.add(
    content.Construction {
        id = "grow_warped_pear_tree",
        group = "warped_pear_tree",
        category = "OTHER",
        post_terrain = "t_tree_pear",
        duration_moves = 720000,
        activity_level = 2,
        requirements = content.Requirement {}
            :component("warptoken", 1)
            :component_any {
                { id = "stick_long", count = 1 },
                { id = "stick", count = 2 },
                { id = "twig", count = 6 },
            }
            :component_any {
                { id = "leaves", count = 8 },
                { id = "young_leaves", count = 8 },
            }
            :component("pear", 6),
    }
        :requires_skill("survival", 3)
        :precheck("check_empty")
)

content.add(
    content.Construction {
        id = "grow_warped_plum_tree",
        group = "warped_plum_tree",
        category = "OTHER",
        post_terrain = "t_tree_plum",
        duration_moves = 720000,
        activity_level = 2,
        requirements = content.Requirement {}
            :component("warptoken", 1)
            :component_any {
                { id = "stick_long", count = 1 },
                { id = "stick", count = 2 },
                { id = "twig", count = 6 },
            }
            :component_any {
                { id = "leaves", count = 8 },
                { id = "young_leaves", count = 8 },
            }
            :component("plums", 6),
    }
        :requires_skill("survival", 3)
        :precheck("check_empty")
)

content.add(
    content.Construction {
        id = "grow_warped_peach_tree",
        group = "warped_peach_tree",
        category = "OTHER",
        post_terrain = "t_tree_peach",
        duration_moves = 720000,
        activity_level = 2,
        requirements = content.Requirement {}
            :component("warptoken", 1)
            :component_any {
                { id = "stick_long", count = 1 },
                { id = "stick", count = 2 },
                { id = "twig", count = 6 },
            }
            :component_any {
                { id = "leaves", count = 8 },
                { id = "young_leaves", count = 8 },
            }
            :component("peach", 6),
    }
        :requires_skill("survival", 3)
        :precheck("check_empty")
)

content.add(
    content.Construction {
        id = "grow_warped_oak_tree",
        group = "warped_oak_tree",
        category = "OTHER",
        post_terrain = "t_tree",
        duration_moves = 720000,
        activity_level = 2,
        requirements = content.Requirement {}
            :component("warptoken", 1)
            :component_any {
                { id = "stick_long", count = 1 },
                { id = "stick", count = 2 },
                { id = "twig", count = 6 },
            }
            :component_any {
                { id = "leaves", count = 8 },
                { id = "young_leaves", count = 8 },
            }
            :component("acorns", 6),
    }
        :requires_skill("survival", 3)
        :precheck("check_empty")
)

content.add(
    content.Construction {
        id = "grow_warped_pine_tree",
        group = "warped_pine_tree",
        category = "OTHER",
        post_terrain = "t_tree_pine",
        duration_moves = 720000,
        activity_level = 2,
        requirements = content.Requirement {}
            :component("warptoken", 1)
            :component_any {
                { id = "stick_long", count = 1 },
                { id = "stick", count = 2 },
                { id = "twig", count = 6 },
            }
            :component_any {
                { id = "leaves", count = 8 },
                { id = "young_leaves", count = 8 },
            }
            :component("pinecone", 6),
    }
        :requires_skill("survival", 3)
        :precheck("check_empty")
)

content.add(
    content.Construction {
        id = "grow_warped_birch_tree",
        group = "warped_birch_tree",
        category = "OTHER",
        post_terrain = "t_tree_birch",
        duration_moves = 720000,
        activity_level = 2,
        requirements = content.Requirement {}
            :component("warptoken", 1)
            :component_any {
                { id = "stick_long", count = 1 },
                { id = "stick", count = 2 },
                { id = "twig", count = 6 },
            }
            :component_any {
                { id = "leaves", count = 8 },
                { id = "young_leaves", count = 8 },
            }
            :component("birchbark", 6),
    }
        :requires_skill("survival", 3)
        :precheck("check_empty")
)

content.add(
    content.Construction {
        id = "grow_warped_mulberry_tree",
        group = "warped_mulberry_tree",
        category = "OTHER",
        post_terrain = "t_tree_mulberry",
        duration_moves = 720000,
        activity_level = 2,
        requirements = content.Requirement {}
            :component("warptoken", 1)
            :component_any {
                { id = "stick_long", count = 1 },
                { id = "stick", count = 2 },
                { id = "twig", count = 6 },
            }
            :component_any {
                { id = "leaves", count = 8 },
                { id = "young_leaves", count = 8 },
            }
            :component("mulberries", 6),
    }
        :requires_skill("survival", 3)
        :precheck("check_empty")
)

-- Intention is for decoration, not to give you infinite water early
content.add(
    content.Construction {
        id = "turn_water_into_pond",
        group = "water_into_pond",
        category = "OTHER",
        post_terrain = "t_water_sh",
        duration_moves = 720000,
        activity_level = 2,
        requirements = content.Requirement {}
            :component("warptoken", 1)
            :component("water_clean", 1000),
    }
        :requires_skill("survival", 0)
        :precheck("check_empty")
)

content.add(
    content.Construction {
        id = "turn_pond_into_deep_pond",
        group = "water_into_deep_pond",
        category = "OTHER",
        post_terrain = "t_water_dp",
        duration_moves = 720000,
        activity_level = 2,
        requirements = content.Requirement {}
            :component("warptoken", 1)
            :component("water_clean", 250),
    }
        :requires_skill("survival", 0)
        :pre_terrain("t_water_sh")
)

content.add(
    content.Construction {
        id = "build_planter_from_token",
        group = "build_planter_from_token",
        category = "OTHER",
        post_terrain = "f_planter",
        duration_moves = 3000,
        activity_level = 2,
        requirements = content.Requirement {}
            :component("planter_token", 1),
    }
        :requires_skill("survival", 0)
        :precheck("check_empty")
)

content.add(
    content.Construction {
        id = "transform_door_into_glass_door",
        group = "transform_door_into_glass_door",
        category = "OTHER",
        post_terrain = "t_door_glass_c",
        duration_moves = 3000,
        activity_level = 2,
        requirements = content.Requirement {}
            :component("glass_door_token", 1),
    }
        :requires_skill("survival", 0)
        :pre_flag("DOOR")
)

content.add(
    content.Construction {
        id = "build_birdbath_from_token",
        group = "build_birdbath_from_token",
        category = "OTHER",
        post_terrain = "f_birdbath",
        duration_moves = 3000,
        activity_level = 2,
        requirements = content.Requirement {}
            :component("birdbath_token", 1),
    }
        :requires_skill("survival", 0)
        :precheck("check_empty")
)

content.add(
    content.Construction {
        id = "build_display_case_from_token",
        group = "build_display_case_from_token",
        category = "OTHER",
        post_terrain = "f_displaycase",
        duration_moves = 3000,
        activity_level = 2,
        requirements = content.Requirement {}
            :component("display_case_token", 1),
    }
        :requires_skill("survival", 0)
        :precheck("check_empty")
)

content.add(
    content.Construction {
        id = "build_statue_from_token",
        group = "build_statue_from_token",
        category = "OTHER",
        post_terrain = "f_statue",
        duration_moves = 3000,
        activity_level = 2,
        requirements = content.Requirement {}
            :component("statue_token", 1),
    }
        :requires_skill("survival", 0)
        :precheck("check_empty")
)

content.add(content.ConstructionGroup {
    id = "sow_grass",
    name = content.text("Cover soil with grass"),
})

content.add(content.ConstructionGroup {
    id = "floor_to_wood_floor",
    name = content.text("Warp floor into a wood floor"),
})

content.add(content.ConstructionGroup {
    id = "wall_to_wood_wall",
    name = content.text("Warp wall into a wood wall"),
})

content.add(content.ConstructionGroup {
    id = "floor_to_flagstone_floor",
    name = content.text("Warp floor into a worked stone floor"),
})

content.add(content.ConstructionGroup {
    id = "wall_to_stone_wall",
    name = content.text("Warp wall into a worked stone wall"),
})

content.add(content.ConstructionGroup {
    id = "floor_to_sand_floor",
    name = content.text("Warp floor into fine sand"),
})

content.add(content.ConstructionGroup {
    id = "floor_to_flesh_floor",
    name = content.text("Warp floor into living flesh"),
})

content.add(content.ConstructionGroup {
    id = "wall_to_flesh_wall",
    name = content.text("Warp wall into living flesh"),
})

content.add(content.ConstructionGroup {
    id = "autodoc_copy",
    name = content.text("Store Autodoc onto copyplate"),
})

content.add(content.ConstructionGroup {
    id = "autodoc_paste",
    name = content.text("Place Autodoc from copyplate"),
})

content.add(content.ConstructionGroup {
    id = "autodoc_couch_conversion",
    name = content.text("Convert sofa into Autodoc couch"),
})

content.add(content.ConstructionGroup {
    id = "build_sofa",
    name = content.text("Build sofa"),
})

content.add(content.ConstructionGroup {
    id = "warped_apple_tree",
    name = content.text("Grow a Warped Apple Tree"),
})

content.add(content.ConstructionGroup {
    id = "warped_cherry_tree",
    name = content.text("Grow a Warped Cherry Tree"),
})

content.add(content.ConstructionGroup {
    id = "warped_maple_tree",
    name = content.text("Grow a Warped Maple Tree"),
})

content.add(content.ConstructionGroup {
    id = "warped_pear_tree",
    name = content.text("Grow a Warped Pear Tree"),
})

content.add(content.ConstructionGroup {
    id = "warped_plum_tree",
    name = content.text("Grow a Warped Plum Tree"),
})

content.add(content.ConstructionGroup {
    id = "warped_peach_tree",
    name = content.text("Grow a Warped Peach Tree"),
})

content.add(content.ConstructionGroup {
    id = "warped_oak_tree",
    name = content.text("Grow a Warped Oak Tree"),
})

content.add(content.ConstructionGroup {
    id = "warped_pine_tree",
    name = content.text("Grow a Warped Pine Tree"),
})

content.add(content.ConstructionGroup {
    id = "warped_birch_tree",
    name = content.text("Grow a Warped Birch Tree"),
})

content.add(content.ConstructionGroup {
    id = "warped_mulberry_tree",
    name = content.text("Grow a Warped Mulberry Tree"),
})

content.add(content.ConstructionGroup {
    id = "water_into_pond",
    name = content.text("Warp water into a pond"),
})

content.add(content.ConstructionGroup {
    id = "water_into_deep_pond",
    name = content.text("Deepen a warped pond"),
})

content.add(content.ConstructionGroup {
    id = "build_birdbath_from_token",
    name = content.text("Transform the token into a birdbath"),
})

content.add(content.ConstructionGroup {
    id = "build_statue_from_token",
    name = content.text("Transform the token into a statue"),
})

content.add(content.ConstructionGroup {
    id = "build_display_case_from_token",
    name = content.text("Transform the token into a display case"),
})

content.add(content.ConstructionGroup {
    id = "build_planter_from_token",
    name = content.text("Transform the token into a display case"),
})

content.add(content.ConstructionGroup {
    id = "transform_door_into_glass_door",
    name = content.text("Transform a closed door into a glass door"),
})
