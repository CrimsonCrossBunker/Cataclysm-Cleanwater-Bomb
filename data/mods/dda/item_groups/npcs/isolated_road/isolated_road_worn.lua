local content = require("ccb").content

do
    local group = content.ItemGroup { id = "CODY_MILLER_worn", kind = "collection" }
    group:item("tank_top")
    group:item("under_armor_shorts")
    group:item("apron_leather")
    group:item("jeans")
    group:item("gloves_work")
    group:entry { item = "knife_combat", container = "bootsheath" }
    group:item("welding_mask_raised")
    group:item("fanny")
    group:item("socks")
    group:item("boots_steel")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "CODY_MILLER_wield", kind = "collection" }
    group:item("hammer")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "JAY_RUCKERS_wield", kind = "collection" }
    group:item("screwdriver")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "JAY_RUCKERS_carry", kind = "collection" }
    group:item("screwdriver_set")
    group:item("metal_file")
    group:item("press")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "CODY_MILLER_carry", kind = "collection" }
    group:entry {
        item = "ear_plugs",
        flags = {
            "no_auto_equip",
        },
    }
    group:item("swage")
    group:item("metal_file")
    group:item("metalworking_tongs")
    group:item("hotcut")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "JAY_RUCKERS_worn", kind = "collection" }
    group:item("tshirt")
    group:group("ballistic_vest_light_pristine")
    group:item("boxer_briefs")
    group:item("jeans")
    group:entry { item = "fn57", charges = { 20, 20 }, container = "tactical_holster", ammo = { item = "57mm" } }
    group:item("powered_earmuffs")
    group:item("glasses_bal")
    group:item("mbag")
    group:item("socks")
    group:item("boots_combat")
    content.add(group)
end
