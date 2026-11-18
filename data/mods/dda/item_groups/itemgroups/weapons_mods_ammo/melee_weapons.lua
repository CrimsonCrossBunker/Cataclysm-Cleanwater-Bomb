local content = require("ccb").content

do
    local group = content.ItemGroup { id = "melee_bashing_common", kind = "distribution" }
    group:group("battleaxes_homemade", 1)
    group:group("melee_bashing_rare_weak", 1)
    group:group("canes", 16)
    group:item("bat", 8)
    group:item("bat_metal", 4)
    group:item("bwirebat", 4)
    group:item("nailbat", 8)
    group:item("baton", 8)
    group:item("PR24-retracted", 8)
    group:item("blackjack", 8)
    group:item("bowling_pin", 4)
    group:item("club_wooden", 8)
    group:item("club_wooden_large", 4)
    group:item("crutches", 4)
    group:item("makeshift_crutches", 8)
    group:item("cudgel", 8)
    group:item("golf_club", 8)
    group:item("hockey_stick", 8)
    group:item("homemade_polehammer", 1)
    group:item("homemade_polehammer_makeshift", 1)
    group:item("mace_trench", 4)
    group:item("mace_pipe", 4)
    group:item("mace_pipe_large", 1)
    group:item("staff_pipe", 4)
    group:item("makeshift_sap", 16)
    group:item("nailboard", 16)
    group:item("rock_sock", 16)
    group:item("sword_wood", 8)
    group:item("sword_wood_large", 4)
    group:item("sword_nail", 8)
    group:item("wrench", 8)
    group:item("wrench_large", 4)
    group:item("primitive_hammer", 16)
    group:item("pipe", 16)
    group:item("hammer", 8)
    group:item("e_tool", 4)
    group:item("lug_wrench", 8)
    group:item("chain", 8)
    group:item("hoe", 8)
    group:item("primitive_shovel", 16)
    group:item("shovel", 8)
    group:item("rake", 8)
    group:item("crowbar", 8)
    group:item("makeshift_crowbar", 16)
    group:item("knuckle_brass", 2)
    group:item("knuckle_steel_forged", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "melee_bashing_rare", kind = "distribution" }
    group:group("battleaxes", 1)
    group:group("aztec_spears", 1)
    group:group("aztec_swords", 1)
    group:group("metal_staves", 1)
    group:group("maces", 1)
    group:group("sledgehammers", 4)
    group:item("2h_flail_steel", 1)
    group:item("2h_flail_wood", 2)
    group:item("2h_club_kanabo_studded", 1)
    group:item("2h_club_kanabo_spiked", 1)
    group:item("warhammer", 1)
    group:item("lucern_hammer", 1)
    group:item("morningstar", 1)
    group:item("poleaxe", 1)
    group:item("sword_metal_large", 1)
    group:item("tazer", 1)
    group:item("pickaxe", 4)
    group:item("heavy_crowbar", 2)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "melee_bashing_rare_weak", kind = "distribution" }
    group:item("bokken", 4)
    group:item("shillelagh", 2)
    group:item("shillelagh_weighted", 1)
    group:item("bo", 1)
    group:item("q_staff", 4)
    group:item("tonfa", 2)
    group:item("tonfa_wood", 4)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "melee_cutting_common", kind = "distribution" }
    group:group("battleaxes_homemade", 1)
    group:item("glass_shiv", 8)
    group:item("sword_crude", 1)
    group:item("sword_crude_large", 1)
    group:item("sword_sheets_welded", 1)
    group:item("sword_sheets_welded_large", 1)
    group:item("makeshift_machete", 4)
    group:item("machete_gimmick", 2)
    group:item("makeshift_axe", 4)
    group:item("primitive_axe", 4)
    group:item("ax", 1)
    group:item("hatchet", 4)
    group:item("throwing_axe", 2)
    group:item("e_tool", 4)
    group:item("knife_cleaver", 2)
    group:item("scythe", 1)
    group:item("sickle", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "melee_cutting_rare", kind = "distribution" }
    group:group("battleaxes", 1)
    group:group("cavalry_sabres", 1)
    group:group("aztec_swords", 1)
    group:group("aztec_spears", 1)
    group:group("kukris", 1)
    group:group("jians", 1)
    group:group("scimitars", 1)
    group:group("longswords", 1)
    group:group("arming_swords", 1)
    group:group("wakizashis", 1)
    group:group("zweihanders", 1)
    group:group("nodachis", 1)
    group:group("broadswords", 1)
    group:group("katanas", 1)
    group:group("cutlasses", 1)
    group:group("kriegsmessers", 1)
    group:group("falxes", 1)
    group:group("talwars", 1)
    group:group("kilijes", 1)
    group:group("khopeshes", 1)
    group:item("makeshift_scythe_war", 16)
    group:item("makeshift_halberd", 16)
    group:item("halberd", 1)
    group:item("makeshift_glaive", 16)
    group:item("glaive", 1)
    group:item("naginata", 1)
    group:item("scythe_war", 1)
    group:item("ji", 1)
    group:item("poleaxe", 1)
    group:item("sword_metal", 8)
    group:item("sword_metal_large", 4)
    group:item("knife_hunting", 16)
    group:item("machete", 16)
    group:item("survivor_machete_qt", 1)
    group:item("sword_xiphos", 1)
    group:item("khopesh", 1)
    group:item("dao", 1)
    group:item("sword_bronze", 4)
    group:item("butterfly_swords", 1)
    group:item("lajatang", 1)
    group:item("bagh_nakha", 1)
    group:item("arisaka_bayonet", 1)
    group:item("diveknife", 8)
    group:item("brush_axe", 8)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "melee_stabbing_common", kind = "distribution" }
    group:group("melee_stabbing_rare_weak", 1)
    group:item("pitchfork", 8)
    group:item("pointy_stick", 16)
    group:item("pointy_stick_long", 16)
    group:item("spear_wood", 4)
    group:item("spear_shaft_sharpened", 4)
    group:item("spear_spike", 1)
    group:item("spear_knife", 1)
    group:item("spear_homemade_halfpike", 4)
    group:item("spear_steel_crude", 4)
    group:item("sharpened_pipe", 16)
    group:item("simple_spear_pipe", 8)
    group:item("spear_pipe", 1)
    group:item("pointed_rebar", 16)
    group:item("sharp_rebar", 16)
    group:item("spear_rebar", 4)
    group:item("spear_stone", 1)
    group:item("spear_stone_simple", 8)
    group:item("switchblade", 1)
    group:item("throwing_knife", 1)
    group:item("knife_folding", 8)
    group:item("utility_knife_folding", 8)
    group:item("knife_swissarmy", 8)
    group:item("pockknife", 8)
    group:item("makeshift_knife", 16)
    group:item("primitive_knife", 16)
    group:item("bone_knife", 16)
    group:item("knuckle_katar", 1)
    group:item("knife_small", 16)
    group:item("knife_large", 8)
    group:item("knife_huge", 4)
    group:item("iceaxe", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "melee_stabbing_rare", kind = "distribution" }
    group:group("rambo_knives", 16)
    group:group("trench_knives", 16)
    group:group("estocs", 1)
    group:group("rapiers", 1)
    group:item("lucern_hammer", 1)
    group:item("morningstar", 1)
    group:item("warhammer", 1)
    group:item("spear_knife_superior", 16)
    group:item("spear_knife_proper", 16)
    group:item("spear_copper", 8)
    group:item("spear_steel", 4)
    group:item("qiang", 1)
    group:item("pike_copper", 8)
    group:item("pike_bronze", 4)
    group:item("pike", 1)
    group:item("spear_dory", 1)
    group:item("sword_metal_fencing", 4)
    group:item("spear_bronze", 4)
    group:item("knife_combat_marine", 16)
    group:item("knife_combat_army", 16)
    group:item("knife_KABAR", 16)
    group:item("knife_rm42", 16)
    group:item("knife_rambo", 16)
    group:item("punch_dagger", 16)
    group:item("sword_bayonet", 4)
    group:item("knife_baselard", 4)
    group:item("kris", 1)
    group:item("tanto", 1)
    group:item("karambit", 1)
    group:item("kirpan", 1)
    group:item("shock_foil", 1)
    group:item("shock_epee", 1)
    group:item("shock_sabre", 1)
    group:item("sword_cane", 8)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "melee_stabbing_rare_weak", kind = "distribution" }
    group:item("pike_wood", 1)
    group:item("fencing_foil", 4)
    group:item("fencing_foil_sharpened", 1)
    group:item("fencing_epee", 4)
    group:item("fencing_epee_sharpened", 1)
    group:item("fencing_sabre", 4)
    group:item("fencing_sabre_sharpened", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "canes", kind = "distribution" }
    group:item("cane", 20)
    group:item("makeshift_cane", 20)
    group:item("sinister_cane", 5)
    group:item("wizard_cane", 2)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "sledgehammers", kind = "distribution" }
    group:item("hammer_sledge", 20)
    group:item("hammer_sledge_short", 20)
    group:item("hammer_sledge_engineer", 5)
    group:item("hammer_sledge_heavy", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "battleaxes", kind = "distribution" }
    group:item("lc_battleaxe", 20)
    group:item("mc_battleaxe", 10)
    group:item("hc_battleaxe", 5)
    group:item("ch_battleaxe", 2)
    group:item("qt_battleaxe", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "battleaxes_homemade", kind = "distribution" }
    group:item("ax_sheets_welded", 1)
    group:item("ax_sheets_bolted", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "aztec_swords", kind = "distribution" }
    group:item("glass_macuahuitl", 40)
    group:item("aztec_sword_stone", 40)
    group:item("aztec_sword_scrap", 30)
    group:item("lc_aztec_sword", 20)
    group:item("mc_aztec_sword", 10)
    group:item("teeth_macuahuitl", 10)
    group:item("hc_aztec_sword", 5)
    group:item("ch_aztec_sword", 2)
    group:item("qt_aztec_sword", 2)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "aztec_spears", kind = "distribution" }
    group:item("aztec_spear_glass", 40)
    group:item("aztec_spear_stone", 40)
    group:item("aztec_spear_scrap", 30)
    group:item("lc_aztec_spear", 20)
    group:item("mc_aztec_spear", 10)
    group:item("hc_aztec_spear", 5)
    group:item("ch_aztec_spear", 2)
    group:item("qt_aztec_spear", 2)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "metal_staves", kind = "distribution" }
    group:item("i_staff", 30)
    group:item("lc_steel_staff", 20)
    group:item("mc_steel_staff", 10)
    group:item("hc_steel_staff", 5)
    group:item("ch_steel_staff", 2)
    group:item("qt_steel_staff", 1)
    group:item("shock_staff", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "maces", kind = "distribution" }
    group:item("mace_bronze", 20)
    group:item("lc_mace", 20)
    group:item("mace", 10)
    group:item("hc_mace", 5)
    group:item("ch_mace", 2)
    group:item("qt_mace", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "rambo_knives", kind = "distribution" }
    group:item("lc_knife_rambo", 20)
    group:item("knife_rambo", 10)
    group:item("hc_knife_rambo", 5)
    group:item("ch_knife_rambo", 2)
    group:item("qt_knife_rambo", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "trench_knives", kind = "distribution" }
    group:item("lc_knife_trench", 20)
    group:item("knife_trench", 10)
    group:item("hc_knife_trench", 5)
    group:item("ch_knife_trench", 2)
    group:item("qt_knife_trench", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cavalry_sabres", kind = "distribution" }
    group:item("lc_cavalry_sabre", 20)
    group:item("mc_cavalry_sabre", 10)
    group:item("hc_cavalry_sabre", 5)
    group:item("ch_cavalry_sabre", 2)
    group:item("qt_cavalry_sabre", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "kukris", kind = "distribution" }
    group:item("lc_kukri", 20)
    group:item("kukri", 10)
    group:item("hc_kukri", 5)
    group:item("ch_kukri", 2)
    group:item("qt_kukri", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "jians", kind = "distribution" }
    group:item("lc_jian", 20)
    group:item("mc_jian", 10)
    group:item("hc_jian", 5)
    group:item("ch_jian", 2)
    group:item("qt_jian", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "scimitars", kind = "distribution" }
    group:item("lc_scimitar", 20)
    group:item("mc_scimitar", 10)
    group:item("hc_scimitar", 5)
    group:item("ch_scimitar", 2)
    group:item("qt_scimitar", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "estocs", kind = "distribution" }
    group:item("lc_estoc", 20)
    group:item("mc_estoc", 10)
    group:item("hc_estoc", 5)
    group:item("ch_estoc", 2)
    group:item("qt_estoc", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "longswords", kind = "distribution" }
    group:item("lc_longsword", 20)
    group:item("mc_longsword", 10)
    group:item("hc_longsword", 5)
    group:item("ch_longsword", 2)
    group:item("qt_longsword", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "khopeshes", kind = "distribution" }
    group:item("lc_khopesh", 20)
    group:item("mc_khopesh", 10)
    group:item("hc_khopesh", 5)
    group:item("ch_khopesh", 2)
    group:item("qt_khopesh", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "arming_swords", kind = "distribution" }
    group:item("lc_arming_sword", 20)
    group:item("mc_arming_sword", 10)
    group:item("hc_arming_sword", 5)
    group:item("ch_arming_sword", 2)
    group:item("qt_arming_sword", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "wakizashis", kind = "distribution" }
    group:item("lc_wakizashi", 20)
    group:item("mc_wakizashi", 10)
    group:item("hc_wakizashi", 5)
    group:item("ch_wakizashi", 2)
    group:item("qt_wakizashi", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "zweihanders", kind = "distribution" }
    group:item("lc_zweihander", 20)
    group:item("mc_zweihander", 10)
    group:item("hc_zweihander", 5)
    group:item("ch_zweihander", 2)
    group:item("qt_zweihander", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "nodachis", kind = "distribution" }
    group:item("lc_nodachi", 20)
    group:item("mc_nodachi", 10)
    group:item("hc_nodachi", 5)
    group:item("ch_nodachi", 2)
    group:item("qt_nodachi", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "broadswords", kind = "distribution" }
    group:item("lc_broadsword", 20)
    group:item("broadsword", 10)
    group:item("hc_broadsword", 5)
    group:item("ch_broadsword", 2)
    group:item("qt_broadsword", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "rapiers", kind = "distribution" }
    group:item("lc_rapier", 20)
    group:item("rapier", 10)
    group:item("hc_rapier", 5)
    group:item("ch_rapier", 2)
    group:item("qt_rapier", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "katanas", kind = "distribution" }
    group:item("lc_katana", 20)
    group:item("mc_katana", 10)
    group:item("hc_katana", 5)
    group:item("ch_katana", 2)
    group:item("qt_katana", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cutlasses", kind = "distribution" }
    group:item("lc_cutlass", 20)
    group:item("mc_cutlass", 10)
    group:item("hc_cutlass", 5)
    group:item("ch_cutlass", 2)
    group:item("qt_cutlass", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "kriegsmessers", kind = "distribution" }
    group:item("lc_kriegsmesser", 20)
    group:item("mc_kriegsmesser", 10)
    group:item("hc_kriegsmesser", 5)
    group:item("ch_kriegsmesser", 2)
    group:item("qt_kriegsmesser", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "falxes", kind = "distribution" }
    group:item("lc_falx", 20)
    group:item("mc_falx", 10)
    group:item("hc_falx", 5)
    group:item("ch_falx", 2)
    group:item("qt_falx", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "talwars", kind = "distribution" }
    group:item("lc_talwar", 20)
    group:item("mc_talwar", 10)
    group:item("hc_talwar", 5)
    group:item("ch_talwar", 2)
    group:item("qt_talwar", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "kilijes", kind = "distribution" }
    group:item("lc_kilij", 20)
    group:item("mc_kilij", 10)
    group:item("hc_kilij", 5)
    group:item("ch_kilij", 2)
    group:item("qt_kilij", 1)
    content.add(group)
end
