local ccb = require("ccb")
local services = ccb.services
return function(E, H)
    local EOC = E.run
    local COND = E.cond
    EOC["EOC_return_to_player"] = function(ctx)
    H.run_eoc("_EOC_return_to_player_do", ctx, nil, services.characters.avatar(), (services.characters.by_id(math.floor(H.global_var_num("player_id") or 0)).value))
    return true
    end
    EOC["_EOC_hello_world_msg"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("hello world")), "neutral")
    return true
    end
    EOC["EOC_null_talker_test"] = function(ctx)
    H.run_eoc("_EOC_hello_world_msg", ctx, nil, "", "")
    return true
    end
    EOC["EOC_set_talker_test"] = function(ctx)
    do local _s = H.char_snap(H.u(ctx)); if _s and _s.id then H.set_var("global", nil, ctx, "u_character_id", _s.id) end end
    services.messages.add(ctx:expand_text(services.translate("Your character id is <global_val:u_character_id>")), "neutral")
    return true
    end
    COND["EOC_print_item_charge"] = function(ctx)
        return ((H.char_bionic_power(H.npc(ctx), "power_max") > 0)) == true
    end
    EOC["EOC_print_item_charge"] = function(ctx)
    if ((H.char_bionic_power(H.npc(ctx), "power_max") > 0)) then
        H.set_var("global", nil, ctx, "ITEM_POWER", H.char_bionic_power(H.npc(ctx), "power"))
        H.set_var("global", nil, ctx, "ITEM_POWER_MAX", H.char_bionic_power(H.npc(ctx), "power_max"))
        H.set_var("global", nil, ctx, "ITEM_POWER_PERC", H.char_bionic_power(H.npc(ctx), "power_percentage"))
        services.messages.add(ctx:expand_text(services.translate("<global_val:ITEM_POWER> / <global_val:ITEM_POWER_MAX> (<global_val:ITEM_POWER_PERC>%)")), "neutral")
        return true
    end
    return false
    end
    EOC["EOC_dimension_swap_test"] = function(ctx)
    do local _ir = services.interaction.input_text(services.text.expand_for("teleport to dimension named:", ctx), { default = ctx:expand_text(services.translate("")) }); if _ir and _ir.accepted then H.set_var("actor", H.u(ctx), ctx, "destination_dimension", _ir.value) end end
    do local _dr = services.relocation.travel_to_dimension(H.var_str("actor", H.u(ctx), ctx, "destination_dimension", ""), { npc_travel_radius = math.floor(5), npc_travel_filter = "follower" })
        if _dr and _dr.ok and _dr.value and _dr.value.accepted then services.messages.add(ctx:expand_text(services.translate("This place feels different.")), 'good') end
        if not (_dr and _dr.ok and _dr.value and _dr.value.accepted) then services.messages.add(ctx:expand_text(services.translate("your body doesn't move")), 'bad') end
    end
    services.messages.add(H.var_str("actor", H.u(ctx), ctx, "destination_dimension", ""), "neutral")
    if (services.gameplay.environment.dimension() == "default") then
        services.messages.add(ctx:expand_text(services.translate("home sweet home")), "neutral")
    end
    return true
    end
    EOC["EOC_dimension_clear_test"] = function(ctx)
    do local _ir = services.interaction.input_text(services.text.expand_for("clear the dimension named:", ctx), { default = ctx:expand_text(services.translate("")) }); if _ir and _ir.accepted then H.set_var("actor", H.u(ctx), ctx, "target_dimension", _ir.value) end end
    services.gameplay.environment.clear_saved_dimension(H.var_str("actor", H.u(ctx), ctx, "target_dimension", ""))
    services.messages.add(ctx:expand_text(services.translate("if dimension with ID <u_val:target_dimension> existed, it doesn't anymore.")), "neutral")
    return true
    end
    COND["EOC_IS_ELECTRIC"] = function(ctx)
        return (((H.npc(ctx) ~= nil and ((H.safe_id('species', "ROBOT") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "ROBOT")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "CYBORG") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "CYBORG")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "ROBOT_FLYING") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "ROBOT_FLYING")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "LEECH_PLANT") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "LEECH_PLANT")).value == true))) or H.char_has_flag(H.npc(ctx), "ELECTRIC") or H.char_has_any_trait(H.npc(ctx), { "EXODII_BODY_1", "EXODII_BODY_2", "EXODII_BODY_9" }) or ((function() local eg = H.safe_id('effect', "absorbed_electric"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.npc(ctx) or not eg then return false end; return services.effects.has(H.npc(ctx), eg, bpg, nil).value == true end)()))) == true
    end
    EOC["EOC_IS_ELECTRIC"] = function(ctx)
    if (((H.npc(ctx) ~= nil and ((H.safe_id('species', "ROBOT") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "ROBOT")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "CYBORG") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "CYBORG")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "ROBOT_FLYING") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "ROBOT_FLYING")).value == true))) or (H.npc(ctx) ~= nil and ((H.safe_id('species', "LEECH_PLANT") ~= nil and services.creatures.has_species(H.npc(ctx), H.safe_id('species', "LEECH_PLANT")).value == true))) or H.char_has_flag(H.npc(ctx), "ELECTRIC") or H.char_has_any_trait(H.npc(ctx), { "EXODII_BODY_1", "EXODII_BODY_2", "EXODII_BODY_9" }) or ((function() local eg = H.safe_id('effect', "absorbed_electric"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.npc(ctx) or not eg then return false end; return services.effects.has(H.npc(ctx), eg, bpg, nil).value == true end)()))) then
        return true
    end
    return false
    end
    EOC["EOC_NONE"] = function(ctx)
    return true
    end
    COND["EOC_RandEnc"] = function(ctx)
        return (((H.var_exists('context', nil, ctx, "map_update") and H.var_exists('context', nil, ctx, "omt") and H.var_exists('context', nil, ctx, "map_removal") and H.var_exists('context', nil, ctx, "chance") and H.var_exists('context', nil, ctx, "days_till_spawn")) and services.random.native_probability(1, ((ctx:get_number("chance") or 0))) and ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), H.var_str("context", nil, ctx, "omt", ""), math.floor(30)) end)()) and ((services.time.calendar().now.turns_since_cataclysm / 86400) >= (ctx:get_number("days_till_spawn") or 0)) and (H.time_since(H.var_num_opt(H.u(ctx), "timer_caravan_RandEnc"), 1) >= 86400) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), H.var_str("context", nil, ctx, "omt", ""), math.floor(2)) end)()))) and (ctx:evaluate_conditional("random_enc_condition") == true))) == true
    end
    EOC["EOC_RandEnc"] = function(ctx)
    if (((H.var_exists('context', nil, ctx, "map_update") and H.var_exists('context', nil, ctx, "omt") and H.var_exists('context', nil, ctx, "map_removal") and H.var_exists('context', nil, ctx, "chance") and H.var_exists('context', nil, ctx, "days_till_spawn")) and services.random.native_probability(1, ((ctx:get_number("chance") or 0))) and ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), H.var_str("context", nil, ctx, "omt", ""), math.floor(30)) end)()) and ((services.time.calendar().now.turns_since_cataclysm / 86400) >= (ctx:get_number("days_till_spawn") or 0)) and (H.time_since(H.var_num_opt(H.u(ctx), "timer_caravan_RandEnc"), 1) >= 86400) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), H.var_str("context", nil, ctx, "omt", ""), math.floor(2)) end)()))) and (ctx:evaluate_conditional("random_enc_condition") == true))) then
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = H.var_str("context", nil, ctx, "omt", ""); local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ H.var_str("context", nil, ctx, "map_update", "") }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        H.set_var("actor", H.u(ctx), ctx, "timer_caravan_RandEnc", services.turn())
        H.eoc_loc_var(H.u(ctx), ctx, "global", "randenc_loc", { terrain = H.var_str("context", nil, ctx, "omt", "") }, nil, nil, nil, nil, false, true, {  }, {  })
        H.set_var("global", nil, ctx, "RandEnc", 1)
        H.copy_var("context", nil, "omt", "global", nil, "random_encounter_omt", ctx)
        H.copy_var("context", nil, "map_removal", "global", nil, "random_encounter_map_remove", ctx)
        return true
    end
    return false
    end
    COND["EOC_RandEnc_remove"] = function(ctx)
        return (((H.time_since(H.var_num_opt(H.u(ctx), "timer_caravan_RandEnc"), 1) > 3600) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), H.var_str("global", nil, ctx, "random_encounter_omt", ""), math.floor(2)) end)()))) and (H.global_var_num("RandEnc") == 1))) == true
    end
    EOC["EOC_RandEnc_remove"] = function(ctx)
    if (((H.time_since(H.var_num_opt(H.u(ctx), "timer_caravan_RandEnc"), 1) > 3600) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), H.var_str("global", nil, ctx, "random_encounter_omt", ""), math.floor(2)) end)()))) and (H.global_var_num("RandEnc") == 1))) then
        do local _p = H.get_tripoint_var("global", nil, ctx, "randenc_loc"); if _p then local _omt = _p:project_to('omt'); local _om = H.var_str("global", nil, ctx, "random_encounter_omt", ""); local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ H.var_str("global", nil, ctx, "random_encounter_map_remove", "") }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        H.set_var("global", nil, ctx, "RandEnc", 0)
        return true
    end
    return false
    end
    EOC["EOC_DEBUG_TELL_ME_TIME"] = function(ctx)
    H.set_var("global", nil, ctx, "TIME_TILL_SUNSET", (H.time_until_named("sunset", false) / 60))
    services.messages.add(ctx:expand_text(services.translate("Minutes remaining until sunset is <global_val:TIME_TILL_SUNSET>")), "good")
    H.set_var("global", nil, ctx, "TIME_TILL_NIGHT", (H.time_until_named("night_time", false) / 60))
    services.messages.add(ctx:expand_text(services.translate("Minutes remaining until night time is <global_val:TIME_TILL_NIGHT>")), "good")
    H.set_var("global", nil, ctx, "TIME_TILL_SUNRISE", (H.time_until_named("sunrise", false) / 60))
    services.messages.add(ctx:expand_text(services.translate("Minutes remaining until sunrise is <global_val:TIME_TILL_SUNRISE>")), "good")
    H.set_var("global", nil, ctx, "TIME_TILL_DAYTIME", (H.time_until_named("daylight_time", false) / 60))
    services.messages.add(ctx:expand_text(services.translate("Minutes remaining until daylight is <global_val:TIME_TILL_DAYTIME>")), "good")
    H.set_var("global", nil, ctx, "TIME_TILL_NOON", (H.time_until_named("noon", false) / 60))
    services.messages.add(ctx:expand_text(services.translate("Minutes remaining until noon is <global_val:TIME_TILL_NOON>")), "good")
    return true
    end
    EOC["EOC_repair_imperfect_doll"] = function(ctx)
    do local g = H.safe_id('item', "imperfect_doll_features"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
    do local g = H.safe_id('item', "imperfect_doll_arms"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
    do local g = H.safe_id('item', "imperfect_doll_legs"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
    H.eoc_spawn_item(H.u(ctx), "imperfect_doll_complete", 1, false, false, nil)
    do local _p, _g = (H.creature_snap(H.u(ctx)) or {}).position, H.safe_id('terrain_furniture_transform', "imperfect_doll_to_couch"); if _p and _g then services.world.transform_radius(_p, math.floor(5), _g, nil) end end
    return true
    end
    EOC["EOC_swap_glass_book_for_eyes"] = function(ctx)
    do local g = H.safe_id('item', "glass_book"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
    H.eoc_spawn_item(H.u(ctx), "imperfect_doll_features", 1, false, false, nil)
    do local _p, _g = (H.creature_snap(H.u(ctx)) or {}).position, H.safe_id('terrain_furniture_transform', "glass_book_on_shelf"); if _p and _g then services.world.transform_radius(_p, math.floor(5), _g, nil) end end
    return true
    end
    EOC["EOC_swap_glass_boat_for_legs"] = function(ctx)
    do local g = H.safe_id('item', "glass_boat"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
    H.eoc_spawn_item(H.u(ctx), "imperfect_doll_legs", 1, false, false, nil)
    return true
    end
    EOC["EOC_swap_glass_apple_for_arms"] = function(ctx)
    do local g = H.safe_id('item', "glass_apple"); if g and H.u(ctx) then services.inventory.remove_type(H.u(ctx), g) end end
    H.eoc_spawn_item(H.u(ctx), "imperfect_doll_arms", 1, false, false, nil)
    return true
    end
    COND["EOC_toolweapon_activate"] = function(ctx)
        return ((not ((H.u(ctx) ~= nil and services.characters.is_underwater(H.u(ctx)).value == true)))) == true
    end
    EOC["EOC_toolweapon_activate"] = function(ctx)
    if ((not ((H.u(ctx) ~= nil and services.characters.is_underwater(H.u(ctx)).value == true)))) then
        if (H.npc(ctx) ~= nil and H.u(ctx) ~= nil and services.items.has_ammo(H.npc(ctx), H.u(ctx)).value == true) then
            local _u9 = H.u(ctx)
            if _u9 then services.characters.adjust(_u9, { moves = -math.floor(((ctx:get_number("turn_cost") or 0)) * 100) }) end
            do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then services.sound.emit(_p, math.floor((ctx:get_number("volume") or 0)), "combat", H.var_str("context", nil, ctx, "success_message", ""), false) end end
            services.messages.add(H.var_str("context", nil, ctx, "success_message", ""), "neutral")
            do local _g = H.safe_id('item', H.var_str("context", nil, ctx, "transform_target", "")); if H.npc(ctx) and _g then services.items.transform(H.npc(ctx), _g, { active = true }) end end
        else
            services.messages.add(H.var_str("context", nil, ctx, "failure_message", ""), "neutral")
        end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("The <npc_name> won't start underwater.")), "neutral")
        return false
    end
    end
    COND["barber_hair"] = function(ctx)
        return (((not ((H.char_has_trait(H.u(ctx), "EXODII_BODY_1") == 1))) and (not ((H.char_has_trait(H.u(ctx), "EXODII_BODY_1b") == 1))) and (not (H.char_has_bionic(H.u(ctx), "bio_robofac_xmlens"))))) == true
    end
    EOC["barber_hair"] = function(ctx)
    if (((not ((H.char_has_trait(H.u(ctx), "EXODII_BODY_1") == 1))) and (not ((H.char_has_trait(H.u(ctx), "EXODII_BODY_1b") == 1))) and (not (H.char_has_bionic(H.u(ctx), "bio_robofac_xmlens"))))) then
        if H.u(ctx) then services.characters.open_topic(H.u(ctx), "TALK_CUT_YOUR_HAIR") end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You don't have any hair to style!")), "neutral")
        return false
    end
    end
    COND["barber_beard"] = function(ctx)
        return (((not ((H.char_has_trait(H.u(ctx), "EXODII_BODY_1") == 1))) and (not ((H.char_has_trait(H.u(ctx), "EXODII_BODY_1b") == 1))) and (not (H.char_has_bionic(H.u(ctx), "bio_robofac_xmlens"))))) == true
    end
    EOC["barber_beard"] = function(ctx)
    if (((not ((H.char_has_trait(H.u(ctx), "EXODII_BODY_1") == 1))) and (not ((H.char_has_trait(H.u(ctx), "EXODII_BODY_1b") == 1))) and (not (H.char_has_bionic(H.u(ctx), "bio_robofac_xmlens"))))) then
        if H.u(ctx) then services.characters.open_topic(H.u(ctx), "TALK_CUT_YOUR_BEARD") end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You don't have any hair to style!")), "neutral")
        return false
    end
    end
    COND["barber_hair_and_beard"] = function(ctx)
        return (((not ((H.char_has_trait(H.u(ctx), "EXODII_BODY_1") == 1))) and (not ((H.char_has_trait(H.u(ctx), "EXODII_BODY_1b") == 1))) and (not (H.char_has_bionic(H.u(ctx), "bio_robofac_xmlens"))))) == true
    end
    EOC["barber_hair_and_beard"] = function(ctx)
    if (((not ((H.char_has_trait(H.u(ctx), "EXODII_BODY_1") == 1))) and (not ((H.char_has_trait(H.u(ctx), "EXODII_BODY_1b") == 1))) and (not (H.char_has_bionic(H.u(ctx), "bio_robofac_xmlens"))))) then
        if H.u(ctx) then services.characters.open_topic(H.u(ctx), "TALK_CUT_HAIR_OR_BEARD") end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You don't have any hair to style!")), "neutral")
        return false
    end
    end
    EOC["reset_all_hair_types"] = function(ctx)
    H.lose_trait(H.u(ctx), "hair_buzzcut")
    H.lose_trait(H.u(ctx), "hair_crewcut")
    H.lose_trait(H.u(ctx), "hair_short")
    H.lose_trait(H.u(ctx), "hair_short_no_fringe")
    H.lose_trait(H.u(ctx), "hair_short_over_eye")
    H.lose_trait(H.u(ctx), "hair_medium")
    H.lose_trait(H.u(ctx), "hair_mohawk")
    H.lose_trait(H.u(ctx), "hair_long")
    H.lose_trait(H.u(ctx), "hair_long_mohawk")
    H.lose_trait(H.u(ctx), "hair_mullet")
    H.lose_trait(H.u(ctx), "hair_long_over_eye")
    H.lose_trait(H.u(ctx), "hair_messy")
    H.lose_trait(H.u(ctx), "hair_very_long")
    H.lose_trait(H.u(ctx), "hair_extremely_long")
    H.lose_trait(H.u(ctx), "hair_body_length")
    H.lose_trait(H.u(ctx), "hair_modern")
    H.lose_trait(H.u(ctx), "hair_puff")
    H.lose_trait(H.u(ctx), "hair_beaded")
    H.lose_trait(H.u(ctx), "hair_curls")
    H.lose_trait(H.u(ctx), "hair_bun")
    H.lose_trait(H.u(ctx), "hair_punk_long")
    H.lose_trait(H.u(ctx), "hair_braid")
    H.lose_trait(H.u(ctx), "hair_detective")
    H.lose_trait(H.u(ctx), "hair_super_princess")
    H.lose_trait(H.u(ctx), "hair_twintails")
    H.lose_trait(H.u(ctx), "hair_bald")
    H.lose_trait(H.u(ctx), "hair_fro")
    H.lose_trait(H.u(ctx), "hair_ponytail")
    return true
    end
    EOC["reset_all_beard_types"] = function(ctx)
    H.lose_trait(H.u(ctx), "FACIAL_HAIR_NECKBEARD")
    H.lose_trait(H.u(ctx), "FACIAL_HAIR_SIDEBURNS")
    H.lose_trait(H.u(ctx), "FACIAL_HAIR_SOUL_PATCH")
    H.lose_trait(H.u(ctx), "FACIAL_HAIR_CHIN_STRIP")
    H.lose_trait(H.u(ctx), "FACIAL_HAIR_3DAYSTUBBLE")
    H.lose_trait(H.u(ctx), "FACIAL_HAIR_TOOTHBRUSH")
    H.lose_trait(H.u(ctx), "FACIAL_HAIR_CHIN_STRAP")
    H.lose_trait(H.u(ctx), "FACIAL_HAIR_MUSTACHE")
    H.lose_trait(H.u(ctx), "FACIAL_HAIR_NECKBEARD")
    H.lose_trait(H.u(ctx), "FACIAL_HAIR_WALRUS")
    H.lose_trait(H.u(ctx), "FACIAL_HAIR_ZAPPA")
    H.lose_trait(H.u(ctx), "FACIAL_HAIR_GOATEE")
    H.lose_trait(H.u(ctx), "FACIAL_HAIR_CIRCLE")
    H.lose_trait(H.u(ctx), "FACIAL_HAIR_SHORTBOXED")
    H.lose_trait(H.u(ctx), "FACIAL_HAIR_HORSESHOE")
    H.lose_trait(H.u(ctx), "FACIAL_HAIR_MUTTONCHOPS")
    H.lose_trait(H.u(ctx), "FACIAL_HAIR_GUNSLINGER")
    H.lose_trait(H.u(ctx), "FACIAL_HAIR_CHIN_CURTAIN")
    H.lose_trait(H.u(ctx), "FACIAL_HAIR_HANDLEBAR")
    H.lose_trait(H.u(ctx), "FACIAL_HAIR_VANDYKE")
    H.lose_trait(H.u(ctx), "FACIAL_HAIR_BEARD")
    H.lose_trait(H.u(ctx), "FACIAL_HAIR_ANCHOR")
    H.lose_trait(H.u(ctx), "FACIAL_HAIR_ROYALE")
    H.lose_trait(H.u(ctx), "FACIAL_HAIR_SHENANDOAH")
    H.lose_trait(H.u(ctx), "FACIAL_HAIR_BEARD_LONG")
    H.lose_trait(H.u(ctx), "FACIAL_HAIR_BEARD_VERY_LONG")
    return true
    end
    COND["EOC_pat_advanced_AR_activate"] = function(ctx)
        return (((H.u(ctx) ~= nil) and ((H.char_snap(H.u(ctx)) or {}).avatar == true))) == true
    end
    EOC["EOC_pat_advanced_AR_activate"] = function(ctx)
    if (((H.u(ctx) ~= nil) and ((H.char_snap(H.u(ctx)) or {}).avatar == true))) then
        if (H.char_has_item(H.u(ctx), "military_vis_aug_system_on") or H.char_has_item(H.u(ctx), "robofac_head_rig_ar_on") or (H.char_has_item(H.u(ctx), "integrated_ar") and (H.char_has_trait(H.u(ctx), "Hub01_CBM_Interface") == 1))) then
            H.run_eoc("EOC_pat_AR_activate", ctx, nil, nil, nil)
        end
        return true
    end
    return false
    end
    COND["EOC_pat_AR_activate"] = function(ctx)
        return ((H.global_var_num("robofac_pat_is_dead") == 1)) == true
    end
    EOC["EOC_pat_AR_activate"] = function(ctx)
    if ((H.global_var_num("robofac_pat_is_dead") == 1)) then
        if services.random.native_probability(1, (1000)) then
            services.messages.add(ctx:expand_text(services.translate("Your comm is eerily silent.")), "neutral")
        end
        return true
    else
        H.run_eoc("EOC_pat_AR_scan", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_pat_AR_scan"] = function(ctx)
        return (((H.u(ctx) ~= nil) and ((H.char_snap(H.u(ctx)) or {}).avatar == true) and (((function() local s = H.char_snap(H.npc(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "unvitrified_orchard", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.npc(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "LIXA_surface_1a", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.npc(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "temple_stairs", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.npc(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "mine_amigara_finale_central", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.npc(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "highlands", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.npc(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "exodii_base_x0y0z0", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.npc(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "microlab_portal_security1", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.npc(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "labyrinth_entrance", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.npc(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "corpse_surface", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.npc(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "xedra_rural_church", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.npc(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "morgantown_2b", math.floor(10)) end)()) or ((function() local s = H.char_snap(H.npc(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cabin_3_reverberation", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.npc(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cabin_3_reverberation_hint", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.npc(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "radiosphere_radio_tower_top", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.npc(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "radio_tower_reverberation_mp3", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.npc(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "string_dimension_crossroads", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.npc(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "mine_spiral_finale_s", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.npc(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "void_spider_lair", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.npc(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "default_portal_storm_dungeon_overmap", math.floor(3)) end)()) or ((services.weather.current().weather and services.weather.current().weather.value) == "scarlet_storm_1") or ((services.weather.current().weather and services.weather.current().weather.value) == "scarlet_storm_2") or ((services.weather.current().weather and services.weather.current().weather.value) == "scarlet_storm_3") or ((services.weather.current().weather and services.weather.current().weather.value) == "scarlet_storm_4") or ((services.weather.current().weather and services.weather.current().weather.value) == "scarlet_storm_5")))) == true
    end
    EOC["EOC_pat_AR_scan"] = function(ctx)
    if (((H.u(ctx) ~= nil) and ((H.char_snap(H.u(ctx)) or {}).avatar == true) and (((function() local s = H.char_snap(H.npc(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "unvitrified_orchard", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.npc(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "LIXA_surface_1a", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.npc(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "temple_stairs", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.npc(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "mine_amigara_finale_central", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.npc(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "highlands", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.npc(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "exodii_base_x0y0z0", math.floor(5)) end)()) or ((function() local s = H.char_snap(H.npc(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "microlab_portal_security1", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.npc(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "labyrinth_entrance", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.npc(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "corpse_surface", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.npc(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "xedra_rural_church", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.npc(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "morgantown_2b", math.floor(10)) end)()) or ((function() local s = H.char_snap(H.npc(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cabin_3_reverberation", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.npc(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cabin_3_reverberation_hint", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.npc(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "radiosphere_radio_tower_top", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.npc(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "radio_tower_reverberation_mp3", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.npc(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "string_dimension_crossroads", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.npc(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "mine_spiral_finale_s", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.npc(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "void_spider_lair", math.floor(3)) end)()) or ((function() local s = H.char_snap(H.npc(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "default_portal_storm_dungeon_overmap", math.floor(3)) end)()) or ((services.weather.current().weather and services.weather.current().weather.value) == "scarlet_storm_1") or ((services.weather.current().weather and services.weather.current().weather.value) == "scarlet_storm_2") or ((services.weather.current().weather and services.weather.current().weather.value) == "scarlet_storm_3") or ((services.weather.current().weather and services.weather.current().weather.value) == "scarlet_storm_4") or ((services.weather.current().weather and services.weather.current().weather.value) == "scarlet_storm_5")))) then
        if (((function() local s = H.char_snap(H.npc(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "unvitrified_orchard", math.floor(3)) end)()) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_saw_vitrified", ""))))))) then
            if H.u(ctx) then services.characters.open_topic(H.u(ctx), "TALK_ROBOFAC_MERC_PAT_POI_unvitrified_orchard") end
            H.set_var("actor", H.u(ctx), ctx, "robofac_pat_saw_vitrified", "yes")
        end
        if (((function() local s = H.char_snap(H.npc(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "LIXA_surface_1a", math.floor(3)) end)()) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_saw_lixa", ""))))))) then
            if H.u(ctx) then services.characters.open_topic(H.u(ctx), "TALK_ROBOFAC_MERC_PAT_POI_LIXA_surface_1a") end
            H.set_var("actor", H.u(ctx), ctx, "robofac_pat_saw_lixa", "yes")
        end
        if (((function() local s = H.char_snap(H.npc(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "temple_stairs", math.floor(3)) end)()) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_saw_strange_temple", ""))))))) then
            if H.u(ctx) then services.characters.open_topic(H.u(ctx), "TALK_ROBOFAC_MERC_PAT_POI_temple_stairs") end
            H.set_var("actor", H.u(ctx), ctx, "robofac_pat_saw_strange_temple", "yes")
        end
        if (((function() local s = H.char_snap(H.npc(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "mine_amigara_finale_central", math.floor(3)) end)()) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_saw_amigara", ""))))))) then
            if H.u(ctx) then services.characters.open_topic(H.u(ctx), "TALK_ROBOFAC_MERC_PAT_POI_mine_amigara_finale_central") end
            H.set_var("actor", H.u(ctx), ctx, "robofac_pat_saw_amigara", "yes")
        end
        if (((function() local s = H.char_snap(H.npc(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "highlands", math.floor(3)) end)()) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_saw_highlands", ""))))))) then
            ccb.presentation.notice(ctx:expand_text(services.translate("Your comm is filled with static and your HUD glitches.")))
            H.set_var("actor", H.u(ctx), ctx, "robofac_pat_saw_highlands", "yes")
            H.set_var("global", nil, ctx, "robofac_pat_lost_signal_highlands", 1)
        end
        if (((function() local s = H.char_snap(H.npc(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "exodii_base_x0y0z0", math.floor(5)) end)()) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_saw_exodii", ""))))))) then
            if H.u(ctx) then services.characters.open_topic(H.u(ctx), "TALK_ROBOFAC_MERC_PAT_POI_exodii_base_x0y0z0") end
            H.set_var("actor", H.u(ctx), ctx, "robofac_pat_saw_exodii", "yes")
        end
        if (((function() local s = H.char_snap(H.npc(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "microlab_portal_security1", math.floor(3)) end)()) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_saw_physics_lab", ""))))))) then
            if H.u(ctx) then services.characters.open_topic(H.u(ctx), "TALK_ROBOFAC_MERC_PAT_POI_microlab_portal_security1") end
            H.set_var("actor", H.u(ctx), ctx, "robofac_pat_saw_physics_lab", "yes")
        end
        if (((function() local s = H.char_snap(H.npc(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "labyrinth_entrance", math.floor(3)) end)()) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_saw_labyrinth", ""))))))) then
            ccb.presentation.notice(ctx:expand_text(services.translate("Your comm is filled with static and your HUD glitches.")))
            H.set_var("actor", H.u(ctx), ctx, "robofac_pat_saw_labyrinth", "yes")
            H.set_var("global", nil, ctx, "robofac_pat_lost_signal_labyrinth", 1)
        end
        if (((function() local s = H.char_snap(H.npc(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "corpse_surface", math.floor(3)) end)()) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_saw_monster_corpse", ""))))))) then
            if H.u(ctx) then services.characters.open_topic(H.u(ctx), "TALK_ROBOFAC_MERC_PAT_POI_corpse_surface") end
            H.set_var("actor", H.u(ctx), ctx, "robofac_pat_saw_monster_corpse", "yes")
        end
        if (((function() local s = H.char_snap(H.npc(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "xedra_rural_church", math.floor(3)) end)()) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_saw_rural_church", ""))))))) then
            if H.u(ctx) then services.characters.open_topic(H.u(ctx), "TALK_ROBOFAC_MERC_PAT_POI_xedra_rural_church") end
            H.set_var("actor", H.u(ctx), ctx, "robofac_pat_saw_rural_church", "yes")
        end
        if (((function() local s = H.char_snap(H.npc(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "morgantown_2b", math.floor(10)) end)()) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_saw_morgantown", ""))))))) then
            if H.u(ctx) then services.characters.open_topic(H.u(ctx), "TALK_ROBOFAC_MERC_PAT_POI_morgantown_2b_far") end
            H.set_var("actor", H.u(ctx), ctx, "robofac_pat_saw_morgantown", "yes")
        end
        if (((function() local s = H.char_snap(H.npc(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "morgantown_2b", math.floor(2)) end)()) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_saw_morgantown_2", ""))))))) then
            if H.u(ctx) then services.characters.open_topic(H.u(ctx), "TALK_ROBOFAC_MERC_PAT_POI_morgantown_2b_close") end
            H.set_var("actor", H.u(ctx), ctx, "robofac_pat_saw_morgantown_2", "yes")
        end
        if (((function() local s = H.char_snap(H.npc(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cabin_3_reverberation", math.floor(3)) end)()) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_saw_cabin_reverb", ""))))))) then
            ccb.presentation.notice(ctx:expand_text(services.translate("Your comm is filled with static and your HUD glitches.")))
            H.set_var("actor", H.u(ctx), ctx, "robofac_pat_saw_cabin_reverb", "yes")
            H.set_var("global", nil, ctx, "robofac_pat_lost_signal_cabin_reverb", 1)
        end
        if (((function() local s = H.char_snap(H.npc(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "radio_tower_reverberation_mp3", math.floor(10)) end)()) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_saw_radio_tower_reverberation_mp3", ""))))))) then
            if H.u(ctx) then services.characters.open_topic(H.u(ctx), "TALK_ROBOFAC_MERC_PAT_POI_radio_tower_reverberation_mp3") end
            H.set_var("actor", H.u(ctx), ctx, "robofac_pat_saw_radio_tower_reverberation_mp3", "yes")
        end
        if (((function() local s = H.char_snap(H.npc(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "mine_spiral_finale_s", math.floor(3)) end)()) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_saw_spiral_mine", ""))))))) then
            if H.u(ctx) then services.characters.open_topic(H.u(ctx), "TALK_ROBOFAC_MERC_PAT_POI_mine_spiral_finale_s") end
            H.set_var("actor", H.u(ctx), ctx, "robofac_pat_saw_spiral_mine", "yes")
        end
        if (((function() local s = H.char_snap(H.npc(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "cabin_3_reverberation_hint", math.floor(10)) end)()) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_saw_cabin_reverb_hint", ""))))))) then
            if H.u(ctx) then services.characters.open_topic(H.u(ctx), "TALK_ROBOFAC_MERC_PAT_POI_cabin_3_reverberation_hint") end
            H.set_var("actor", H.u(ctx), ctx, "robofac_pat_saw_cabin_reverb_hint", "yes")
        end
        if (((function() local s = H.char_snap(H.npc(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "radiosphere_radio_tower_top", math.floor(3)) end)()) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_saw_radiosphere", ""))))))) then
            ccb.presentation.notice(ctx:expand_text(services.translate("Your comm is filled with static and your HUD glitches.")))
            H.set_var("actor", H.u(ctx), ctx, "robofac_pat_saw_radiosphere", "yes")
            H.set_var("global", nil, ctx, "robofac_pat_lost_signal_radiosphere", 1)
        end
        if (((function() local s = H.char_snap(H.npc(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "string_dimension_crossroads", math.floor(3)) end)()) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_saw_string_dimension", ""))))))) then
            ccb.presentation.notice(ctx:expand_text(services.translate("Your comm is filled with static and your HUD glitches.")))
            H.set_var("actor", H.u(ctx), ctx, "robofac_pat_saw_string_dimension", "yes")
            H.set_var("global", nil, ctx, "robofac_pat_lost_signal_string_dimension", 1)
        end
        if (((function() local s = H.char_snap(H.npc(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "void_spider_lair", math.floor(3)) end)()) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_saw_spider_dimension", ""))))))) then
            ccb.presentation.notice(ctx:expand_text(services.translate("Your comm is filled with static and your HUD glitches.")))
            H.set_var("actor", H.u(ctx), ctx, "robofac_pat_saw_spider_dimension", "yes")
            H.set_var("global", nil, ctx, "robofac_pat_lost_signal_spider_dimension", 1)
        end
        if (((function() local s = H.char_snap(H.npc(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "default_portal_storm_dungeon_overmap", math.floor(3)) end)()) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_saw_portal_storm_dungeon", ""))))))) then
            ccb.presentation.notice(ctx:expand_text(services.translate("Your comm is filled with static and your HUD glitches.")))
            H.set_var("actor", H.u(ctx), ctx, "robofac_pat_saw_portal_storm_dungeon", "yes")
            H.set_var("global", nil, ctx, "robofac_pat_lost_signal_portal_storm_dungeon", 1)
        end
        if ((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and (((services.weather.current().weather and services.weather.current().weather.value) == "scarlet_storm_1") or ((services.weather.current().weather and services.weather.current().weather.value) == "scarlet_storm_2") or ((services.weather.current().weather and services.weather.current().weather.value) == "scarlet_storm_3") or ((services.weather.current().weather and services.weather.current().weather.value) == "scarlet_storm_4") or ((services.weather.current().weather and services.weather.current().weather.value) == "scarlet_storm_5")) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "robofac_pat_saw_scarlet_storm", ""))))))) then
            if H.u(ctx) then services.characters.open_topic(H.u(ctx), "TALK_ROBOFAC_MERC_PAT_POI_scarlet_storm") end
            H.set_var("actor", H.u(ctx), ctx, "robofac_pat_saw_scarlet_storm", "yes")
        end
        return true
    end
    return false
    end
    COND["lab_security_check"] = function(ctx)
        return ((H.char_at_om_location(H.u(ctx), "lab_1x1x2_RES_8_apartments_lower") and (not (H.char_has_item(H.u(ctx), "id_science_medical_red"))))) == true
    end
    EOC["lab_security_check"] = function(ctx)
    if ((H.char_at_om_location(H.u(ctx), "lab_1x1x2_RES_8_apartments_lower") and (not (H.char_has_item(H.u(ctx), "id_science_medical_red"))))) then
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "lab_health_z-3_A"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "release_the_bots" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        return true
    end
    return false
    end
    COND["lab_security_check_surface_3"] = function(ctx)
        return ((H.char_at_om_location(H.u(ctx), "lab_res_8_SWU_ground") and (not (H.char_has_item(H.u(ctx), "id_science_maintenance_green"))))) == true
    end
    EOC["lab_security_check_surface_3"] = function(ctx)
    if ((H.char_at_om_location(H.u(ctx), "lab_res_8_SWU_ground") and (not (H.char_has_item(H.u(ctx), "id_science_maintenance_green"))))) then
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "lab_res_8_SEU_ground"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "release_the_bots_2" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        return true
    end
    return false
    end
    COND["lab_security_check_surface_2"] = function(ctx)
        return ((H.char_at_om_location(H.u(ctx), "lab_res_8_SWD_ground") and (not (H.char_has_item(H.u(ctx), "id_science_maintenance_green"))))) == true
    end
    EOC["lab_security_check_surface_2"] = function(ctx)
    if ((H.char_at_om_location(H.u(ctx), "lab_res_8_SWD_ground") and (not (H.char_has_item(H.u(ctx), "id_science_maintenance_green"))))) then
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "lab_res_8_SED_ground"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "release_the_bots_2" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        return true
    end
    return false
    end
    COND["lab_security_check_surface_1"] = function(ctx)
        return ((H.char_at_om_location(H.u(ctx), "lab_CORE_2x1_WC_ground") and (not (H.char_has_item(H.u(ctx), "id_science_maintenance_green"))))) == true
    end
    EOC["lab_security_check_surface_1"] = function(ctx)
    if ((H.char_at_om_location(H.u(ctx), "lab_CORE_2x1_WC_ground") and (not (H.char_has_item(H.u(ctx), "id_science_maintenance_green"))))) then
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "lab_security_z0"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "release_bots_garage" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "lab_CORE_2x1_WC_ground"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "open_walls_garage" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        return true
    end
    return false
    end
    COND["lab_check_magenta_security_drop"] = function(ctx)
        return ((H.char_at_om_location(H.u(ctx), "lab_security_z-1") and H.char_has_item(H.u(ctx), "id_science_security_yellow") and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "check_trap_trigger_valid_security_employee", "")))))))) == true
    end
    EOC["lab_check_magenta_security_drop"] = function(ctx)
    if ((H.char_at_om_location(H.u(ctx), "lab_security_z-1") and H.char_has_item(H.u(ctx), "id_science_security_yellow") and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "check_trap_trigger_valid_security_employee", "")))))))) then
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "lab_security_z-1"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "magenta_security_card_spawn" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        H.set_var("actor", H.u(ctx), ctx, "check_trap_trigger_valid_security_employee", "yes")
        return true
    end
    return false
    end
    COND["lab_1x1x2_RES_8_check_SEC"] = function(ctx)
        return ((H.char_at_om_location(H.u(ctx), "lab_1x1_RES_8_commons_SEC") and (not (H.char_has_item(H.u(ctx), "id_science_security_yellow"))))) == true
    end
    EOC["lab_1x1x2_RES_8_check_SEC"] = function(ctx)
    if ((H.char_at_om_location(H.u(ctx), "lab_1x1_RES_8_commons_SEC") and (not (H.char_has_item(H.u(ctx), "id_science_security_yellow"))))) then
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "lab_1x1_RES_8_commons_SEC"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "release_bots_3" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        return true
    end
    return false
    end
    COND["lab_1x1x2_RES_8_check_MAINT"] = function(ctx)
        return ((H.char_at_om_location(H.u(ctx), "lab_1x1_RES_8_commons_MAINT") and (not (H.char_has_item(H.u(ctx), "id_science_maintenance_yellow"))))) == true
    end
    EOC["lab_1x1x2_RES_8_check_MAINT"] = function(ctx)
    if ((H.char_at_om_location(H.u(ctx), "lab_1x1_RES_8_commons_MAINT") and (not (H.char_has_item(H.u(ctx), "id_science_maintenance_yellow"))))) then
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "lab_1x1_RES_8_commons_MAINT"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "release_bots_3" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        return true
    end
    return false
    end
    COND["lab_concourse_bot_release"] = function(ctx)
        return ((H.char_at_om_location(H.u(ctx), "lab_CORE_2x1_1DN") and (not ((H.char_has_item(H.u(ctx), "id_science_maintenance_yellow") or H.char_has_item(H.u(ctx), "id_science_transport_1") or H.char_has_item(H.u(ctx), "id_science_visitor_1") or H.char_has_item(H.u(ctx), "id_science_maintenance_green") or H.char_has_item(H.u(ctx), "id_science_maintenance_blue") or H.char_has_item(H.u(ctx), "id_science_security_yellow") or H.char_has_item(H.u(ctx), "id_science_security_magenta") or H.char_has_item(H.u(ctx), "id_science_security_black") or H.char_has_item(H.u(ctx), "id_science_mutagen_green") or H.char_has_item(H.u(ctx), "id_science_mutagen_pink") or H.char_has_item(H.u(ctx), "id_science_mutagen_cyan") or H.char_has_item(H.u(ctx), "id_science_medical_red")))))) == true
    end
    EOC["lab_concourse_bot_release"] = function(ctx)
    if ((H.char_at_om_location(H.u(ctx), "lab_CORE_2x1_1DN") and (not ((H.char_has_item(H.u(ctx), "id_science_maintenance_yellow") or H.char_has_item(H.u(ctx), "id_science_transport_1") or H.char_has_item(H.u(ctx), "id_science_visitor_1") or H.char_has_item(H.u(ctx), "id_science_maintenance_green") or H.char_has_item(H.u(ctx), "id_science_maintenance_blue") or H.char_has_item(H.u(ctx), "id_science_security_yellow") or H.char_has_item(H.u(ctx), "id_science_security_magenta") or H.char_has_item(H.u(ctx), "id_science_security_black") or H.char_has_item(H.u(ctx), "id_science_mutagen_green") or H.char_has_item(H.u(ctx), "id_science_mutagen_pink") or H.char_has_item(H.u(ctx), "id_science_mutagen_cyan") or H.char_has_item(H.u(ctx), "id_science_medical_red")))))) then
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "lab_CORE_2x1_1DN"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "release_bots_concourse" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        return true
    end
    return false
    end
    COND["lab_concourse_bot_release_2"] = function(ctx)
        return ((H.char_at_om_location(H.u(ctx), "lab_CORE_2x1_2DN") and (not ((H.char_has_item(H.u(ctx), "id_science_transport_1") or H.char_has_item(H.u(ctx), "id_science_visitor_1") or H.char_has_item(H.u(ctx), "id_science_maintenance_yellow") or H.char_has_item(H.u(ctx), "id_science_maintenance_green") or H.char_has_item(H.u(ctx), "id_science_maintenance_blue") or H.char_has_item(H.u(ctx), "id_science_security_yellow") or H.char_has_item(H.u(ctx), "id_science_security_magenta") or H.char_has_item(H.u(ctx), "id_science_security_black") or H.char_has_item(H.u(ctx), "id_science_mutagen_green") or H.char_has_item(H.u(ctx), "id_science_mutagen_pink") or H.char_has_item(H.u(ctx), "id_science_mutagen_cyan") or H.char_has_item(H.u(ctx), "id_science_medical_red")))))) == true
    end
    EOC["lab_concourse_bot_release_2"] = function(ctx)
    if ((H.char_at_om_location(H.u(ctx), "lab_CORE_2x1_2DN") and (not ((H.char_has_item(H.u(ctx), "id_science_transport_1") or H.char_has_item(H.u(ctx), "id_science_visitor_1") or H.char_has_item(H.u(ctx), "id_science_maintenance_yellow") or H.char_has_item(H.u(ctx), "id_science_maintenance_green") or H.char_has_item(H.u(ctx), "id_science_maintenance_blue") or H.char_has_item(H.u(ctx), "id_science_security_yellow") or H.char_has_item(H.u(ctx), "id_science_security_magenta") or H.char_has_item(H.u(ctx), "id_science_security_black") or H.char_has_item(H.u(ctx), "id_science_mutagen_green") or H.char_has_item(H.u(ctx), "id_science_mutagen_pink") or H.char_has_item(H.u(ctx), "id_science_mutagen_cyan") or H.char_has_item(H.u(ctx), "id_science_medical_red")))))) then
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "lab_CORE_2x1_2DN"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "release_bots_concourse_2" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        return true
    end
    return false
    end
    COND["lab_magenta_security_check"] = function(ctx)
        return ((H.char_at_om_location(H.u(ctx), "lab_security_z-5") and (not (H.char_has_item(H.u(ctx), "id_science_security_magenta"))))) == true
    end
    EOC["lab_magenta_security_check"] = function(ctx)
    if ((H.char_at_om_location(H.u(ctx), "lab_security_z-5") and (not (H.char_has_item(H.u(ctx), "id_science_security_magenta"))))) then
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "lab_security_z-5"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "release_bots_4" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        return true
    end
    return false
    end
    COND["lab_cyan_mutagen_check"] = function(ctx)
        return ((H.char_at_om_location(H.u(ctx), "lab_2x2_MUT_tier_2_NE") and (not (H.char_has_item(H.u(ctx), "id_science_mutagen_cyan"))))) == true
    end
    EOC["lab_cyan_mutagen_check"] = function(ctx)
    if ((H.char_at_om_location(H.u(ctx), "lab_2x2_MUT_tier_2_NE") and (not (H.char_has_item(H.u(ctx), "id_science_mutagen_cyan"))))) then
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "lab_2x2_MUT_tier_2_NE"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "release_bots_5" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        return true
    end
    return false
    end
    COND["lab_cyan_mutagen_check_2"] = function(ctx)
        return ((H.char_at_om_location(H.u(ctx), "lab_2x2_MUT_tier_2_NW_final_flr") and (not (H.char_has_item(H.u(ctx), "id_science_mutagen_cyan"))))) == true
    end
    EOC["lab_cyan_mutagen_check_2"] = function(ctx)
    if ((H.char_at_om_location(H.u(ctx), "lab_2x2_MUT_tier_2_NW_final_flr") and (not (H.char_has_item(H.u(ctx), "id_science_mutagen_cyan"))))) then
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "lab_2x2_MUT_tier_2_NW_final_flr"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "release_bots_6" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        return true
    end
    return false
    end
    COND["lab_cyan_mutagen_check_3"] = function(ctx)
        return ((H.char_at_om_location(H.u(ctx), "lab_2x2_MUT_tier_2_SW") and (not (H.char_has_item(H.u(ctx), "id_science_mutagen_cyan"))))) == true
    end
    EOC["lab_cyan_mutagen_check_3"] = function(ctx)
    if ((H.char_at_om_location(H.u(ctx), "lab_2x2_MUT_tier_2_SW") and (not (H.char_has_item(H.u(ctx), "id_science_mutagen_cyan"))))) then
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "lab_2x2_MUT_tier_2_SW"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "release_bots_7" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        return true
    end
    return false
    end
    COND["lab_cyan_mutagen_check_4"] = function(ctx)
        return ((H.char_at_om_location(H.u(ctx), "lab_2x2_MUT_tier_2_SE") and (not (H.char_has_item(H.u(ctx), "id_science_mutagen_cyan"))))) == true
    end
    EOC["lab_cyan_mutagen_check_4"] = function(ctx)
    if ((H.char_at_om_location(H.u(ctx), "lab_2x2_MUT_tier_2_SE") and (not (H.char_has_item(H.u(ctx), "id_science_mutagen_cyan"))))) then
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "lab_2x2_MUT_tier_2_SE"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "release_bots_8" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        return true
    end
    return false
    end
    COND["lab_pink_mutagen_check"] = function(ctx)
        return ((H.char_at_om_location(H.u(ctx), "lab_2x2_MUT_tier_1_NE") and (not (H.char_has_item(H.u(ctx), "id_science_mutagen_pink"))))) == true
    end
    EOC["lab_pink_mutagen_check"] = function(ctx)
    if ((H.char_at_om_location(H.u(ctx), "lab_2x2_MUT_tier_1_NE") and (not (H.char_has_item(H.u(ctx), "id_science_mutagen_pink"))))) then
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "lab_2x2_MUT_tier_1_NE"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "release_bots_5" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        return true
    end
    return false
    end
    COND["lab_pink_mutagen_check_2"] = function(ctx)
        return ((H.char_at_om_location(H.u(ctx), "lab_2x2_MUT_tier_1_NW") and (not (H.char_has_item(H.u(ctx), "id_science_mutagen_pink"))))) == true
    end
    EOC["lab_pink_mutagen_check_2"] = function(ctx)
    if ((H.char_at_om_location(H.u(ctx), "lab_2x2_MUT_tier_1_NW") and (not (H.char_has_item(H.u(ctx), "id_science_mutagen_pink"))))) then
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "lab_2x2_MUT_tier_1_NW"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "release_bots_6" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        return true
    end
    return false
    end
    COND["lab_pink_mutagen_check_3"] = function(ctx)
        return ((H.char_at_om_location(H.u(ctx), "lab_2x2_MUT_tier_1_SW") and (not (H.char_has_item(H.u(ctx), "id_science_mutagen_pink"))))) == true
    end
    EOC["lab_pink_mutagen_check_3"] = function(ctx)
    if ((H.char_at_om_location(H.u(ctx), "lab_2x2_MUT_tier_1_SW") and (not (H.char_has_item(H.u(ctx), "id_science_mutagen_pink"))))) then
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "lab_2x2_MUT_tier_1_SW"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "release_bots_7" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        return true
    end
    return false
    end
    COND["lab_pink_mutagen_check_4"] = function(ctx)
        return ((H.char_at_om_location(H.u(ctx), "lab_2x2_MUT_tier_1_SE") and (not (H.char_has_item(H.u(ctx), "id_science_mutagen_pink"))))) == true
    end
    EOC["lab_pink_mutagen_check_4"] = function(ctx)
    if ((H.char_at_om_location(H.u(ctx), "lab_2x2_MUT_tier_1_SE") and (not (H.char_has_item(H.u(ctx), "id_science_mutagen_pink"))))) then
        do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "lab_2x2_MUT_tier_1_SE"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "release_bots_8" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        return true
    end
    return false
    end
    EOC["EOC_SLEEP"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("You feel very sleepy…")), "neutral")
    H.set_char_val_extra(H.u(ctx), "sleepiness", 40, "+=")
    return true
    end
    EOC["EOC_MINOR_SLEEP"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("You feel sleepy…")), "neutral")
    H.set_char_val_extra(H.u(ctx), "sleepiness", 20, "+=")
    return true
    end
    COND["ambient_subway"] = function(ctx)
        return (H.char_at_om_location(H.u(ctx), "subway")) == true
    end
    EOC["ambient_subway"] = function(ctx)
    if (H.char_at_om_location(H.u(ctx), "subway")) then
        services.messages.add((services.snippets.native_random("<AMBIENT_SUBWAY>") or ''), "neutral")
        return true
    end
    return false
    end
    COND["ambient_lab_subway"] = function(ctx)
        return (H.char_at_om_location(H.u(ctx), "lab_subway")) == true
    end
    EOC["ambient_lab_subway"] = function(ctx)
    if (H.char_at_om_location(H.u(ctx), "lab_subway")) then
        services.messages.add((services.snippets.native_random("<AMBIENT_LAB_SUBWAY>") or ''), "neutral")
        return true
    end
    return false
    end
    COND["ambient_sewer"] = function(ctx)
        return (H.char_at_om_location(H.u(ctx), "sewer")) == true
    end
    EOC["ambient_sewer"] = function(ctx)
    if (H.char_at_om_location(H.u(ctx), "sewer")) then
        services.messages.add((services.snippets.native_random("<AMBIENT_SEWER>") or ''), "neutral")
        return true
    end
    return false
    end
    COND["robofac_surveillance"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "PROF_HUB01_ANCILLIARY") == 1) or ((function() local eg = H.safe_id('effect', "robofac_surveillance"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) == true
    end
    EOC["robofac_surveillance"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "PROF_HUB01_ANCILLIARY") == 1) or ((function() local eg = H.safe_id('effect', "robofac_surveillance"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) then
        do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster', "mon_robofac_camspy") or H.safe_id('monster_group', "mon_robofac_camspy"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor(1), min_radius = math.floor(15), max_radius = math.floor(40), outdoor_only = true }); 
        end end
        return true
    end
    return false
    end
    EOC["EOC_mininuke_record"] = function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "mininuke_activated", (H.var_num(H.u(ctx), "mininuke_activated")) + (1))
    return true
    end
    COND["EOC_DEATH_SWITCH"] = function(ctx)
        return ((H.npc_allies_global(1) and (services.interaction.confirm(ctx:expand_text(services.translate("You have died.  Continue as one of your followers?"))) == true))) == true
    end
    EOC["EOC_DEATH_SWITCH"] = function(ctx)
    if ((H.npc_allies_global(1) and (services.interaction.confirm(ctx:expand_text(services.translate("You have died.  Continue as one of your followers?"))) == true))) then
        services.npcs.open_control_menu()
        return true
    end
    return false
    end
    COND["EOC_last_amigara_death"] = function(ctx)
        return ((H.mons_nearby(H.npc(ctx), { "mon_amigara_horror" }, 1000, nil) < 1)) == true
    end
    EOC["EOC_last_amigara_death"] = function(ctx)
    if ((H.mons_nearby(H.npc(ctx), { "mon_amigara_horror" }, 1000, nil) < 1)) then
        H.eoc_loc_var(H.npc(ctx), ctx, "context", "loc", nil, nil, nil, { max_radius = math.floor(2), passable_only = true }, nil, false, true, {  }, {  })
        do local _p = H.get_tripoint_var("context", nil, ctx, "loc"); local _g = H.safe_id('item_group', "amigara_drops"); if _p and _g then local _its = services.items.possible_from_group(_g); services.world.spawn_item(_p, _g, math.floor(1)) end end
        H.run_eoc("EOC_remove_amigara_effect", ctx, nil, nil, nil)
        if ctx:has_speaker() then
            do local _eg = H.safe_id('effect', "effect_amigara"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
            H.set_var("actor", H.u(ctx), ctx, "general_talk_clearead_amigara_mine", "yes")
            services.messages.add(ctx:expand_text(services.translate("As the last of the horrors fell dead, you notice a strange thing popped up from nowhere and dropped on the ground.")), "info")
        end
        return true
    end
    return false
    end
    EOC["EOC_remove_amigara_effect"] = function(ctx)
    do local _eg = H.safe_id('effect', "effect_amigara"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    return true
    end
    COND["EOC_RANDOM_HALLUCINATIONS"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "hallucination_attacks"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and services.random.native_probability((1), (6)))) == true
    end
    EOC["EOC_RANDOM_HALLUCINATIONS"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "hallucination_attacks"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and services.random.native_probability((1), (6)))) then
        if (H.mons_nearby(H.u(ctx), {  }, 1000, nil) > 1) then
            do local _cs = H.creature_snap(H.u(ctx)); local _mg = H.safe_id('monster_group', "GROUP_YOUR_FEARS"); if _cs and _mg then local _sr = services.spawns.population(_mg, _cs.position, { count = math.floor(0), hallucinations = math.floor((services.random.native_int(0, H.round_half_away(2)) + 1)), min_radius = math.floor(10), max_radius = math.floor(40), outdoor_only = false, lifespan = { minimum = services.time.duration_from_turns(math.floor(3600)), maximum = services.time.duration_from_turns(math.floor(14400)) } }); 
            end end
        end
        return true
    end
    return false
    end
    COND["EOC_discover_zomborg"] = function(ctx)
        return (((H.mons_nearby(H.u(ctx), { "mon_zomborg" }, 60, nil) >= 1) and (not (H.truthy((H.var_exists("global", nil, ctx, "dialogue_exodii_seen_zomborg") and 1 or 0)))))) == true
    end
    EOC["EOC_discover_zomborg"] = function(ctx)
    if (((H.mons_nearby(H.u(ctx), { "mon_zomborg" }, 60, nil) >= 1) and (not (H.truthy((H.var_exists("global", nil, ctx, "dialogue_exodii_seen_zomborg") and 1 or 0)))))) then
        H.set_var("actor", H.u(ctx), ctx, "dialogue_exodii_seen_zomborg", "yes")
        return true
    end
    return false
    end
    EOC["add_effect"] = function(ctx)
    H.eoc_add_effect(H.u(ctx), H.var_str("context", nil, ctx, "effect", ""), (ctx:get_number("duration") or 0), nil, nil, nil)
    return true
    end
    COND["sewer_morale_debuff"] = function(ctx)
        return ((H.char_at_om_location(H.u(ctx), "sewer") or H.char_at_om_location(H.u(ctx), "pump_station_3") or H.char_at_om_location(H.u(ctx), "pump_station_4") or H.char_at_om_location(H.u(ctx), "pump_station_5"))) == true
    end
    EOC["sewer_morale_debuff"] = function(ctx)
    if ((H.char_at_om_location(H.u(ctx), "sewer") or H.char_at_om_location(H.u(ctx), "pump_station_3") or H.char_at_om_location(H.u(ctx), "pump_station_4") or H.char_at_om_location(H.u(ctx), "pump_station_5"))) then
        services.messages.add((services.snippets.native_random("<SEWER_MORALE_DEBUFF>") or ''), "neutral")
        if (H.char_has_trait(H.u(ctx), "SQUEAMISH") == 1) then
            do local _g = H.safe_id('morale', "morale_hates_sewer"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(-20), math.floor(-40), { duration = services.time.duration_from_turns(math.floor(3600)), decay_start = services.time.duration_from_turns(math.floor(3600)) }) end end
        else
            do local _g = H.safe_id('morale', "morale_dislikes_sewer"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(-10), math.floor(-20), { duration = services.time.duration_from_turns(math.floor(3600)), decay_start = services.time.duration_from_turns(math.floor(3600)) }) end end
        end
        return true
    end
    return false
    end
    EOC["EOC_camp_rumor_spread"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("Rumors of your takeover of <context_val:camp_name> have begun to spread…")), "mixed")
    return true
    end
    COND["EOC_TOOK_OVER_CAMP_NOTICE"] = function(ctx)
        return ((H.var_exists('context', nil, ctx, "old_owner") and H.var_exists('context', nil, ctx, "new_owner") and H.var_exists('context', nil, ctx, "camp_name") and H.var_exists('context', nil, ctx, "was_violent"))) == true
    end
    EOC["EOC_TOOK_OVER_CAMP_NOTICE"] = function(ctx)
    if ((H.var_exists('context', nil, ctx, "old_owner") and H.var_exists('context', nil, ctx, "new_owner") and H.var_exists('context', nil, ctx, "camp_name") and H.var_exists('context', nil, ctx, "was_violent"))) then
        if ((("your_followers") == (H.var_str("context", nil, ctx, "new_owner", "")))) then
            do local _t = math.max(1, math.floor((function() local a, b = math.floor(604800), math.floor(1209600); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_camp_rumor_spread"), nil) end end
        else
            if (services.camps.has_player_owned_camp().value == true) then
                ccb.presentation.notice(ctx:expand_text(services.translate("While you've been out of contact with the powers of <context_val:camp_name> it's been taken over by its enemies.")))
            end
        end
        return true
    end
    return false
    end
    COND["eoc_boomered_apply_conjunctivitis"] = function(ctx)
        return ((((("boomered") == (H.var_str("context", nil, ctx, "effect", "")))) and ((("eyes") == (H.var_str("context", nil, ctx, "bodypart", "")))) and (not ((H.char_has_trait(H.u(ctx), "COMPOUND_EYES") == 1))) and (not ((H.char_has_trait(H.u(ctx), "SEESLEEP") == 1))) and (not (H.char_has_bionic(H.u(ctx), "armor_bio_eyes"))) and (H.char_coverage(H.u(ctx), "eyes") < services.random.native_int(0, H.round_half_away(100))) and services.random.native_probability((2), (3)))) == true
    end
    EOC["eoc_boomered_apply_conjunctivitis"] = function(ctx)
    if ((((("boomered") == (H.var_str("context", nil, ctx, "effect", "")))) and ((("eyes") == (H.var_str("context", nil, ctx, "bodypart", "")))) and (not ((H.char_has_trait(H.u(ctx), "COMPOUND_EYES") == 1))) and (not ((H.char_has_trait(H.u(ctx), "SEESLEEP") == 1))) and (not (H.char_has_bionic(H.u(ctx), "armor_bio_eyes"))) and (H.char_coverage(H.u(ctx), "eyes") < services.random.native_int(0, H.round_half_away(100))) and services.random.native_probability((2), (3)))) then
        if ((function() local eg = H.safe_id('effect', "conjunctivitis"); local bpg = ("eyes" ~= nil) and H.safe_id('body_part', "eyes") or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) then
            do local _eg = H.safe_id('effect', "conjunctivitis"); local _bp = ("eyes" ~= nil) and H.safe_id('body_part', "eyes") or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        end
        H.eoc_add_effect(H.u(ctx), "conjunctivitis", (((1 - (H.char_coverage(H.u(ctx), "eyes") / 100)) * services.random.native_int(0, H.round_half_away(345600))) + 86400), "eyes", nil, nil)
        return true
    end
    return false
    end
end
