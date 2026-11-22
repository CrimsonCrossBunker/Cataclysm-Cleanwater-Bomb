local ccb = require("ccb")
local services = ccb.services
return function(E, H)
    local EOC = E.run
    local COND = E.cond
    COND["EOC_CHECK_GAMEBEGIN_AFS_ELECTROKIN_RECIPE_SEE_ELECTRIC"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "AFS_ELECTROKINETIC") == 1) and (H.char_spell_level(H.u(ctx), "afs_electrokinetic_see_electric") >= 0))) == true
    end
    EOC["EOC_CHECK_GAMEBEGIN_AFS_ELECTROKIN_RECIPE_SEE_ELECTRIC"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "AFS_ELECTROKINETIC") == 1) and (H.char_spell_level(H.u(ctx), "afs_electrokinetic_see_electric") >= 0))) then
        H.learn_recipe(H.u(ctx), "practice_afs_electrokinetic_see_electric")
        return true
    end
    return false
    end
    COND["EOC_CHECK_GAMEBEGIN_AFS_ELECTROKIN_RECIPE_SHOCK_TOUCH"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "AFS_ELECTROKINETIC") == 1) and (H.char_spell_level(H.u(ctx), "afs_electrokinetic_shock_touch") >= 0))) == true
    end
    EOC["EOC_CHECK_GAMEBEGIN_AFS_ELECTROKIN_RECIPE_SHOCK_TOUCH"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "AFS_ELECTROKINETIC") == 1) and (H.char_spell_level(H.u(ctx), "afs_electrokinetic_shock_touch") >= 0))) then
        H.learn_recipe(H.u(ctx), "practice_afs_electrokinetic_shock_touch")
        return true
    end
    return false
    end
    COND["EOC_CHECK_GAMEBEGIN_AFS_ELECTROKIN_RECIPE_ZAP_ENEMIES"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "AFS_ELECTROKINETIC") == 1) and (H.char_spell_level(H.u(ctx), "afs_electrokinetic_zap_enemies") >= 0))) == true
    end
    EOC["EOC_CHECK_GAMEBEGIN_AFS_ELECTROKIN_RECIPE_ZAP_ENEMIES"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "AFS_ELECTROKINETIC") == 1) and (H.char_spell_level(H.u(ctx), "afs_electrokinetic_zap_enemies") >= 0))) then
        H.learn_recipe(H.u(ctx), "practice_afs_electrokinetic_zap_enemies")
        return true
    end
    return false
    end
    COND["EOC_CHECK_GAMEBEGIN_AFS_ELECTROKIN_RECIPE_HACKING_INTERFACE"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "AFS_ELECTROKINETIC") == 1) and (H.char_spell_level(H.u(ctx), "afs_electrokinetic_hacking_interface") >= 0))) == true
    end
    EOC["EOC_CHECK_GAMEBEGIN_AFS_ELECTROKIN_RECIPE_HACKING_INTERFACE"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "AFS_ELECTROKINETIC") == 1) and (H.char_spell_level(H.u(ctx), "afs_electrokinetic_hacking_interface") >= 0))) then
        H.learn_recipe(H.u(ctx), "practice_afs_electrokinetic_hacking_interface")
        return true
    end
    return false
    end
    COND["EOC_CHECK_GAMEBEGIN_AFS_ELECTROKIN_RECIPE_PERSONAL_BATTERY"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "AFS_ELECTROKINETIC") == 1) and (H.char_spell_level(H.u(ctx), "afs_electrokinetic_personal_battery") >= 0))) == true
    end
    EOC["EOC_CHECK_GAMEBEGIN_AFS_ELECTROKIN_RECIPE_PERSONAL_BATTERY"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "AFS_ELECTROKINETIC") == 1) and (H.char_spell_level(H.u(ctx), "afs_electrokinetic_personal_battery") >= 0))) then
        H.learn_recipe(H.u(ctx), "practice_afs_electrokinetic_personal_battery")
        return true
    end
    return false
    end
    COND["EOC_CHECK_GAMEBEGIN_AFS_ELECTROKIN_RECIPE_RECHARGE_VEHICLE"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "AFS_ELECTROKINETIC") == 1) and (H.char_spell_level(H.u(ctx), "afs_electrokinetic_recharge_vehicle") >= 0))) == true
    end
    EOC["EOC_CHECK_GAMEBEGIN_AFS_ELECTROKIN_RECIPE_RECHARGE_VEHICLE"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "AFS_ELECTROKINETIC") == 1) and (H.char_spell_level(H.u(ctx), "afs_electrokinetic_recharge_vehicle") >= 0))) then
        H.learn_recipe(H.u(ctx), "practice_afs_electrokinetic_recharge_vehicle")
        return true
    end
    return false
    end
    COND["EOC_AFS_PRECOG_RECIPE_TEACHER"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "AFS_PRECOG") == 1)) == true
    end
    EOC["EOC_AFS_PRECOG_RECIPE_TEACHER"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "AFS_PRECOG") == 1)) then
        H.run_eoc("EOC_TEACH_AFS_PRECOG_CONTEMPLATE_RECIPES", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    EOC["EOC_TEACH_AFS_PRECOG_CONTEMPLATE_RECIPES"] = function(ctx)
    H.run_eoc("EOC_CHECK_GAMEBEGIN_AFS_PRECOG_RECIPE_DANGER_SENSE", ctx, nil, nil, nil)
    H.run_eoc("EOC_CHECK_GAMEBEGIN_AFS_PRECOG_RECIPE_DAMAGE_FORESEE", ctx, nil, nil, nil)
    H.run_eoc("EOC_CHECK_GAMEBEGIN_AFS_PRECOG_RECIPE_RANGED_ENHANCE", ctx, nil, nil, nil)
    H.run_eoc("EOC_CHECK_GAMEBEGIN_AFS_PRECOG_RECIPE_CRAFT_BONUS", ctx, nil, nil, nil)
    H.run_eoc("EOC_CHECK_GAMEBEGIN_AFS_PRECOG_RECIPE_DODGE_BONUS", ctx, nil, nil, nil)
    H.run_eoc("EOC_CHECK_GAMEBEGIN_AFS_PRECOG_RECIPE_MELEE_ENHANCE", ctx, nil, nil, nil)
    return true
    end
    COND["EOC_CHECK_GAMEBEGIN_AFS_PRECOG_RECIPE_DANGER_SENSE"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "AFS_PRECOG") == 1) and (H.char_spell_level(H.u(ctx), "afs_precog_danger_sense") >= 0))) == true
    end
    EOC["EOC_CHECK_GAMEBEGIN_AFS_PRECOG_RECIPE_DANGER_SENSE"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "AFS_PRECOG") == 1) and (H.char_spell_level(H.u(ctx), "afs_precog_danger_sense") >= 0))) then
        H.learn_recipe(H.u(ctx), "practice_afs_precog_danger_sense")
        return true
    end
    return false
    end
    COND["EOC_CHECK_GAMEBEGIN_AFS_PRECOG_RECIPE_DAMAGE_FORESEE"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "AFS_PRECOG") == 1) and (H.char_spell_level(H.u(ctx), "afs_precog_damage_foresee") >= 0))) == true
    end
    EOC["EOC_CHECK_GAMEBEGIN_AFS_PRECOG_RECIPE_DAMAGE_FORESEE"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "AFS_PRECOG") == 1) and (H.char_spell_level(H.u(ctx), "afs_precog_damage_foresee") >= 0))) then
        H.learn_recipe(H.u(ctx), "practice_afs_precog_damage_foresee")
        return true
    end
    return false
    end
    COND["EOC_CHECK_GAMEBEGIN_AFS_PRECOG_RECIPE_RANGED_ENHANCE"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "AFS_PRECOG") == 1) and (H.char_spell_level(H.u(ctx), "afs_precog_ranged_enhance") >= 0))) == true
    end
    EOC["EOC_CHECK_GAMEBEGIN_AFS_PRECOG_RECIPE_RANGED_ENHANCE"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "AFS_PRECOG") == 1) and (H.char_spell_level(H.u(ctx), "afs_precog_ranged_enhance") >= 0))) then
        H.learn_recipe(H.u(ctx), "practice_afs_precog_ranged_enhance")
        return true
    end
    return false
    end
    COND["EOC_CHECK_GAMEBEGIN_AFS_PRECOG_RECIPE_CRAFT_BONUS"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "AFS_PRECOG") == 1) and (H.char_spell_level(H.u(ctx), "afs_precog_craft_bonus") >= 0))) == true
    end
    EOC["EOC_CHECK_GAMEBEGIN_AFS_PRECOG_RECIPE_CRAFT_BONUS"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "AFS_PRECOG") == 1) and (H.char_spell_level(H.u(ctx), "afs_precog_craft_bonus") >= 0))) then
        H.learn_recipe(H.u(ctx), "practice_afs_precog_craft_bonus")
        return true
    end
    return false
    end
    COND["EOC_CHECK_GAMEBEGIN_AFS_PRECOG_RECIPE_DODGE_BONUS"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "AFS_PRECOG") == 1) and (H.char_spell_level(H.u(ctx), "afs_precog_dodge_bonus") >= 0))) == true
    end
    EOC["EOC_CHECK_GAMEBEGIN_AFS_PRECOG_RECIPE_DODGE_BONUS"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "AFS_PRECOG") == 1) and (H.char_spell_level(H.u(ctx), "afs_precog_dodge_bonus") >= 0))) then
        H.learn_recipe(H.u(ctx), "practice_afs_precog_dodge_bonus")
        return true
    end
    return false
    end
    COND["EOC_CHECK_GAMEBEGIN_AFS_PRECOG_RECIPE_MELEE_ENHANCE"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "AFS_PRECOG") == 1) and (H.char_spell_level(H.u(ctx), "afs_precog_melee_enhance") >= 0))) == true
    end
    EOC["EOC_CHECK_GAMEBEGIN_AFS_PRECOG_RECIPE_MELEE_ENHANCE"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "AFS_PRECOG") == 1) and (H.char_spell_level(H.u(ctx), "afs_precog_melee_enhance") >= 0))) then
        H.learn_recipe(H.u(ctx), "practice_afs_precog_melee_enhance")
        return true
    end
    return false
    end
    COND["EOC_AFS_TELEKINETIC_RECIPE_TEACHER"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "AFS_TELEKINETIC") == 1)) == true
    end
    EOC["EOC_AFS_TELEKINETIC_RECIPE_TEACHER"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "AFS_TELEKINETIC") == 1)) then
        H.run_eoc("EOC_TEACH_AFS_TELEKINETIC_CONTEMPLATE_RECIPES", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    EOC["EOC_TEACH_AFS_TELEKINETIC_CONTEMPLATE_RECIPES"] = function(ctx)
    H.run_eoc("EOC_CHECK_GAMEBEGIN_AFS_TELEKINETIC_RECIPE_MOVE_ITEM", ctx, nil, nil, nil)
    H.run_eoc("EOC_CHECK_GAMEBEGIN_AFS_TELEKINETIC_RECIPE_MOVE_CREATURE", ctx, nil, nil, nil)
    H.run_eoc("EOC_CHECK_GAMEBEGIN_AFS_TELEKINETIC_RECIPE_MOMENTUM", ctx, nil, nil, nil)
    H.run_eoc("EOC_CHECK_GAMEBEGIN_AFS_TELEKINETIC_RECIPE_WAVE_OF_FORCE", ctx, nil, nil, nil)
    H.run_eoc("EOC_CHECK_GAMEBEGIN_AFS_TELEKINETIC_RECIPE_MINDHAMMER", ctx, nil, nil, nil)
    return true
    end
    COND["EOC_CHECK_GAMEBEGIN_AFS_TELEKINETIC_RECIPE_MOVE_ITEM"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "AFS_TELEKINETIC") == 1) and (H.char_spell_level(H.u(ctx), "afs_telekinetic_move_item") >= 0))) == true
    end
    EOC["EOC_CHECK_GAMEBEGIN_AFS_TELEKINETIC_RECIPE_MOVE_ITEM"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "AFS_TELEKINETIC") == 1) and (H.char_spell_level(H.u(ctx), "afs_telekinetic_move_item") >= 0))) then
        H.learn_recipe(H.u(ctx), "practice_afs_telekinetic_move_items")
        return true
    end
    return false
    end
    COND["EOC_CHECK_GAMEBEGIN_AFS_TELEKINETIC_RECIPE_MOVE_CREATURE"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "AFS_TELEKINETIC") == 1) and (H.char_spell_level(H.u(ctx), "afs_telekinetic_move_creature") >= 0))) == true
    end
    EOC["EOC_CHECK_GAMEBEGIN_AFS_TELEKINETIC_RECIPE_MOVE_CREATURE"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "AFS_TELEKINETIC") == 1) and (H.char_spell_level(H.u(ctx), "afs_telekinetic_move_creature") >= 0))) then
        H.learn_recipe(H.u(ctx), "practice_afs_telekinetic_move_creatures")
        return true
    end
    return false
    end
    COND["EOC_CHECK_GAMEBEGIN_AFS_TELEKINETIC_RECIPE_MOMENTUM"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "AFS_TELEKINETIC") == 1) and (H.char_spell_level(H.u(ctx), "afs_telekinetic_momentum") >= 0))) == true
    end
    EOC["EOC_CHECK_GAMEBEGIN_AFS_TELEKINETIC_RECIPE_MOMENTUM"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "AFS_TELEKINETIC") == 1) and (H.char_spell_level(H.u(ctx), "afs_telekinetic_momentum") >= 0))) then
        H.learn_recipe(H.u(ctx), "practice_afs_telekinetic_momentum")
        return true
    end
    return false
    end
    COND["EOC_CHECK_GAMEBEGIN_AFS_TELEKINETIC_RECIPE_WAVE_OF_FORCE"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "AFS_TELEKINETIC") == 1) and (H.char_spell_level(H.u(ctx), "afs_telekinetic_wave") >= 0))) == true
    end
    EOC["EOC_CHECK_GAMEBEGIN_AFS_TELEKINETIC_RECIPE_WAVE_OF_FORCE"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "AFS_TELEKINETIC") == 1) and (H.char_spell_level(H.u(ctx), "afs_telekinetic_wave") >= 0))) then
        H.learn_recipe(H.u(ctx), "practice_afs_telekinetic_wave")
        return true
    end
    return false
    end
    COND["EOC_CHECK_GAMEBEGIN_AFS_TELEKINETIC_RECIPE_MINDHAMMER"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "AFS_TELEKINETIC") == 1) and (H.char_spell_level(H.u(ctx), "afs_telekinetic_hammer") >= 0))) == true
    end
    EOC["EOC_CHECK_GAMEBEGIN_AFS_TELEKINETIC_RECIPE_MINDHAMMER"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "AFS_TELEKINETIC") == 1) and (H.char_spell_level(H.u(ctx), "afs_telekinetic_hammer") >= 0))) then
        H.learn_recipe(H.u(ctx), "practice_afs_telekinetic_hammer")
        return true
    end
    return false
    end
    COND["EOC_AFS_TELEPATH_RECIPE_TEACHER"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "AFS_TELEPATH") == 1)) == true
    end
    EOC["EOC_AFS_TELEPATH_RECIPE_TEACHER"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "AFS_TELEPATH") == 1)) then
        H.run_eoc("EOC_TEACH_AFS_TELEPATH_CONTEMPLATE_RECIPES", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    EOC["EOC_TEACH_AFS_TELEPATH_CONTEMPLATE_RECIPES"] = function(ctx)
    H.run_eoc("EOC_CHECK_GAMEBEGIN_AFS_TELEPATH_RECIPE_SHIELD", ctx, nil, nil, nil)
    H.run_eoc("EOC_CHECK_GAMEBEGIN_AFS_TELEPATH_RECIPE_SUGGESTION", ctx, nil, nil, nil)
    H.run_eoc("EOC_CHECK_GAMEBEGIN_AFS_TELEPATH_RECIPE_MIND_SENSE", ctx, nil, nil, nil)
    H.run_eoc("EOC_CHECK_GAMEBEGIN_AFS_TELEPATH_RECIPE_CONFUSION", ctx, nil, nil, nil)
    H.run_eoc("EOC_CHECK_GAMEBEGIN_AFS_TELEPATH_RECIPE_BLAST", ctx, nil, nil, nil)
    return true
    end
    COND["EOC_CHECK_GAMEBEGIN_AFS_TELEPATH_RECIPE_SHIELD"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "AFS_TELEPATH") == 1) and (H.char_spell_level(H.u(ctx), "afs_telepathic_shield") >= 0))) == true
    end
    EOC["EOC_CHECK_GAMEBEGIN_AFS_TELEPATH_RECIPE_SHIELD"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "AFS_TELEPATH") == 1) and (H.char_spell_level(H.u(ctx), "afs_telepathic_shield") >= 0))) then
        H.learn_recipe(H.u(ctx), "practice_afs_telepathic_shield")
        return true
    end
    return false
    end
    COND["EOC_CHECK_GAMEBEGIN_AFS_TELEPATH_RECIPE_MIND_SENSE"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "AFS_TELEPATH") == 1) and (H.char_spell_level(H.u(ctx), "afs_telepathic_mind_sense") >= 0))) == true
    end
    EOC["EOC_CHECK_GAMEBEGIN_AFS_TELEPATH_RECIPE_MIND_SENSE"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "AFS_TELEPATH") == 1) and (H.char_spell_level(H.u(ctx), "afs_telepathic_mind_sense") >= 0))) then
        H.learn_recipe(H.u(ctx), "practice_afs_telepathic_mind_sense")
        return true
    end
    return false
    end
    COND["EOC_CHECK_GAMEBEGIN_AFS_TELEPATH_RECIPE_SUGGESTION"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "AFS_TELEPATH") == 1) and (H.char_spell_level(H.u(ctx), "afs_telepathic_suggestion") >= 0))) == true
    end
    EOC["EOC_CHECK_GAMEBEGIN_AFS_TELEPATH_RECIPE_SUGGESTION"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "AFS_TELEPATH") == 1) and (H.char_spell_level(H.u(ctx), "afs_telepathic_suggestion") >= 0))) then
        H.learn_recipe(H.u(ctx), "practice_afs_telepathic_suggestion")
        return true
    end
    return false
    end
    COND["EOC_CHECK_GAMEBEGIN_AFS_TELEPATH_RECIPE_CONFUSION"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "AFS_TELEPATH") == 1) and (H.char_spell_level(H.u(ctx), "afs_telepathic_confusion") >= 0))) == true
    end
    EOC["EOC_CHECK_GAMEBEGIN_AFS_TELEPATH_RECIPE_CONFUSION"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "AFS_TELEPATH") == 1) and (H.char_spell_level(H.u(ctx), "afs_telepathic_confusion") >= 0))) then
        H.learn_recipe(H.u(ctx), "practice_afs_telepathic_confusion")
        return true
    end
    return false
    end
    COND["EOC_CHECK_GAMEBEGIN_AFS_TELEPATH_RECIPE_BLAST"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "AFS_TELEPATH") == 1) and (H.char_spell_level(H.u(ctx), "afs_telepathic_blast") >= 0))) == true
    end
    EOC["EOC_CHECK_GAMEBEGIN_AFS_TELEPATH_RECIPE_BLAST"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "AFS_TELEPATH") == 1) and (H.char_spell_level(H.u(ctx), "afs_telepathic_blast") >= 0))) then
        H.learn_recipe(H.u(ctx), "practice_afs_telepathic_blast")
        return true
    end
    return false
    end
    COND["EOC_AFS_LEADERSHIP_SWITCH"] = function(ctx)
        return ((H.npc_allies_global(1) and (H.global_var_num("afs_leadership_act") == 1) and (services.interaction.confirm(ctx:expand_text(services.translate("You have died.  Continue as one of your followers?"))) == true))) == true
    end
    EOC["EOC_AFS_LEADERSHIP_SWITCH"] = function(ctx)
    if ((H.npc_allies_global(1) and (H.global_var_num("afs_leadership_act") == 1) and (services.interaction.confirm(ctx:expand_text(services.translate("You have died.  Continue as one of your followers?"))) == true))) then
        services.npcs.open_control_menu()
        return true
    end
    return false
    end
    EOC["_EOC_return_to_partyleader_do"] = function(ctx)
    H.run_eoc("follow", ctx)
    H.set_var("global", nil, ctx, "afs_leadership_act", 0)
    H.run_eoc("take_control", ctx)
    return true
    end
    EOC["EOC_return_to_partyleader"] = function(ctx)
    H.run_eoc("_EOC_return_to_partyleader_do", ctx, nil, services.characters.avatar(), (services.characters.by_id(math.floor(H.global_var_num("party_leader_id") or 0)).value))
    return true
    end
    COND["EOC_start_lock_hack"] = function(ctx)
        return (((H.var_exists('context', nil, ctx, "furn_pos") and H.var_exists('context', nil, ctx, "t_delay") and H.var_exists('context', nil, ctx, "difficulty") and H.var_exists('context', nil, ctx, "t_radius")) and (((H.char_snap(H.u(ctx)) or {}).senses or {}).can_see ~= false))) == true
    end
    EOC["EOC_start_lock_hack"] = function(ctx)
    if (((H.var_exists('context', nil, ctx, "furn_pos") and H.var_exists('context', nil, ctx, "t_delay") and H.var_exists('context', nil, ctx, "difficulty") and H.var_exists('context', nil, ctx, "t_radius")) and (((H.char_snap(H.u(ctx)) or {}).senses or {}).can_see ~= false))) then
        H.set_var("context", nil, ctx, "t_delay", H._jm_afs_hack_time_adjust(ctx, (ctx:get_number("t_delay") or 0), 20, 120))
        H.set_var("context", nil, ctx, "hack_cost", ((5 * ((ctx:get_number("t_delay") or 0) / 600)) * math.max(1, (ctx:get_number("power_cost_mult") or 0))))
        H.set_var("context", nil, ctx, "hack_cost_bionic", ((2000000 * ((ctx:get_number("t_delay") or 0) / 600)) * math.max(1, (ctx:get_number("power_cost_mult") or 0))))
        H.eoc_run_inv_eocs(H.u(ctx), ctx, "manual", ctx:expand_text(services.translate("Select a Hacking tool")), { { _cond_fn = function(ctx) return ((((function() local g = H.safe_id('quality', "HACK"); if not g or not H.npc(ctx) then return 0 end; local r = services.items.quality(H.npc(ctx), g); return (r.ok and r.value) or 0 end)()) > 0)) end }, { _cond_fn = function(ctx) return (((((function() local g = H.safe_id('quality', "HACK"); if not g or not H.npc(ctx) then return 0 end; local r = services.items.quality(H.npc(ctx), g); return (r.ok and r.value) or 0 end)()) > 0) and ((ctx:get_number("hack_cost_bionic") or 0) < H.char_bionic_power(H.u(ctx), "power")))) end }, { _cond_fn = function(ctx) return (((((function() local g = H.safe_id('quality', "HACK"); if not g or not H.npc(ctx) then return 0 end; local r = services.items.quality(H.npc(ctx), g); return (r.ok and r.value) or 0 end)()) > 0) and ((ctx:get_number("hack_cost") or 0) < H.char_bionic_power(H.npc(ctx), "power")))) end } }, { "EOC_hack_with_tool" }, {  })
        return true
    end
    return false
    end
    EOC["EOC_hack_with_tool"] = function(ctx)
    do local _g = H.safe_id('json_flag', "ACTIVE_HACK_TOOL"); if H.npc(ctx) and _g then services.items.set_flag(H.npc(ctx), _g, true) end end
    services.messages.add(ctx:expand_text(services.translate("You connect to the lock controller.")), "neutral")
    do local _g = H.safe_id('activity', "ACT_afs_hack"); if H.u(ctx) and _g then services.activities.assign_timed(H.u(ctx), _g, services.time.duration_from_turns(math.max(1, math.floor((ctx:get_number("t_delay") or 0))))) end end
    H.set_var("actor", H.u(ctx), ctx, "hack_bonus", H._jm_afs_hack_bonus(ctx, ((function() local g = H.safe_id('quality', "HACK"); if not g or not H.npc(ctx) then return 0 end; local r = services.items.quality(H.npc(ctx), g); return (r.ok and r.value) or 0 end)()), H.char_val_extra(H.u(ctx), "focus")))
    H.run_eoc("EOC_hack_item_power_consume", ctx, nil, nil, nil)
    H.run_eoc("EOC_hack_bionic_power_consume", ctx, nil, nil, nil)
    do local _t = math.max(1, math.floor((ctx:get_number("t_delay") or 0))); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_afs_hack_unlock"), { ["furn_pos"] = H.var_str("context", nil, ctx, "furn_pos", ""), ["difficulty"] = H.var_str("context", nil, ctx, "difficulty", ""), ["t_radius"] = H.var_str("context", nil, ctx, "t_radius", "") }) end end
    return true
    end
    EOC["EOC_hack_item_power_consume_found_item"] = function(ctx)
    H.set_bionic_power(H.npc(ctx), (ctx:get_number("hack_cost") or 0), "-=")
    do local _g = H.safe_id('json_flag', "ACTIVE_HACK_TOOL"); if H.npc(ctx) and _g then services.items.set_flag(H.npc(ctx), _g, false) end end
    return true
    end
    EOC["EOC_hack_item_power_consume"] = function(ctx)
    H.eoc_run_inv_eocs(H.u(ctx), ctx, "all", nil, { {  } }, { "EOC_hack_item_power_consume_found_item" }, {  })
    return true
    end
    EOC["EOC_hack_bionic_power_consume_found_item"] = function(ctx)
    H.set_bionic_power(H.u(ctx), (ctx:get_number("hack_cost_bionic") or 0), "-=")
    do local _g = H.safe_id('json_flag', "ACTIVE_HACK_TOOL"); if H.npc(ctx) and _g then services.items.set_flag(H.npc(ctx), _g, false) end end
    return true
    end
    EOC["EOC_hack_bionic_power_consume"] = function(ctx)
    H.eoc_run_inv_eocs(H.u(ctx), ctx, "all", nil, { {  } }, { "EOC_hack_bionic_power_consume_found_item" }, {  })
    return true
    end
    COND["EOC_afs_hack_success"] = function(ctx)
        return (((services.random.native_int(1, math.floor(4)) + (H._jm_afs_hack_skill(ctx, 1))) > ((ctx:get_number("difficulty") or 0)))) == true
    end
    EOC["EOC_afs_hack_success"] = function(ctx)
    if (((services.random.native_int(1, math.floor(4)) + (H._jm_afs_hack_skill(ctx, 1))) > ((ctx:get_number("difficulty") or 0)))) then
        if (((H.var_str("actor", H.u(ctx), ctx, "hack_success_eoc", "")) == (""))) then
            H.set_var("actor", H.u(ctx), ctx, "hack_success_eoc", "EOC_afs_hack_generic_success")
        end
        H.run_eoc(H.var_str("actor", H.u(ctx), ctx, "hack_success_eoc", ""), ctx, nil, nil, nil)
        H.set_var("actor", H.u(ctx), ctx, "hack_minor_failure_eoc", "")
        H.set_var("actor", H.u(ctx), ctx, "hack_critical_fail_eoc", "")
        H.set_var("actor", H.u(ctx), ctx, "hack_success_eoc", "")
        return true
    else
        H.run_eoc("EOC_afs_hack_failure", ctx, nil, nil, nil)
        H.set_var("actor", H.u(ctx), ctx, "hack_minor_failure_eoc", "")
        H.set_var("actor", H.u(ctx), ctx, "hack_critical_fail_eoc", "")
        H.set_var("actor", H.u(ctx), ctx, "hack_success_eoc", "")
        return false
    end
    end
    COND["EOC_afs_hack_unlock"] = function(ctx)
        return (((H.var_exists('context', nil, ctx, "furn_pos") and H.var_exists('context', nil, ctx, "difficulty") and H.var_exists('context', nil, ctx, "t_radius")) and ((function() local eg = H.safe_id('effect', "afs_hack_done"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) == true
    end
    EOC["EOC_afs_hack_unlock"] = function(ctx)
    if (((H.var_exists('context', nil, ctx, "furn_pos") and H.var_exists('context', nil, ctx, "difficulty") and H.var_exists('context', nil, ctx, "t_radius")) and ((function() local eg = H.safe_id('effect', "afs_hack_done"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) then
        H.run_eoc("EOC_afs_hack_success", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    EOC["EOC_afs_hack_generic_success"] = function(ctx)
    do local _p, _g = H.get_tripoint_var("context", nil, ctx, "furn_pos"), H.safe_id('terrain_furniture_transform', "afs_multi_unlock"); if _p and _g then services.world.transform_radius(_p, math.floor((ctx:get_number("t_radius") or 0)), _g, nil) end end
    return true
    end
    EOC["EOC_afs_hack_failure"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("You fail to override the device.")), "bad")
    H.set_var("context", nil, ctx, "failure_roll", services.random.native_int(0, H.round_half_away(9)))
    if (((H.var_str("actor", H.u(ctx), ctx, "hack_minor_failure_eoc", "")) == (""))) then
        H.set_var("actor", H.u(ctx), ctx, "hack_minor_failure_eoc", "EOC_afs_generic_hack_minor_failures")
    end
    if (((H.var_str("actor", H.u(ctx), ctx, "hack_critical_fail_eoc", "")) == (""))) then
        H.set_var("actor", H.u(ctx), ctx, "hack_critical_fail_eoc", "EOC_afs_generic_hack_critical_fail")
    end
    if ((ctx:get_number("failure_roll") or 0) <= H.clamp_num(((ctx:get_number("difficulty") or 0) - H._jm_afs_hack_skill(ctx, 1)), 1, 10)) then
        H.run_eoc(H.var_str("actor", H.u(ctx), ctx, "hack_critical_fail_eoc", ""), ctx, nil, nil, nil)
        H.set_var("context", nil, ctx, "failure_roll", 10)
    end
    if ((ctx:get_number("failure_roll") or 0) <= H.clamp_num((((ctx:get_number("difficulty") or 0) - H._jm_afs_hack_skill(ctx, 1)) + 3), 1, 10)) then
        H.run_eoc(H.var_str("actor", H.u(ctx), ctx, "hack_minor_failure_eoc", ""), ctx, nil, nil, nil)
    end
    H.set_var("actor", H.u(ctx), ctx, "hack_minor_failure_eoc", "")
    H.set_var("actor", H.u(ctx), ctx, "hack_critical_fail_eoc", "")
    H.set_var("actor", H.u(ctx), ctx, "hack_success_eoc", "")
    return true
    end
    EOC["EOC_afs_generic_hack_minor_failures"] = function(ctx)
    H.set_var("context", nil, ctx, "failure_eoc", ((function() local _t = { "EOC_afs_generic_hack_minor_failure_alarm", "EOC_afs_generic_hack_minor_failure_hurt" }; return _t[services.random.native_int(1, #_t)] end)()))
    H.run_eoc(H.var_str("context", nil, ctx, "failure_eoc", ""), ctx, nil, nil, nil)
    return true
    end
    EOC["EOC_afs_generic_hack_critical_fail"] = function(ctx)
    do local _p, _g = H.get_tripoint_var("context", nil, ctx, "furn_pos"), H.safe_id('terrain_furniture_transform', "afs_multi_lockdown"); if _p and _g then services.world.transform_radius(_p, math.floor(0), _g, nil) end end
    return true
    end
    EOC["EOC_afs_generic_hack_minor_failure_alarm"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("You set off the devices alarm!")), "bad")
    services.weather.override_light(math.floor(80), services.time.duration_from_turns(math.floor((function() local a, b = math.floor(1), math.floor(10); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())), "")
    do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then services.sound.emit(_p, math.floor(15), "alarm", ctx:expand_text(services.translate("Alarm Bleeping")), false) end end
    return true
    end
    EOC["EOC_afs_generic_hack_minor_failure_hurt"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("The device shocks you!")), "bad")
    do local _g, _a = H.safe_id('damage_type', "electric"), H.u(ctx); if _g and _a then services.creatures.damage(_a, _g, 10, nil) end end
    return true
    end
    EOC["EOC_hack_cryo_storage_unit_success"] = function(ctx)
    do local _p, _g = H.get_tripoint_var("context", nil, ctx, "furn_pos"), H.safe_id('terrain_furniture_transform', "afs_open_cryo_storage"); if _p and _g then services.world.transform_radius(_p, math.floor((ctx:get_number("t_radius") or 0)), _g, nil) end end
    do local _p = H.get_tripoint_var("context", nil, ctx, "furn_pos"); local _g = H.safe_id('item_group', "farmlab_cryostorage"); if _p and _g then local _its = services.items.possible_from_group(_g); services.world.spawn_item(_p, _g, math.floor(2)) end end
    return true
    end
    EOC["EOC_SHIP_RAMP"] = function(ctx)
    if (not (H.char_at_om_location(H.u(ctx), "high_orbit_salus_4tp"))) then
        if (H.global_var_num("your_ship_ramp_up") == 1) then
            H.eoc_loc_var(H.u(ctx), ctx, "context", "ramp", nil, nil, nil, nil, nil, false, true, {  }, {  })
            do local _p, _g = H.get_tripoint_var("context", nil, ctx, "ramp"), H.safe_id('terrain_furniture_transform', "your_ship_ramp_down"); if _p and _g then services.world.transform_radius(_p, math.floor(20), _g, nil) end end
            do local tp = H.get_tripoint_var("context", nil, ctx, "ramp"); if tp then local nt = services.coords.tripoint_abs_ms((tp.x or 0) + math.floor(0) * 1, (tp.y or 0) + math.floor(0) * 1, (tp.z or 0) + math.floor(-1)); H.set_var("context", nil, ctx, "ramp", nt) end end
            do local _p = H.get_tripoint_var("context", nil, ctx, "ramp"); if _p then local _omt = _p:project_to('omt'); local _om = nil; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "your_ship_ramp_deployed" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
            services.messages.add(ctx:expand_text(services.translate("The bay ramp hydraulics whine as the ramp extends downwards.")), "neutral")
            H.set_var("global", nil, ctx, "your_ship_ramp_up", 0)
        else
            H.eoc_loc_var(H.u(ctx), ctx, "context", "ramp", nil, nil, nil, nil, nil, false, true, {  }, {  })
            do local _p = H.get_tripoint_var("context", nil, ctx, "ramp"); if _p then local _omt = _p:project_to('omt'); local _om = nil; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "your_ship_ramp_closed" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
            H.eoc_loc_var(H.u(ctx), ctx, "context", "find_open", nil, nil, { kind = "terrain", id = H.safe_id("terrain", "t_open_air_bay") }, { target_max_radius = math.floor(24) }, nil, false, true, {  }, {  })
            if H.truthy((H.var_exists("context", nil, ctx, "find_open") and 1 or 0)) then
                services.messages.add(ctx:expand_text(services.translate("You must clear all vehicles near the ramp before raising it")), "neutral")
            else
                do local tp = H.get_tripoint_var("context", nil, ctx, "ramp"); if tp then local nt = services.coords.tripoint_abs_ms((tp.x or 0) + math.floor(0) * 1, (tp.y or 0) + math.floor(0) * 1, (tp.z or 0) + math.floor(-1)); H.set_var("context", nil, ctx, "ramp", nt) end end
                do local _p = H.get_tripoint_var("context", nil, ctx, "ramp"); if _p then local _omt = _p:project_to('omt'); local _om = nil; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "your_ship_ramp_retract" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
                services.messages.add(ctx:expand_text(services.translate("The ramp rises into position, sealing the bay.")), "neutral")
                H.set_var("global", nil, ctx, "your_ship_ramp_up", 1)
            end
        end
    else
        services.messages.add(ctx:expand_text(services.translate("You cant deploy the ramp while in space.")), "neutral")
    end
    return true
    end
    EOC["EOC_SHIP_AUTO_CONTROL"] = function(ctx)
    local _u6 = H.u(ctx)
    if _u6 then services.characters.adjust(_u6, { moves = -math.floor((4) * 100) }) end
    H.eoc_add_effect(H.u(ctx), "blind_no_msg", 3, nil, nil, nil)
    H.eoc_loc_var(H.u(ctx), ctx, "global", "ship", nil, nil, nil, nil, nil, false, true, {  }, {  })
    if (H.truthy((H.var_exists("global", nil, ctx, "ship_new") and 1 or 0))) then
        do local _mid = "MISSION_thi_location"; if H.u(ctx) then local _pg = services.missions.active(H.u(ctx), { limit = 64 }); for _, _m in ipairs((_pg and _pg.items) or {}) do if _m.id and _m.id.value == _mid and _m.token then services.missions.abandon(H.u(ctx), _m.token); break end end end end
        do local _g = H.safe_id('mission', "MISSION_thi_location"); if H.u(ctx) and _g then local _res = services.missions.reserve(_g); if _res.ok and _res.value and _res.value.token then services.missions.assign(H.u(ctx), _res.value.token) end end end
        do local _s, _d = H.get_tripoint_var("global", nil, ctx, "ship"), H.get_tripoint_var("global", nil, ctx, "ship_new"); if _s and _d then services.world.schedule_location_copy(_s, _d, services.time.infinite_duration(), "tp_key") end end
        services.time.reschedule("tp_key", services.time.duration_from_turns(0))
        do local _t = math.max(1, math.floor(1)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_SHIP_TELEPORTS"), nil) end end
    else
        services.messages.add(ctx:expand_text(services.translate("You can only plot a course to an empty field at least 5 map tiles away.")), "warning")
    end
    return true
    end
    EOC["EOC_SHIP_THI_MANUAL_QUERY"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("Select Destination:")), "neutral")
    H.eoc_loc_var(H.u(ctx), ctx, "global", "ship", nil, nil, nil, nil, nil, false, true, {  }, {  })
    H.coord_set("global", nil, ctx, "ship_new", "z", 0, "=")
    if (H.truthy((H.var_exists("global", nil, ctx, "ship_new") and 1 or 0)) and (((function() local p1, p2 = (H.char_snap(H.u(ctx)) or {}).creature.position, H.get_tripoint_var("global", nil, ctx, "ship_new"); if not p1 or not p2 then return 0 end; return math.max(math.abs((p1.x or 0)-(p2.x or 0)), math.abs((p1.y or 0)-(p2.y or 0))) end)()) >= 190) and (((function() local p = H.get_tripoint_var("global", nil, ctx, "ship_new"); return p ~= nil and (services.overmap.matches(p:project_to('omt'), "glacial_field")) end)()) or ((function() local p = H.get_tripoint_var("global", nil, ctx, "ship_new"); return p ~= nil and (services.overmap.matches(p:project_to('omt'), "field")) end)()))) then
        H.set_var("global", nil, ctx, "ship_can_travel", 1)
    else
        H.set_var("global", nil, ctx, "ship_can_travel", 0)
    end
    return true
    end
    EOC["EOC_SHIP_THI_MANUAL_CONTROL"] = function(ctx)
    local _u7 = H.u(ctx)
    if _u7 then services.characters.adjust(_u7, { moves = -math.floor((4) * 100) }) end
    H.eoc_add_effect(H.u(ctx), "blind_no_msg", 3, nil, nil, nil)
    do local _mid = "MISSION_thi_location"; if H.u(ctx) then local _pg = services.missions.active(H.u(ctx), { limit = 64 }); for _, _m in ipairs((_pg and _pg.items) or {}) do if _m.id and _m.id.value == _mid and _m.token then services.missions.abandon(H.u(ctx), _m.token); break end end end end
    do local _g = H.safe_id('mission', "MISSION_thi_location"); if H.u(ctx) and _g then local _res = services.missions.reserve(_g); if _res.ok and _res.value and _res.value.token then services.missions.assign(H.u(ctx), _res.value.token) end end end
    H.coord_set("global", nil, ctx, "ship_new", "z", 1, "=")
    do local _s, _d = H.get_tripoint_var("global", nil, ctx, "ship"), H.get_tripoint_var("global", nil, ctx, "ship_new"); if _s and _d then services.world.schedule_location_copy(_s, _d, services.time.infinite_duration(), "tp_key") end end
    services.time.reschedule("tp_key", services.time.duration_from_turns(0))
    do local _t = math.max(1, math.floor(1)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_SHIP_TELEPORTS"), nil) end end
    return true
    end
    EOC["EOC_SHIP_TELEPORTS"] = function(ctx)
    H.run_eoc("EOC_SHIP_veh", ctx, nil, nil, nil)
    H.run_eoc("EOC_SHIP_npc", ctx, nil, nil, nil)
    H.run_eoc("EOC_SHIP_mon", ctx, nil, nil, nil)
    H.run_eoc("EOC_SHIP_zone", ctx, nil, nil, nil)
    H.run_eoc("EOC_SHIP_TP", ctx, nil, nil, nil)
    do local _t = math.max(1, math.floor(1)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_SHIP_CLEANUP"), nil) end end
    do local _t = math.max(1, math.floor(1)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_SHIP_VER"), nil) end end
    return true
    end
    EOC["EOC_SHIP_veh"] = function(ctx)
    H.eoc_run_vehicle_eocs(H.u(ctx), ctx, { "EOC_SHIP_TP" }, 24, H.coord_get("global", nil, ctx, "ship", "z"), H.coord_get("global", nil, ctx, "ship", "z"))
    return true
    end
    EOC["EOC_SHIP_npc"] = function(ctx)
    do local _r = services.npcs.loaded(); for _, _n in ipairs((_r and _r.items) or {}) do for _, _eid in ipairs({ "EOC_SHIP_TP" }) do H.run_eoc(_eid, ctx, nil, _n.handle or _n, ctx.u) end end end
    return true
    end
    EOC["EOC_SHIP_mon"] = function(ctx)
    do local _cs = H.creature_snap(H.u(ctx)); if _cs then local _mr = services.monsters.nearby(_cs.position, math.floor(24), nil); for _, _m in ipairs((_mr.ok and _mr.value) or {}) do for _, _eid in ipairs({ "EOC_SHIP_TP" }) do H.run_eoc(_eid, ctx, nil, _m, ctx.u) end end end end
    return true
    end
    EOC["EOC_SHIP_zone"] = function(ctx)
    H.eoc_run_fixed_zone_eocs(H.u(ctx), ctx, { "EOC_SHIP_TP" }, 24, H.coord_get("global", nil, ctx, "ship", "z"), H.coord_get("global", nil, ctx, "ship", "z"))
    return true
    end
    EOC["EOC_SHIP_TP"] = function(ctx)
    H.eoc_loc_var(H.u(ctx), ctx, "context", "my_pos", nil, nil, nil, nil, nil, false, true, {  }, {  })
    H.set_var("context", nil, ctx, "new_ship_x", (((12 * H.round_half_away((H.coord_get("global", nil, ctx, "ship_new", "x") / 12))) - H.coord_get("context", nil, ctx, "my_pos", "x")) + ((((H.coord_get("context", nil, ctx, "my_pos", "x") % 24) + 24) % 24) - 12)))
    H.set_var("context", nil, ctx, "new_ship_y", (((12 * H.round_half_away((H.coord_get("global", nil, ctx, "ship_new", "y") / 12))) - H.coord_get("context", nil, ctx, "my_pos", "y")) + ((((H.coord_get("context", nil, ctx, "my_pos", "y") % 24) + 24) % 24) - 12)))
    H.coord_set("context", nil, ctx, "my_pos", "z", H.coord_get("global", nil, ctx, "ship_new", "z"), "=")
    H.coord_set("context", nil, ctx, "my_pos", "x", (ctx:get_number("new_ship_x") or 0), "+=")
    H.coord_set("context", nil, ctx, "my_pos", "y", (ctx:get_number("new_ship_y") or 0), "+=")
    do local _p = H.get_tripoint_var("context", nil, ctx, "my_pos"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, { force = true }) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, { force = true }) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, { force = true }) end end end
    return true
    end
    EOC["EOC_SHIP_VER"] = function(ctx)
    H.eoc_loc_var(H.u(ctx), ctx, "context", "my_pos", nil, nil, nil, nil, nil, false, true, {  }, {  })
    H.eoc_loc_var(H.u(ctx), ctx, "context", "my_pos2", nil, nil, nil, nil, nil, false, true, {  }, {  })
    do local tp = H.get_tripoint_var("context", nil, ctx, "my_pos2"); if tp then local nt = services.coords.tripoint_abs_ms((tp.x or 0) + math.floor(12) * 1, (tp.y or 0) + math.floor(3) * 1, (tp.z or 0) + math.floor(0)); H.set_var("context", nil, ctx, "my_pos2", nt) end end
    do local _p = H.get_tripoint_var("context", nil, ctx, "my_pos2"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, nil) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, nil) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, nil) end end end
    do local _p = H.get_tripoint_var("context", nil, ctx, "my_pos"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, nil) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, nil) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, nil) end end end
    return true
    end
    EOC["EOC_SHIP_CLEANUP"] = function(ctx)
    do local _p, _g = H.get_tripoint_var("global", nil, ctx, "ship_new"), H.safe_id('terrain_furniture_transform', "your_ship_stairs_up"); if _p and _g then services.world.transform_radius(_p, math.floor(20), _g, nil) end end
    H.set_var("global", nil, ctx, "your_ship_stairs_up", 1)
    H.coord_set("global", nil, ctx, "ship_new", "z", 1, "-=")
    do local _p = H.get_tripoint_var("global", nil, ctx, "ship_new"); if _p then local _omt = _p:project_to('omt'); local _om = nil; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "your_ship_gear" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
    H.coord_set("global", nil, ctx, "ship_new", "z", 2, "+=")
    do local _p = H.get_tripoint_var("global", nil, ctx, "ship_new"); if _p then local _omt = _p:project_to('omt'); local _om = nil; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "your_ship_roof" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
    do local _p = H.get_tripoint_var("global", nil, ctx, "ship"); if _p then local _omt = _p:project_to('omt'); local _om = nil; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "your_ship_left" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
    H.coord_set("global", nil, ctx, "ship", "z", 1, "-=")
    do local _p = H.get_tripoint_var("global", nil, ctx, "ship"); if _p then local _omt = _p:project_to('omt'); local _om = nil; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "your_ship_landing_left" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
    do local _p = H.get_tripoint_var("global", nil, ctx, "ship"); if _p then local _omt = _p:project_to('omt'); local _om = nil; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "your_ship_stairs_retract" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
    H.coord_set("global", nil, ctx, "ship", "z", 2, "+=")
    do local _p = H.get_tripoint_var("global", nil, ctx, "ship"); if _p then local _omt = _p:project_to('omt'); local _om = nil; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "your_ship_left" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
    H.set_var("actor", H.u(ctx), ctx, "ship_new", nil)
    H.set_var("actor", H.u(ctx), ctx, "ship", nil)
    return true
    end
    EOC["EOC_SHIP_THI_TO_SALUS_ORBIT"] = function(ctx)
    if H.truthy((H.var_exists("global", nil, ctx, "salus_4_orbit_pos") and 1 or 0)) then
        H.coord_set("global", nil, ctx, "ship_new", "x", H.coord_get("global", nil, ctx, "salus_4_orbit_pos", "x"), "=")
        H.coord_set("global", nil, ctx, "ship_new", "y", H.coord_get("global", nil, ctx, "salus_4_orbit_pos", "y"), "=")
        H.coord_set("global", nil, ctx, "ship_new", "z", H.coord_get("global", nil, ctx, "salus_4_orbit_pos", "z"), "=")
        H.run_eoc("EOC_SHIP_AUTO_CONTROL", ctx, nil, nil, nil)
    else
        H.eoc_loc_var(H.u(ctx), ctx, "global", "salus_4_orbit_pos", { terrain = "high_orbit_salus_4tp" }, { z = math.floor(-9) }, nil, nil, { dx = math.floor(12), dy = math.floor(12) }, false, true, {  }, {  })
        H.coord_set("global", nil, ctx, "ship_new", "x", H.coord_get("global", nil, ctx, "salus_4_orbit_pos", "x"), "=")
        H.coord_set("global", nil, ctx, "ship_new", "y", H.coord_get("global", nil, ctx, "salus_4_orbit_pos", "y"), "=")
        H.coord_set("global", nil, ctx, "ship_new", "z", H.coord_get("global", nil, ctx, "salus_4_orbit_pos", "z"), "=")
        H.run_eoc("EOC_SHIP_AUTO_CONTROL", ctx, nil, nil, nil)
    end
    return true
    end
    EOC["EOC_SHIP_THI_TO_SPACEPORT"] = function(ctx)
    if H.truthy((H.var_exists("global", nil, ctx, "salus_old_pad_pos") and 1 or 0)) then
        H.coord_set("global", nil, ctx, "ship_new", "x", H.coord_get("global", nil, ctx, "salus_old_pad_pos", "x"), "=")
        H.coord_set("global", nil, ctx, "ship_new", "y", H.coord_get("global", nil, ctx, "salus_old_pad_pos", "y"), "=")
        H.coord_set("global", nil, ctx, "ship_new", "z", (H.coord_get("global", nil, ctx, "salus_old_pad_pos", "z") + 1), "=")
        H.run_eoc("EOC_SHIP_AUTO_CONTROL", ctx, nil, nil, nil)
    else
        H.eoc_loc_var(H.u(ctx), ctx, "global", "salus_old_pad_pos", { terrain = "afs_shuttlepad_salvors_old_pad" }, { z = math.floor(0) }, nil, nil, { dx = math.floor(12), dy = math.floor(12) }, false, true, {  }, {  })
        H.coord_set("global", nil, ctx, "ship_new", "x", H.coord_get("global", nil, ctx, "salus_old_pad_pos", "x"), "=")
        H.coord_set("global", nil, ctx, "ship_new", "y", H.coord_get("global", nil, ctx, "salus_old_pad_pos", "y"), "=")
        H.coord_set("global", nil, ctx, "ship_new", "z", (H.coord_get("global", nil, ctx, "salus_old_pad_pos", "z") + 1), "=")
        H.run_eoc("EOC_SHIP_AUTO_CONTROL", ctx, nil, nil, nil)
    end
    return true
    end
end
