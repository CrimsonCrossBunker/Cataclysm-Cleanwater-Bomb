local ccb = require("ccb")
local content = ccb.content

do
    -- NO_I18N
    local item = content.Item {
        id = "veh_tools_abstract",
        abstract = true,
        name = content.plural_text("vehicle tool station", "vehicle tool stations"),
        category = "veh_parts",
        mass_milligrams = 40000000,
        volume_ml = 20000,
        price_cents = 40000,
        price_postapoc_cents = 2000,
        symbol = "&",
        color = "light_cyan",
    }
    item:material("steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "veh_tools_kitchen",
        copy_from = "veh_tools_abstract",
        name = ccb.content.plural_text("kitchen station", "kitchen stations"),
        description = ccb.content.text("A table rig with a faucet for water tank access, fume hood, drawers and fixtures for storing tools, low power electric connectors and valves for fuel tank connections."),
        looks_like = "kitchen_unit",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "veh_tools_workshop",
        copy_from = "veh_tools_abstract",
        name = ccb.content.plural_text("workshop station", "workshop stations"),
        description = ccb.content.text("A table rig with drawers and fixtures for storing tools, wiring for high power electric connectors and valves for fuel tank connections."),
        looks_like = "welding_rig",
    }
    content.add(item)
end
