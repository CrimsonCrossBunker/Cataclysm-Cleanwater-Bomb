local content = require("ccb").content

do
    local group = content.ItemGroup { id = "milspec_arsenal_223_pouch_gun&mags&cans", kind = "collection" }
    group:group("milspec_arsenal_223_pouch_gun&ammo")
    group:entry {
        distribution = {
            { item = "ammo_can_50_556_m855a1_clipped_840", count = { 1, 4 } },
            { item = "ammo_can_50_556tracer_820", count = { 1, 4 }, probability = 5 },
        },
    }
    content.add(group)
end
