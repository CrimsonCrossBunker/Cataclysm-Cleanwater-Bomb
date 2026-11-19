local ccb = require("ccb")
local content = ccb.content

content.add(content.TerrainTransform { id = "ter_pyrokin_quell_fire" }
    :field {
        inputs = { "fd_fire" },
        results = { "fd_null" },
        message = ccb.content.text("The fire gutters and dies!"),
        message_good = true,
    })

content.add(content.TerrainTransform { id = "ter_null_zombie_delete_fields" }
    :field {
        inputs = { "fd_nullifying_field", "fd_neutralizing_field" },
        results = { "fd_null" },
    })

content.add(content.TerrainTransform { id = "telekinetic_earthshaker_transform" }
    :terrain {
        inputs = { "t_grass" },
        results = { { "t_grass", 10 }, "t_pit_shallow" },
    }
    :terrain {
        inputs = { "t_grass_long" },
        results = { { "t_grass_long", 10 }, "t_pit_shallow" },
    }
    :terrain {
        inputs = { "t_dirt" },
        results = { { "t_dirt", 10 }, "t_pit_shallow" },
    }
    :terrain {
        inputs = { "t_dirtfloor" },
        results = { { "t_dirtfloor", 10 }, "t_pit_shallow" },
    }
    :terrain {
        inputs = { "t_dirtfloor_no_roof" },
        results = { { "t_dirtfloor_no_roof", 10 }, "t_pit_shallow" },
    }
    :terrain {
        inputs = { "t_dirtmoundfloor" },
        results = { { "t_dirtmoundfloor", 10 }, "t_pit_shallow" },
    }
    :terrain {
        inputs = { "t_dirtmound" },
        results = { { "t_dirtmound", 10 }, "t_pit_shallow" },
    }
    :terrain {
        inputs = { "t_grass_dead" },
        results = { { "t_grass_dead", 10 }, "t_pit_shallow" },
    }
    :terrain {
        inputs = { "t_grass_white" },
        results = { { "t_grass_white", 10 }, "t_pit_shallow" },
    }
    :terrain {
        inputs = { "t_sand" },
        results = { { "t_sand", 10 }, "t_pit_shallow" },
    }
    :terrain {
        inputs = { "t_clay" },
        results = { { "t_clay", 10 }, "t_pit_shallow" },
    }
    :terrain {
        inputs = { "t_sandmound" },
        results = { { "t_sandmound", 10 }, "t_pit_shallow" },
    }
    :terrain {
        inputs = { "t_forestfloor" },
        results = { { "t_forestfloor", 10 }, "t_pit_shallow" },
    }
    :terrain {
        inputs = { "t_grass_tall" },
        results = { { "t_grass_tall", 10 }, "t_pit_shallow" },
    }
    :terrain {
        inputs = { "t_fungus_floor_in" },
        results = { { "t_fungus_floor_in", 10 }, "t_pit_shallow" },
    }
    :terrain {
        inputs = { "t_fungus_floor_sup" },
        results = { { "t_fungus_floor_sup", 10 }, "t_pit_shallow" },
    }
    :terrain {
        inputs = { "t_fungus_floor_out" },
        results = { { "t_fungus_floor_out", 10 }, "t_pit_shallow" },
    }
    :terrain {
        inputs = { "t_sandbox" },
        results = { { "t_sandbox", 10 }, "t_pit_shallow" },
    }
    :terrain {
        inputs = { "t_pit_shallow" },
        results = { { "t_pit_shallow", 10 }, "t_dirt", "t_pit" },
    }
    :terrain {
        inputs = { "t_pit" },
        results = { { "t_pit", 10 }, "t_pit_shallow" },
    }
    :furniture {
        inputs = { "f_null" },
        results = { { "f_null", 15 }, "f_rubble_rock" },
    })
