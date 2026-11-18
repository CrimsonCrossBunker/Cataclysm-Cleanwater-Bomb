local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_ROBOFAC_SCIENTIST_GARAGE_worn", kind = "collection" }
    group:item("under_armor")
    group:item("under_armor_shorts")
    group:item("socks")
    group:item("robofac_enviro_suit")
    group:entry {
        item = "welding_papr_helmet_raised",
        contents = {
            { item = "diving_flashlight_small_hipower" },
        },
    }
    group:item("basic_papr_belt_off")
    group:item("coat_lab")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ROBOFAC_SCIENTIST_GARAGE_wield", kind = "collection" }
    group:item("red_pen")
    content.add(group)
end
