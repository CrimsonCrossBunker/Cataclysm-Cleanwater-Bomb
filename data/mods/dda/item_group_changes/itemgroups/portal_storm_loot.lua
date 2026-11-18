local content = require("ccb").content

do
    local group = content.ItemGroup { id = "ps_artifact_weak", kind = "distribution" }
    group:entry {
        group = "ps_artifacts",
        artifact = {
            preset = "netherum_tunnels",
            power_level = 500,
            max_attributes = 3,
            max_negative_power = -750,
            resonant = true,
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "ps_artifact_medium", kind = "distribution" }
    group:entry {
        group = "ps_artifacts",
        artifact = {
            preset = "netherum_tunnels",
            power_level = 750,
            max_attributes = 4,
            max_negative_power = -1000,
            resonant = true,
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "ps_artifact_strong", kind = "distribution" }
    group:entry {
        group = "ps_artifacts",
        artifact = {
            preset = "netherum_tunnels",
            power_level = 1000,
            max_attributes = 5,
            max_negative_power = -1250,
            resonant = true,
        },
    }
    content.add(group)
end
