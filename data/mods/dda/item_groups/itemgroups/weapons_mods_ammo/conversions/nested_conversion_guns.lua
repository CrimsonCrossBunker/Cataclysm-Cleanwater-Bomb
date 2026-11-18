local content = require("ccb").content

do
    -- An item group for a random, personally-converted weapon to spawn.
    local group = content.ItemGroup { id = "nested_converted_mdrx", kind = "collection" }
    group:entry {
        distribution = {
            { group = "nested_mdrx_retool_223rem", probability = 30 },
            { group = "nested_mdrx_retool_300blk", probability = 20 },
            { group = "nested_mdrx_retool_308win", probability = 15 },
        },
    }
    content.add(group)
end

do
    -- An item group for a random, personally-converted weapon to spawn.
    local group = content.ItemGroup { id = "nested_converted_axmc", kind = "collection" }
    group:entry {
        distribution = {
            { group = "nested_axmc_retool_300win", probability = 20 },
            { group = "nested_axmc_retool_308win", probability = 20 },
        },
    }
    content.add(group)
end
