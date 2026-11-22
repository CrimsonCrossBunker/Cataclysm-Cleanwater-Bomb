local ccb = require("ccb")
local services = ccb.services
local H = {}

H.char_has_trait = function(actor, trait_id)
    if not actor then return 0 end
    local r = services.mutations.has_id_text(actor, trait_id)
    if not r.ok or not r.value then return 0 end
    return 1
end

H.char_skill = function(actor, skill_id)
    if not actor then return 0 end
    local r = services.skills.level(actor, skill_id)
    if not r.ok then return 0 end
    return r.value or 0
end

H.global_var_num = function(key)
    local r = services.variables.get_global_number(key)
    if not r.ok or not r.value or not r.value.exists or r.value.value == nil then return 0 end
    return r.value.value
end

H.npc = function(ctx)
    return ctx:interlocutor()
end

H.set_var = function(scope, actor, ctx, key, val)
    if scope == "context" then
        if val == nil then ctx:remove(key) else ctx:set(key, val) end
        return
    end
    if scope == "global" then
        if val == nil then services.variables.remove_global(key) else services.variables.set_global(key, val) end
        return
    end
    if not actor then return end
    if val == nil then services.variables.remove(actor, key) else services.variables.set(actor, key, val) end
end

H.u = function(ctx)
    return ctx:speaker()
end

ccb.runtime.handler("dlg_p_defense_mode_010eff7a1ea0", function(ctx)
    return (H.global_var_num("regular_zombies_allowed") == 0)
end)

ccb.runtime.handler("dlg_p_defense_mode_5c817e0fd0d5", function(ctx)
    return (H.global_var_num("regular_zombies_allowed") == 1)
end)

ccb.runtime.handler("dlg_p_defense_mode_94c0a1394fc8", function(ctx)
    return (H.global_var_num("special_zombies_allowed") == 0)
end)

ccb.runtime.handler("dlg_p_defense_mode_33067f8c26d6", function(ctx)
    return (H.global_var_num("special_zombies_allowed") == 1)
end)

ccb.runtime.handler("dlg_p_defense_mode_ef1a26f8fe4f", function(ctx)
    return (H.global_var_num("spiders_allowed") == 0)
end)

ccb.runtime.handler("dlg_p_defense_mode_d51e85c0aeb5", function(ctx)
    return (H.global_var_num("spiders_allowed") == 1)
end)

ccb.runtime.handler("dlg_p_defense_mode_50cf2f50deb1", function(ctx)
    return (H.global_var_num("triffids_allowed") == 0)
end)

ccb.runtime.handler("dlg_p_defense_mode_92f29bde9172", function(ctx)
    return (H.global_var_num("triffids_allowed") == 1)
end)

ccb.runtime.handler("dlg_p_defense_mode_0c5d3a6721cc", function(ctx)
    return (H.global_var_num("robots_allowed") == 0)
end)

ccb.runtime.handler("dlg_p_defense_mode_5dc0484a959a", function(ctx)
    return (H.global_var_num("robots_allowed") == 1)
end)

ccb.runtime.handler("dlg_p_defense_mode_f9dc94df3cea", function(ctx)
    return (H.global_var_num("subspace_allowed") == 0)
end)

ccb.runtime.handler("dlg_p_defense_mode_564c5858070e", function(ctx)
    return (H.global_var_num("subspace_allowed") == 1)
end)

ccb.runtime.handler("dlg_p_defense_mode_390bd7f03489", function(ctx)
    return (services.gameplay.mods.is_loaded("DinoMod") and (H.global_var_num("dinos_allowed") == 0))
end)

ccb.runtime.handler("dlg_p_defense_mode_05b2f45eb20e", function(ctx)
    return (services.gameplay.mods.is_loaded("DinoMod") and (H.global_var_num("dinos_allowed") == 1))
end)

ccb.runtime.handler("dlg_p_defense_mode_2fd89984e627", function(ctx)
    return (services.gameplay.mods.is_loaded("magiclysm") and (H.global_var_num("lizardfolk_allowed") == 0))
end)

ccb.runtime.handler("dlg_p_defense_mode_4902ac896cf4", function(ctx)
    return (services.gameplay.mods.is_loaded("magiclysm") and (H.global_var_num("lizardfolk_allowed") == 1))
end)

ccb.runtime.handler("dlg_p_defense_mode_edd65c70a3fe", function(ctx)
    return (services.gameplay.mods.is_loaded("magiclysm") and (H.global_var_num("golems_allowed") == 0))
end)

ccb.runtime.handler("dlg_p_defense_mode_91a0faafcfd8", function(ctx)
    return (services.gameplay.mods.is_loaded("magiclysm") and (H.global_var_num("golems_allowed") == 1))
end)

ccb.runtime.handler("dlg_p_defense_mode_fb734f59752e", function(ctx)
    return (services.gameplay.mods.is_loaded("magiclysm") and (H.global_var_num("goblins_allowed") == 0))
end)

ccb.runtime.handler("dlg_p_defense_mode_66d53dcd6a7f", function(ctx)
    return (services.gameplay.mods.is_loaded("magiclysm") and (H.global_var_num("goblins_allowed") == 1))
end)

ccb.runtime.handler("dlg_p_defense_mode_e3df65f69aca", function(ctx)
    return (services.gameplay.mods.is_loaded("magiclysm") and (H.global_var_num("orcs_allowed") == 0))
end)

ccb.runtime.handler("dlg_p_defense_mode_7c8935d2444e", function(ctx)
    return (services.gameplay.mods.is_loaded("magiclysm") and (H.global_var_num("orcs_allowed") == 1))
end)

ccb.runtime.handler("dlg_p_defense_mode_0104dd84936a", function(ctx)
    return (services.gameplay.mods.is_loaded("megafauna") and (H.global_var_num("megafauna_allowed") == 0))
end)

ccb.runtime.handler("dlg_p_defense_mode_80a4055c89a3", function(ctx)
    return (services.gameplay.mods.is_loaded("megafauna") and (H.global_var_num("megafauna_allowed") == 1))
end)

ccb.runtime.handler("dlg_p_defense_mode_e7cc711dca97", function(ctx)
    return (services.gameplay.mods.is_loaded("mindovermatter") and (H.global_var_num("mindovermatter_allowed") == 0))
end)

ccb.runtime.handler("dlg_p_defense_mode_891a5d3f35ca", function(ctx)
    return (services.gameplay.mods.is_loaded("mindovermatter") and (H.global_var_num("mindovermatter_allowed") == 1))
end)

ccb.runtime.handler("dlg_p_defense_mode_804c05d3757b", function(ctx)
    return (services.gameplay.mods.is_loaded("my_sweet_cataclysm") and (H.global_var_num("candymonsters_allowed") == 0))
end)

ccb.runtime.handler("dlg_p_defense_mode_04db419293d7", function(ctx)
    return (services.gameplay.mods.is_loaded("my_sweet_cataclysm") and (H.global_var_num("candymonsters_allowed") == 1))
end)

ccb.runtime.handler("dlg_p_defense_mode_0556c6ac9c61", function(ctx)
    return (services.gameplay.mods.is_loaded("Mythos-Creatures") and (H.global_var_num("mythos_allowed") == 0))
end)

ccb.runtime.handler("dlg_p_defense_mode_05b980dd9d45", function(ctx)
    return (services.gameplay.mods.is_loaded("Mythos-Creatures") and (H.global_var_num("mythos_allowed") == 1))
end)

ccb.runtime.handler("dlg_p_defense_mode_e1a121653e98", function(ctx)
    return (services.gameplay.mods.is_loaded("xedra_evolved") and (H.global_var_num("exodii_allowed") == 0))
end)

ccb.runtime.handler("dlg_p_defense_mode_683eca4b487d", function(ctx)
    return (services.gameplay.mods.is_loaded("xedra_evolved") and (H.global_var_num("exodii_allowed") == 1))
end)

ccb.runtime.handler("dlg_p_defense_mode_146df0146c1a", function(ctx)
    return (services.gameplay.mods.is_loaded("xedra_evolved") and (H.global_var_num("xedra_allowed") == 0))
end)

ccb.runtime.handler("dlg_p_defense_mode_64c23344a5d8", function(ctx)
    return (services.gameplay.mods.is_loaded("xedra_evolved") and (H.global_var_num("xedra_allowed") == 1))
end)

ccb.runtime.handler("dlg_p_defense_mode_438ec38f3ce4", function(ctx)
    return (services.gameplay.mods.is_loaded("aftershock") and (H.global_var_num("aftershock_allowed") == 0))
end)

ccb.runtime.handler("dlg_p_defense_mode_4512b8bd747e", function(ctx)
    return (services.gameplay.mods.is_loaded("aftershock") and (H.global_var_num("aftershock_allowed") == 1))
end)

ccb.runtime.handler("dlg_p_defense_mode_4f183993ed37", function(ctx)
    return (H.global_var_num("trading_allowed") == 0)
end)

ccb.runtime.handler("dlg_p_defense_mode_bc5a52f7992a", function(ctx)
    return (H.global_var_num("trading_allowed") == 1)
end)

ccb.runtime.handler("dlg_p_defense_mode_d67468dfedcf", function(ctx)
    return (H.global_var_num("special_waves_allowed") == 0)
end)

ccb.runtime.handler("dlg_p_defense_mode_7e73c430b65d", function(ctx)
    return (H.global_var_num("special_waves_allowed") == 1)
end)

ccb.runtime.handler("dlg_p_defense_mode_c38900ae8853", function(ctx)
    return (H.global_var_num("portal_storms_allowed") == 0)
end)

ccb.runtime.handler("dlg_p_defense_mode_172920d3e0ef", function(ctx)
    return (H.global_var_num("portal_storms_allowed") == 1)
end)

ccb.runtime.handler("dlg_p_defense_mode_2d6d0ac2fd12", function(ctx)
    return (H.global_var_num("random_events_allowed") == 0)
end)

ccb.runtime.handler("dlg_p_defense_mode_98997d9c77a9", function(ctx)
    return (H.global_var_num("random_events_allowed") == 1)
end)

ccb.runtime.handler("dlg_a_defense_mode_cab489514716", function(ctx)
    H.set_var("global", nil, ctx, "final_wave_defeated", 0)
end)

ccb.runtime.handler("dlg_a_defense_mode_0626ec5c1519", function(ctx)
    H.set_var("global", nil, ctx, "regular_zombies_allowed", 1)
end)

ccb.runtime.handler("dlg_a_defense_mode_c37cf0e24aff", function(ctx)
    H.set_var("global", nil, ctx, "regular_zombies_allowed", 0)
end)

ccb.runtime.handler("dlg_a_defense_mode_4ef780cfc6f7", function(ctx)
    H.set_var("global", nil, ctx, "special_zombies_allowed", 1)
end)

ccb.runtime.handler("dlg_a_defense_mode_e7dfde9075d3", function(ctx)
    H.set_var("global", nil, ctx, "special_zombies_allowed", 0)
end)

ccb.runtime.handler("dlg_a_defense_mode_0b3097475b40", function(ctx)
    H.set_var("global", nil, ctx, "spiders_allowed", 1)
end)

ccb.runtime.handler("dlg_a_defense_mode_314185f49277", function(ctx)
    H.set_var("global", nil, ctx, "spiders_allowed", 0)
end)

ccb.runtime.handler("dlg_a_defense_mode_caf8c2fcafee", function(ctx)
    H.set_var("global", nil, ctx, "triffids_allowed", 1)
end)

ccb.runtime.handler("dlg_a_defense_mode_b450266f3530", function(ctx)
    H.set_var("global", nil, ctx, "triffids_allowed", 0)
end)

ccb.runtime.handler("dlg_a_defense_mode_0f61dd16c140", function(ctx)
    H.set_var("global", nil, ctx, "robots_allowed", 1)
end)

ccb.runtime.handler("dlg_a_defense_mode_9b8b95c34e9b", function(ctx)
    H.set_var("global", nil, ctx, "robots_allowed", 0)
end)

ccb.runtime.handler("dlg_a_defense_mode_686d24f617ab", function(ctx)
    H.set_var("global", nil, ctx, "subspace_allowed", 1)
end)

ccb.runtime.handler("dlg_a_defense_mode_436e0bededc9", function(ctx)
    H.set_var("global", nil, ctx, "subspace_allowed", 0)
end)

ccb.runtime.handler("dlg_a_defense_mode_80371da47fa7", function(ctx)
    H.set_var("global", nil, ctx, "dinos_allowed", 1)
end)

ccb.runtime.handler("dlg_a_defense_mode_ebf6e9cf0d98", function(ctx)
    H.set_var("global", nil, ctx, "dinos_allowed", 0)
end)

ccb.runtime.handler("dlg_a_defense_mode_c4e4057bc5cc", function(ctx)
    H.set_var("global", nil, ctx, "lizardfolk_allowed", 1)
end)

ccb.runtime.handler("dlg_a_defense_mode_89e95b7d3ce7", function(ctx)
    H.set_var("global", nil, ctx, "lizardfolk_allowed", 0)
end)

ccb.runtime.handler("dlg_a_defense_mode_2266d3162f64", function(ctx)
    H.set_var("global", nil, ctx, "golems_allowed", 1)
end)

ccb.runtime.handler("dlg_a_defense_mode_1da1dea0a7ef", function(ctx)
    H.set_var("global", nil, ctx, "golems_allowed", 0)
end)

ccb.runtime.handler("dlg_a_defense_mode_2484229866a2", function(ctx)
    H.set_var("global", nil, ctx, "goblins_allowed", 1)
end)

ccb.runtime.handler("dlg_a_defense_mode_f666437aa566", function(ctx)
    H.set_var("global", nil, ctx, "goblins_allowed", 0)
end)

ccb.runtime.handler("dlg_a_defense_mode_88e06bd214a2", function(ctx)
    H.set_var("global", nil, ctx, "orcs_allowed", 1)
end)

ccb.runtime.handler("dlg_a_defense_mode_526696ee84e5", function(ctx)
    H.set_var("global", nil, ctx, "orcs_allowed", 0)
end)

ccb.runtime.handler("dlg_a_defense_mode_e130fde79de8", function(ctx)
    H.set_var("global", nil, ctx, "megafauna_allowed", 1)
end)

ccb.runtime.handler("dlg_a_defense_mode_2975b10c2135", function(ctx)
    H.set_var("global", nil, ctx, "megafauna_allowed", 0)
end)

ccb.runtime.handler("dlg_a_defense_mode_6b0d9131783d", function(ctx)
    H.set_var("global", nil, ctx, "mindovermatter_allowed", 1)
end)

ccb.runtime.handler("dlg_a_defense_mode_e6dabda90a61", function(ctx)
    H.set_var("global", nil, ctx, "mindovermatter_allowed", 0)
end)

ccb.runtime.handler("dlg_a_defense_mode_383e12c5b11e", function(ctx)
    H.set_var("global", nil, ctx, "candymonsters_allowed", 1)
end)

ccb.runtime.handler("dlg_a_defense_mode_00bf3e71eead", function(ctx)
    H.set_var("global", nil, ctx, "candymonsters_allowed", 0)
end)

ccb.runtime.handler("dlg_a_defense_mode_46d5597086d5", function(ctx)
    H.set_var("global", nil, ctx, "mythos_allowed", 1)
end)

ccb.runtime.handler("dlg_a_defense_mode_2c61c9b55399", function(ctx)
    H.set_var("global", nil, ctx, "mythos_allowed", 0)
end)

ccb.runtime.handler("dlg_a_defense_mode_19603a34563d", function(ctx)
    H.set_var("global", nil, ctx, "exodii_allowed", 1)
end)

ccb.runtime.handler("dlg_a_defense_mode_e8424f0dcb51", function(ctx)
    H.set_var("global", nil, ctx, "exodii_allowed", 0)
end)

ccb.runtime.handler("dlg_a_defense_mode_c55d4c71e4da", function(ctx)
    H.set_var("global", nil, ctx, "xedra_allowed", 1)
end)

ccb.runtime.handler("dlg_a_defense_mode_fed9bfb21d5e", function(ctx)
    H.set_var("global", nil, ctx, "xedra_allowed", 0)
end)

ccb.runtime.handler("dlg_a_defense_mode_264ba0f04fb3", function(ctx)
    H.set_var("global", nil, ctx, "aftershock_allowed", 1)
end)

ccb.runtime.handler("dlg_a_defense_mode_a1befa35f64f", function(ctx)
    H.set_var("global", nil, ctx, "aftershock_allowed", 0)
end)

ccb.runtime.handler("dlg_a_defense_mode_490bc88ccc5c", function(ctx)
    H.set_var("global", nil, ctx, "trading_allowed", 1)
end)

ccb.runtime.handler("dlg_a_defense_mode_d4b7eb50796f", function(ctx)
    H.set_var("global", nil, ctx, "trading_allowed", 0)
end)

ccb.runtime.handler("dlg_a_defense_mode_ac1594a283c0", function(ctx)
    H.set_var("global", nil, ctx, "special_waves_allowed", 1)
end)

ccb.runtime.handler("dlg_a_defense_mode_120b19157b58", function(ctx)
    H.set_var("global", nil, ctx, "special_waves_allowed", 0)
end)

ccb.runtime.handler("dlg_a_defense_mode_0d009cfd1f84", function(ctx)
    H.set_var("global", nil, ctx, "portal_storms_allowed", 1)
end)

ccb.runtime.handler("dlg_a_defense_mode_b133b259df0e", function(ctx)
    H.set_var("global", nil, ctx, "portal_storms_allowed", 0)
end)

ccb.runtime.handler("dlg_a_defense_mode_9106a9753c6a", function(ctx)
    H.set_var("global", nil, ctx, "random_events_allowed", 1)
end)

ccb.runtime.handler("dlg_a_defense_mode_5ebe52eb6ba1", function(ctx)
    H.set_var("global", nil, ctx, "random_events_allowed", 0)
end)

ccb.runtime.handler("dlg_a_defense_mode_b7ee22e84e8e", function(ctx)
    H.set_var("global", nil, ctx, "diffulty_modifier", 1)
    H.set_var("global", nil, ctx, "revivication_counter", 1)
end)

ccb.runtime.handler("dlg_a_defense_mode_a14361e899d7", function(ctx)
    H.set_var("global", nil, ctx, "diffulty_modifier", 1)
end)

ccb.runtime.handler("dlg_a_defense_mode_7e858b22e91f", function(ctx)
    H.set_var("global", nil, ctx, "diffulty_modifier", 1.5)
end)

ccb.runtime.handler("dlg_a_defense_mode_b2468f9b2461", function(ctx)
    H.set_var("global", nil, ctx, "diffulty_modifier", 2)
end)

ccb.runtime.handler("dlg_a_defense_mode_70e40ed0a2a6", function(ctx)
    H.set_var("global", nil, ctx, "diffulty_modifier", 3)
end)

ccb.runtime.handler("dlg_a_defense_mode_7f0a26536973", function(ctx)
    H.set_var("global", nil, ctx, "diffulty_modifier", 5)
end)

ccb.runtime.handler("dlg_a_defense_mode_39cb13fc160b", function(ctx)
    H.set_var("global", nil, ctx, "diffulty_modifier", (H.global_var_num("diffulty_modifier")) + 1)
end)

ccb.runtime.handler("dlg_a_defense_mode_e768e112cec6", function(ctx)
    H.set_var("global", nil, ctx, "diffulty_modifier", (H.global_var_num("diffulty_modifier")) + (5))
end)

ccb.runtime.handler("dlg_a_defense_mode_b5dfefacfcc9", function(ctx)
    H.set_var("global", nil, ctx, "diffulty_modifier", (H.global_var_num("diffulty_modifier")) - 1)
end)

ccb.runtime.handler("dlg_a_defense_mode_625fcbbd05df", function(ctx)
    H.set_var("global", nil, ctx, "diffulty_modifier", (H.global_var_num("diffulty_modifier")) - (5))
end)

ccb.runtime.handler("dlg_a_defense_mode_58e96e9a7004", function(ctx)
    ctx:set_conditional("perk_condition", (H.global_var_num("wave_number") >= 1))
end)

ccb.runtime.handler("dlg_a_defense_mode_8bc0dece8a8d", function(ctx)
    ctx:set_conditional("perk_condition", (0 == 0))
end)

ccb.runtime.handler("dlg_a_defense_mode_b07e0566006f", function(ctx)
    ctx:set_conditional("perk_condition", ((H.char_has_trait(H.u(ctx), "perk_slice&dice") == 1) and (H.char_has_trait(H.u(ctx), "perk_bash&mash") == 1) and (H.char_has_trait(H.u(ctx), "perk_knifey") == 1)))
end)

ccb.runtime.handler("dlg_a_defense_mode_a5d3000f212f", function(ctx)
    ctx:set_conditional("perk_condition", ((H.char_skill(H.u(ctx), "swimming") >= 5) and (H.char_has_trait(H.u(ctx), "perk_gymrat") == 1)))
end)
