local content = require("ccb").content

local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "fbms_2_storage_1",
    result = "fbms_2_storage_1",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Place 12 pieces of storage furniture providing 1 ½ aisle of storage."),
}
    :camp_blueprint {
        update = "fbms_2_storage_1",
        name = content.text("place 1 ½ aisles of storage in section A"),
        provides = {
            { id = "fbms_2_storage_1" },
        },
        requires = {
            { id = "fbms_2_1" },
        },
        excludes = {
            { id = "fbms_2_storage_1" },
        },
        parameter_labels = {
            ["fbms_2_storage_palette"] = {
                ["fbms_2_bookcase_palette"] = content.text("Bookcases (2000 L storage, contents visible from a distance, blocks LoS)"),
                ["fbms_2_dresser_palette"] = content.text("Dressers (2000 L storage, contents not visible from a distance, doesn't block LoS)"),
                ["fbms_2_locker_palette"] = content.text("Lockers (2000 L storage, contents not visible from a distance, blocks LoS). Consider if bookcases or dressers might be better."),
                ["fbms_2_rack_palette"] = content.text("Display racks (1750 L storage, contents visible from a distance, doesn't block LoS)"),
                ["fbms_2_rack_wood_palette"] = content.text("Wooden racks (1500 L storage, contents visible from a distance, doesn't block LoS)"),
                ["fbms_2_warehouse_shelf_palette"] = content.text("Warehouse shelves (3500 L storage, contents visible from a distance, blocks LoS). The king of storage space, with a royal resource price tag."),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbms_2_storage_2",
    result = "fbms_2_storage_2",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Place 12 pieces of storage furniture providing 1 ½ aisle of storage."),
}
    :camp_blueprint {
        update = "fbms_2_storage_2",
        name = content.text("place 1 ½ aisles of storage in section B"),
        provides = {
            { id = "fbms_2_storage_2" },
        },
        requires = {
            { id = "fbms_2_2" },
        },
        excludes = {
            { id = "fbms_2_storage_2" },
        },
        parameter_labels = {
            ["fbms_2_storage_palette"] = {
                ["fbms_2_bookcase_palette"] = content.text("Bookcases (2000 L storage, contents visible from a distance, blocks LoS)"),
                ["fbms_2_dresser_palette"] = content.text("Dressers (2000 L storage, contents not visible from a distance, doesn't block LoS)"),
                ["fbms_2_locker_palette"] = content.text("Lockers (2000 L storage, contents not visible from a distance, blocks LoS). Consider if bookcases or dressers might be better."),
                ["fbms_2_rack_palette"] = content.text("Display racks (1750 L storage, contents visible from a distance, doesn't block LoS)"),
                ["fbms_2_rack_wood_palette"] = content.text("Wooden racks (1500 L storage, contents visible from a distance, doesn't block LoS)"),
                ["fbms_2_warehouse_shelf_palette"] = content.text("Warehouse shelves (3500 L storage, contents visible from a distance, blocks LoS). The king of storage space, with a royal resource price tag."),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbms_2_storage_3",
    result = "fbms_2_storage_3",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Place 12 pieces of storage furniture providing 1 ½ aisle of storage."),
}
    :camp_blueprint {
        update = "fbms_2_storage_3",
        name = content.text("place 1 ½ aisles of storage in section C"),
        provides = {
            { id = "fbms_2_storage_3" },
        },
        requires = {
            { id = "fbms_2_3" },
        },
        excludes = {
            { id = "fbms_2_storage_3" },
        },
        parameter_labels = {
            ["fbms_2_storage_palette"] = {
                ["fbms_2_bookcase_palette"] = content.text("Bookcases (2000 L storage, contents visible from a distance, blocks LoS)"),
                ["fbms_2_dresser_palette"] = content.text("Dressers (2000 L storage, contents not visible from a distance, doesn't block LoS)"),
                ["fbms_2_locker_palette"] = content.text("Lockers (2000 L storage, contents not visible from a distance, blocks LoS). Consider if bookcases or dressers might be better."),
                ["fbms_2_rack_palette"] = content.text("Display racks (1750 L storage, contents visible from a distance, doesn't block LoS)"),
                ["fbms_2_rack_wood_palette"] = content.text("Wooden racks (1500 L storage, contents visible from a distance, doesn't block LoS)"),
                ["fbms_2_warehouse_shelf_palette"] = content.text("Warehouse shelves (3500 L storage, contents visible from a distance, blocks LoS). The king of storage space, with a royal resource price tag."),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbms_2_storage_4",
    result = "fbms_2_storage_4",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Place 12 pieces of storage furniture providing 1 ½ aisle of storage."),
}
    :camp_blueprint {
        update = "fbms_2_storage_4",
        name = content.text("place 1 ½ aisles of storage in section D"),
        provides = {
            { id = "fbms_2_storage_4" },
        },
        requires = {
            { id = "fbms_2_3" },
        },
        excludes = {
            { id = "fbms_2_storage_4" },
        },
        parameter_labels = {
            ["fbms_2_storage_palette"] = {
                ["fbms_2_bookcase_palette"] = content.text("Bookcases (2000 L storage, contents visible from a distance, blocks LoS)"),
                ["fbms_2_dresser_palette"] = content.text("Dressers (2000 L storage, contents not visible from a distance, doesn't block LoS)"),
                ["fbms_2_locker_palette"] = content.text("Lockers (2000 L storage, contents not visible from a distance, blocks LoS). Consider if bookcases or dressers might be better."),
                ["fbms_2_rack_palette"] = content.text("Display racks (1750 L storage, contents visible from a distance, doesn't block LoS)"),
                ["fbms_2_rack_wood_palette"] = content.text("Wooden racks (1500 L storage, contents visible from a distance, doesn't block LoS)"),
                ["fbms_2_warehouse_shelf_palette"] = content.text("Warehouse shelves (3500 L storage, contents visible from a distance, blocks LoS). The king of storage space, with a royal resource price tag."),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbms_2_storage_5",
    result = "fbms_2_storage_5",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Place 12 pieces of storage furniture providing 1 ½ aisle of storage."),
}
    :camp_blueprint {
        update = "fbms_2_storage_5",
        name = content.text("place 1 ½ aisles of storage in section E"),
        provides = {
            { id = "fbms_2_storage_5" },
        },
        requires = {
            { id = "fbms_2_4" },
        },
        excludes = {
            { id = "fbms_2_storage_5" },
        },
        parameter_labels = {
            ["fbms_2_storage_palette"] = {
                ["fbms_2_bookcase_palette"] = content.text("Bookcases (2000 L storage, contents visible from a distance, blocks LoS)"),
                ["fbms_2_dresser_palette"] = content.text("Dressers (2000 L storage, contents not visible from a distance, doesn't block LoS)"),
                ["fbms_2_locker_palette"] = content.text("Lockers (2000 L storage, contents not visible from a distance, blocks LoS). Consider if bookcases or dressers might be better."),
                ["fbms_2_rack_palette"] = content.text("Display racks (1750 L storage, contents visible from a distance, doesn't block LoS)"),
                ["fbms_2_rack_wood_palette"] = content.text("Wooden racks (1500 L storage, contents visible from a distance, doesn't block LoS)"),
                ["fbms_2_warehouse_shelf_palette"] = content.text("Warehouse shelves (3500 L storage, contents visible from a distance, blocks LoS). The king of storage space, with a royal resource price tag."),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbms_2_storage_6",
    result = "fbms_2_storage_6",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Place 12 pieces of storage furniture providing 1 ½ aisle of storage."),
}
    :camp_blueprint {
        update = "fbms_2_storage_6",
        name = content.text("place 1 ½ aisles of storage in section F"),
        provides = {
            { id = "fbms_2_storage_6" },
        },
        requires = {
            { id = "fbms_2_5" },
        },
        excludes = {
            { id = "fbms_2_storage_6" },
        },
        parameter_labels = {
            ["fbms_2_storage_palette"] = {
                ["fbms_2_bookcase_palette"] = content.text("Bookcases (2000 L storage, contents visible from a distance, blocks LoS)"),
                ["fbms_2_dresser_palette"] = content.text("Dressers (2000 L storage, contents not visible from a distance, doesn't block LoS)"),
                ["fbms_2_locker_palette"] = content.text("Lockers (2000 L storage, contents not visible from a distance, blocks LoS). Consider if bookcases or dressers might be better."),
                ["fbms_2_rack_palette"] = content.text("Display racks (1750 L storage, contents visible from a distance, doesn't block LoS)"),
                ["fbms_2_rack_wood_palette"] = content.text("Wooden racks (1500 L storage, contents visible from a distance, doesn't block LoS)"),
                ["fbms_2_warehouse_shelf_palette"] = content.text("Warehouse shelves (3500 L storage, contents visible from a distance, blocks LoS). The king of storage space, with a royal resource price tag."),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbms_2_storage_7",
    result = "fbms_2_storage_7",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Place 12 pieces of storage furniture providing 1 ½ aisle of storage."),
}
    :camp_blueprint {
        update = "fbms_2_storage_7",
        name = content.text("place 1 ½ aisles of storage in section G"),
        provides = {
            { id = "fbms_2_storage_7" },
        },
        requires = {
            { id = "fbms_2_6" },
        },
        excludes = {
            { id = "fbms_2_storage_7" },
        },
        parameter_labels = {
            ["fbms_2_storage_palette"] = {
                ["fbms_2_bookcase_palette"] = content.text("Bookcases (2000 L storage, contents visible from a distance, blocks LoS)"),
                ["fbms_2_dresser_palette"] = content.text("Dressers (2000 L storage, contents not visible from a distance, doesn't block LoS)"),
                ["fbms_2_locker_palette"] = content.text("Lockers (2000 L storage, contents not visible from a distance, blocks LoS). Consider if bookcases or dressers might be better."),
                ["fbms_2_rack_palette"] = content.text("Display racks (1750 L storage, contents visible from a distance, doesn't block LoS)"),
                ["fbms_2_rack_wood_palette"] = content.text("Wooden racks (1500 L storage, contents visible from a distance, doesn't block LoS)"),
                ["fbms_2_warehouse_shelf_palette"] = content.text("Warehouse shelves (3500 L storage, contents visible from a distance, blocks LoS). The king of storage space, with a royal resource price tag."),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbms_2_storage_8",
    result = "fbms_2_storage_8",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Place 12 pieces of storage furniture providing 1 ½ aisle of storage."),
}
    :camp_blueprint {
        update = "fbms_2_storage_8",
        name = content.text("place 1 ½ aisles of storage in section H"),
        provides = {
            { id = "fbms_2_storage_8" },
        },
        requires = {
            { id = "fbms_2_6" },
        },
        excludes = {
            { id = "fbms_2_storage_8" },
        },
        parameter_labels = {
            ["fbms_2_storage_palette"] = {
                ["fbms_2_bookcase_palette"] = content.text("Bookcases (2000 L storage, contents visible from a distance, blocks LoS)"),
                ["fbms_2_dresser_palette"] = content.text("Dressers (2000 L storage, contents not visible from a distance, doesn't block LoS)"),
                ["fbms_2_locker_palette"] = content.text("Lockers (2000 L storage, contents not visible from a distance, blocks LoS). Consider if bookcases or dressers might be better."),
                ["fbms_2_rack_palette"] = content.text("Display racks (1750 L storage, contents visible from a distance, doesn't block LoS)"),
                ["fbms_2_rack_wood_palette"] = content.text("Wooden racks (1500 L storage, contents visible from a distance, doesn't block LoS)"),
                ["fbms_2_warehouse_shelf_palette"] = content.text("Warehouse shelves (3500 L storage, contents visible from a distance, blocks LoS). The king of storage space, with a royal resource price tag."),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbms_2_storage_9",
    result = "fbms_2_storage_9",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Place 12 pieces of storage furniture providing 1 ½ aisle of storage."),
}
    :camp_blueprint {
        update = "fbms_2_storage_9",
        name = content.text("place 1 ½ aisles of storage in section I"),
        provides = {
            { id = "fbms_2_storage_9" },
        },
        requires = {
            { id = "fbms_2_7" },
        },
        excludes = {
            { id = "fbms_2_storage_9" },
        },
        parameter_labels = {
            ["fbms_2_storage_palette"] = {
                ["fbms_2_bookcase_palette"] = content.text("Bookcases (2000 L storage, contents visible from a distance, blocks LoS)"),
                ["fbms_2_dresser_palette"] = content.text("Dressers (2000 L storage, contents not visible from a distance, doesn't block LoS)"),
                ["fbms_2_locker_palette"] = content.text("Lockers (2000 L storage, contents not visible from a distance, blocks LoS). Consider if bookcases or dressers might be better."),
                ["fbms_2_rack_palette"] = content.text("Display racks (1750 L storage, contents visible from a distance, doesn't block LoS)"),
                ["fbms_2_rack_wood_palette"] = content.text("Wooden racks (1500 L storage, contents visible from a distance, doesn't block LoS)"),
                ["fbms_2_warehouse_shelf_palette"] = content.text("Warehouse shelves (3500 L storage, contents visible from a distance, blocks LoS). The king of storage space, with a royal resource price tag."),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbms_2_storage_10",
    result = "fbms_2_storage_10",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Place 12 pieces of storage furniture providing 1 ½ aisle of storage."),
}
    :camp_blueprint {
        update = "fbms_2_storage_10",
        name = content.text("place 1 ½ aisles of storage in section J"),
        provides = {
            { id = "fbms_2_storage_10" },
        },
        requires = {
            { id = "fbms_2_8" },
        },
        excludes = {
            { id = "fbms_2_storage_10" },
        },
        parameter_labels = {
            ["fbms_2_storage_palette"] = {
                ["fbms_2_bookcase_palette"] = content.text("Bookcases (2000 L storage, contents visible from a distance, blocks LoS)"),
                ["fbms_2_dresser_palette"] = content.text("Dressers (2000 L storage, contents not visible from a distance, doesn't block LoS)"),
                ["fbms_2_locker_palette"] = content.text("Lockers (2000 L storage, contents not visible from a distance, blocks LoS). Consider if bookcases or dressers might be better."),
                ["fbms_2_rack_palette"] = content.text("Display racks (1750 L storage, contents visible from a distance, doesn't block LoS)"),
                ["fbms_2_rack_wood_palette"] = content.text("Wooden racks (1500 L storage, contents visible from a distance, doesn't block LoS)"),
                ["fbms_2_warehouse_shelf_palette"] = content.text("Warehouse shelves (3500 L storage, contents visible from a distance, blocks LoS). The king of storage space, with a royal resource price tag."),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbms_2_storage_11",
    result = "fbms_2_storage_11",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Place 12 pieces of storage furniture providing 1 ½ aisle of storage."),
}
    :camp_blueprint {
        update = "fbms_2_storage_11",
        name = content.text("place 1 ½ aisles of storage in section K"),
        provides = {
            { id = "fbms_2_storage_11" },
        },
        requires = {
            { id = "fbms_2_9" },
        },
        excludes = {
            { id = "fbms_2_storage_11" },
        },
        parameter_labels = {
            ["fbms_2_storage_palette"] = {
                ["fbms_2_bookcase_palette"] = content.text("Bookcases (2000 L storage, contents visible from a distance, blocks LoS)"),
                ["fbms_2_dresser_palette"] = content.text("Dressers (2000 L storage, contents not visible from a distance, doesn't block LoS)"),
                ["fbms_2_locker_palette"] = content.text("Lockers (2000 L storage, contents not visible from a distance, blocks LoS). Consider if bookcases or dressers might be better."),
                ["fbms_2_rack_palette"] = content.text("Display racks (1750 L storage, contents visible from a distance, doesn't block LoS)"),
                ["fbms_2_rack_wood_palette"] = content.text("Wooden racks (1500 L storage, contents visible from a distance, doesn't block LoS)"),
                ["fbms_2_warehouse_shelf_palette"] = content.text("Warehouse shelves (3500 L storage, contents visible from a distance, blocks LoS). The king of storage space, with a royal resource price tag."),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbms_2_storage_12",
    result = "fbms_2_storage_12",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Place 12 pieces of storage furniture providing 1 ½ aisle of storage."),
}
    :camp_blueprint {
        update = "fbms_2_storage_12",
        name = content.text("place 1 ½ aisles of storage in section L"),
        provides = {
            { id = "fbms_2_storage_12" },
        },
        requires = {
            { id = "fbms_2_9" },
        },
        excludes = {
            { id = "fbms_2_storage_12" },
        },
        parameter_labels = {
            ["fbms_2_storage_palette"] = {
                ["fbms_2_bookcase_palette"] = content.text("Bookcases (2000 L storage, contents visible from a distance, blocks LoS)"),
                ["fbms_2_dresser_palette"] = content.text("Dressers (2000 L storage, contents not visible from a distance, doesn't block LoS)"),
                ["fbms_2_locker_palette"] = content.text("Lockers (2000 L storage, contents not visible from a distance, blocks LoS). Consider if bookcases or dressers might be better."),
                ["fbms_2_rack_palette"] = content.text("Display racks (1750 L storage, contents visible from a distance, doesn't block LoS)"),
                ["fbms_2_rack_wood_palette"] = content.text("Wooden racks (1500 L storage, contents visible from a distance, doesn't block LoS)"),
                ["fbms_2_warehouse_shelf_palette"] = content.text("Warehouse shelves (3500 L storage, contents visible from a distance, blocks LoS). The king of storage space, with a royal resource price tag."),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbms_2_storage_13",
    result = "fbms_2_storage_13",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Place 12 pieces of storage furniture providing 1 ½ aisle of storage."),
}
    :camp_blueprint {
        update = "fbms_2_storage_13",
        name = content.text("place 1 ½ aisles of storage in section M"),
        provides = {
            { id = "fbms_2_storage_13" },
        },
        requires = {
            { id = "fbms_2_10" },
        },
        excludes = {
            { id = "fbms_2_storage_13" },
        },
        parameter_labels = {
            ["fbms_2_storage_palette"] = {
                ["fbms_2_bookcase_palette"] = content.text("Bookcases (2000 L storage, contents visible from a distance, blocks LoS)"),
                ["fbms_2_dresser_palette"] = content.text("Dressers (2000 L storage, contents not visible from a distance, doesn't block LoS)"),
                ["fbms_2_locker_palette"] = content.text("Lockers (2000 L storage, contents not visible from a distance, blocks LoS). Consider if bookcases or dressers might be better."),
                ["fbms_2_rack_palette"] = content.text("Display racks (1750 L storage, contents visible from a distance, doesn't block LoS)"),
                ["fbms_2_rack_wood_palette"] = content.text("Wooden racks (1500 L storage, contents visible from a distance, doesn't block LoS)"),
                ["fbms_2_warehouse_shelf_palette"] = content.text("Warehouse shelves (3500 L storage, contents visible from a distance, blocks LoS). The king of storage space, with a royal resource price tag."),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbms_2_storage_14",
    result = "fbms_2_storage_14",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Place 12 pieces of storage furniture providing 1 ½ aisle of storage."),
}
    :camp_blueprint {
        update = "fbms_2_storage_14",
        name = content.text("place 1 ½ aisles of storage in section N"),
        provides = {
            { id = "fbms_2_storage_14" },
        },
        requires = {
            { id = "fbms_2_11" },
        },
        excludes = {
            { id = "fbms_2_storage_14" },
        },
        parameter_labels = {
            ["fbms_2_storage_palette"] = {
                ["fbms_2_bookcase_palette"] = content.text("Bookcases (2000 L storage, contents visible from a distance, blocks LoS)"),
                ["fbms_2_dresser_palette"] = content.text("Dressers (2000 L storage, contents not visible from a distance, doesn't block LoS)"),
                ["fbms_2_locker_palette"] = content.text("Lockers (2000 L storage, contents not visible from a distance, blocks LoS). Consider if bookcases or dressers might be better."),
                ["fbms_2_rack_palette"] = content.text("Display racks (1750 L storage, contents visible from a distance, doesn't block LoS)"),
                ["fbms_2_rack_wood_palette"] = content.text("Wooden racks (1500 L storage, contents visible from a distance, doesn't block LoS)"),
                ["fbms_2_warehouse_shelf_palette"] = content.text("Warehouse shelves (3500 L storage, contents visible from a distance, blocks LoS). The king of storage space, with a royal resource price tag."),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbms_2_storage_15",
    result = "fbms_2_storage_15",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Place 12 pieces of storage furniture providing 1 ½ aisle of storage."),
}
    :camp_blueprint {
        update = "fbms_2_storage_15",
        name = content.text("place 1 ½ aisles of storage in section O"),
        provides = {
            { id = "fbms_2_storage_15" },
        },
        requires = {
            { id = "fbms_2_12" },
        },
        excludes = {
            { id = "fbms_2_storage_15" },
        },
        parameter_labels = {
            ["fbms_2_storage_palette"] = {
                ["fbms_2_bookcase_palette"] = content.text("Bookcases (2000 L storage, contents visible from a distance, blocks LoS)"),
                ["fbms_2_dresser_palette"] = content.text("Dressers (2000 L storage, contents not visible from a distance, doesn't block LoS)"),
                ["fbms_2_locker_palette"] = content.text("Lockers (2000 L storage, contents not visible from a distance, blocks LoS). Consider if bookcases or dressers might be better."),
                ["fbms_2_rack_palette"] = content.text("Display racks (1750 L storage, contents visible from a distance, doesn't block LoS)"),
                ["fbms_2_rack_wood_palette"] = content.text("Wooden racks (1500 L storage, contents visible from a distance, doesn't block LoS)"),
                ["fbms_2_warehouse_shelf_palette"] = content.text("Warehouse shelves (3500 L storage, contents visible from a distance, blocks LoS). The king of storage space, with a royal resource price tag."),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbms_2_storage_16",
    result = "fbms_2_storage_16",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Place 12 pieces of storage furniture providing 1 ½ aisle of storage."),
}
    :camp_blueprint {
        update = "fbms_2_storage_16",
        name = content.text("place 1 ½ aisles of storage in section P"),
        provides = {
            { id = "fbms_2_storage_16" },
        },
        requires = {
            { id = "fbms_2_12" },
        },
        excludes = {
            { id = "fbms_2_storage_16" },
        },
        parameter_labels = {
            ["fbms_2_storage_palette"] = {
                ["fbms_2_bookcase_palette"] = content.text("Bookcases (2000 L storage, contents visible from a distance, blocks LoS)"),
                ["fbms_2_dresser_palette"] = content.text("Dressers (2000 L storage, contents not visible from a distance, doesn't block LoS)"),
                ["fbms_2_locker_palette"] = content.text("Lockers (2000 L storage, contents not visible from a distance, blocks LoS). Consider if bookcases or dressers might be better."),
                ["fbms_2_rack_palette"] = content.text("Display racks (1750 L storage, contents visible from a distance, doesn't block LoS)"),
                ["fbms_2_rack_wood_palette"] = content.text("Wooden racks (1500 L storage, contents visible from a distance, doesn't block LoS)"),
                ["fbms_2_warehouse_shelf_palette"] = content.text("Warehouse shelves (3500 L storage, contents visible from a distance, blocks LoS). The king of storage space, with a royal resource price tag."),
            },
        },
    }
)
