local content = require("ccb").content

do
    local group = content.ItemGroup { id = "milspec_arsenal_9mm_sub_gun&mags&cans", kind = "collection" }
    group:group("milspec_arsenal_9mm_sub_gun&ammo")
    group:entry {
        distribution = {
            { item = "ammo_can_30_9mm_fmj_1000", count = { 1, 4 } },
            { item = "ammo_can_30_9mm_jhp_1000", count = { 1, 4 } },
        },
    }
    content.add(group)
end
