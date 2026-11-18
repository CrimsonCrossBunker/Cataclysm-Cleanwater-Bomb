local content = require("ccb").content

do
    local group = content.ItemGroup { id = "microlab_artifacts", kind = "distribution" }
    group:item("abyss_teleport_orb", 1)
    group:entry {
        group = "twisted_geometry",
        artifact = {
            preset = "twisted_geometry",
            power_level = 750,
            max_attributes = 4,
            max_negative_power = -1000,
            resonant = true,
        },
        probability = 50,
    }
    group:entry {
        group = "ps_artifacts",
        artifact = {
            preset = "netherum_tunnels",
            power_level = 750,
            max_attributes = 4,
            max_negative_power = -1000,
            resonant = true,
        },
        probability = 50,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "altered_object_i", kind = "collection" }
    group:entry {
        group = "altered_item",
        artifact = {
            preset = "altered_object",
            power_level = 750,
            max_attributes = 4,
            max_negative_power = -1000,
            resonant = true,
        },
    }
    group:item("resonance_measurement_device", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "art_book", kind = "collection" }
    group:entry {
        item = "art_book",
        artifact = {
            preset = "artifact_book",
            power_level = 750,
            max_attributes = 3,
            max_negative_power = -1000,
            resonant = true,
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "portalmancy_i", kind = "distribution" }
    group:entry {
        group = "portalmancy",
        artifact = { preset = "portalmancy", power_level = 1000, max_attributes = 1, max_negative_power = -1000 },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "strange_temple_artifacts", kind = "distribution" }
    group:entry {
        group = "amigara_items",
        artifact = { preset = "cult", power_level = 1250, max_attributes = 4, max_negative_power = -1000, resonant = true },
    }
    content.add(group)
end
