local content = require("ccb").content

do
    local group = content.ItemGroup { id = "milspec_arsenal_84x246_gun&mags&cans", kind = "collection" }
    group:group("milspec_arsenal_84x246_gun&ammo")
    group:entry {
        distribution = {
            { item = "ammunition_box_carlgustav_he", count = { 1, 4 } },
            { item = "ammunition_box_carlgustav_hedp", count = { 1, 4 } },
        },
    }
    content.add(group)
end
