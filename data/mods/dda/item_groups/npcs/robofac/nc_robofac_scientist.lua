local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_ROBOFAC_SCIENTIST_worn", kind = "collection" }
    group:entry { item = "under_armor", damage = { 0, 2 } }
    group:entry { item = "under_armor_shorts", damage = { 0, 2 } }
    group:entry { item = "jumpsuit", damage = { 0, 2 }, variant = "robofac" }
    group:entry { group = "robofac_mantle_prototype", damage = { 0, 2 } }
    group:entry {
        item = "coat_lab",
        damage = { 0, 2 },
        contents = {
            { item = "sunglasses" },
            { item = "grenade_emp" },
            { item = "grenade_emp" },
        },
    }
    group:entry { item = "black_pen", charges = { 50, 100 } }
    group:entry { item = "red_pen", charges = { 50, 100 }, probability = 40 }
    group:entry { item = "pencil", damage = { 0, 2 } }
    group:entry { item = "paper", count = { 2, 3 } }
    group:entry { item = "laptop", charges = { 300, 500 } }
    group:entry { item = "nic_gum", count = { 5, 10 } }
    group:entry { item = "water_clean", charges = { 2, 6 }, container = "canteen", probability = 50 }
    group:item("boots")
    content.add(group)
end
