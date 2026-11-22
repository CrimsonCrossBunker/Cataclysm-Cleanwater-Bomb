local ccb = require("ccb")
local services = ccb.services
return function(E, H)
    local EOC = E.run
    local COND = E.cond
    COND["EOC_ETHEREAL_WINGS_INITIATE"] = function(ctx)
        return ((not ((H.char_has_trait(H.u(ctx), "ethereal_wings") == 1)))) == true
    end
    EOC["EOC_ETHEREAL_WINGS_INITIATE"] = function(ctx)
    if ((not ((H.char_has_trait(H.u(ctx), "ethereal_wings") == 1)))) then
        services.messages.add(ctx:expand_text(services.translate("<color_white>Ethereal</color> wings grow from your back.")), "good")
        do local _g = H.safe_id('mutation', "ethereal_wings"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        do local _t = math.max(1, math.floor(((H.char_spell_level(H.u(ctx), "spell_ethereal_wings") + 1) * 500))); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_ETHEREAL_WINGS_CONTINUE"), nil) end end
        return true
    else
        H.lose_trait(H.u(ctx), "ethereal_wings")
        services.messages.add(ctx:expand_text(services.translate("The wings behind you fade out of existence.")), "neutral")
        return false
    end
    end
    COND["EOC_ETHEREAL_WINGS_CONTINUE"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "ethereal_wings") == 1) and (H.char_mana(H.u(ctx), "current") >= 200))) == true
    end
    EOC["EOC_ETHEREAL_WINGS_CONTINUE"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "ethereal_wings") == 1) and (H.char_mana(H.u(ctx), "current") >= 200))) then
        local _a96 = H.u(ctx)
        if _a96 then services.spells.set_mana_raw(_a96, math.floor((H.char_mana(_a96, "current")) - (200))) end
        services.messages.add(ctx:expand_text(services.translate("The wings behind you grow slightly more transparent, but they quickly revert back to normal.")), "good")
        do local _t = math.max(1, math.floor(((H.char_spell_level(H.u(ctx), "spell_ethereal_wings") + 1) * 500))); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_ETHEREAL_WINGS_CONTINUE"), nil) end end
        do local _a, _sp = H.u(ctx), "spell_ethereal_wings"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = ((((function() local _g = H.safe_id('spell', "spell_ethereal_wings"); return (_g and services.spells.experience_for_level(_g, math.floor((H.char_spell_level(H.u(ctx), "spell_ethereal_wings") + 1)))) or 0 end)()) - ((function() local _g = H.safe_id('spell', "spell_ethereal_wings"); return (_g and services.spells.experience_for_level(_g, math.floor(H.char_spell_level(H.u(ctx), "spell_ethereal_wings")))) or 0 end)())) / H._jm_spell_train_factor(ctx, 200)); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        return true
    else
        H.lose_trait(H.u(ctx), "ethereal_wings")
        services.messages.add(ctx:expand_text(services.translate("The wings behind you fade out of existence.")), "neutral")
        return false
    end
    end
    COND["EOC_KARMA_ARMS_INITIATE"] = function(ctx)
        return ((not ((H.char_has_trait(H.u(ctx), "karma_arms") == 1)))) == true
    end
    EOC["EOC_KARMA_ARMS_INITIATE"] = function(ctx)
    if ((not ((H.char_has_trait(H.u(ctx), "karma_arms") == 1)))) then
        services.messages.add(ctx:expand_text(services.translate("Ethereal, transparent arms appear behind your shoulders and <color_cyan>glow</color>.")), "good")
        do local _g = H.safe_id('mutation', "karma_arms"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        do local _t = math.max(1, math.floor(((H.char_spell_level(H.u(ctx), "spell_karma_arms") + 1) * 500))); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_KARMA_ARMS_CONTINUE"), nil) end end
        return true
    else
        H.set_char_hp(H.u(ctx), "karma_arm_up_r", 150, "+=")
        H.set_char_hp(H.u(ctx), "karma_arm_up_l", 150, "+=")
        H.set_char_hp(H.u(ctx), "karma_arm_lw_r", 150, "+=")
        H.set_char_hp(H.u(ctx), "karma_arm_lw_l", 150, "+=")
        do local _eg = H.safe_id('effect', "bleed"); local _bp = ("karma_arm_up_r" ~= nil) and H.safe_id('body_part', "karma_arm_up_r") or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "bleed"); local _bp = ("karma_arm_up_l" ~= nil) and H.safe_id('body_part', "karma_arm_up_l") or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "bleed"); local _bp = ("karma_arm_lw_r" ~= nil) and H.safe_id('body_part', "karma_arm_lw_r") or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "bleed"); local _bp = ("karma_arm_lw_l" ~= nil) and H.safe_id('body_part', "karma_arm_lw_l") or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "infected"); local _bp = ("karma_arm_up_r" ~= nil) and H.safe_id('body_part', "karma_arm_up_r") or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "infected"); local _bp = ("karma_arm_up_l" ~= nil) and H.safe_id('body_part', "karma_arm_up_l") or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "infected"); local _bp = ("karma_arm_lw_r" ~= nil) and H.safe_id('body_part', "karma_arm_lw_r") or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "infected"); local _bp = ("karma_arm_lw_l" ~= nil) and H.safe_id('body_part', "karma_arm_lw_l") or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "bite"); local _bp = ("karma_arm_up_r" ~= nil) and H.safe_id('body_part', "karma_arm_up_r") or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "bite"); local _bp = ("karma_arm_up_l" ~= nil) and H.safe_id('body_part', "karma_arm_up_l") or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "bite"); local _bp = ("karma_arm_lw_r" ~= nil) and H.safe_id('body_part', "karma_arm_lw_r") or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _eg = H.safe_id('effect', "bite"); local _bp = ("karma_arm_lw_l" ~= nil) and H.safe_id('body_part', "karma_arm_lw_l") or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        H.lose_trait(H.u(ctx), "karma_arms")
        services.messages.add(ctx:expand_text(services.translate("The cyan arms grow dim and finally disappear.")), "neutral")
        return false
    end
    end
    COND["EOC_KARMA_ARMS_CONTINUE"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "karma_arms") == 1) and (H.char_mana(H.u(ctx), "current") >= 200))) == true
    end
    EOC["EOC_KARMA_ARMS_CONTINUE"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "karma_arms") == 1) and (H.char_mana(H.u(ctx), "current") >= 200))) then
        local _a97 = H.u(ctx)
        if _a97 then services.spells.set_mana_raw(_a97, math.floor((H.char_mana(_a97, "current")) - (200))) end
        services.messages.add(ctx:expand_text(services.translate("The floating arms behind you slightly flicker, but they soon resume their steady glow.")), "good")
        do local _t = math.max(1, math.floor(((H.char_spell_level(H.u(ctx), "spell_karma_arms") + 1) * 500))); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_KARMA_ARMS_CONTINUE"), nil) end end
        do local _a, _sp = H.u(ctx), "spell_karma_arms"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = ((((function() local _g = H.safe_id('spell', "spell_karma_arms"); return (_g and services.spells.experience_for_level(_g, math.floor((H.char_spell_level(H.u(ctx), "spell_karma_arms") + 1)))) or 0 end)()) - ((function() local _g = H.safe_id('spell', "spell_karma_arms"); return (_g and services.spells.experience_for_level(_g, math.floor(H.char_spell_level(H.u(ctx), "spell_karma_arms")))) or 0 end)())) / H._jm_spell_train_factor(ctx, 200)); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        return true
    else
        H.lose_trait(H.u(ctx), "karma_arms")
        services.messages.add(ctx:expand_text(services.translate("The cyan arms grow dim and finally disappear.")), "neutral")
        return false
    end
    end
    COND["EOC_DEVIL_TAIL_INITIATE"] = function(ctx)
        return ((not ((H.char_has_trait(H.u(ctx), "devil_tail") == 1)))) == true
    end
    EOC["EOC_DEVIL_TAIL_INITIATE"] = function(ctx)
    if ((not ((H.char_has_trait(H.u(ctx), "devil_tail") == 1)))) then
        services.messages.add(ctx:expand_text(services.translate("You feel like your spine stretched enormously.")), "good")
        do local _g = H.safe_id('mutation', "devil_tail"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        do local _t = math.max(1, math.floor(((H.char_spell_level(H.u(ctx), "spell_devil_tail") + 1) * 900))); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_DEVIL_TAIL_CONTINUE"), nil) end end
        return true
    else
        H.lose_trait(H.u(ctx), "devil_tail")
        services.messages.add(ctx:expand_text(services.translate("Your devil tail fades away.")), "neutral")
        return false
    end
    end
    COND["EOC_DEVIL_TAIL_CONTINUE"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "devil_tail") == 1) and (H.char_mana(H.u(ctx), "current") >= 100))) == true
    end
    EOC["EOC_DEVIL_TAIL_CONTINUE"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "devil_tail") == 1) and (H.char_mana(H.u(ctx), "current") >= 100))) then
        local _a98 = H.u(ctx)
        if _a98 then services.spells.set_mana_raw(_a98, math.floor((H.char_mana(_a98, "current")) - (100))) end
        services.messages.add(ctx:expand_text(services.translate("Your devilish tail stretches and twists playfully.")), "good")
        do local _t = math.max(1, math.floor(((H.char_spell_level(H.u(ctx), "spell_devil_tail") + 1) * 900))); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_DEVIL_TAIL_CONTINUE"), nil) end end
        do local _a, _sp = H.u(ctx), "spell_devil_tail"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = ((((function() local _g = H.safe_id('spell', "spell_devil_tail"); return (_g and services.spells.experience_for_level(_g, math.floor((H.char_spell_level(H.u(ctx), "spell_devil_tail") + 1)))) or 0 end)()) - ((function() local _g = H.safe_id('spell', "spell_devil_tail"); return (_g and services.spells.experience_for_level(_g, math.floor(H.char_spell_level(H.u(ctx), "spell_devil_tail")))) or 0 end)())) / H._jm_spell_train_factor(ctx, 100)); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        return true
    else
        H.lose_trait(H.u(ctx), "devil_tail")
        services.messages.add(ctx:expand_text(services.translate("Your devil tail fades away.")), "neutral")
        return false
    end
    end
    COND["EOC_STALKER_EYES_INITIATE"] = function(ctx)
        return ((not ((H.char_has_trait(H.u(ctx), "stalker_eyes") == 1)))) == true
    end
    EOC["EOC_STALKER_EYES_INITIATE"] = function(ctx)
    if ((not ((H.char_has_trait(H.u(ctx), "stalker_eyes") == 1)))) then
        services.messages.add(ctx:expand_text(services.translate("Your vision grows dark for a moment, but a second later a whole new world is revealed under your eyes.")), "good")
        do local _g = H.safe_id('mutation', "stalker_eyes"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        do local _t = math.max(1, math.floor(((H.char_spell_level(H.u(ctx), "spell_stalker_eyes") + 1) * 1300))); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_STALKER_EYES_CONTINUE"), nil) end end
        return true
    else
        H.lose_trait(H.u(ctx), "stalker_eyes")
        services.messages.add(ctx:expand_text(services.translate("The great new world visible to your eyes disappears.")), "neutral")
        return false
    end
    end
    COND["EOC_STALKER_EYES_CONTINUE"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "stalker_eyes") == 1) and (H.char_mana(H.u(ctx), "current") >= 200))) == true
    end
    EOC["EOC_STALKER_EYES_CONTINUE"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "stalker_eyes") == 1) and (H.char_mana(H.u(ctx), "current") >= 200))) then
        local _a99 = H.u(ctx)
        if _a99 then services.spells.set_mana_raw(_a99, math.floor((H.char_mana(_a99, "current")) - (200))) end
        services.messages.add(ctx:expand_text(services.translate("Your sight darkens for a second, but it quickly turns back.")), "good")
        do local _t = math.max(1, math.floor(((H.char_spell_level(H.u(ctx), "spell_stalker_eyes") + 1) * 1300))); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_STALKER_EYES_CONTINUE"), nil) end end
        do local _a, _sp = H.u(ctx), "spell_stalker_eyes"; local _g = H.safe_id('spell', _sp); if _a and _g then local _cur = H.char_spell_exp(_a, _sp); local _nxt = ((((function() local _g = H.safe_id('spell', "spell_stalker_eyes"); return (_g and services.spells.experience_for_level(_g, math.floor((H.char_spell_level(H.u(ctx), "spell_stalker_eyes") + 1)))) or 0 end)()) - ((function() local _g = H.safe_id('spell', "spell_stalker_eyes"); return (_g and services.spells.experience_for_level(_g, math.floor(H.char_spell_level(H.u(ctx), "spell_stalker_eyes")))) or 0 end)())) / H._jm_spell_train_factor(ctx, 200)); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.spells.set_experience(_a, _g, math.floor(_val + 0.5), true) end end
        return true
    else
        H.lose_trait(H.u(ctx), "stalker_eyes")
        services.messages.add(ctx:expand_text(services.translate("The great new world visible to your eyes disappears.")), "neutral")
        return false
    end
    end
    COND["EOC_LUCID_DREAM_START"] = function(ctx)
        return (((("effect_lucid_dream") == (H.var_str("context", nil, ctx, "effect", ""))))) == true
    end
    EOC["EOC_LUCID_DREAM_START"] = function(ctx)
    if (((("effect_lucid_dream") == (H.var_str("context", nil, ctx, "effect", ""))))) then
        H.eoc_loc_var(H.u(ctx), ctx, "actor", "lucid_dream_teleport", nil, nil, nil, { min_radius = math.floor(0), max_radius = math.floor(0) }, nil, false, true, {  }, {  })
        H.set_var("actor", H.u(ctx), ctx, "hp_before_lucid", (H.char_hp(H.u(ctx), "ALL", false) / 6))
        H.set_var("actor", H.u(ctx), ctx, "pain_before_lucid", (((H.char_snap(H.u(ctx)) or {}).creature or {}).pain or 0))
        H.set_var("actor", H.u(ctx), ctx, "kcal_before_lucid", (((H.char_snap(H.u(ctx)) or {}).needs or {}).stored_kcal or 0))
        H.set_var("actor", H.u(ctx), ctx, "thirst_before_lucid", (((H.char_snap(H.u(ctx)) or {}).needs or {}).thirst or 0))
        H.set_var("actor", H.u(ctx), ctx, "blood_before_lucid", H.char_vitamin(H.u(ctx), "blood"))
        H.set_var("actor", H.u(ctx), ctx, "redcells_before_lucid", H.char_vitamin(H.u(ctx), "redcells"))
        H.set_var("actor", H.u(ctx), ctx, "rad_before_lucid", (((services.needs.get(H.u(ctx)) or {}).value or {}).radiation or 0))
        do local _g = H.safe_id('mutation', "LUCID_DREAM"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        return true
    end
    return false
    end
    COND["EOC_LUCID_DREAM_END"] = function(ctx)
        return (((("effect_lucid_dream") == (H.var_str("context", nil, ctx, "effect", ""))))) == true
    end
    EOC["EOC_LUCID_DREAM_END"] = function(ctx)
    if (((("effect_lucid_dream") == (H.var_str("context", nil, ctx, "effect", ""))))) then
        ccb.presentation.notice(ctx:expand_text(services.translate("You wake up.")))
        services.activities.offer_interruption(ctx:expand_text(services.translate("You wake up.")))
        do local _p = H.get_tripoint_var("actor", H.u(ctx), ctx, "lucid_dream_teleport"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, nil) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, nil) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, nil) end end end
        H.set_char_hp(H.u(ctx), "ALL", H.var_num(H.u(ctx), "hp_before_lucid"), "=")
        local _a100 = H.u(ctx)
        if _a100 then services.characters.adjust(_a100, { pain = math.floor((H.var_num(H.u(ctx), "pain_before_lucid")) - (H.char_pain(_a100))) }) end
        do local _a = H.u(ctx); if _a then if "=" == '=' then services.needs.set_calories(_a, math.floor(H.var_num(H.u(ctx), "kcal_before_lucid") + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = H.var_num(H.u(ctx), "kcal_before_lucid"); local _d = ("=" == '+=') and _nxt or (("=" == '-=') and -_nxt or (("=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), ((H.global_var_num("true")) ~= 0)) end end end
        H.set_char_val_extra(H.u(ctx), "thirst", H.var_num(H.u(ctx), "thirst_before_lucid"), "=")
        do local _a, _v = H.u(ctx), "blood"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = H.var_num(H.u(ctx), "blood_before_lucid"); local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        do local _a, _v = H.u(ctx), "redcells"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = H.var_num(H.u(ctx), "redcells_before_lucid"); local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        H.set_char_val_extra(H.u(ctx), "rad", H.var_num(H.u(ctx), "rad_before_lucid"), "=")
        do local _eg = H.safe_id('effect', "bleed"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        H.lose_trait(H.u(ctx), "LUCID_DREAM")
        return true
    end
    return false
    end
    COND["EOC_LUCID_DREAM_SWITCH"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_lucid_dream"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_LUCID_DREAM_SWITCH"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_lucid_dream"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        H.run_eoc("EOC_LUCID_DREAM_FORCE_END", ctx, nil, nil, nil)
        return true
    else
        H.run_eoc("EOC_LUCID_DREAM_FORCE_START", ctx, nil, nil, nil)
        return false
    end
    end
    EOC["EOC_LUCID_DREAM_FORCE_END"] = function(ctx)
    do local _eg = H.safe_id('effect', "effect_lucid_dream"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
    return true
    end
    EOC["EOC_LUCID_DREAM_FORCE_START"] = function(ctx)
    H.eoc_add_effect(H.u(ctx), "effect_lucid_dream", ((H.char_spell_level(H.u(ctx), "dreamer_lucid_dreams") + 1) * 700), nil, nil, nil)
    return true
    end
    COND["EOC_LUCID_REBIRTH"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "effect_lucid_dream"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_LUCID_REBIRTH"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "effect_lucid_dream"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        do local _a, _v = H.u(ctx), "blood"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = H.var_num(H.u(ctx), "blood_before_lucid"); local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        if H.u(ctx) then services.characters.prevent_death(H.u(ctx)); if ctx.prevent_death_fn then ctx.prevent_death_fn() end end
        H.set_char_hp(H.u(ctx), "ALL", 1, "=")
        H.run_eoc("EOC_LUCID_DREAM_FORCE_END", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    EOC["EOC_RETURN_SUMMONS"] = function(ctx)
    H.eoc_loc_var(H.npc(ctx), ctx, "context", "pos_nearby", nil, nil, nil, { min_radius = math.floor(1), max_radius = math.floor(7), passable_only = true }, nil, false, true, {  }, {  })
    do local _p = H.get_tripoint_var("context", nil, ctx, "pos_nearby"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, nil) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, nil) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, nil) end end end
    return true
    end
    COND["EOC_ATTEMPT_HORSE_FAMILIAR"] = function(ctx)
        return ((H.char_vitamin(H.u(ctx), "human_blood_vitamin") >= 2400)) == true
    end
    EOC["EOC_ATTEMPT_HORSE_FAMILIAR"] = function(ctx)
    if ((H.char_vitamin(H.u(ctx), "human_blood_vitamin") >= 2400)) then
        H.eoc_cast_spell(H.u(ctx), "dhampir_horse_familiar_spell", false, nil)
        do local _a, _v = H.u(ctx), "human_blood_vitamin"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 2000; local _val = ("-=" == '=') and _nxt or (("-=" == '+=') and (_cur + _nxt) or (("-=" == '-=') and (_cur - _nxt) or (("-=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        services.messages.add(ctx:expand_text(services.translate("You feed your blood and will into this once docile horse, transforming it into a familiar worthy of a hunter of monsters and men.")), "info")
        return true
    else
        H.run_eoc("EOC_ATTEMPT_HORSE_FAMILIAR_FAIL_MESSAGE", ctx, nil, nil, nil)
        return false
    end
    end
    EOC["EOC_ATTEMPT_HORSE_FAMILIAR_FAIL_MESSAGE"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("You lack the excess blood needed, you must be engorged or even tick-like before you can attempt this.")), "bad")
    return true
    end
    COND["EOC_FEED_HORSE_FAMILIAR"] = function(ctx)
        return ((H.char_vitamin(H.u(ctx), "human_blood_vitamin") >= 1800)) == true
    end
    EOC["EOC_FEED_HORSE_FAMILIAR"] = function(ctx)
    if ((H.char_vitamin(H.u(ctx), "human_blood_vitamin") >= 1800)) then
        H.eoc_cast_spell(H.u(ctx), "dhampir_horse_familiar_spell", false, nil)
        do local _a, _v = H.u(ctx), "human_blood_vitamin"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = 1000; local _val = ("-=" == '=') and _nxt or (("-=" == '+=') and (_cur + _nxt) or (("-=" == '-=') and (_cur - _nxt) or (("-=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        services.messages.add(ctx:expand_text(services.translate("You feed your blood to this monstrous nightmare horse and it swallows the blood like an addict with their vice of choice after a forced avoidance.")), "info")
        return true
    else
        H.run_eoc("EOC_FEED_HORSE_FAMILIAR_FAIL_MESSAGE", ctx, nil, nil, nil)
        return false
    end
    end
    EOC["EOC_FEED_HORSE_FAMILIAR_FAIL_MESSAGE"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("You lack the excess blood needed.")), "bad")
    return true
    end
    COND["EOC_WEREWOLF_SUMMON_FOG"] = function(ctx)
        return ((H.global_var_num("magic_weather_dense_fog") ~= 1)) == true
    end
    EOC["EOC_WEREWOLF_SUMMON_FOG"] = function(ctx)
    if ((H.global_var_num("magic_weather_dense_fog") ~= 1)) then
        if (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) then
            services.messages.add(ctx:expand_text(services.translate("A thick fog begins to rise.")), "neutral")
        end
        H.set_var("global", nil, ctx, "magic_weather_dense_fog", 1)
        H.eoc_add_effect(H.u(ctx), "effect_controlling_weather_fog", 21600, nil, nil, nil)
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(15), math.floor(45); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_CALL_NEXT_WEATHER"), nil) end end
        H.set_var("context", nil, ctx, "lower_bound", math.min((((((186.52 + (H._jm_werewolf_tier_one_traits(ctx) * 9.5)) + (H._jm_werewolf_tier_two_traits(ctx) * 18.12)) + (H._jm_werewolf_tier_three_traits(ctx) * 27.5)) + (H._jm_werewolf_tier_four_traits(ctx) * 41.85)) + (H._jm_werewolf_tier_five_traits(ctx) * 68.52)), 3600))
        H.set_var("context", nil, ctx, "upper_bound", math.min((((((318.5 + (H._jm_werewolf_tier_one_traits(ctx) * 21.5)) + (H._jm_werewolf_tier_two_traits(ctx) * 39.5)) + (H._jm_werewolf_tier_three_traits(ctx) * 55.1)) + (H._jm_werewolf_tier_four_traits(ctx) * 95.21)) + (H._jm_werewolf_tier_five_traits(ctx) * 157.05)), 9000))
        do local _t = math.max(1, math.floor((function() local a, b = math.floor((ctx:get_number("lower_bound") or 0)), math.floor((ctx:get_number("upper_bound") or 0)); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_WEREWOLF_SUMMON_FOG_REMOVE"), nil) end end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You release your command over the fog and it begins to disperse.")), "neutral")
        H.set_var("global", nil, ctx, "magic_weather_dense_fog", 0)
        do local _eg = H.safe_id('effect', "effect_controlling_weather_fog"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(15), math.floor(45); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_CALL_NEXT_WEATHER"), nil) end end
        return false
    end
    end
    COND["EOC_WEREWOLF_SUMMON_FOG_REMOVE"] = function(ctx)
        return ((H.global_var_num("magic_weather_dense_fog") == 1)) == true
    end
    EOC["EOC_WEREWOLF_SUMMON_FOG_REMOVE"] = function(ctx)
    if ((H.global_var_num("magic_weather_dense_fog") == 1)) then
        if (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) then
            services.messages.add(ctx:expand_text(services.translate("The thick fog begins to disperse.")), "neutral")
        end
        do local _eg = H.safe_id('effect', "effect_controlling_weather_fog"); local _bp = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if H.u(ctx) and _eg then services.effects.remove(H.u(ctx), _eg, _bp) end end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(15), math.floor(45); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_CALL_NEXT_WEATHER"), nil) end end
        H.set_var("global", nil, ctx, "magic_weather_dense_fog", 0)
        return true
    end
    return false
    end
    COND["magic_weather_thunder"] = function(ctx)
        return (((((services.weather.current().weather and services.weather.current().weather.value) == "magic_weather_thunder") or ((services.weather.current().weather and services.weather.current().weather.value) == "magic_weather_lightning")) and services.random.native_probability(1, (50)) and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) >= 0))) == true
    end
    EOC["magic_weather_thunder"] = function(ctx)
    if (((((services.weather.current().weather and services.weather.current().weather.value) == "magic_weather_thunder") or ((services.weather.current().weather and services.weather.current().weather.value) == "magic_weather_lightning")) and services.random.native_probability(1, (50)) and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) >= 0))) then
        services.messages.add(ctx:expand_text(services.translate("You hear a distant rumble of thunder.")), "neutral")
        services.sound.play_from_outdoors("thunder_far", "environment", math.floor(80))
        return true
    end
    return false
    end
    COND["magic_weather_lightning"] = function(ctx)
        return ((((services.weather.current().weather and services.weather.current().weather.value) == "magic_weather_lightning") and services.random.native_probability(1, (600)) and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) >= 0))) == true
    end
    EOC["magic_weather_lightning"] = function(ctx)
    if ((((services.weather.current().weather and services.weather.current().weather.value) == "magic_weather_lightning") and services.random.native_probability(1, (600)) and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) >= 0))) then
        services.messages.add(ctx:expand_text(services.translate("A flash of lightning illuminates your surroundings!")), "neutral")
        services.sound.play_if_audible("thunder_near", "environment", math.floor(80))
        services.weather.activate_lightning()
        services.weather.override_light(math.floor(100), services.time.duration_from_turns(math.floor(1)), "")
        return true
    end
    return false
    end
    COND["EOC_XE_OMINOUS_FOG_WEATHER"] = function(ctx)
        return (((H.global_var_num("xe_weather_ominous_fog_scenario") ~= 1) and (services.gameplay.environment.dimension() == "default") and services.random.native_probability((1), (5)))) == true
    end
    EOC["EOC_XE_OMINOUS_FOG_WEATHER"] = function(ctx)
    if (((H.global_var_num("xe_weather_ominous_fog_scenario") ~= 1) and (services.gameplay.environment.dimension() == "default") and services.random.native_probability((1), (5)))) then
        H.run_eoc("EOC_XE_CAUSE_OMINOUS_FOG_WEATHER_WARNING", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_XE_CAUSE_OMINOUS_FOG_WEATHER_WARNING"] = function(ctx)
        return ((not ((((services.weather.current().weather and services.weather.current().weather.value) == "portal_storm") or ((services.weather.current().weather and services.weather.current().weather.value) == "early_portal_storm"))))) == true
    end
    EOC["EOC_XE_CAUSE_OMINOUS_FOG_WEATHER_WARNING"] = function(ctx)
    if ((not ((((services.weather.current().weather and services.weather.current().weather.value) == "portal_storm") or ((services.weather.current().weather and services.weather.current().weather.value) == "early_portal_storm"))))) then
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(120), math.floor(300); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_XE_CAUSE_OMINOUS_FOG_WEATHER"), nil) end end
        if ((((H.char_snap(H.u(ctx)) or {}).senses or {}).can_see ~= false) and (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true)) then
            ccb.presentation.notice(ctx:expand_text(services.translate("Out of nowhere, a thick fog begins to rise, blanketing the distance in an obscuring white shroud.")))
        end
        return true
    end
    return false
    end
    COND["EOC_XE_CAUSE_OMINOUS_FOG_WEATHER"] = function(ctx)
        return ((not ((((services.weather.current().weather and services.weather.current().weather.value) == "portal_storm") or ((services.weather.current().weather and services.weather.current().weather.value) == "early_portal_storm"))))) == true
    end
    EOC["EOC_XE_CAUSE_OMINOUS_FOG_WEATHER"] = function(ctx)
    if ((not ((((services.weather.current().weather and services.weather.current().weather.value) == "portal_storm") or ((services.weather.current().weather and services.weather.current().weather.value) == "early_portal_storm"))))) then
        H.set_var("global", nil, ctx, "xe_weather_ominous_fog_active", 1)
        services.weather.request_update()
        if ((((H.char_snap(H.u(ctx)) or {}).senses or {}).can_see ~= false) and (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true)) then
            services.messages.add(ctx:expand_text(services.translate("The fog shrouds everything, muffling sounds and making it almost impossible to distinguish anything in the distance.  You have a bad feeling about this.")), "info")
        end
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(43200), math.floor(259200); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_XE_REMOVE_OMINOUS_FOG_WEATHER"), nil) end end
        return true
    end
    return false
    end
    COND["EOC_XE_REMOVE_OMINOUS_FOG_WEATHER"] = function(ctx)
        return ((H.global_var_num("xe_weather_ominous_fog_active") == 1)) == true
    end
    EOC["EOC_XE_REMOVE_OMINOUS_FOG_WEATHER"] = function(ctx)
    if ((H.global_var_num("xe_weather_ominous_fog_active") == 1)) then
        H.set_var("global", nil, ctx, "xe_weather_ominous_fog_active", 0)
        services.weather.request_update()
        if ((((H.char_snap(H.u(ctx)) or {}).senses or {}).can_see ~= false) and (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and (not ((((services.weather.current().weather and services.weather.current().weather.value) == "portal_storm") or ((services.weather.current().weather and services.weather.current().weather.value) == "early_portal_storm"))))) then
            services.messages.add(ctx:expand_text(services.translate("As quickly as it appeared, the strange fog blows away on the wind.  Things are back to normal, for now.")), "info")
        end
        return true
    end
    return false
    end
end
