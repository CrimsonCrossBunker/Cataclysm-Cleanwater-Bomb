local content = require("ccb").content

do
    -- Very rare high level loot. This list doesn't spawn anywhere directly, it is used to create the recipes inside nanofabricator templates.
    local group = content.ItemGroup { id = "nanofab_recipes", kind = "distribution", with_magazine = 100 }
    group:item("emp_gun", 10)
    group:item("laser_rifle", 10)
    group:item("optical_cloak", 10)
    group:item("holo_cloak", 10)
    group:item("portal", 10)
    group:item("rm13_armor", 10)
    group:item("high_density_capacitor", 10)
    group:item("beam_scatterer", 10)
    group:item("rm11b_sniper_rifle", 10)
    group:item("v29", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "launchers", kind = "distribution" }
    group:item("m320", 50)
    group:item("mgl", 60)
    group:item("m203", 50)
    group:item("LAW_Packed", 80)
    group:item("m3_carlgustav", 10)
    group:item("m4_carlgustav", 10)
    group:item("m202_flash", 20)
    group:item("atgm_launcher", 3)
    group:item("atgm_heat", 6)
    group:item("rm451_flamethrower", 40)
    content.upsert_item_group(group)
end

do
    local group = content.ItemGroup { id = "archery", kind = "distribution" }
    group:item("crossbow", 70)
    group:item("compcrossbow", 10)
    group:item("bullet_crossbow", 10)
    group:item("hand_crossbow", 10)
    group:item("bow_sling", 10)
    group:item("longbow", 40)
    group:item("compbow", 40)
    group:item("shortbow", 20)
    group:item("recurbow", 40)
    group:item("takedown_recurbow", 2)
    group:item("quiver_takedown_bow", 1)
    group:item("reflexbow", 20)
    group:item("slingshot", 50)
    group:item("wristrocket", 50)
    content.upsert_item_group(group)
end
