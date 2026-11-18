local content = require("ccb").content

do
    local group = content.ItemGroup { id = "CODY_MILLER_trade", kind = "collection" }
    group:entry { group = "sca_smith_manuals", count = { 0, 4 } }
    group:entry { group = "sca_smith_armor", count = { 4, 8 } }
    group:entry { group = "sca_smith_ranged", count = { 0, 4 } }
    group:entry { group = "sca_smith_weapons", count = { 0, 4 } }
    group:entry { group = "sca_smith_accessories", count = { 0, 4 } }
    group:entry { group = "sca_smith_ammo", count = { 0, 8 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "JAY_RUCKERS_trade", kind = "collection" }
    group:entry { group = "ammo_common_boxed", count = { 1, 1 } }
    group:entry { group = "guns_rifle_milspec", count = { 1, 1 } }
    group:entry { group = "gunsmith_basic_ammo", count = { 4, 16 } }
    group:entry { group = "gunsmith_repack_ammo", count = { 9, 18 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "sca_smith_armor", kind = "distribution" }
    group:item("gambeson", 2)
    group:item("armor_lamellar", 2)
    group:item("cuirass_lightplate", 2)
    group:item("armor_lc_armguard", 2)
    group:item("armor_lc_leg_guard", 2)
    group:item("armor_samurai", 2)
    group:item("helmet_kabuto", 2)
    group:item("gloves_plate", 2)
    group:item("boots_plate", 2)
    group:item("helmet_barbute", 2)
    group:item("helmet_conical", 2)
    group:item("helmet_galea", 2)
    group:item("helmet_nasal", 2)
    group:item("helmet_kettle", 2)
    group:item("helmet_sallet", 2)
    group:item("helmet_armet", 2)
    group:item("legguard_metal", 2)
    group:item("helmet_plate", 2)
    group:item("helmet_larmor", 2)
    group:item("boots_larmor", 2)
    group:item("armor_larmor", 2)
    group:item("armguard_larmor", 2)
    group:item("vambrace_larmor", 2)
    group:item("helmet_corinthian", 2)
    group:item("armor_cuirass", 2)
    group:item("legguard_bronze", 2)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "sca_smith_manuals", kind = "distribution" }
    group:item("textbook_weapwest", 5)
    group:item("textbook_weapeast", 5)
    group:item("textbook_armwest", 5)
    group:item("textbook_armeast", 5)
    group:item("textbook_armschina", 5)
    group:item("textbook_weparabic", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "sca_smith_weapons", kind = "distribution" }
    group:item("katana", 1)
    group:item("cestus", 1)
    group:item("mace", 3)
    group:item("morningstar", 3)
    group:item("glaive", 2)
    group:item("rapier", 2)
    group:item("cavalry_sabre", 2)
    group:item("estoc", 2)
    group:item("cutlass", 2)
    group:item("scimitar", 2)
    group:item("arming_sword", 4)
    group:item("broadsword", 4)
    group:item("longsword", 3)
    group:item("zweihander", 2)
    group:item("battleaxe", 2)
    group:item("warhammer", 2)
    group:item("halberd", 4)
    group:item("lucern_hammer", 2)
    group:item("pike", 2)
    group:item("spear_steel", 2)
    group:item("shillelagh_weighted", 1)
    group:item("nodachi", 1)
    group:item("knife_baselard", 2)
    group:item("q_staff", 1)
    group:item("i_staff", 2)
    group:item("bagh_nakha", 1)
    group:item("kris", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "sca_smith_ranged", kind = "distribution" }
    group:item("huge_crossbow", 2)
    group:item("rep_crossbow", 1)
    group:item("compcrossbow", 2)
    group:item("compositecrossbow", 2)
    group:item("shortbow", 1)
    group:item("compbow", 2)
    group:item("compositebow", 2)
    group:item("reflexbow", 2)
    group:item("recurbow", 2)
    group:item("longbow", 2)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "sca_smith_ammo", kind = "distribution" }
    group:group("makeshift_archery_ammo", 2)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "sca_smith_accessories", kind = "distribution" }
    group:item("tunic", 1)
    group:item("quiver", 2)
    group:item("quiver_large", 1)
    group:item("baldric", 2)
    group:item("scabbard", 2)
    group:item("bscabbard", 2)
    content.add(group)
end

do
    -- basic ammo that the gunsmith will trade to start
    local group = content.ItemGroup { id = "gunsmith_basic_ammo", kind = "distribution" }
    group:item("9mm", 1)
    group:item("44magnum", 1)
    group:item("45_acp", 1)
    group:item("57mm", 1)
    group:item("shot_00", 2)
    group:item("shot_slug", 1)
    group:item("3006", 1)
    group:item("762_m87", 3)
    group:item("556", 3)
    group:item("762_51", 1)
    content.add(group)
end

do
    -- repacked ammo that the gunsmith will trade to start
    local group = content.ItemGroup { id = "gunsmith_repack_ammo", kind = "distribution" }
    group:item("reloaded_9mm", 1)
    group:item("reloaded_44magnum", 1)
    group:item("reloaded_45_acp", 1)
    group:item("reloaded_57mm", 1)
    group:item("reloaded_shot_00", 2)
    group:item("reloaded_3006", 1)
    group:item("reloaded_762_m87", 3)
    group:item("reloaded_556", 3)
    group:item("reloaded_545", 3)
    group:item("reloaded_762_51", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "kitted_kord", kind = "collection", container = "briefcase" }
    group:item("broken_kord")
    group:item("shoulder_strap")
    group:item("compensator")
    group:item("rail_laser_sight")
    group:item("holo_sight")
    group:item("ak74mag")
    content.add(group)
end
