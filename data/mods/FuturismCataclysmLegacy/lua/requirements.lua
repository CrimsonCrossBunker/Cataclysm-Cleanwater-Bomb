local content = require("ccb").content

-- requirements/cooking_tools.json

-- surface_heat
content.merge_requirement(
    content.Requirement { id = "surface_heat" },
    content.Requirement {}
        :tool_any {
            { id = "fcl_atomic_coffeemaker", count = 1 },
            { id = "fcl_atompot", count = 1 },
        }
)

-- water_boiling_heat
content.merge_requirement(
    content.Requirement { id = "water_boiling_heat" },
    content.Requirement {}
        :tool_any {
            { id = "fcl_atomic_coffeemaker", count = 1 },
            { id = "fcl_atompot", count = 1 },
        }
)

-- requirements/vehicle.json

content.merge_requirement(
    content.Requirement { id = "solar_panel_v3" }
        :component("solar_cell_v3", 3)
        :component("cable", 2)
)
