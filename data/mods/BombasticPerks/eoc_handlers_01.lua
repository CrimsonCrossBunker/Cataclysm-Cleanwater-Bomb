local ccb = require("ccb")
local services = ccb.services
return function(E, H)
    local EOC = E.run
    local COND = E.cond
    EOC["EOC_level_up_exec"] = function(ctx)
    H.run_eoc("EOC_give_perk_point", ctx, nil, nil, nil)
    H.set_var("actor", H.u(ctx), ctx, "bperk_leveled_up", 1)
    H.set_var("actor", H.u(ctx), ctx, "used_exp", (H.var_num(H.u(ctx), "used_exp")) + (H.var_num(H.u(ctx), "exp_to_perk")))
    H.set_var("actor", H.u(ctx), ctx, "available_exp", ((H.char_val_extra(H.u(ctx), "exp") + H.var_num(H.u(ctx), "bonus_exp")) - H.var_num(H.u(ctx), "used_exp")))
    H.set_var("actor", H.u(ctx), ctx, "exp_to_perk", (H.var_num(H.u(ctx), "exp_to_perk")) + (H.var_num(H.u(ctx), "exp_per_level")))
    H.set_var("actor", H.u(ctx), ctx, "current_level", (H.var_num(H.u(ctx), "current_level")) + (1))
    H.set_var("actor", H.u(ctx), ctx, "perks_toward_playstyle", (H.var_num(H.u(ctx), "perks_toward_playstyle")) + (1))
    if (H.var_num(H.u(ctx), "perks_toward_playstyle") >= H.var_num(H.u(ctx), "perks_toward_playstyle_setting")) then
        H.set_var("actor", H.u(ctx), ctx, "playstyle_perks_available", (H.var_num(H.u(ctx), "playstyle_perks_available")) + (1))
        H.set_var("actor", H.u(ctx), ctx, "perks_toward_playstyle", (H.var_num(H.u(ctx), "perks_toward_playstyle")) - (H.var_num(H.u(ctx), "perks_toward_playstyle_setting")))
    end
    return true
    end
    EOC["EOC_level_up"] = function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "available_exp", ((H.char_val_extra(H.u(ctx), "exp") + H.var_num(H.u(ctx), "bonus_exp")) - H.var_num(H.u(ctx), "used_exp")))
    if (H.var_num(H.u(ctx), "available_exp") > H.var_num(H.u(ctx), "exp_to_perk")) then
        H.run_eoc("EOC_level_up_exec", ctx, nil, nil, nil)
    end
    if (H.var_num(H.u(ctx), "bperk_leveled_up") == 1) then
        H.set_var("actor", H.u(ctx), ctx, "bperk_leveled_up", 0)
        H.run_eoc("EOC_level_up_notification", ctx, nil, nil, nil)
    end
    return true
    end
    COND["EOC_level_up_notification"] = function(ctx)
        return ((H.var_num(H.u(ctx), "no_notifications") ~= 1)) == true
    end
    EOC["EOC_level_up_notification"] = function(ctx)
    if ((H.var_num(H.u(ctx), "no_notifications") ~= 1)) then
        if H.u(ctx) then services.characters.open_topic(H.u(ctx), "TALK_PERK_MENU_MAIN") end
        return true
    end
    return false
    end
    EOC["EOC_on_kill_check_exp"] = function(ctx)
    H.run_eoc("EOC_level_up", ctx, nil, nil, nil)
    return true
    end
    COND["EOC_bombastic_perks_initialize"] = function(ctx)
        return (((not ((H.char_has_trait(H.u(ctx), "perk_perk_menu") == 1))))) == true
    end
    EOC["EOC_bombastic_perks_initialize"] = function(ctx)
    if (((not ((H.char_has_trait(H.u(ctx), "perk_perk_menu") == 1))))) then
        services.messages.add(ctx:expand_text(services.translate("Bombastic Perks is loaded, configuration menu should appear.  If the mod is properly loaded you should have a new mutation called \"perk menu\".  If you do not, you can enable the mod manually by activating the \"EOC_bombastic_perks_try_configure\" EOC in debug.")), "neutral")
        H.run_eoc("EOC_bombastic_perks_try_configure", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_bombastic_perks_avatar_new"] = function(ctx)
        return (((not ((H.char_has_trait(H.u(ctx), "perk_perk_menu") == 1))) and ((ctx:get_number("is_new_game") or 0) == 0) and ((ctx:get_number("is_debug") or 0) == 0))) == true
    end
    EOC["EOC_bombastic_perks_avatar_new"] = function(ctx)
    if (((not ((H.char_has_trait(H.u(ctx), "perk_perk_menu") == 1))) and ((ctx:get_number("is_new_game") or 0) == 0) and ((ctx:get_number("is_debug") or 0) == 0))) then
        H.run_eoc("EOC_give_perk_menu", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_bombastic_perks_try_configure"] = function(ctx)
        return (((not ((H.char_has_trait(H.u(ctx), "perk_perk_menu") == 1))))) == true
    end
    EOC["EOC_bombastic_perks_try_configure"] = function(ctx)
    if (((not ((H.char_has_trait(H.u(ctx), "perk_perk_menu") == 1))))) then
        if H.u(ctx) then services.characters.open_topic(H.u(ctx), "TALK_PERK_MENU_WELCOME") end
        do local _t = math.max(1, math.floor(30)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_bombastic_perks_try_configure"), nil) end end
        services.messages.add(ctx:expand_text(services.translate("Configuration menu closed, if Bombastic Perks was not properly configured menu will open again in 30 seconds.")), "neutral")
        return true
    end
    return false
    end
    COND["EOC_give_perk_menu"] = function(ctx)
        return (((not ((H.char_has_trait(H.u(ctx), "perk_perk_menu") == 1))))) == true
    end
    EOC["EOC_give_perk_menu"] = function(ctx)
    if (((not ((H.char_has_trait(H.u(ctx), "perk_perk_menu") == 1))))) then
        H.set_var("actor", H.u(ctx), ctx, "num_perks", 0)
        H.set_var("actor", H.u(ctx), ctx, "exp_to_perk", 100)
        H.set_var("actor", H.u(ctx), ctx, "exp_per_level", 300)
        H.set_var("actor", H.u(ctx), ctx, "available_exp", 0)
        H.set_var("actor", H.u(ctx), ctx, "current_level", 0)
        H.set_var("actor", H.u(ctx), ctx, "no_playstyle", 0)
        H.set_var("actor", H.u(ctx), ctx, "perks_toward_playstyle_setting", 6)
        H.set_var("actor", H.u(ctx), ctx, "playstyle_perks_available", 0)
        H.set_var("actor", H.u(ctx), ctx, "no_prerecs", 0)
        H.set_var("actor", H.u(ctx), ctx, "upgraded_to_new_bombastic_version", 1)
        do local _g = H.safe_id('mutation', "perk_perk_menu"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        return true
    end
    return false
    end
    EOC["EOC_give_perk_point"] = function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "num_perks", (H.var_num(H.u(ctx), "num_perks")) + (1))
    return true
    end
    COND["EOC_EXISTING_CHARACTER_UPDATE_BOMBASTIC_PERKS"] = function(ctx)
        return ((H.var_num(H.u(ctx), "upgraded_to_new_bombastic_version") ~= 1)) == true
    end
    EOC["EOC_EXISTING_CHARACTER_UPDATE_BOMBASTIC_PERKS"] = function(ctx)
    if ((H.var_num(H.u(ctx), "upgraded_to_new_bombastic_version") ~= 1)) then
        H.set_var("actor", H.u(ctx), ctx, "upgraded_to_new_bombastic_version", 1)
        H.set_var("actor", H.u(ctx), ctx, "perks_toward_playstyle_setting", 6)
        H.set_var("actor", H.u(ctx), ctx, "playstyle_perks_available", 0)
        return true
    end
    return false
    end
    COND["EOC_PERK_ABSIT_INVIDIA_HOLY_SYMBOL"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "perk_absit_invidia") == 1) and ((("taint") == (H.var_str("context", nil, ctx, "effect", "")))) and (H.u(ctx) ~= nil and H.safe_id('json_flag', "ANTI_EVIL_EYE_GEAR") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "ANTI_EVIL_EYE_GEAR")).value == true))) == true
    end
    EOC["EOC_PERK_ABSIT_INVIDIA_HOLY_SYMBOL"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "perk_absit_invidia") == 1) and ((("taint") == (H.var_str("context", nil, ctx, "effect", "")))) and (H.u(ctx) ~= nil and H.safe_id('json_flag', "ANTI_EVIL_EYE_GEAR") ~= nil and services.inventory.has_worn_flag(H.u(ctx), H.safe_id('json_flag', "ANTI_EVIL_EYE_GEAR")).value == true))) then
        do local _eg = H.safe_id('effect', "taint"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_PERK_ABSIT_INVIDIA_SALT"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "perk_absit_invidia") == 1)) == true
    end
    EOC["EOC_PERK_ABSIT_INVIDIA_SALT"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "perk_absit_invidia") == 1)) then
        do local _eg = H.safe_id('effect', "taint"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        services.messages.add(ctx:expand_text(services.translate("You toss the salt over your shoulder and mutter under your breath the words that you remember from your childhood.")), "mixed")
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You toss the salt over your shoulder.  Hey, any luck you can get, right?")), "mixed")
        return false
    end
    end
    COND["EOC_perk_bellringer_application_monster"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "perk_bellringer") == 1) and (((function() local eg = H.safe_id('effect', "dazed"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.npc(ctx) or not eg then return false end; return services.effects.has(H.npc(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "stunned"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.npc(ctx) or not eg then return false end; return services.effects.has(H.npc(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_perk_bellringer_application_monster"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "perk_bellringer") == 1) and (((function() local eg = H.safe_id('effect', "dazed"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.npc(ctx) or not eg then return false end; return services.effects.has(H.npc(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "stunned"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.npc(ctx) or not eg then return false end; return services.effects.has(H.npc(ctx), eg, bpg, nil).value == true end)())))) then
        H.eoc_add_effect(H.npc(ctx), "effect_perk_bellringer", 1, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_perk_bellringer_application_character"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "perk_bellringer") == 1) and (((function() local eg = H.safe_id('effect', "dazed"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.npc(ctx) or not eg then return false end; return services.effects.has(H.npc(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "stunned"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.npc(ctx) or not eg then return false end; return services.effects.has(H.npc(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_perk_bellringer_application_character"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "perk_bellringer") == 1) and (((function() local eg = H.safe_id('effect', "dazed"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.npc(ctx) or not eg then return false end; return services.effects.has(H.npc(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "stunned"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.npc(ctx) or not eg then return false end; return services.effects.has(H.npc(ctx), eg, bpg, nil).value == true end)())))) then
        H.eoc_add_effect(H.npc(ctx), "effect_perk_bellringer", 1, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_perk_blood_drinking_heal"] = function(ctx)
        return (((((("blood") == (H.var_str("context", nil, ctx, "itype", "")))) or ((("animal_blood") == (H.var_str("context", nil, ctx, "itype", "")))) or ((("demihuman_blood") == (H.var_str("context", nil, ctx, "itype", "")))) or ((("mutant_human_blood") == (H.var_str("context", nil, ctx, "itype", ""))))) and (H.char_has_trait(H.u(ctx), "perk_blood_drinking_heal") == 1))) == true
    end
    EOC["EOC_perk_blood_drinking_heal"] = function(ctx)
    if (((((("blood") == (H.var_str("context", nil, ctx, "itype", "")))) or ((("animal_blood") == (H.var_str("context", nil, ctx, "itype", "")))) or ((("demihuman_blood") == (H.var_str("context", nil, ctx, "itype", "")))) or ((("mutant_human_blood") == (H.var_str("context", nil, ctx, "itype", ""))))) and (H.char_has_trait(H.u(ctx), "perk_blood_drinking_heal") == 1))) then
        local _a1 = H.u(ctx)
        if _a1 then services.characters.adjust(_a1, { pain = math.floor(-(2)) }) end
        H.run_eoc("EOC_perk_blood_drinking_heal_hp_check", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_perk_blood_drinking_heal_hp_check"] = function(ctx)
        return (((H.char_hp(H.u(ctx), "arm_l", false) < H.char_hp(H.u(ctx), "arm_l", true)) or (H.char_hp(H.u(ctx), "arm_r", false) < H.char_hp(H.u(ctx), "arm_r", true)) or (H.char_hp(H.u(ctx), "leg_l", false) < H.char_hp(H.u(ctx), "leg_l", true)) or (H.char_hp(H.u(ctx), "leg_r", false) < H.char_hp(H.u(ctx), "leg_r", true)) or (H.char_hp(H.u(ctx), "torso", false) < H.char_hp(H.u(ctx), "torso", true)) or (H.char_hp(H.u(ctx), "head", false) < H.char_hp(H.u(ctx), "head", true)))) == true
    end
    EOC["EOC_perk_blood_drinking_heal_hp_check"] = function(ctx)
    if (((H.char_hp(H.u(ctx), "arm_l", false) < H.char_hp(H.u(ctx), "arm_l", true)) or (H.char_hp(H.u(ctx), "arm_r", false) < H.char_hp(H.u(ctx), "arm_r", true)) or (H.char_hp(H.u(ctx), "leg_l", false) < H.char_hp(H.u(ctx), "leg_l", true)) or (H.char_hp(H.u(ctx), "leg_r", false) < H.char_hp(H.u(ctx), "leg_r", true)) or (H.char_hp(H.u(ctx), "torso", false) < H.char_hp(H.u(ctx), "torso", true)) or (H.char_hp(H.u(ctx), "head", false) < H.char_hp(H.u(ctx), "head", true)))) then
        do
            local _sw2 = services.random.native_int(0, H.round_half_away(5))
            if _sw2 == 0 then
                H.run_eoc("EOC_perk_blood_drinking_heal_arm_l", ctx, nil, nil, nil)
            elseif _sw2 == 1 then
                H.run_eoc("EOC_perk_blood_drinking_heal_arm_r", ctx, nil, nil, nil)
            elseif _sw2 == 2 then
                H.run_eoc("EOC_perk_blood_drinking_heal_leg_l", ctx, nil, nil, nil)
            elseif _sw2 == 3 then
                H.run_eoc("EOC_perk_blood_drinking_heal_leg_r", ctx, nil, nil, nil)
            elseif _sw2 == 4 then
                H.run_eoc("EOC_perk_blood_drinking_heal_torso", ctx, nil, nil, nil)
            elseif _sw2 == 5 then
                H.run_eoc("EOC_perk_blood_drinking_heal_head", ctx, nil, nil, nil)
            end
        end
        return true
    end
    return false
    end
    COND["EOC_perk_blood_drinking_heal_arm_l"] = function(ctx)
        return ((H.char_hp(H.u(ctx), "arm_l", false) < H.char_hp(H.u(ctx), "arm_l", true))) == true
    end
    EOC["EOC_perk_blood_drinking_heal_arm_l"] = function(ctx)
    if ((H.char_hp(H.u(ctx), "arm_l", false) < H.char_hp(H.u(ctx), "arm_l", true))) then
        H.set_char_hp(H.u(ctx), "arm_l", 2, "+=")
        return true
    else
        H.run_eoc("EOC_perk_blood_drinking_heal_hp_check", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_perk_blood_drinking_heal_arm_r"] = function(ctx)
        return ((H.char_hp(H.u(ctx), "arm_r", false) < H.char_hp(H.u(ctx), "arm_r", true))) == true
    end
    EOC["EOC_perk_blood_drinking_heal_arm_r"] = function(ctx)
    if ((H.char_hp(H.u(ctx), "arm_r", false) < H.char_hp(H.u(ctx), "arm_r", true))) then
        H.set_char_hp(H.u(ctx), "arm_r", 2, "+=")
        return true
    else
        H.run_eoc("EOC_perk_blood_drinking_heal_hp_check", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_perk_blood_drinking_heal_leg_l"] = function(ctx)
        return ((H.char_hp(H.u(ctx), "leg_l", false) < H.char_hp(H.u(ctx), "leg_l", true))) == true
    end
    EOC["EOC_perk_blood_drinking_heal_leg_l"] = function(ctx)
    if ((H.char_hp(H.u(ctx), "leg_l", false) < H.char_hp(H.u(ctx), "leg_l", true))) then
        H.set_char_hp(H.u(ctx), "leg_l", 2, "+=")
        return true
    else
        H.run_eoc("EOC_perk_blood_drinking_heal_hp_check", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_perk_blood_drinking_heal_leg_r"] = function(ctx)
        return ((H.char_hp(H.u(ctx), "leg_r", false) < H.char_hp(H.u(ctx), "leg_r", true))) == true
    end
    EOC["EOC_perk_blood_drinking_heal_leg_r"] = function(ctx)
    if ((H.char_hp(H.u(ctx), "leg_r", false) < H.char_hp(H.u(ctx), "leg_r", true))) then
        H.set_char_hp(H.u(ctx), "leg_r", 2, "+=")
        return true
    else
        H.run_eoc("EOC_perk_blood_drinking_heal_hp_check", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_perk_blood_drinking_heal_torso"] = function(ctx)
        return ((H.char_hp(H.u(ctx), "torso", false) < H.char_hp(H.u(ctx), "torso", true))) == true
    end
    EOC["EOC_perk_blood_drinking_heal_torso"] = function(ctx)
    if ((H.char_hp(H.u(ctx), "torso", false) < H.char_hp(H.u(ctx), "torso", true))) then
        H.set_char_hp(H.u(ctx), "torso", 2, "+=")
        return true
    else
        H.run_eoc("EOC_perk_blood_drinking_heal_hp_check", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_perk_blood_drinking_heal_head"] = function(ctx)
        return ((H.char_hp(H.u(ctx), "head", false) < H.char_hp(H.u(ctx), "head", true))) == true
    end
    EOC["EOC_perk_blood_drinking_heal_head"] = function(ctx)
    if ((H.char_hp(H.u(ctx), "head", false) < H.char_hp(H.u(ctx), "head", true))) then
        H.set_char_hp(H.u(ctx), "head", 2, "+=")
        return true
    else
        H.run_eoc("EOC_perk_blood_drinking_heal_hp_check", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_perk_boomstick_blast_monster"] = function(ctx)
        return ((H.npc(ctx) ~= nil)) == true
    end
    EOC["EOC_perk_boomstick_blast_monster"] = function(ctx)
    if ((H.npc(ctx) ~= nil)) then
        if ((H.char_has_trait(H.npc(ctx), "perk_boomstick_blast") == 1) and ((function() local sg = H.safe_id('skill', "shotgun"); return H.npc(ctx) ~= nil and sg ~= nil and services.inventory.wielded_matches(H.npc(ctx), sg).value == true end)())) then
            H.eoc_loc_var(H.npc(ctx), ctx, "context", "player_position", nil, nil, nil, nil, nil, false, true, {  }, {  })
            if (ctx:has_speaker() and (((function() local p1, p2 = (H.char_snap(H.u(ctx)) or {}).creature.position, H.get_tripoint_var("context", nil, ctx, "player_position"); if not p1 or not p2 then return 0 end; return math.max(math.abs((p1.x or 0)-(p2.x or 0)), math.abs((p1.y or 0)-(p2.y or 0))) end)()) <= 2)) then
                if H.u(ctx) then services.characters.knockback(H.u(ctx), { force = math.floor(math.max(((ctx:get_number("damage") or 0) / 25), 5)), stun = math.floor(0), dam_mult = math.floor(0.5), direction = H.get_tripoint_var("context", nil, ctx, "player_position") }) end
                H.eoc_add_effect(H.u(ctx), "downed", 1, nil, nil, nil)
            end
        end
        return true
    end
    return false
    end
    COND["EOC_perk_boomstick_blast_character"] = function(ctx)
        return ((H.npc(ctx) ~= nil)) == true
    end
    EOC["EOC_perk_boomstick_blast_character"] = function(ctx)
    if ((H.npc(ctx) ~= nil)) then
        if ((H.char_has_trait(H.npc(ctx), "perk_boomstick_blast") == 1) and ((function() local sg = H.safe_id('skill', "shotgun"); return H.npc(ctx) ~= nil and sg ~= nil and services.inventory.wielded_matches(H.npc(ctx), sg).value == true end)())) then
            H.eoc_loc_var(H.npc(ctx), ctx, "context", "player_position", nil, nil, nil, nil, nil, false, true, {  }, {  })
            if (ctx:has_speaker() and (((function() local p1, p2 = (H.char_snap(H.u(ctx)) or {}).creature.position, H.get_tripoint_var("context", nil, ctx, "player_position"); if not p1 or not p2 then return 0 end; return math.max(math.abs((p1.x or 0)-(p2.x or 0)), math.abs((p1.y or 0)-(p2.y or 0))) end)()) <= 2)) then
                if H.u(ctx) then services.characters.knockback(H.u(ctx), { force = math.floor(math.max(((ctx:get_number("damage") or 0) / 25), 5)), stun = math.floor(0), dam_mult = math.floor(0.5), direction = H.get_tripoint_var("context", nil, ctx, "player_position") }) end
                H.eoc_add_effect(H.u(ctx), "downed", 1, nil, nil, nil)
            end
        end
        return true
    end
    return false
    end
    EOC["EOC_BOMBASTIC_PERKS_CLOSET_STORAGE_TRAVEL_TO_CLOSETLAND_WALL_CHECK"] = function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "closetland_perk_nearby_walls", (H.var_num(H.u(ctx), "closetland_perk_nearby_walls")) + (1))
    return true
    end
    EOC["EOC_BOMBASTIC_PERKS_CLOSET_STORAGE_TRAVEL_TO_CLOSETLAND_FURNITURE_CHECK"] = function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "closetland_perk_nearby_furniture", (H.var_num(H.u(ctx), "closetland_perk_nearby_furniture")) + (1))
    return true
    end
    EOC["EOC_BOMBASTIC_PERKS_CLOSET_STORAGE_TRAVEL_TO_CLOSETLAND_DOOR_CHECK"] = function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "closetland_perk_nearby_doors", (H.var_num(H.u(ctx), "closetland_perk_nearby_doors")) + (1))
    return true
    end
    COND["EOC_BOMBASTIC_PERKS_CLOSET_STORAGE_TRAVEL_TO_CLOSETLAND"] = function(ctx)
        return ((not (((function() local eg = H.safe_id('effect', "effect_bombastic_escaped_closetland"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) == true
    end
    EOC["EOC_BOMBASTIC_PERKS_CLOSET_STORAGE_TRAVEL_TO_CLOSETLAND"] = function(ctx)
    if ((not (((function() local eg = H.safe_id('effect', "effect_bombastic_escaped_closetland"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())))) then
        H.set_var("global", nil, ctx, "closetland_last_dimension", services.gameplay.environment.dimension())
        H.set_var("actor", H.u(ctx), ctx, "closetland_perk_nearby_walls", 0)
        H.set_var("actor", H.u(ctx), ctx, "closetland_perk_nearby_furniture", 0)
        H.set_var("actor", H.u(ctx), ctx, "closetland_perk_nearby_doors", 0)
        do local _o = (H.char_snap(H.u(ctx)) or {}).creature.position; if _o then local _pg = services.world.points_nearby(_o, { max_radius = math.floor(1) }); for _, _pt in ipairs((_pg and _pg.items) or {}) do local _p = _pt.position; H.set_var("context", nil, ctx, "closetland_terrain_check", _p); if (((function() local p = H.get_tripoint_var("context", nil, ctx, "closetland_terrain_check"); local fg = H.safe_id('json_flag', "WALL"); return p ~= nil and fg ~= nil and services.gameplay.environment.terrain_has_flag(p, fg) end)())) then for _, _eid in ipairs({ "EOC_BOMBASTIC_PERKS_CLOSET_STORAGE_TRAVEL_TO_CLOSETLAND_WALL_CHECK" }) do H.run_eoc(_eid, ctx) end; if false then break end end end end end
        do local _o = (H.char_snap(H.u(ctx)) or {}).creature.position; if _o then local _pg = services.world.points_nearby(_o, { max_radius = math.floor(1) }); for _, _pt in ipairs((_pg and _pg.items) or {}) do local _p = _pt.position; H.set_var("context", nil, ctx, "closetland_terrain_check", _p); if ((((function() local p = H.get_tripoint_var("context", nil, ctx, "closetland_terrain_check"); local fg = H.safe_id('json_flag', "BLOCKSDOOR"); return p ~= nil and fg ~= nil and services.gameplay.environment.furniture_has_flag(p, fg) end)()) or ((function() local p = H.get_tripoint_var("context", nil, ctx, "closetland_terrain_check"); if not p then return false end; local f = services.gameplay.environment.furniture_id(p); return f and f.value == "f_safe_l" end)()) or ((function() local p = H.get_tripoint_var("context", nil, ctx, "closetland_terrain_check"); if not p then return false end; local f = services.gameplay.environment.furniture_id(p); return f and f.value == "f_safe_c" end)()))) then for _, _eid in ipairs({ "EOC_BOMBASTIC_PERKS_CLOSET_STORAGE_TRAVEL_TO_CLOSETLAND_FURNITURE_CHECK" }) do H.run_eoc(_eid, ctx) end; if false then break end end end end end
        do local _o = (H.char_snap(H.u(ctx)) or {}).creature.position; if _o then local _pg = services.world.points_nearby(_o, { max_radius = math.floor(1) }); for _, _pt in ipairs((_pg and _pg.items) or {}) do local _p = _pt.position; H.set_var("context", nil, ctx, "closetland_terrain_check", _p); if ((((function() local p = H.get_tripoint_var("context", nil, ctx, "closetland_terrain_check"); local fg = H.safe_id('json_flag', "DOOR"); return p ~= nil and fg ~= nil and services.gameplay.environment.terrain_has_flag(p, fg) end)()) or ((function() local p = H.get_tripoint_var("context", nil, ctx, "closetland_terrain_check"); local fg = H.safe_id('json_flag', "LOCKED"); return p ~= nil and fg ~= nil and services.gameplay.environment.terrain_has_flag(p, fg) end)()))) then for _, _eid in ipairs({ "EOC_BOMBASTIC_PERKS_CLOSET_STORAGE_TRAVEL_TO_CLOSETLAND_DOOR_CHECK" }) do H.run_eoc(_eid, ctx) end; if true then break end end end end end
        H.eoc_loc_var(H.u(ctx), ctx, "context", "check_terrain", nil, nil, nil, nil, nil, false, true, {  }, {  })
        if ((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) or ((function() local p = H.get_tripoint_var("context", nil, ctx, "check_terrain"); if not p then return false end; local f = services.gameplay.environment.furniture_id(p); return f and f.value == "f_toilet" end)()) or ((function() local p = H.get_tripoint_var("context", nil, ctx, "check_terrain"); if not p then return false end; local t = services.gameplay.environment.terrain_id(p); return t and t.value == "t_stairs_up" end)()) or ((function() local p = H.get_tripoint_var("context", nil, ctx, "check_terrain"); if not p then return false end; local t = services.gameplay.environment.terrain_id(p); return t and t.value == "t_stairs_down" end)())) then
            H.set_var("actor", H.u(ctx), ctx, "closetland_perk_nearby_walls", 0)
        end
        if ((H.var_num(H.u(ctx), "closetland_perk_nearby_walls") >= 5) and ((H.var_num(H.u(ctx), "closetland_perk_nearby_walls") + H.var_num(H.u(ctx), "closetland_perk_nearby_furniture")) == 7) and (H.var_num(H.u(ctx), "closetland_perk_nearby_doors") == 1)) then
            if (((H.var_str("global", nil, ctx, "closetland_last_dimension", "")) == ("default")) or ((H.var_str("global", nil, ctx, "closetland_last_dimension", "")) == (H.var_str("global", nil, ctx, "sky_island_target_region_settings", ""))) or ((H.var_str("global", nil, ctx, "closetland_last_dimension", "")) == ("highlands")) or (("default") == (H.var_str("global", nil, ctx, "sky_island_target_region_settings", ""))) or (("default") == ("highlands")) or ((H.var_str("global", nil, ctx, "sky_island_target_region_settings", "")) == ("highlands"))) then
                H.eoc_loc_var(H.u(ctx), ctx, "actor", "closetland_departure_point", nil, nil, nil, { min_radius = math.floor(0), max_radius = math.floor(0) }, nil, false, true, {  }, {  })
                H.eoc_add_effect(H.u(ctx), "blind", 0, nil, nil, nil)
                H.eoc_add_effect(H.u(ctx), "effect_perk_closetland_temp_levitation", 0, nil, nil, nil)
                do local _dr = services.relocation.travel_to_dimension("dimension_perk_closetland", { npc_travel_radius = math.floor(0) })
                end
                H.eoc_add_effect(H.u(ctx), "effect_perk_closetland_sleepiness", -1, nil, nil, nil)
                if (not (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "closetland_arrival_point") and 1 or 0)))) then
                    H.run_eoc("EOC_BOMBASTIC_PERKS_CLOSET_STORAGE_TRAVEL_TO_CLOSETLAND_INITIAL_ARRIVAL", ctx, nil, nil, nil)
                else
                    do local _p = H.get_tripoint_var("actor", H.u(ctx), ctx, "closetland_arrival_point"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, nil) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, nil) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, nil) end end end
                    do local _eg = H.safe_id('effect', "blind"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
                end
                if (services.gameplay.mods.is_loaded("skyisland") and (not (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "closetland_has_been_told_about_skyisland_risk") and 1 or 0))))) then
                    ccb.presentation.notice(ctx:expand_text(services.translate("The walls of the closet seem to vibrate to your heartbeat, you feel certain that failing a raid will cause the walls here to briefly vanish, ejecting everything here into nothingness.")))
                    H.set_var("actor", H.u(ctx), ctx, "closetland_has_been_told_about_skyisland_risk", H.global_var_num("true"))
                end
            else
                services.messages.add(ctx:expand_text(services.translate("Try as you might, you can't seem to find the way to the secret realm.")), "neutral")
                do local _t = math.max(1, math.floor(0)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_BOMBASTIC_PERKS_CLOSET_STORAGE_TRAVEL_TO_CLOSETLAND_DEACTIVATE_FUTURE"), nil) end end
            end
        else
            services.messages.add(ctx:expand_text(services.translate("You can only find the path to Closetland if enclosed in a closet.")), "neutral")
            do local _t = math.max(1, math.floor(0)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_BOMBASTIC_PERKS_CLOSET_STORAGE_TRAVEL_TO_CLOSETLAND_DEACTIVATE_FUTURE"), nil) end end
        end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("After what just happened, going back there would be a terrible idea.  You'd better wait a bit for whatever that was to lose your trail.")), "mixed")
        do local _t = math.max(1, math.floor(0)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_BOMBASTIC_PERKS_CLOSET_STORAGE_TRAVEL_TO_CLOSETLAND_DEACTIVATE_FUTURE"), nil) end end
        return false
    end
    end
    EOC["EOC_BOMBASTIC_PERKS_CLOSET_STORAGE_TRAVEL_TO_CLOSETLAND_DEACTIVATE_FUTURE"] = function(ctx)
    do local _g = H.safe_id('mutation', "perk_secret_closet_storage"); if H.u(ctx) and _g then services.mutations.invoke_activation(H.u(ctx), _g, false) end end
    return true
    end
    EOC["EOC_BOMBASTIC_PERKS_CLOSET_STORAGE_TRAVEL_TO_CLOSETLAND_SLEEPINESS_COST"] = function(ctx)
    H.set_char_val_extra(H.u(ctx), "sleepiness", 20, "+=")
    return true
    end
    EOC["EOC_BOMBASTIC_PERKS_CLOSET_STORAGE_TRAVEL_TO_CLOSETLAND_INITIAL_ARRIVAL"] = function(ctx)
    H.eoc_loc_var(H.u(ctx), ctx, "actor", "closetland_arrival_point", nil, nil, { kind = "terrain", id = H.safe_id("terrain", "t_closetland_floor_olight") }, { target_min_radius = math.floor(0), target_max_radius = math.floor(24) }, { dz = math.floor(0) }, true, true, {  }, {  })
    do local _p = H.get_tripoint_var("actor", H.u(ctx), ctx, "closetland_arrival_point"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, nil) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, nil) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, nil) end end end
    do local _eg = H.safe_id('effect', "blind"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    return true
    end
    COND["EOC_BOMBASTIC_PERKS_CLOSET_STORAGE_SLEEP_DEPRIVATION_COST_IN_CLOSETLAND"] = function(ctx)
        return (((services.gameplay.environment.dimension() == "dimension_perk_closetland"))) == true
    end
    EOC["EOC_BOMBASTIC_PERKS_CLOSET_STORAGE_SLEEP_DEPRIVATION_COST_IN_CLOSETLAND"] = function(ctx)
    if (((services.gameplay.environment.dimension() == "dimension_perk_closetland"))) then
        if services.random.native_probability(1, (8)) then
            H.set_char_val_extra(H.u(ctx), "sleep_deprivation", 1, "+=")
        end
        if (((H.char_val_extra(H.u(ctx), "sleep_deprivation") >= 1000) or ((((H.char_snap(H.u(ctx)) or {}).needs or {}).sleepiness or 0) > 250)) and services.random.native_probability(1, (450))) then
            services.messages.add(ctx:expand_text(services.translate("You let out another yawn.  Did the shadows get darker for just a moment?")), "mixed")
        end
        return true
    end
    return false
    end
    COND["EOC_BOMBASTIC_PERKS_CLOSET_STORAGE_TRAVEL_BACK_FROM_CLOSETLAND"] = function(ctx)
        return ((services.gameplay.environment.dimension() == "dimension_perk_closetland")) == true
    end
    EOC["EOC_BOMBASTIC_PERKS_CLOSET_STORAGE_TRAVEL_BACK_FROM_CLOSETLAND"] = function(ctx)
    if ((services.gameplay.environment.dimension() == "dimension_perk_closetland")) then
        H.eoc_add_effect(H.u(ctx), "blind", 0, nil, nil, nil)
        do local _p, _g = H.get_tripoint_var("actor", H.u(ctx), ctx, "closetland_arrival_point"), H.safe_id('terrain_furniture_transform', "perk_closetland_regenerate_light_if_broken"); if _p and _g then services.world.transform_radius(_p, math.floor(0), _g, nil) end end
        do local _dr = services.relocation.travel_to_dimension(H.var_str("global", nil, ctx, "closetland_last_dimension", ""), nil)
        end
        do local _p = H.get_tripoint_var("actor", H.u(ctx), ctx, "closetland_departure_point"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, nil) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, nil) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, nil) end end end
        do local _eg = H.safe_id('effect', "blind"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "effect_perk_closetland_sleepiness"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_PERK_CLOSETLAND_FALL_ASLEEP_IN_CLOSETLAND"] = function(ctx)
        return (((services.gameplay.environment.dimension() == "dimension_perk_closetland") and ((("sleep") == (H.var_str("context", nil, ctx, "effect", "")))) and (((H.char_has_trait(H.u(ctx), "perk_dream_armor") == 1) and ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "bombastic_closetland_dream_armor_warning", ""))))) or (not ((H.char_has_trait(H.u(ctx), "perk_dream_armor") == 1)))))) == true
    end
    EOC["EOC_PERK_CLOSETLAND_FALL_ASLEEP_IN_CLOSETLAND"] = function(ctx)
    if (((services.gameplay.environment.dimension() == "dimension_perk_closetland") and ((("sleep") == (H.var_str("context", nil, ctx, "effect", "")))) and (((H.char_has_trait(H.u(ctx), "perk_dream_armor") == 1) and ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "bombastic_closetland_dream_armor_warning", ""))))) or (not ((H.char_has_trait(H.u(ctx), "perk_dream_armor") == 1)))))) then
        ccb.presentation.notice(ctx:expand_text(services.translate("You fall asleep and are almost immediately plagued by fitful dreams of being chased through seemingly-endless corridors by a shadowy form with two pale burning eyes, giving you just enough time to rest before resuming the chase.  But at some point, you realize that it's *not* a dream, and you cannot wake up, and you cannot find a way out.\n\nYou never find a way out.")))
        if H.u(ctx) then services.characters.die(H.u(ctx)) end
        return true
    end
    return false
    end
    COND["EOC_PERK_CLOSETLAND_FALL_ASLEEP_IN_CLOSETLAND_BUT_HAS_DREAM_ARMOR"] = function(ctx)
        return (((services.gameplay.environment.dimension() == "dimension_perk_closetland") and ((("sleep") == (H.var_str("context", nil, ctx, "effect", "")))) and (H.char_has_trait(H.u(ctx), "perk_dream_armor") == 1) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "bombastic_closetland_dream_armor_warning", "")))))))) == true
    end
    EOC["EOC_PERK_CLOSETLAND_FALL_ASLEEP_IN_CLOSETLAND_BUT_HAS_DREAM_ARMOR"] = function(ctx)
    if (((services.gameplay.environment.dimension() == "dimension_perk_closetland") and ((("sleep") == (H.var_str("context", nil, ctx, "effect", "")))) and (H.char_has_trait(H.u(ctx), "perk_dream_armor") == 1) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "bombastic_closetland_dream_armor_warning", "")))))))) then
        ccb.presentation.notice(ctx:expand_text(services.translate("You fall asleep for only a moment before being jerked awake.  The room is engulfed in shadows, barely anything visible beyond the tip of your nose, but you feel a palpable sense of menace.  You scramble to your feet and, just as the shadows in the corner begin to grow even darker, frantically take the path away and out of Closetland.")))
        if H.u(ctx) then services.activities.cancel(H.u(ctx)) end
        H.eoc_add_effect(H.u(ctx), "effect_bombastic_escaped_closetland", 86400, nil, nil, nil)
        H.set_var("actor", H.u(ctx), ctx, "bombastic_closetland_dream_armor_warning", "yes")
        do local _g = H.safe_id('mutation', "perk_secret_closet_storage"); if H.u(ctx) and _g then services.mutations.invoke_activation(H.u(ctx), _g, false) end end
        return true
    end
    return false
    end
    EOC["EOC_BOMBASTIC_PERKS_CLOSET_STORAGE_DIFFERENT_PATHS_OF_CLOSETLAND_WALL_CHECK"] = function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "closetland_perk_nearby_walls", (H.var_num(H.u(ctx), "closetland_perk_nearby_walls")) + (1))
    return true
    end
    EOC["EOC_BOMBASTIC_PERKS_CLOSET_STORAGE_DIFFERENT_PATHS_OF_CLOSETLAND_FURNITURE_CHECK"] = function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "closetland_perk_nearby_furniture", (H.var_num(H.u(ctx), "closetland_perk_nearby_furniture")) + (1))
    return true
    end
    EOC["EOC_BOMBASTIC_PERKS_CLOSET_STORAGE_DIFFERENT_PATHS_OF_CLOSETLAND_DOOR_CHECK"] = function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "closetland_perk_nearby_doors", (H.var_num(H.u(ctx), "closetland_perk_nearby_doors")) + (1))
    return true
    end
    COND["EOC_BOMBASTIC_PERKS_CLOSET_STORAGE_DIFFERENT_PATHS_OF_CLOSETLAND"] = function(ctx)
        return ((not ((services.gameplay.environment.dimension() == "dimension_perk_closetland")))) == true
    end
    EOC["EOC_BOMBASTIC_PERKS_CLOSET_STORAGE_DIFFERENT_PATHS_OF_CLOSETLAND"] = function(ctx)
    if ((not ((services.gameplay.environment.dimension() == "dimension_perk_closetland")))) then
        H.set_var("context", nil, ctx, "closetland_paths_last_dimension", services.gameplay.environment.dimension())
        H.set_var("actor", H.u(ctx), ctx, "closetland_perk_nearby_walls", 0)
        H.set_var("actor", H.u(ctx), ctx, "closetland_perk_nearby_furniture", 0)
        H.set_var("actor", H.u(ctx), ctx, "closetland_perk_nearby_doors", 0)
        do local _o = (H.char_snap(H.u(ctx)) or {}).creature.position; if _o then local _pg = services.world.points_nearby(_o, { max_radius = math.floor(1) }); for _, _pt in ipairs((_pg and _pg.items) or {}) do local _p = _pt.position; H.set_var("context", nil, ctx, "closetland_terrain_check", _p); if (((function() local p = H.get_tripoint_var("context", nil, ctx, "closetland_terrain_check"); local fg = H.safe_id('json_flag', "WALL"); return p ~= nil and fg ~= nil and services.gameplay.environment.terrain_has_flag(p, fg) end)())) then for _, _eid in ipairs({ "EOC_BOMBASTIC_PERKS_CLOSET_STORAGE_DIFFERENT_PATHS_OF_CLOSETLAND_WALL_CHECK" }) do H.run_eoc(_eid, ctx) end; if false then break end end end end end
        do local _o = (H.char_snap(H.u(ctx)) or {}).creature.position; if _o then local _pg = services.world.points_nearby(_o, { max_radius = math.floor(1) }); for _, _pt in ipairs((_pg and _pg.items) or {}) do local _p = _pt.position; H.set_var("context", nil, ctx, "closetland_terrain_check", _p); if ((((function() local p = H.get_tripoint_var("context", nil, ctx, "closetland_terrain_check"); local fg = H.safe_id('json_flag', "BLOCKSDOOR"); return p ~= nil and fg ~= nil and services.gameplay.environment.furniture_has_flag(p, fg) end)()) or ((function() local p = H.get_tripoint_var("context", nil, ctx, "closetland_terrain_check"); if not p then return false end; local f = services.gameplay.environment.furniture_id(p); return f and f.value == "f_safe_l" end)()) or ((function() local p = H.get_tripoint_var("context", nil, ctx, "closetland_terrain_check"); if not p then return false end; local f = services.gameplay.environment.furniture_id(p); return f and f.value == "f_safe_c" end)()))) then for _, _eid in ipairs({ "EOC_BOMBASTIC_PERKS_CLOSET_STORAGE_DIFFERENT_PATHS_OF_CLOSETLAND_FURNITURE_CHECK" }) do H.run_eoc(_eid, ctx) end; if false then break end end end end end
        do local _o = (H.char_snap(H.u(ctx)) or {}).creature.position; if _o then local _pg = services.world.points_nearby(_o, { max_radius = math.floor(1) }); for _, _pt in ipairs((_pg and _pg.items) or {}) do local _p = _pt.position; H.set_var("context", nil, ctx, "closetland_terrain_check", _p); if ((((function() local p = H.get_tripoint_var("context", nil, ctx, "closetland_terrain_check"); local fg = H.safe_id('json_flag', "DOOR"); return p ~= nil and fg ~= nil and services.gameplay.environment.terrain_has_flag(p, fg) end)()) or ((function() local p = H.get_tripoint_var("context", nil, ctx, "closetland_terrain_check"); local fg = H.safe_id('json_flag', "LOCKED"); return p ~= nil and fg ~= nil and services.gameplay.environment.terrain_has_flag(p, fg) end)()))) then for _, _eid in ipairs({ "EOC_BOMBASTIC_PERKS_CLOSET_STORAGE_DIFFERENT_PATHS_OF_CLOSETLAND_DOOR_CHECK" }) do H.run_eoc(_eid, ctx) end; if true then break end end end end end
        H.eoc_loc_var(H.u(ctx), ctx, "context", "check_terrain", nil, nil, nil, nil, nil, false, true, {  }, {  })
        if ((((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) or ((function() local p = H.get_tripoint_var("context", nil, ctx, "check_terrain"); if not p then return false end; local f = services.gameplay.environment.furniture_id(p); return f and f.value == "f_toilet" end)()) or ((function() local p = H.get_tripoint_var("context", nil, ctx, "check_terrain"); if not p then return false end; local t = services.gameplay.environment.terrain_id(p); return t and t.value == "t_stairs_up" end)()) or ((function() local p = H.get_tripoint_var("context", nil, ctx, "check_terrain"); if not p then return false end; local t = services.gameplay.environment.terrain_id(p); return t and t.value == "t_stairs_down" end)())) then
            H.set_var("actor", H.u(ctx), ctx, "closetland_perk_nearby_walls", 0)
        end
        if ((H.var_num(H.u(ctx), "closetland_perk_nearby_walls") >= 5) and ((H.var_num(H.u(ctx), "closetland_perk_nearby_walls") + H.var_num(H.u(ctx), "closetland_perk_nearby_furniture")) == 7) and (H.var_num(H.u(ctx), "closetland_perk_nearby_doors") == 1)) then
            if (((H.var_str("context", nil, ctx, "closetland_paths_last_dimension", "")) == ("default"))) then
                H.run_eoc("EOC_BOMBASTIC_PERKS_CLOSET_STORAGE_DIFFERENT_PATHS_OF_CLOSETLAND_MEMORIZE", ctx, nil, nil, nil)
            else
                services.messages.add(ctx:expand_text(services.translate("You can't memorize this closet, for some reason.")), "neutral")
            end
        else
            services.messages.add(ctx:expand_text(services.translate("You're not in a closet, and there's no path here to remember.")), "neutral")
        end
        return true
    else
        H.run_eoc("EOC_BOMBASTIC_PERKS_CLOSET_STORAGE_DIFFERENT_PATHS_OF_CLOSETLAND_TRAVEL", ctx, nil, nil, nil)
        return false
    end
    end
    EOC["EOC_BOMBASTIC_PERKS_CLOSET_STORAGE_DIFFERENT_PATHS_OF_CLOSETLAND_MEMORIZE"] = function(ctx)
    do
        local _choices, _targets = {}, {}
        do local _en = (E.cond["EOC_BOMBASTIC_PERKS_CLOSET_STORAGE_DIFFERENT_PATHS_OF_CLOSETLAND_SELECTOR_01"] == nil or E.cond["EOC_BOMBASTIC_PERKS_CLOSET_STORAGE_DIFFERENT_PATHS_OF_CLOSETLAND_SELECTOR_01"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(1), label = ctx:expand_text(services.translate("Remember Closetland Path: <u_val:perk_closetland_paths_destination_name_1>")), description = ctx:expand_text(services.translate("Remember this Closetpath.")), enabled = _en, hotkey = "1" }); _targets[tostring(1)] = "EOC_BOMBASTIC_PERKS_CLOSET_STORAGE_DIFFERENT_PATHS_OF_CLOSETLAND_SELECTOR_01" end end
        do local _en = (E.cond["EOC_BOMBASTIC_PERKS_CLOSET_STORAGE_DIFFERENT_PATHS_OF_CLOSETLAND_SELECTOR_02"] == nil or E.cond["EOC_BOMBASTIC_PERKS_CLOSET_STORAGE_DIFFERENT_PATHS_OF_CLOSETLAND_SELECTOR_02"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(2), label = ctx:expand_text(services.translate("Remember Closetland Path: <u_val:perk_closetland_paths_destination_name_2>")), description = ctx:expand_text(services.translate("Remember this Closetpath.")), enabled = _en, hotkey = "2" }); _targets[tostring(2)] = "EOC_BOMBASTIC_PERKS_CLOSET_STORAGE_DIFFERENT_PATHS_OF_CLOSETLAND_SELECTOR_02" end end
        do local _en = (E.cond["EOC_BOMBASTIC_PERKS_CLOSET_STORAGE_DIFFERENT_PATHS_OF_CLOSETLAND_SELECTOR_03"] == nil or E.cond["EOC_BOMBASTIC_PERKS_CLOSET_STORAGE_DIFFERENT_PATHS_OF_CLOSETLAND_SELECTOR_03"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(3), label = ctx:expand_text(services.translate("Remember Closetland Path: <u_val:perk_closetland_paths_destination_name_3>")), description = ctx:expand_text(services.translate("Remember this Closetpath.")), enabled = _en, hotkey = "3" }); _targets[tostring(3)] = "EOC_BOMBASTIC_PERKS_CLOSET_STORAGE_DIFFERENT_PATHS_OF_CLOSETLAND_SELECTOR_03" end end
        if #_choices > 0 then
            local _res = services.interaction.choose(_choices, { title = ctx:expand_text(services.translate("Select an option")), allow_cancel = true })
            if _res and _res.accepted and _res.id and _targets[_res.id] then
                H.run_eoc(_targets[_res.id], ctx)
            end
        end
    end
    return true
    end
    EOC["EOC_BOMBASTIC_PERKS_CLOSET_STORAGE_DIFFERENT_PATHS_OF_CLOSETLAND_SELECTOR_01"] = function(ctx)
    do local _ir = services.interaction.input_text(ctx:expand_text(services.translate("Input a destination name:")), { default = ctx:expand_text(services.translate("")) }); if _ir and _ir.accepted then H.set_var("actor", H.u(ctx), ctx, "perk_closetland_paths_destination_name_1", _ir.value) end end
    H.eoc_loc_var(H.u(ctx), ctx, "actor", "perk_closetland_paths_destination_1", nil, nil, nil, { min_radius = math.floor(0), max_radius = math.floor(0) }, nil, false, true, {  }, {  })
    H.set_var("actor", H.u(ctx), ctx, "perk_closetland_paths_destination_dimension_1", services.gameplay.environment.dimension())
    return true
    end
    EOC["EOC_BOMBASTIC_PERKS_CLOSET_STORAGE_DIFFERENT_PATHS_OF_CLOSETLAND_SELECTOR_02"] = function(ctx)
    do local _ir = services.interaction.input_text(ctx:expand_text(services.translate("Input a destination name:")), { default = ctx:expand_text(services.translate("")) }); if _ir and _ir.accepted then H.set_var("actor", H.u(ctx), ctx, "perk_closetland_paths_destination_name_2", _ir.value) end end
    H.eoc_loc_var(H.u(ctx), ctx, "actor", "perk_closetland_paths_destination_2", nil, nil, nil, { min_radius = math.floor(0), max_radius = math.floor(0) }, nil, false, true, {  }, {  })
    H.set_var("actor", H.u(ctx), ctx, "perk_closetland_paths_destination_dimension_2", services.gameplay.environment.dimension())
    return true
    end
    EOC["EOC_BOMBASTIC_PERKS_CLOSET_STORAGE_DIFFERENT_PATHS_OF_CLOSETLAND_SELECTOR_03"] = function(ctx)
    do local _ir = services.interaction.input_text(ctx:expand_text(services.translate("Input a destination name:")), { default = ctx:expand_text(services.translate("")) }); if _ir and _ir.accepted then H.set_var("actor", H.u(ctx), ctx, "perk_closetland_paths_destination_name_3", _ir.value) end end
    H.eoc_loc_var(H.u(ctx), ctx, "actor", "perk_closetland_paths_destination_3", nil, nil, nil, { min_radius = math.floor(0), max_radius = math.floor(0) }, nil, false, true, {  }, {  })
    H.set_var("actor", H.u(ctx), ctx, "perk_closetland_paths_destination_dimension_3", services.gameplay.environment.dimension())
    return true
    end
    EOC["EOC_BOMBASTIC_PERKS_CLOSET_STORAGE_DIFFERENT_PATHS_OF_CLOSETLAND_TRAVEL"] = function(ctx)
    do
        local _choices, _targets = {}, {}
        do local _en = (E.cond["EOC_BOMBASTIC_PERKS_CLOSET_STORAGE_DIFFERENT_PATHS_OF_CLOSETLAND_TRAVEL_SELECTOR_01"] == nil or E.cond["EOC_BOMBASTIC_PERKS_CLOSET_STORAGE_DIFFERENT_PATHS_OF_CLOSETLAND_TRAVEL_SELECTOR_01"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(1), label = ctx:expand_text(services.translate("Travel Closetland Path: <u_val:perk_closetland_paths_destination_name_1>")), description = ctx:expand_text(services.translate("Travel this Closetpath.")), enabled = _en, hotkey = "1" }); _targets[tostring(1)] = "EOC_BOMBASTIC_PERKS_CLOSET_STORAGE_DIFFERENT_PATHS_OF_CLOSETLAND_TRAVEL_SELECTOR_01" end end
        do local _en = (E.cond["EOC_BOMBASTIC_PERKS_CLOSET_STORAGE_DIFFERENT_PATHS_OF_CLOSETLAND_TRAVEL_SELECTOR_02"] == nil or E.cond["EOC_BOMBASTIC_PERKS_CLOSET_STORAGE_DIFFERENT_PATHS_OF_CLOSETLAND_TRAVEL_SELECTOR_02"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(2), label = ctx:expand_text(services.translate("Travel Closetland Path: <u_val:perk_closetland_paths_destination_name_2>")), description = ctx:expand_text(services.translate("Travel this Closetpath.")), enabled = _en, hotkey = "2" }); _targets[tostring(2)] = "EOC_BOMBASTIC_PERKS_CLOSET_STORAGE_DIFFERENT_PATHS_OF_CLOSETLAND_TRAVEL_SELECTOR_02" end end
        do local _en = (E.cond["EOC_BOMBASTIC_PERKS_CLOSET_STORAGE_DIFFERENT_PATHS_OF_CLOSETLAND_TRAVEL_SELECTOR_03"] == nil or E.cond["EOC_BOMBASTIC_PERKS_CLOSET_STORAGE_DIFFERENT_PATHS_OF_CLOSETLAND_TRAVEL_SELECTOR_03"](ctx) == true); if _en or (not true) then table.insert(_choices, { id = tostring(3), label = ctx:expand_text(services.translate("Travel Closetland Path: <u_val:perk_closetland_paths_destination_name_3>")), description = ctx:expand_text(services.translate("Travel this Closetpath.")), enabled = _en, hotkey = "3" }); _targets[tostring(3)] = "EOC_BOMBASTIC_PERKS_CLOSET_STORAGE_DIFFERENT_PATHS_OF_CLOSETLAND_TRAVEL_SELECTOR_03" end end
        if #_choices > 0 then
            local _res = services.interaction.choose(_choices, { title = ctx:expand_text(services.translate("Select an option")), allow_cancel = true })
            if _res and _res.accepted and _res.id and _targets[_res.id] then
                H.run_eoc(_targets[_res.id], ctx)
            end
        end
    end
    return true
    end
    COND["EOC_BOMBASTIC_PERKS_CLOSET_STORAGE_DIFFERENT_PATHS_OF_CLOSETLAND_TRAVEL_SELECTOR_01"] = function(ctx)
        return (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "perk_closetland_paths_destination_1") and 1 or 0))) == true
    end
    EOC["EOC_BOMBASTIC_PERKS_CLOSET_STORAGE_DIFFERENT_PATHS_OF_CLOSETLAND_TRAVEL_SELECTOR_01"] = function(ctx)
    if (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "perk_closetland_paths_destination_1") and 1 or 0))) then
        H.eoc_add_effect(H.u(ctx), "blind", 0, nil, nil, nil)
        do local _dr = services.relocation.travel_to_dimension(H.var_str("actor", H.u(ctx), ctx, "perk_closetland_paths_destination_dimension_1", ""), nil)
        end
        do local _p = H.get_tripoint_var("actor", H.u(ctx), ctx, "perk_closetland_paths_destination_1"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, nil) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, nil) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, nil) end end end
        do local _eg = H.safe_id('effect', "blind"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "effect_perk_closetland_sleepiness"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _t = math.max(1, math.floor(0)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_BOMBASTIC_PERKS_CLOSET_STORAGE_TRAVEL_TO_CLOSETLAND_DEACTIVATE_FUTURE"), nil) end end
        return true
    end
    return false
    end
    COND["EOC_BOMBASTIC_PERKS_CLOSET_STORAGE_DIFFERENT_PATHS_OF_CLOSETLAND_TRAVEL_SELECTOR_02"] = function(ctx)
        return (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "perk_closetland_paths_destination_2") and 1 or 0))) == true
    end
    EOC["EOC_BOMBASTIC_PERKS_CLOSET_STORAGE_DIFFERENT_PATHS_OF_CLOSETLAND_TRAVEL_SELECTOR_02"] = function(ctx)
    if (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "perk_closetland_paths_destination_2") and 1 or 0))) then
        H.eoc_add_effect(H.u(ctx), "blind", 0, nil, nil, nil)
        do local _dr = services.relocation.travel_to_dimension(H.var_str("actor", H.u(ctx), ctx, "perk_closetland_paths_destination_dimension_2", ""), nil)
        end
        do local _p = H.get_tripoint_var("actor", H.u(ctx), ctx, "perk_closetland_paths_destination_2"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, nil) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, nil) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, nil) end end end
        do local _eg = H.safe_id('effect', "blind"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "effect_perk_closetland_sleepiness"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _t = math.max(1, math.floor(0)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_BOMBASTIC_PERKS_CLOSET_STORAGE_TRAVEL_TO_CLOSETLAND_DEACTIVATE_FUTURE"), nil) end end
        return true
    end
    return false
    end
    COND["EOC_BOMBASTIC_PERKS_CLOSET_STORAGE_DIFFERENT_PATHS_OF_CLOSETLAND_TRAVEL_SELECTOR_03"] = function(ctx)
        return (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "perk_closetland_paths_destination_3") and 1 or 0))) == true
    end
    EOC["EOC_BOMBASTIC_PERKS_CLOSET_STORAGE_DIFFERENT_PATHS_OF_CLOSETLAND_TRAVEL_SELECTOR_03"] = function(ctx)
    if (H.truthy((H.var_exists("actor", H.u(ctx), ctx, "perk_closetland_paths_destination_3") and 1 or 0))) then
        H.eoc_add_effect(H.u(ctx), "blind", 0, nil, nil, nil)
        do local _dr = services.relocation.travel_to_dimension(H.var_str("actor", H.u(ctx), ctx, "perk_closetland_paths_destination_dimension_3", ""), nil)
        end
        do local _p = H.get_tripoint_var("actor", H.u(ctx), ctx, "perk_closetland_paths_destination_3"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, nil) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, nil) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, nil) end end end
        do local _eg = H.safe_id('effect', "blind"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "effect_perk_closetland_sleepiness"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _t = math.max(1, math.floor(0)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_BOMBASTIC_PERKS_CLOSET_STORAGE_TRAVEL_TO_CLOSETLAND_DEACTIVATE_FUTURE"), nil) end end
        return true
    end
    return false
    end
    EOC["eoc_perk_dice_addition_damage"] = function(ctx)
    H.set_var("context", nil, ctx, "dice_side_nums", 0)
    if (((H.var_str("context", nil, ctx, "ammo", "")) == ("plastic_six_dice"))) then
        H.set_var("context", nil, ctx, "dice_side_nums", 6)
    end
    if (((H.var_str("context", nil, ctx, "ammo", "")) == ("RPG_die")) or ((H.var_str("context", nil, ctx, "ammo", "")) == ("metal_RPG_die")) or (("RPG_die") == ("metal_RPG_die"))) then
        H.set_var("context", nil, ctx, "dice_side_nums", ((services.random.native_int(0, H.round_half_away(4)) + 2) * 2))
    end
    H.set_var("context", nil, ctx, "dice_result", (services.random.native_int(0, H.round_half_away(((ctx:get_number("dice_side_nums") or 0) - 1))) + 1))
    services.messages.add(ctx:expand_text(services.translate("Damage dice result: 1D<context_val:dice_side_nums> = <context_val:dice_result>")), "neutral")
    do local _g, _a = H.safe_id('damage_type', "pure"), H.npc(ctx); if _g and _a then services.creatures.damage(_a, _g, (ctx:get_number("dice_result") or 0), nil) end end
    return true
    end
    COND["event_perk_dice_addition_damage_ranged_attacks_character"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "perk_dice_addition_damage") == 1))) == true
    end
    EOC["event_perk_dice_addition_damage_ranged_attacks_character"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "perk_dice_addition_damage") == 1))) then
        H.run_eoc("eoc_perk_dice_addition_damage", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["event_perk_dice_addition_damage_ranged_attacks_monster"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "perk_dice_addition_damage") == 1))) == true
    end
    EOC["event_perk_dice_addition_damage_ranged_attacks_monster"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "perk_dice_addition_damage") == 1))) then
        H.run_eoc("eoc_perk_dice_addition_damage", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_perk_duck_and_weave_2"] = function(ctx)
        return ((H.var_num(H.u(ctx), "duck_and_weave_counter") >= 3)) == true
    end
    EOC["EOC_perk_duck_and_weave_2"] = function(ctx)
    if ((H.var_num(H.u(ctx), "duck_and_weave_counter") >= 3)) then
        H.eoc_add_effect(H.u(ctx), "effect_perk_duck_and_weave", 1, nil, nil, nil)
        return true
    else
        H.set_var("actor", H.u(ctx), ctx, "duck_and_weave_counter", (H.var_num(H.u(ctx), "duck_and_weave_counter")) + (1))
        return false
    end
    end
    COND["EOC_perk_duck_and_weave"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "perk_duck_and_weave") == 1) and ((("run") == (H.var_str("context", nil, ctx, "movement_mode", "")))))) == true
    end
    EOC["EOC_perk_duck_and_weave"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "perk_duck_and_weave") == 1) and ((("run") == (H.var_str("context", nil, ctx, "movement_mode", "")))))) then
        H.run_eoc("EOC_perk_duck_and_weave_2", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_perk_duck_and_weave_reset"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "perk_duck_and_weave") == 1) and (((("walk") == (H.var_str("context", nil, ctx, "movement_mode", "")))) or ((("crouch") == (H.var_str("context", nil, ctx, "movement_mode", "")))) or ((("prone") == (H.var_str("context", nil, ctx, "movement_mode", ""))))))) == true
    end
    EOC["EOC_perk_duck_and_weave_reset"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "perk_duck_and_weave") == 1) and (((("walk") == (H.var_str("context", nil, ctx, "movement_mode", "")))) or ((("crouch") == (H.var_str("context", nil, ctx, "movement_mode", "")))) or ((("prone") == (H.var_str("context", nil, ctx, "movement_mode", ""))))))) then
        H.set_var("actor", H.u(ctx), ctx, "duck_and_weave_counter", 0)
        do local _eg = H.safe_id('effect', "effect_perk_duck_and_weave"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        return true
    end
    return false
    end
    COND["EOC_NETHER_ATTENTION_NIGHTMARES"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "perk_early_to_rise") == 1) and ((((services.turn() % 86400) / 3600) >= 4) or (((services.turn() % 86400) / 3600) <= 7)))) == true
    end
    EOC["EOC_NETHER_ATTENTION_NIGHTMARES"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "perk_early_to_rise") == 1) and ((((services.turn() % 86400) / 3600) >= 4) or (((services.turn() % 86400) / 3600) <= 7)))) then
        do local _g = H.safe_id('morale', "morale_perk_early_to_rise"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(20), math.floor(20), { duration = services.time.duration_from_turns(math.floor(21600)), decay_start = services.time.duration_from_turns(math.floor(10800)) }) end end
        return true
    end
    return false
    end
    COND["EOC_empath"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "perk_empath") == 1))) == true
    end
    EOC["EOC_empath"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "perk_empath") == 1))) then
        H.run_eoc("EOC_empath_zombie", ctx, nil, nil, nil)
        H.run_eoc("EOC_empath_animal", ctx, nil, nil, nil)
        H.run_eoc("EOC_empath_nether", ctx, nil, nil, nil)
        H.run_eoc("EOC_empath_fungus", ctx, nil, nil, nil)
        H.run_eoc("EOC_empath_insect", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_empath_zombie"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "perk_empath") == 1) and ((("zombie") == (services.registry.monster_default_faction(tostring(H.var_str("context", nil, ctx, "victim_type", "") or ''))))))) == true
    end
    EOC["EOC_empath_zombie"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "perk_empath") == 1) and ((("zombie") == (services.registry.monster_default_faction(tostring(H.var_str("context", nil, ctx, "victim_type", "") or ''))))))) then
        H.eoc_add_effect(H.u(ctx), "effect_zombie", 30, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_empath_animal"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "perk_empath") == 1) and ((("animal") == (services.registry.monster_default_faction(tostring(H.var_str("context", nil, ctx, "victim_type", "") or ''))))))) == true
    end
    EOC["EOC_empath_animal"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "perk_empath") == 1) and ((("animal") == (services.registry.monster_default_faction(tostring(H.var_str("context", nil, ctx, "victim_type", "") or ''))))))) then
        H.eoc_add_effect(H.u(ctx), "effect_animal", 30, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_empath_nether"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "perk_empath") == 1) and ((("nether") == (services.registry.monster_default_faction(tostring(H.var_str("context", nil, ctx, "victim_type", "") or ''))))))) == true
    end
    EOC["EOC_empath_nether"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "perk_empath") == 1) and ((("nether") == (services.registry.monster_default_faction(tostring(H.var_str("context", nil, ctx, "victim_type", "") or ''))))))) then
        H.eoc_add_effect(H.u(ctx), "effect_nether", 30, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_empath_fungus"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "perk_empath") == 1) and ((("fungus") == (services.registry.monster_default_faction(tostring(H.var_str("context", nil, ctx, "victim_type", "") or ''))))))) == true
    end
    EOC["EOC_empath_fungus"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "perk_empath") == 1) and ((("fungus") == (services.registry.monster_default_faction(tostring(H.var_str("context", nil, ctx, "victim_type", "") or ''))))))) then
        H.eoc_add_effect(H.u(ctx), "effect_fungus", 30, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_empath_insect"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "perk_empath") == 1) and ((("insect") == (services.registry.monster_default_faction(tostring(H.var_str("context", nil, ctx, "victim_type", "") or ''))))))) == true
    end
    EOC["EOC_empath_insect"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "perk_empath") == 1) and ((("insect") == (services.registry.monster_default_faction(tostring(H.var_str("context", nil, ctx, "victim_type", "") or ''))))))) then
        H.eoc_add_effect(H.u(ctx), "effect_insect", 30, nil, nil, nil)
        return true
    end
    return false
    end
end
