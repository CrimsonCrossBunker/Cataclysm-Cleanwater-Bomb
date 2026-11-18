local content = require("ccb").content

do
    -- Common gunmods typically owned by citizens and found in many locations.
    local group = content.ItemGroup { id = "gunmod_common", kind = "distribution" }
    group:item("belt_clip", 5)
    group:item("brass_catcher")
    group:item("improve_sights", 60)
    group:item("compensator", 40)
    group:item("muzzle_brake", 20)
    group:item("rifle_scope", 30)
    group:item("shoulder_strap", 50)
    group:item("shoulder_strap_simple", 70)
    group:item("single_sling", 50)
    group:item("butt_hook", 30)
    group:item("match_trigger", 20)
    group:item("offset_sights", 40)
    group:item("offset_sight_rail", 30)
    group:item("cheek_pad", 25)
    group:item("rail_laser_sight", 40)
    group:item("red_dot_sight", 70)
    group:item("choke", 50)
    group:item("big_brass_catcher", 20)
    group:item("offset_grip", 5)
    content.add(group)
end

do
    -- Less common gunmods including those only used by police/paramilitary forces.
    local group = content.ItemGroup { id = "gunmod_rare", kind = "distribution" }
    group:item("adjustable_stock", 80)
    group:item("barrel_ported", 20)
    group:item("bipod", 20)
    group:item("folding_stock", 60)
    group:item("grip", 80)
    group:item("wooden_grip", 5)
    group:item("laser_sight", 40)
    group:item("pistol_bayonet", 10)
    group:item("pistol_scope", 10)
    group:item("pistol_stock", 10)
    group:item("tail_hook_stock", 30)
    group:item("butt_hook", 20)
    group:item("arredondo_chute", 20)
    group:item("recoil_stock", 60)
    group:item("u_shotgun", 60)
    group:item("retool_ar15_300blk", 40)
    group:item("acog_scope", 40)
    group:item("holo_sight", 50)
    group:item("holo_magnifier", 30)
    group:item("hybrid_sight_4x", 30)
    group:item("rifle_scope_high_end_mount", 20)
    group:item("modern_handguard", 20)
    group:item("mounted_flashlight", 80)
    group:item("bipod_handguard", 10)
    group:item("high_end_folding_stock", 10)
    group:item("muzzle_weight", 10)
    group:item("muzzle_pistol_weight", 10)
    content.add(group)
end

do
    -- Military specification gunmods found only at military sites.
    local group = content.ItemGroup { id = "gunmod_milspec", kind = "distribution" }
    group:item("acog_scope")
    group:item("holo_sight")
    group:item("red_dot_sight")
    group:item("holo_magnifier", 80)
    group:item("hybrid_sight_4x")
    group:item("m203", 30)
    group:item("m320_mod", 10)
    group:item("masterkey", 30)
    group:item("m26_mass", 35)
    group:item("mipim", 10)
    group:item("sword_bayonet", 10)
    content.add(group)
end

do
    -- Sights that are issued by the US Army for the M4 and similar firearms.
    local group = content.ItemGroup { id = "issued_carbine_sights", kind = "distribution" }
    group:item("acog_scope", 15)
    group:item("hybrid_sight_4x", 5)
    group:item("holo_sight", 10)
    group:item("red_dot_sight", 20)
    group:item("null", 50)
    content.add(group)
end

do
    -- Slings that belong on a firearm, the 5% of soldiers who lost theirs are very unhappy right now.
    local group = content.ItemGroup { id = "issued_slings", kind = "distribution" }
    group:item("shoulder_strap_simple", 60)
    group:item("shoulder_strap", 35)
    group:item("null", 5)
    content.add(group)
end

do
    -- Not all soldiers would have a forward grip, but they're common accessories.
    local group = content.ItemGroup { id = "issued_grip", kind = "distribution" }
    group:item("grip", 33)
    group:item("null", 67)
    content.add(group)
end

do
    -- Weapon mod loadouts that represent the average US Army carbine loadout.
    local group = content.ItemGroup { id = "issued_carbine_mods", kind = "collection" }
    group:group("issued_slings")
    group:group("issued_carbine_sights")
    group:group("issued_grip")
    content.add(group)
end

do
    -- Weapon mod loadouts that represent the average US Army grenadier loadout.
    local group = content.ItemGroup { id = "issued_grenadier_mods", kind = "collection" }
    group:group("issued_slings")
    group:group("issued_carbine_sights")
    group:group("military_grenadier_mods")
    content.add(group)
end

do
    -- Aftermarket sights that are for rifles.
    local group = content.ItemGroup { id = "sights_rifle", kind = "distribution" }
    group:item("improve_sights", 84)
    group:item("red_dot_sight", 42)
    group:item("holo_sight", 18)
    group:item("laser_sight", 15)
    group:item("rail_laser_sight", 6)
    group:item("offset_sights", 6)
    group:item("acog_scope", 21)
    group:item("hybrid_sight_4x", 15)
    group:item("rifle_scope", 25)
    group:item("rifle_scope_high_end_mount", 10)
    content.add(group)
end

do
    -- Aftermarket sights that are for shotguns.
    local group = content.ItemGroup { id = "sights_shotgun", kind = "distribution" }
    group:item("improve_sights", 84)
    group:item("red_dot_sight", 42)
    group:item("holo_sight", 18)
    group:item("laser_sight", 15)
    group:item("offset_sights", 6)
    content.add(group)
end

do
    -- Default mods for m4 carbines issued with grenade launchers
    local group = content.ItemGroup { id = "military_grenadier_mods", kind = "distribution" }
    group:item("m203", 40)
    group:item("m320_mod", 60)
    content.add(group)
end

do
    -- Default mods for the Kalashnikov AKS-74 variant of the 5.45x39mm fighting rifle
    local group = content.ItemGroup { id = "ak74_folding_mods", kind = "collection" }
    group:item("stock_mount")
    group:item("folding_stock")
    content.add(group)
end

do
    -- Default possible mods for the C96.
    local group = content.ItemGroup { id = "c96_mods", kind = "distribution" }
    group:item("stock_mauser", 40)
    content.add(group)
end

do
    -- Default mods for the EBR variants of the Mosin carbine and battle rifle
    local group = content.ItemGroup { id = "mosin_mods", kind = "collection" }
    group:item("rail_mount")
    group:item("stock_mount")
    content.add(group)
end

do
    -- Default possible mods for Arisaka Type 99 rifles.
    local group = content.ItemGroup { id = "type99_mods", kind = "distribution" }
    group:item("arisaka_monopod", 25)
    group:item("arisaka_bayonet", 50)
    content.add(group)
end

do
    -- Default mods for the mk23 variant of the USP .45 pistol
    local group = content.ItemGroup { id = "mk23_mods", kind = "collection" }
    group:item("suppressor")
    group:item("laser_sight")
    content.add(group)
end

do
    -- Gunmods for energy weaponry found only at military sites and laboratories.
    local group = content.ItemGroup { id = "gunmod_energy", kind = "distribution" }
    group:item("beam_scatterer", 80)
    group:item("focusing_lens", 60)
    group:item("electrolaser_conversion", 40)
    group:item("effective_emitter", 40)
    group:item("high_density_capacitor", 60)
    content.add(group)
end
