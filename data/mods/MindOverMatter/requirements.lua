local content = require("ccb").content

-- recipes/recipe_requirements.json

content.merge_requirement(
    content.Requirement { id = "matrix_dust_refined" }
        :component_any {
            { id = "matrix_crystal_biokin_dust_refined", count = 1 },
            { id = "matrix_crystal_clair_dust_refined", count = 1 },
            { id = "matrix_crystal_pyrokin_dust_refined", count = 1 },
            { id = "matrix_crystal_telekin_dust_refined", count = 1 },
            { id = "matrix_crystal_telepath_dust_refined", count = 1 },
            { id = "matrix_crystal_teleport_dust_refined", count = 1 },
            { id = "matrix_crystal_vitakin_dust_refined", count = 1 },
        }
)

content.merge_requirement(
    content.Requirement { id = "surface_heat" },
    content.Requirement {}
        :tool_any {
            { id = "pyrokinetic_fire_tool", count = 1 },
            { id = "pyrokinetic_fire_tool_four_arms", count = 1 },
            { id = "pyrokinetic_fire_tool_six_arms", count = 1 },
            { id = "pyrokinetic_fire_tool_eight_arms", count = 1 },
        }
)

content.merge_requirement(
    content.Requirement { id = "water_boiling_heat" },
    content.Requirement {}
        :tool_any {
            { id = "pyrokinetic_fire_tool", count = 1 },
            { id = "pyrokinetic_fire_tool_four_arms", count = 1 },
            { id = "pyrokinetic_fire_tool_six_arms", count = 1 },
            { id = "pyrokinetic_fire_tool_eight_arms", count = 1 },
        }
)

content.merge_requirement(
    content.Requirement { id = "welding_standard" },
    content.Requirement {}
        :tool("pyrokinetic_torch_weld", 1)
)

content.merge_requirement(
    content.Requirement { id = "welding_alloys" },
    content.Requirement {}
        :tool("pyrokinetic_torch_weld", 1)
)

content.merge_requirement(
    content.Requirement { id = "repair_welding_standard" },
    content.Requirement {}
        :tool("pyrokinetic_torch_weld", 1)
)

content.merge_requirement(
    content.Requirement { id = "repair_welding_alloys" },
    content.Requirement {}
        :tool("pyrokinetic_torch_weld", 1)
)

content.merge_requirement(
    content.Requirement { id = "repair_welding_rebar" },
    content.Requirement {}
        :tool("pyrokinetic_torch_weld", 1)
)

content.merge_requirement(
    content.Requirement { id = "repair_welding_lc_steel" },
    content.Requirement {}
        :tool("pyrokinetic_torch_weld", 1)
)

content.merge_requirement(
    content.Requirement { id = "bullet_forming" }
        :tool("press", 1)
        :tool_any {
            { id = "fire", count = 1 },
            { id = "pyrokinetic_fire_tool", count = 1 },
            { id = "hotplate", charges = 2 },
            { id = "integrated_welder", charges = 2 },
        }
)

content.merge_requirement(
    content.Requirement { id = "earthenware_firing" },
    content.Requirement {}
        :tool("pyrokinetic_fire_tool", 1)
)

-- Forming of shot from raw materials
content.merge_requirement(
    content.Requirement { id = "shot_forming" }
        :tool_any {
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 },
            { id = "iron_pot", count = 1 },
            { id = "pan", count = 1 },
            { id = "pot_makeshift", count = 1 },
        }
        :tool_any {
            { id = "water", charges = 1 },
            { id = "water_clean", count = 1 },
            { id = "salt_water", count = 1 },
            { id = "water_sewage", count = 1 },
        }
        :tool_any {
            { id = "ladle", count = 1 },
            { id = "ceramic_mug", count = 1 },
            { id = "ceramic_cup", count = 1 },
            { id = "teapot", count = 1 },
            { id = "clay_teapot", count = 1 },
            { id = "can_food", count = 1 },
        }
        :tool_any {
            { id = "fire", count = 1 },
            { id = "pyrokinetic_fire_tool", count = 1 },
            { id = "hotplate", charges = 2 },
            { id = "integrated_welder", charges = 2 },
        }
)

content.merge_requirement(
    content.Requirement { id = "eggs_bird" },
    content.Requirement {}
        :component_any {
            { id = "egg_cockatrice", count = 1 },
            { id = "egg_pigeon_passenger", count = 1 },
        }
)
