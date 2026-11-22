local ccb = require("ccb")
local services = ccb.services
return function(E, H)
    local EOC = E.run
    local COND = E.cond
    EOC["EOC_BALTHAZAR_CHECK_PROGRESS"] = function(ctx)
    return true
    end
    COND["afs_spot_spaceport"] = function(ctx)
        return ((services.random.native_probability(1, (2)) and (not (H.truthy((H.var_exists("global", nil, ctx, "know_spaceport") and 1 or 0)))) and (not (H.char_has_mission(H.u(ctx), "MISSION_REACH_SPACEPORT"))) and (not ((not services.gameplay.environment.is_night()))) and (((H.char_snap(H.u(ctx)) or {}).senses or {}).can_see ~= false) and ((services.weather.current().weather and services.weather.current().weather.value) == "clear") and (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true))) == true
    end
    EOC["afs_spot_spaceport"] = function(ctx)
    if ((services.random.native_probability(1, (2)) and (not (H.truthy((H.var_exists("global", nil, ctx, "know_spaceport") and 1 or 0)))) and (not (H.char_has_mission(H.u(ctx), "MISSION_REACH_SPACEPORT"))) and (not ((not services.gameplay.environment.is_night()))) and (((H.char_snap(H.u(ctx)) or {}).senses or {}).can_see ~= false) and ((services.weather.current().weather and services.weather.current().weather.value) == "clear") and (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true))) then
        do local _g = H.safe_id('mission', "MISSION_REACH_SPACEPORT"); if H.u(ctx) and _g then local _res = services.missions.reserve(_g); if _res.ok and _res.value and _res.value.token then services.missions.assign(H.u(ctx), _res.value.token) end end end
        services.messages.add(ctx:expand_text(services.translate("You notice the rocket plumes of three ascending ships in the distance.  There must be a large space port in that direction.")), "neutral")
        return true
    end
    return false
    end
    COND["afs_night_messages"] = function(ctx)
        return ((services.random.native_probability(1, (3)) and (not ((not services.gameplay.environment.is_night()))) and (((H.char_snap(H.u(ctx)) or {}).senses or {}).can_see ~= false) and ((services.weather.current().weather and services.weather.current().weather.value) == "clear") and (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true))) == true
    end
    EOC["afs_night_messages"] = function(ctx)
    if ((services.random.native_probability(1, (3)) and (not ((not services.gameplay.environment.is_night()))) and (((H.char_snap(H.u(ctx)) or {}).senses or {}).can_see ~= false) and ((services.weather.current().weather and services.weather.current().weather.value) == "clear") and (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true))) then
        services.messages.add((services.snippets.native_random("AFS_NIGHT_MESSAGES_1") or ''), "neutral")
        return true
    end
    return false
    end
    COND["afs_motion_sensor_audio_warning_low"] = function(ctx)
        return ((H.mons_nearby(H.u(ctx), {  }, 24, nil) > 1)) == true
    end
    EOC["afs_motion_sensor_audio_warning_low"] = function(ctx)
    if ((H.mons_nearby(H.u(ctx), {  }, 24, nil) > 1)) then
        services.messages.add(ctx:expand_text(services.translate("The motion detector emits a single warning beep.")), "info")
        return true
    end
    return false
    end
    COND["afs_motion_sensor_audio_warning_medium"] = function(ctx)
        return ((H.mons_nearby(H.u(ctx), {  }, 24, nil) > 5)) == true
    end
    EOC["afs_motion_sensor_audio_warning_medium"] = function(ctx)
    if ((H.mons_nearby(H.u(ctx), {  }, 24, nil) > 5)) then
        services.messages.add(ctx:expand_text(services.translate("The motion detector emits a short series of warning beeps.")), "warning")
        return true
    else
        H.run_eoc("afs_motion_sensor_audio_warning_low", ctx, nil, nil, nil)
        return false
    end
    end
    COND["afs_motion_sensor_audio_warning_high"] = function(ctx)
        return ((H.mons_nearby(H.u(ctx), {  }, 24, nil) > 15)) == true
    end
    EOC["afs_motion_sensor_audio_warning_high"] = function(ctx)
    if ((H.mons_nearby(H.u(ctx), {  }, 24, nil) > 15)) then
        services.messages.add(ctx:expand_text(services.translate("The motion detector whines distressingly!")), "warning")
        return true
    else
        H.run_eoc("afs_motion_sensor_audio_warning_medium", ctx, nil, nil, nil)
        return false
    end
    end
    COND["afs_motion_sensor_eoc"] = function(ctx)
        return (H.char_has_items(H.u(ctx), "afs_motion_sensor_on", math.floor(0), math.floor(1))) == true
    end
    EOC["afs_motion_sensor_eoc"] = function(ctx)
    if (H.char_has_items(H.u(ctx), "afs_motion_sensor_on", math.floor(0), math.floor(1))) then
        H.run_eoc("afs_motion_sensor_audio_warning_high", ctx, nil, nil, nil)
        H.set_var("actor", H.u(ctx), ctx, "flag_motion_sensor_afs_motion_sensor_ping", (H.var_num(H.u(ctx), "flag_motion_sensor_afs_motion_sensor_ping")) + (1))
        do local _t = math.max(1, math.floor(2)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("afs_motion_sensor_eoc_end_ping"), nil) end end
        return true
    end
    return false
    end
    EOC["afs_motion_sensor_eoc_end_ping"] = function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "flag_motion_sensor_afs_motion_sensor_ping", 0)
    return true
    end
    COND["EOC_LIEUTENANT_SPAWN_SHADOW"] = function(ctx)
        return (H.test_eoc("EOC_SHADOW_SPAWN_CONDITIONS", ctx)) == true
    end
    EOC["EOC_LIEUTENANT_SPAWN_SHADOW"] = function(ctx)
    if (H.test_eoc("EOC_SHADOW_SPAWN_CONDITIONS", ctx)) then
        return true
    else
        return false
    end
    end
    EOC["_SHIELD_SETUP"] = function(ctx)
    H.set_var("actor", H.npc(ctx), ctx, "shield_uid", (ctx:get_number("shield_uid") or 0))
    H.set_var("actor", H.npc(ctx), ctx, "shield_is_bionic", 0)
    H.set_var("actor", H.npc(ctx), ctx, "shield_turn", 0)
    H.set_var("actor", H.npc(ctx), ctx, "SHIELD_REGEN", 0)
    H.set_var("actor", H.npc(ctx), ctx, "SHIELD_REGEN_RATE", 0)
    H.set_var("actor", H.npc(ctx), ctx, "ENERGY_SHIELD_HP", ((ctx:get_number("shield_max_hp") or 0) * 0.1))
    H.set_var("actor", H.npc(ctx), ctx, "ENERGY_SHIELD_MAX_HP", (ctx:get_number("shield_max_hp") or 0))
    H.set_var("actor", H.npc(ctx), ctx, "SHIELD_REGEN", (ctx:get_number("shield_regen") or 0))
    H.set_var("actor", H.npc(ctx), ctx, "SHIELD_REGEN_RATE", H.global_var_num("shield_regen_rate"))
    H.set_var("actor", H.u(ctx), ctx, "shield_ratio", (H.var_num(H.npc(ctx), "ENERGY_SHIELD_HP") / H.var_num(H.npc(ctx), "ENERGY_SHIELD_MAX_HP")))
    return true
    end
    EOC["EOC_start_shield"] = function(ctx)
    if ((not ((H.u(ctx) ~= nil and H.safe_id('json_flag', "ENERGY_SHIELD") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "ENERGY_SHIELD")).value == true))) and (H.npc(ctx) ~= nil and H.u(ctx) ~= nil and services.items.has_ammo(H.npc(ctx), H.u(ctx)).value == true)) then
        local _u8 = H.u(ctx)
        if _u8 then services.characters.adjust(_u8, { moves = -math.floor(((ctx:get_number("turn_cost") or 0)) * 100) }) end
        H.eoc_cast_spell(H.u(ctx), "spawn_shield", false, { hit_self = true })
        services.messages.add(H.var_str("context", nil, ctx, "success_message", ""), "neutral")
        do local _g = H.safe_id('item', H.var_str("context", nil, ctx, "transform_target", "")); if H.npc(ctx) and _g then services.items.transform(H.npc(ctx), _g, { active = true }) end end
        H.set_var("context", nil, ctx, "shield_uid", services.random.native_int(0, H.round_half_away(1200)))
        H.set_var("actor", H.npc(ctx), ctx, "shield_gen_uid", (ctx:get_number("shield_uid") or 0))
        H.eoc_run_inv_eocs(H.u(ctx), ctx, "all", nil, { { id = ((function() local _t = { "afs_energy_shield" }; return _t[services.random.native_int(1, #_t)] end)()) } }, { "_SHIELD_SETUP" }, {  })
    else
        services.messages.add(H.var_str("context", nil, ctx, "failure_message", ""), "neutral")
    end
    return true
    end
    COND["_afs_actually_do_shield"] = function(ctx)
        return (((ctx:get_number("shield_uid") or 0) == H.var_num(H.npc(ctx), "shield_gen_uid"))) == true
    end
    EOC["_afs_actually_do_shield"] = function(ctx)
    if (((ctx:get_number("shield_uid") or 0) == H.var_num(H.npc(ctx), "shield_gen_uid"))) then
        H.set_var("actor", H.u(ctx), ctx, "proceed_shield", 1)
        return true
    end
    return false
    end
    EOC["EOC_afs_do_shield"] = function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "proceed_shield", 0)
    H.set_var("context", nil, ctx, "shield_uid", H.var_num(H.npc(ctx), "shield_uid"))
    H.set_var("actor", H.u(ctx), ctx, "shield_ratio", ((H.var_num(H.npc(ctx), "ENERGY_SHIELD_HP") / H.var_num(H.npc(ctx), "ENERGY_SHIELD_MAX_HP")) * 100))
    if ((H.var_num(H.npc(ctx), "shield_is_bionic") == 1) and H.char_has_flag(H.u(ctx), "BIO_SHIELD_ACTIVE")) then
        H.set_var("actor", H.u(ctx), ctx, "proceed_shield", 1)
    else
        H.eoc_run_inv_eocs(H.u(ctx), ctx, "all", nil, { { worn_only = true } }, { "_afs_actually_do_shield" }, {  })
    end
    if (H.var_num(H.u(ctx), "proceed_shield") == 1) then
        H.set_var("actor", H.npc(ctx), ctx, "shield_turn", (H.var_num(H.npc(ctx), "shield_turn")) + (1))
        if ((H.var_num(H.npc(ctx), "SHIELD_REGEN") ~= 0) and ((H.var_num(H.npc(ctx), "shield_turn") / H.var_num(H.npc(ctx), "SHIELD_REGEN_RATE")) > 1)) then
            H.set_var("actor", H.npc(ctx), ctx, "shield_turn", 0)
            H.set_var("actor", H.npc(ctx), ctx, "ENERGY_SHIELD_HP", (H.var_num(H.npc(ctx), "ENERGY_SHIELD_HP")) + (H.var_num(H.npc(ctx), "SHIELD_REGEN")))
            H.set_var("actor", H.npc(ctx), ctx, "ENERGY_SHIELD_HP", (((H.var_num(H.npc(ctx), "ENERGY_SHIELD_HP") > H.var_num(H.npc(ctx), "ENERGY_SHIELD_MAX_HP"))) and (H.var_num(H.npc(ctx), "ENERGY_SHIELD_MAX_HP")) or (H.var_num(H.npc(ctx), "ENERGY_SHIELD_HP"))))
        end
    else
        do local g = H.safe_id('item', "afs_energy_shield"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        H.set_var("actor", H.u(ctx), ctx, "shield_ratio", (-1))
    end
    return true
    end
    EOC["EOC_stop_shield"] = function(ctx)
    do local _g = H.safe_id('item', H.var_str("context", nil, ctx, "transform_target", "")); if H.npc(ctx) and _g then services.items.transform(H.npc(ctx), _g, nil) end end
    do local g = H.safe_id('item', "afs_energy_shield"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
    H.set_var("actor", H.u(ctx), ctx, "shield_ratio", (-1))
    return true
    end
    EOC["_afs_drop_update_power"] = function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "shield_power_ratio", H.char_bionic_power(H.npc(ctx), "power_percentage"))
    return true
    end
    COND["EOC_check_drop_shield_gen"] = function(ctx)
        return ((((("ACT_DROP") == (H.var_str("context", nil, ctx, "activity", "")))) and (H.var_num(H.u(ctx), "shield_power_ratio") >= 0))) == true
    end
    EOC["EOC_check_drop_shield_gen"] = function(ctx)
    if ((((("ACT_DROP") == (H.var_str("context", nil, ctx, "activity", "")))) and (H.var_num(H.u(ctx), "shield_power_ratio") >= 0))) then
        H.set_var("actor", H.u(ctx), ctx, "shield_power_ratio", (-1))
        H.eoc_run_inv_eocs(H.u(ctx), ctx, "all", nil, { { worn_only = true } }, { "_afs_drop_update_power" }, {  })
        return true
    end
    return false
    end
    COND["EOC_detonate_shield"] = function(ctx)
        return ((((("afs_energy_shield") == (H.var_str("context", nil, ctx, "itype", "")))))) == true
    end
    EOC["EOC_detonate_shield"] = function(ctx)
    if ((((("afs_energy_shield") == (H.var_str("context", nil, ctx, "itype", "")))))) then
        H.set_var("actor", H.u(ctx), ctx, "shield_ratio", (-1))
        if H.u(ctx) then services.characters.emit(H.u(ctx), "heavy_rad_glimmer", 2) end
        services.messages.add(ctx:expand_text(services.translate("The shield blasts you with radiation as it dissipates.")), "bad")
        return true
    end
    return false
    end
    EOC["_EOC_JETPACK_RUN_ACTIVE"] = function(ctx)
    do local _g = H.safe_id('item', "afs_jetpack_active"); if H.npc(ctx) and _g then services.items.transform(H.npc(ctx), _g, { active = true }) end end
    services.messages.add(ctx:expand_text(services.translate("You start using the rocket pack to boost your running speed.")), "neutral")
    return true
    end
    COND["EOC_JETPACK_RUN_ACTIVE"] = function(ctx)
        return (((H.u(ctx) ~= nil and H.safe_id('json_flag', "JETPACK") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "JETPACK")).value == true) and ((("run") == (H.var_str("context", nil, ctx, "movement_mode", "")))))) == true
    end
    EOC["EOC_JETPACK_RUN_ACTIVE"] = function(ctx)
    if (((H.u(ctx) ~= nil and H.safe_id('json_flag', "JETPACK") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "JETPACK")).value == true) and ((("run") == (H.var_str("context", nil, ctx, "movement_mode", "")))))) then
        H.eoc_run_inv_eocs(H.u(ctx), ctx, "all", nil, { { id = "afs_jetpack", worn_only = true, _cond_fn = function(ctx) return ((H.npc(ctx) ~= nil and H.u(ctx) ~= nil and services.items.has_ammo(H.npc(ctx), H.u(ctx)).value == true)) end } }, { "_EOC_JETPACK_RUN_ACTIVE" }, {  })
        return true
    end
    return false
    end
    EOC["_EOC_JETPACK_RUN_DEACTIVATE"] = function(ctx)
    do local _g = H.safe_id('item', "afs_jetpack"); if H.npc(ctx) and _g then services.items.transform(H.npc(ctx), _g, nil) end end
    return true
    end
    COND["EOC_JETPACK_RUN_DEACTIVATE"] = function(ctx)
        return (((H.u(ctx) ~= nil and H.safe_id('json_flag', "JETPACK") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "JETPACK")).value == true) and (not (((("run") == (H.var_str("context", nil, ctx, "movement_mode", "")))))))) == true
    end
    EOC["EOC_JETPACK_RUN_DEACTIVATE"] = function(ctx)
    if (((H.u(ctx) ~= nil and H.safe_id('json_flag', "JETPACK") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "JETPACK")).value == true) and (not (((("run") == (H.var_str("context", nil, ctx, "movement_mode", "")))))))) then
        H.eoc_run_inv_eocs(H.u(ctx), ctx, "all", nil, { { id = "afs_jetpack_active", worn_only = true, _cond_fn = function(ctx) return ((H.npc(ctx) ~= nil and H.u(ctx) ~= nil and services.items.has_ammo(H.npc(ctx), H.u(ctx)).value == true)) end } }, { "_EOC_JETPACK_RUN_DEACTIVATE" }, {  })
        return true
    end
    return false
    end
    EOC["EOC_SHOCK_MINE_CONTROL"] = function(ctx)
    if H.truthy((H.var_exists("actor", H.u(ctx), ctx, "death_timer") and 1 or 0)) then
        if (H.time_since(H.var_num_opt(H.u(ctx), "death_timer"), 1) > 28800) then
            if H.u(ctx) then services.characters.die(H.u(ctx)) end
        end
    else
        H.set_var("actor", H.u(ctx), ctx, "death_timer", services.turn())
    end
    return true
    end
    EOC["EOC_UICA_VEHICLE_BUY"] = function(ctx)
    H.set_var("actor", H.npc(ctx), ctx, "player_has_bought_car", "yes")
    do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "afs_shuttlepad_salvors_a1_1"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "afs_shuttlepad_salvors_garage_open_and_remove_lynx", "afs_shuttlepad_salvors_garage_place_lynx" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
    return true
    end
    EOC["EOC_GET_AUGUSTMOON_KIT"] = function(ctx)
    H.eoc_spawn_item(H.u(ctx), "augustmoon_kit", 1, true, false, nil)
    H.set_var("actor", H.u(ctx), ctx, "augustmoon_kit", "yes")
    return true
    end
    EOC["EOC_QUARTERMASTER_DID_NOT_PAY_BRIBE"] = function(ctx)
    H.set_var("actor", H.npc(ctx), ctx, "player_can_trade", "no")
    return true
    end
    EOC["EOC_GENERIC_SALVAGE_COMPUTER"] = function(ctx)
    if H.npc(ctx) then services.npcs.open_dialogue(H.npc(ctx), H.u(ctx)) end
    return true
    end
    EOC["EOC_COMPUTER_GENERIC_SALVAGE_FAIL"] = function(ctx)
    ccb.presentation.notice(ctx:expand_text(services.translate("The computer shuts down for a final time.")))
    do local _p, _g = (H.creature_snap(H.u(ctx)) or {}).position, H.safe_id('terrain_furniture_transform', "afs_computer_off"); if _p and _g then services.world.transform_radius(_p, math.floor(1), _g, nil) end end
    return true
    end
    EOC["EOC_ESPOD_CONTROL"] = function(ctx)
    if H.npc(ctx) then services.npcs.open_dialogue(H.npc(ctx), H.u(ctx)) end
    return true
    end
    COND["EOC_AFS_ESPER_OLD_EFFECTS_REMOVAL"] = function(ctx)
        return ((H.creature_has_effect(H.u(ctx), "effect_telepath_sense_minds") or H.creature_has_effect(H.u(ctx), "effect_telepathic_suggestion") or H.creature_has_effect(H.u(ctx), "effect_telepathic_psi_armor"))) == true
    end
    EOC["EOC_AFS_ESPER_OLD_EFFECTS_REMOVAL"] = function(ctx)
    if ((H.creature_has_effect(H.u(ctx), "effect_telepath_sense_minds") or H.creature_has_effect(H.u(ctx), "effect_telepathic_suggestion") or H.creature_has_effect(H.u(ctx), "effect_telepathic_psi_armor"))) then
        do local _eg = H.safe_id('effect', "effect_telepath_sense_minds"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "effect_telepathic_suggestion"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "effect_telepathic_psi_armor"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        H.run_eoc("EOC_AFS_END_PSI_POWERS_MAINTAINED", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_AFS_UPGRADE_ESPERS_ON_LOAD"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "ESPER") == 1) and (not (H.char_has_any_trait(H.u(ctx), { "ESPER_ADVANCEMENT_OKAY", "ESPER_STARTER_ADVANCEMENT_OKAY" }))) and (H.var_num(H.u(ctx), "afs_esper_heritage_updated") ~= 1))) == true
    end
    EOC["EOC_AFS_UPGRADE_ESPERS_ON_LOAD"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "ESPER") == 1) and (not (H.char_has_any_trait(H.u(ctx), { "ESPER_ADVANCEMENT_OKAY", "ESPER_STARTER_ADVANCEMENT_OKAY" }))) and (H.var_num(H.u(ctx), "afs_esper_heritage_updated") ~= 1))) then
        do local _g = H.safe_id('mutation', "ESPER_STARTER_ADVANCEMENT_OKAY"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        H.set_var("actor", H.u(ctx), ctx, "afs_esper_heritage_updated", 1)
        return true
    end
    return false
    end
    COND["EOC_AFS_UPGRADE_ESPERS_ON_GAME_START"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "ESPER") == 1) and (H.var_num(H.u(ctx), "afs_esper_heritage_updated") ~= 1))) == true
    end
    EOC["EOC_AFS_UPGRADE_ESPERS_ON_GAME_START"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "ESPER") == 1) and (H.var_num(H.u(ctx), "afs_esper_heritage_updated") ~= 1))) then
        H.set_var("actor", H.u(ctx), ctx, "afs_esper_heritage_updated", 1)
        return true
    end
    return false
    end
    EOC["eoc_bio_superheater_on"] = function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "bio_superheater_on", "yes")
    return true
    end
    EOC["eoc_bio_superheater_off"] = function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "bio_superheater_on", nil)
    return true
    end
    EOC["eoc_bio_blade_electric_on"] = function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "bio_blade_electric_on", "yes")
    return true
    end
    EOC["eoc_bio_blade_electric_off"] = function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "bio_blade_electric_on", nil)
    return true
    end
    COND["afs_eoc_blood_brain_heal"] = function(ctx)
        return (H.char_has_bionic(H.u(ctx), "afs_bio_blood_brain")) == true
    end
    EOC["afs_eoc_blood_brain_heal"] = function(ctx)
    if (H.char_has_bionic(H.u(ctx), "afs_bio_blood_brain")) then
        H.set_char_hp(H.u(ctx), "head", 1, "=")
        return true
    end
    return false
    end
    EOC["afs_eoc_chembaseline"] = function(ctx)
    do local _eg = H.safe_id('effect', "decreased_performance"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    do local _g = H.safe_id('morale', "morale_afs_drugs"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(20), math.floor(60), { duration = services.time.duration_from_turns(math.floor(129600)), decay_start = services.time.duration_from_turns(math.floor(86400)) }) end end
    return true
    end
    EOC["afs_eoc_hangover_baseline"] = function(ctx)
    H.eoc_add_effect(H.u(ctx), "decreased_performance", 21600, nil, nil, nil)
    H.eoc_add_effect(H.u(ctx), "disrupted_sleep", 28800, nil, nil, nil)
    do local _g = H.safe_id('morale', "morale_afs_drugs"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(-20), math.floor(-60), { duration = services.time.duration_from_turns(math.floor(129600)), decay_start = services.time.duration_from_turns(math.floor(86400)) }) end end
    return true
    end
    EOC["afs_eoc_chemspeed"] = function(ctx)
    do local _eg = H.safe_id('effect', "post_speed_injection"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    return true
    end
    EOC["afs_eoc_hangover_speed"] = function(ctx)
    H.eoc_add_effect(H.u(ctx), "post_speed_injection", 21600, nil, nil, nil)
    H.eoc_add_effect(H.u(ctx), "disrupted_sleep", 28800, nil, nil, nil)
    do local _g = H.safe_id('morale', "morale_afs_drugs"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(-20), math.floor(-60), { duration = services.time.duration_from_turns(math.floor(129600)), decay_start = services.time.duration_from_turns(math.floor(86400)) }) end end
    return true
    end
    EOC["afs_eoc_chemhealing"] = function(ctx)
    do local _eg = H.safe_id('effect', "post_healing_injection"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    return true
    end
    COND["afs_eoc_chemhealing_pkill"] = function(ctx)
        return (services.random.native_probability(1, (40))) == true
    end
    EOC["afs_eoc_chemhealing_pkill"] = function(ctx)
    if (services.random.native_probability(1, (40))) then
        local _a9 = H.u(ctx)
        if _a9 then services.characters.adjust(_a9, { pain = math.floor(-1) }) end
        return true
    end
    return false
    end
    EOC["afs_eoc_hangover_healing"] = function(ctx)
    H.eoc_add_effect(H.u(ctx), "post_healing_injection", 21600, "torso", nil, nil)
    H.set_char_val_extra(H.u(ctx), "sleepiness", 80, "+=")
    do local _g = H.safe_id('morale', "morale_afs_drugs"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(-20), math.floor(-60), { duration = services.time.duration_from_turns(math.floor(129600)), decay_start = services.time.duration_from_turns(math.floor(86400)) }) end end
    return true
    end
    EOC["afs_eoc_chemstrength"] = function(ctx)
    do local _eg = H.safe_id('effect', "post_strength_injection"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    return true
    end
    EOC["afs_eoc_hangover_strength"] = function(ctx)
    H.eoc_add_effect(H.u(ctx), "post_strength_injection", 21600, nil, nil, nil)
    H.set_char_val_extra(H.u(ctx), "sleepiness", 80, "+=")
    do local _g = H.safe_id('morale', "morale_afs_drugs"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(-20), math.floor(-60), { duration = services.time.duration_from_turns(math.floor(129600)), decay_start = services.time.duration_from_turns(math.floor(86400)) }) end end
    return true
    end
    EOC["_BIO_SHIELD_SETUP"] = function(ctx)
    H.set_var("actor", H.npc(ctx), ctx, "shield_uid", (ctx:get_number("shield_uid") or 0))
    H.set_var("actor", H.npc(ctx), ctx, "shield_is_bionic", 1)
    H.set_var("actor", H.npc(ctx), ctx, "shield_turn", 0)
    H.set_var("actor", H.npc(ctx), ctx, "SHIELD_REGEN", 0)
    H.set_var("actor", H.npc(ctx), ctx, "SHIELD_REGEN_RATE", 0)
    H.set_var("actor", H.npc(ctx), ctx, "ENERGY_SHIELD_HP", ((ctx:get_number("shield_max_hp") or 0) * 0.1))
    H.set_var("actor", H.npc(ctx), ctx, "ENERGY_SHIELD_MAX_HP", (ctx:get_number("shield_max_hp") or 0))
    H.set_var("actor", H.npc(ctx), ctx, "SHIELD_REGEN", (ctx:get_number("shield_regen") or 0))
    H.set_var("actor", H.npc(ctx), ctx, "SHIELD_REGEN_RATE", H.global_var_num("shield_regen_rate"))
    H.set_var("actor", H.u(ctx), ctx, "shield_ratio", (H.var_num(H.npc(ctx), "ENERGY_SHIELD_HP") / H.var_num(H.npc(ctx), "ENERGY_SHIELD_MAX_HP")))
    return true
    end
    EOC["EOC_bio_start_shield"] = function(ctx)
    if (not ((H.u(ctx) ~= nil and H.safe_id('json_flag', "ENERGY_SHIELD") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "ENERGY_SHIELD")).value == true))) then
        H.eoc_cast_spell(H.u(ctx), "spawn_shield", false, { hit_self = true })
        services.messages.add(H.var_str("context", nil, ctx, "success_message", ""), "neutral")
        H.set_var("context", nil, ctx, "shield_uid", services.random.native_int(0, H.round_half_away(1200)))
        H.set_var("actor", H.u(ctx), ctx, "shield_gen_uid", (ctx:get_number("shield_uid") or 0))
        H.set_var("actor", H.u(ctx), ctx, "shield_power_ratio", H.char_bionic_power(H.u(ctx), "power_percentage"))
        H.eoc_run_inv_eocs(H.u(ctx), ctx, "all", nil, { { id = ((function() local _t = { "afs_energy_shield" }; return _t[services.random.native_int(1, #_t)] end)()) } }, { "_BIO_SHIELD_SETUP" }, {  })
    else
        services.messages.add(H.var_str("context", nil, ctx, "failure_message", ""), "neutral")
    end
    return true
    end
    EOC["EOC_bio_stop_shield"] = function(ctx)
    do local g = H.safe_id('item', "afs_energy_shield"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
    H.set_var("actor", H.u(ctx), ctx, "shield_ratio", (-1))
    return true
    end
    EOC["EOC_bio_update_ui"] = function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "shield_power_ratio", H.char_bionic_power(H.u(ctx), "power_percentage"))
    return true
    end
    COND["EOC_AFS_ELECTROKIN_SEE_ELECTRICITY_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_afs_electrokin_see_electricity"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_AFS_ELECTROKIN_SEE_ELECTRICITY_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_afs_electrokin_see_electricity"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("You open your senses to the flow of current.")), "good")
        H.run_eoc("EOC_AFS_POWER_MAINTENANCE_PLUS_ONE", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_afs_electrokin_see_electricity", -1, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "afs_electrokinetic_see_electric") * 150) + 900) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0)))), math.floor((((H.char_spell_level(H.u(ctx), "afs_electrokinetic_see_electric") * 300) + 1800) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0)))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_AFS_ELECTROKIN_SEE_ELECTRICITY_MAINTENANCE"), nil) end end
        return true
    else
        H.run_eoc("EOC_AFS_ELECTROKIN_REMOVE_SEE_ELECTRICITY", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_AFS_ELECTROKIN_REMOVE_SEE_ELECTRICITY"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_afs_electrokin_see_electricity"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_AFS_ELECTROKIN_REMOVE_SEE_ELECTRICITY"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_afs_electrokin_see_electricity"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_AFS_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        do local _eg = H.safe_id('effect', "effect_afs_electrokin_see_electricity"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_AFS_ELECTROKIN_SEE_ELECTRICITY_MAINTENANCE"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_afs_electrokin_see_electricity"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_AFS_ELECTROKIN_SEE_ELECTRICITY_MAINTENANCE"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_afs_electrokin_see_electricity"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", H.char_spell_difficulty(H.u(ctx), "afs_electrokinetic_see_electric", false))
        do local _a, _sp = H.u(ctx), "afs_electrokinetic_see_electric"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula_maintenance(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        H.run_eoc("EOC_AFS_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "afs_electrokinetic_see_electric") * 150) + 900) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0)))), math.floor((((H.char_spell_level(H.u(ctx), "afs_electrokinetic_see_electric") * 300) + 1800) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0)))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_AFS_ELECTROKIN_SEE_ELECTRICITY_MAINTENANCE"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_AFS_ELECTROKIN_HACKING_INTERFACE_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_afs_electrokin_hacking_interface"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_AFS_ELECTROKIN_HACKING_INTERFACE_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_afs_electrokin_hacking_interface"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("You now have the ability to hack into nearby electronics.")), "good")
        H.run_eoc("EOC_AFS_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        H.run_eoc("EOC_AFS_ELECTROKIN_HACKING_INTERFACE_SWITCHER", ctx, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "effect_afs_electrokin_hacking_interface", -1, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "afs_electrokinetic_hacking_interface") * 45) + 600) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0)))), math.floor((((H.char_spell_level(H.u(ctx), "afs_electrokinetic_hacking_interface") * 90) + 1800) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0)))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_AFS_ELECTROKIN_HACKING_INTERFACE_MAINTENANCE"), nil) end end
        return true
    else
        H.run_eoc("EOC_AFS_ELECTROKIN_REMOVE_HACKING_INTERFACE", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_AFS_ELECTROKIN_REMOVE_HACKING_INTERFACE"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_afs_electrokin_hacking_interface"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_AFS_ELECTROKIN_REMOVE_HACKING_INTERFACE"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_afs_electrokin_hacking_interface"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        do local g = H.safe_id('item', "electrokinetic_electrohack_1"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "electrokinetic_electrohack_2"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "electrokinetic_electrohack_3"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "electrokinetic_electrohack_4"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local g = H.safe_id('item', "electrokinetic_electrohack_5"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
        do local _eg = H.safe_id('effect', "effect_afs_electrokin_hacking_interface"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        H.run_eoc("EOC_AFS_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    EOC["EOC_AFS_ELECTROKIN_HACKING_INTERFACE_SWITCHER"] = function(ctx)
    do
        local _sw10 = H.char_spell_level(H.u(ctx), "afs_electrokinetic_hacking_interface")
        if _sw10 == 0 then
            H.eoc_spawn_item(H.u(ctx), "electrokinetic_electrohack_1", 1, false, true, nil)
        elseif _sw10 == 5 then
            H.eoc_spawn_item(H.u(ctx), "electrokinetic_electrohack_2", 1, false, true, nil)
        elseif _sw10 == 10 then
            H.eoc_spawn_item(H.u(ctx), "electrokinetic_electrohack_3", 1, false, true, nil)
        elseif _sw10 == 15 then
            H.eoc_spawn_item(H.u(ctx), "electrokinetic_electrohack_4", 1, false, true, nil)
        elseif _sw10 == 20 then
            H.eoc_spawn_item(H.u(ctx), "electrokinetic_electrohack_5", 1, false, true, nil)
        end
    end
    return true
    end
    COND["EOC_AFS_ELECTROKIN_HACKING_INTERFACE_MAINTENANCE"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_afs_electrokin_hacking_interface"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_AFS_ELECTROKIN_HACKING_INTERFACE_MAINTENANCE"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_afs_electrokin_hacking_interface"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", H.char_spell_difficulty(H.u(ctx), "afs_electrokinetic_hacking_interface", false))
        do local _a, _sp = H.u(ctx), "afs_electrokinetic_hacking_interface"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = H._jm_psionic_power_experience_formula_maintenance(ctx); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        H.run_eoc("EOC_AFS_POWER_MAINTENANCE_CONCENTRATION_CHECK", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((((H.char_spell_level(H.u(ctx), "afs_electrokinetic_hacking_interface") * 45) + 600) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0)))), math.floor((((H.char_spell_level(H.u(ctx), "afs_electrokinetic_hacking_interface") * 90) + 1800) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0)))); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_AFS_ELECTROKIN_HACKING_INTERFACE_MAINTENANCE"), nil) end end
        return true
    else
        return false
    end
    end
    COND["EOC_AFS_ELECTROKIN_PERSONAL_BATTERY_INITIATE"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_afs_electrokin_personal_battery"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_AFS_ELECTROKIN_PERSONAL_BATTERY_INITIATE"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_afs_electrokin_personal_battery"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        services.messages.add(ctx:expand_text(services.translate("The hair on your body stands up on end.")), "good")
        H.run_eoc("EOC_AFS_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(math.max((60 - ((H.char_spell_level(H.u(ctx), "afs_electrokinetic_personal_battery") * 2.5) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0)))), 5)), math.floor(math.max((240 - ((H.char_spell_level(H.u(ctx), "afs_electrokinetic_personal_battery") * 5) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0)))), 10)); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_AFS_ELECTROKIN_PERSONAL_BATTERY_INV_SCANNER"), nil) end end
        H.eoc_add_effect(H.u(ctx), "effect_afs_electrokin_personal_battery", -1, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(math.min((((H.char_spell_level(H.u(ctx), "afs_electrokinetic_personal_battery") * 45) + 600) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0))), 14400)), math.floor(math.min((((H.char_spell_level(H.u(ctx), "afs_electrokinetic_personal_battery") * 90) + 1800) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0))), 14400)); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_AFS_ELECTROKIN_PERSONAL_BATTERY_MAINTENANCE"), nil) end end
        return true
    else
        H.run_eoc("EOC_AFS_ELECTROKIN_REMOVE_PERSONAL_BATTERY", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_AFS_ELECTROKIN_REMOVE_PERSONAL_BATTERY"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_afs_electrokin_personal_battery"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_AFS_ELECTROKIN_REMOVE_PERSONAL_BATTERY"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_afs_electrokin_personal_battery"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        do local _eg = H.safe_id('effect', "effect_afs_electrokin_personal_battery"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        H.run_eoc("EOC_AFS_POWER_MAINTENANCE_MINUS_ONE", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    EOC["EOC_AFS_ELECTROKIN_PERSONAL_BATTERY_INV_SCANNER_COUNTER"] = function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "afs_electrokin_personal_battery_count", (H.var_num(H.u(ctx), "afs_electrokin_personal_battery_count")) + (1))
    return true
    end
    COND["EOC_AFS_ELECTROKIN_PERSONAL_BATTERY_INV_SCANNER"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_afs_electrokin_personal_battery"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_AFS_ELECTROKIN_PERSONAL_BATTERY_INV_SCANNER"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_afs_electrokin_personal_battery"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(math.max((60 - ((H.char_spell_level(H.u(ctx), "afs_electrokinetic_personal_battery") * 2.5) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0)))), 5)), math.floor(math.max((240 - ((H.char_spell_level(H.u(ctx), "afs_electrokinetic_personal_battery") * 5) * H._jm_scaling_factor(ctx, (((H.char_snap(H.u(ctx)) or {}).stats or {}).intelligence or 0)))), 10)); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_AFS_ELECTROKIN_PERSONAL_BATTERY_INV_SCANNER"), nil) end end
        H.set_var("actor", H.u(ctx), ctx, "afs_electrokin_personal_battery_count", 0)
        H.eoc_run_inv_eocs(H.u(ctx), ctx, "all", nil, { {  } }, { "EOC_AFS_ELECTROKIN_PERSONAL_BATTERY_INV_SCANNER_COUNTER" }, {  })
        do local _t = math.max(1, math.floor(1)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_AFS_ELECTROKIN_PERSONAL_BATTERY_INV_SCANNER_FINALIZATION"), nil) end end
        return true
    end
    return false
    end
end
