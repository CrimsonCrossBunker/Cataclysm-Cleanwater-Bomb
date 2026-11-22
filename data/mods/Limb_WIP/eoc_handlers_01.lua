local ccb = require("ccb")
local services = ccb.services
return function(E, H)
    local EOC = E.run
    local COND = E.cond
    EOC["EOC_VITAKIN_RESTORE_LIMB_SELECTOR"] = function(ctx)
    do
        local _choices, _targets = {}, {}
        do local _en = (E.cond["EOC_VITAKIN_RESTORE_LIMB_RIGHT_LEG"] == nil or E.cond["EOC_VITAKIN_RESTORE_LIMB_RIGHT_LEG"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(1), label = ctx:expand_text(services.translate("Restore Right Leg")), description = ctx:expand_text(services.translate("Attempt to restore your right leg.")), enabled = _en, hotkey = "1" }); _targets[tostring(1)] = "EOC_VITAKIN_RESTORE_LIMB_RIGHT_LEG" end end
        do local _en = (E.cond["EOC_VITAKIN_RESTORE_LIMB_LEFT_LEG"] == nil or E.cond["EOC_VITAKIN_RESTORE_LIMB_LEFT_LEG"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(2), label = ctx:expand_text(services.translate("Restore Left Leg")), description = ctx:expand_text(services.translate("Attempt to restore your left leg.")), enabled = _en, hotkey = "2" }); _targets[tostring(2)] = "EOC_VITAKIN_RESTORE_LIMB_LEFT_LEG" end end
        do local _en = (E.cond["EOC_VITAKIN_RESTORE_LIMB_RIGHT_ARM"] == nil or E.cond["EOC_VITAKIN_RESTORE_LIMB_RIGHT_ARM"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(3), label = ctx:expand_text(services.translate("Restore Right Arm")), description = ctx:expand_text(services.translate("Attempt to restore your right arm.")), enabled = _en, hotkey = "3" }); _targets[tostring(3)] = "EOC_VITAKIN_RESTORE_LIMB_RIGHT_ARM" end end
        do local _en = (E.cond["EOC_VITAKIN_RESTORE_LIMB_LEFT_ARM"] == nil or E.cond["EOC_VITAKIN_RESTORE_LIMB_LEFT_ARM"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(4), label = ctx:expand_text(services.translate("Restore Left Arm")), description = ctx:expand_text(services.translate("Attempt to restore your left arm.")), enabled = _en, hotkey = "4" }); _targets[tostring(4)] = "EOC_VITAKIN_RESTORE_LIMB_LEFT_ARM" end end
        do local _en = (E.cond["EOC_MOM_NO_EFFECT"] == nil or E.cond["EOC_MOM_NO_EFFECT"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(5), label = ctx:expand_text(services.translate("Nevermind")), description = ctx:expand_text(services.translate("Do nothing for now.")), enabled = _en, hotkey = "5" }); _targets[tostring(5)] = "EOC_MOM_NO_EFFECT" end end
        if #_choices > 0 then
            local _res = services.interaction.choose(_choices, { title = ctx:expand_text(services.translate("Select an option")), allow_cancel = false })
            if _res and _res.accepted and _res.id and _targets[_res.id] then
                H.run_eoc(_targets[_res.id], ctx)
            end
        end
    end
    return true
    end
    COND["EOC_VITAKIN_RESTORE_LIMB_RIGHT_LEG"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "NO_RIGHT_LEG") == 1)) == true
    end
    EOC["EOC_VITAKIN_RESTORE_LIMB_RIGHT_LEG"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "NO_RIGHT_LEG") == 1)) then
        do local _g = H.safe_id('activity', "ACT_VITAKIN_RESTORE_LIMB_RIGHT_LEG"); if H.u(ctx) and _g then services.activities.assign_timed(H.u(ctx), _g, services.time.duration_from_turns(math.max(1, math.floor(32400)))) end end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You have a right leg or equivalent thereof.  If it's a prosthetic, please take it off before restoring your leg.")), "mixed")
        return false
    end
    end
    COND["EOC_VITAKIN_RESTORE_LIMB_LEFT_LEG"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "NO_LEFT_LEG") == 1)) == true
    end
    EOC["EOC_VITAKIN_RESTORE_LIMB_LEFT_LEG"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "NO_LEFT_LEG") == 1)) then
        do local _g = H.safe_id('activity', "ACT_VITAKIN_RESTORE_LIMB_LEFT_LEG"); if H.u(ctx) and _g then services.activities.assign_timed(H.u(ctx), _g, services.time.duration_from_turns(math.max(1, math.floor(32400)))) end end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You have a left leg or equivalent thereof.  If it's a prosthetic, please take it off before restoring your leg.")), "mixed")
        return false
    end
    end
    COND["EOC_VITAKIN_RESTORE_LIMB_RIGHT_ARM"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "NO_RIGHT_ARM") == 1)) == true
    end
    EOC["EOC_VITAKIN_RESTORE_LIMB_RIGHT_ARM"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "NO_RIGHT_ARM") == 1)) then
        do local _g = H.safe_id('activity', "ACT_VITAKIN_RESTORE_LIMB_RIGHT_ARM"); if H.u(ctx) and _g then services.activities.assign_timed(H.u(ctx), _g, services.time.duration_from_turns(math.max(1, math.floor(32400)))) end end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You have a right arm or equivalent thereof.  If it's a prosthetic, please take it off before restoring your arm.")), "mixed")
        return false
    end
    end
    COND["EOC_VITAKIN_RESTORE_LIMB_LEFT_ARM"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "NO_LEFT_ARM") == 1)) == true
    end
    EOC["EOC_VITAKIN_RESTORE_LIMB_LEFT_ARM"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "NO_LEFT_ARM") == 1)) then
        do local _g = H.safe_id('activity', "ACT_VITAKIN_RESTORE_LIMB_LEFT_ARM"); if H.u(ctx) and _g then services.activities.assign_timed(H.u(ctx), _g, services.time.duration_from_turns(math.max(1, math.floor(32400)))) end end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You have a left arm or equivalent thereof.  If it's a prosthetic, please take it off before restoring your arm.")), "mixed")
        return false
    end
    end
    COND["EOC_PROSTHETIC_HIT"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "LEFT_PROSTHETIC_LEG") == 1) or (H.char_has_trait(H.u(ctx), "LEFT_PEG_LEG") == 1) or (H.char_has_trait(H.u(ctx), "RIGHT_PROSTHETIC_LEG") == 1) or (H.char_has_trait(H.u(ctx), "RIGHT_PEG_LEG") == 1) or (H.char_has_trait(H.u(ctx), "RIGHT_PROSTHETIC_ARM") == 1) or (H.char_has_trait(H.u(ctx), "LEFT_PROSTHETIC_ARM") == 1) or (H.char_has_trait(H.u(ctx), "RIGHT_NEUROPROSTHETIC_ARM") == 1) or (H.char_has_trait(H.u(ctx), "LEFT_NEUROPROSTHETIC_ARM") == 1) or (H.char_has_trait(H.u(ctx), "RIGHT_COSMETIC_PROSTHETIC_ARM") == 1) or (H.char_has_trait(H.u(ctx), "LEFT_COSMETIC_PROSTHETIC_ARM") == 1))) == true
    end
    EOC["EOC_PROSTHETIC_HIT"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "LEFT_PROSTHETIC_LEG") == 1) or (H.char_has_trait(H.u(ctx), "LEFT_PEG_LEG") == 1) or (H.char_has_trait(H.u(ctx), "RIGHT_PROSTHETIC_LEG") == 1) or (H.char_has_trait(H.u(ctx), "RIGHT_PEG_LEG") == 1) or (H.char_has_trait(H.u(ctx), "RIGHT_PROSTHETIC_ARM") == 1) or (H.char_has_trait(H.u(ctx), "LEFT_PROSTHETIC_ARM") == 1) or (H.char_has_trait(H.u(ctx), "RIGHT_NEUROPROSTHETIC_ARM") == 1) or (H.char_has_trait(H.u(ctx), "LEFT_NEUROPROSTHETIC_ARM") == 1) or (H.char_has_trait(H.u(ctx), "RIGHT_COSMETIC_PROSTHETIC_ARM") == 1) or (H.char_has_trait(H.u(ctx), "LEFT_COSMETIC_PROSTHETIC_ARM") == 1))) then
        H.eoc_run_inv_eocs(H.u(ctx), ctx, "random", nil, { { id = "left_leg_prosthetic", worn_only = true } }, { "EOC_left_leg_hp_set" }, {  })
        H.eoc_run_inv_eocs(H.u(ctx), ctx, "random", nil, { { id = "right_leg_prosthetic", worn_only = true } }, { "EOC_right_leg_hp_set" }, {  })
        H.eoc_run_inv_eocs(H.u(ctx), ctx, "random", nil, { { id = "left_peg_leg_old", worn_only = true } }, { "EOC_left_peg_leg_old_hp_set" }, {  })
        H.eoc_run_inv_eocs(H.u(ctx), ctx, "random", nil, { { id = "right_peg_leg_old", worn_only = true } }, { "EOC_right_peg_leg_old_hp_set" }, {  })
        H.eoc_run_inv_eocs(H.u(ctx), ctx, "random", nil, { { id = "left_arm_prosthetic", worn_only = true } }, { "EOC_left_arm_hp_set" }, {  })
        H.eoc_run_inv_eocs(H.u(ctx), ctx, "random", nil, { { id = "right_arm_prosthetic", worn_only = true } }, { "EOC_right_arm_hp_set" }, {  })
        H.eoc_run_inv_eocs(H.u(ctx), ctx, "random", nil, { { id = "left_arm_prosthetic_steel_old", worn_only = true } }, { "EOC_left_arm_hp_set" }, {  })
        H.eoc_run_inv_eocs(H.u(ctx), ctx, "random", nil, { { id = "right_arm_prosthetic_steel_old", worn_only = true } }, { "EOC_right_arm_hp_set" }, {  })
        H.eoc_run_inv_eocs(H.u(ctx), ctx, "random", nil, { { id = "left_arm_neuroprosthetic", worn_only = true } }, { "EOC_left_neuroarm_hp_set" }, {  })
        H.eoc_run_inv_eocs(H.u(ctx), ctx, "random", nil, { { id = "right_arm_neuroprosthetic", worn_only = true } }, { "EOC_right_neuroarm_hp_set" }, {  })
        H.eoc_run_inv_eocs(H.u(ctx), ctx, "random", nil, { { id = "left_arm_prosthetic_wood_old", worn_only = true } }, { "EOC_left_cosmetic_arm_hp_set" }, {  })
        H.eoc_run_inv_eocs(H.u(ctx), ctx, "random", nil, { { id = "right_arm_prosthetic_wood_old", worn_only = true } }, { "EOC_right_cosmetic_arm_hp_set" }, {  })
        return true
    end
    return false
    end
    EOC["EOC_left_leg_hp_set"] = function(ctx)
    H.set_char_hp(H.npc(ctx), "ALL", ((H.char_hp(H.u(ctx), "leg_prosthetic_l", false) * H.char_hp(H.npc(ctx), "bp_null", true)) / H.char_hp(H.u(ctx), "leg_prosthetic_l", true)), "=")
    return true
    end
    EOC["EOC_right_leg_hp_set"] = function(ctx)
    H.set_char_hp(H.npc(ctx), "ALL", ((H.char_hp(H.u(ctx), "leg_prosthetic_r", false) * H.char_hp(H.npc(ctx), "bp_null", true)) / H.char_hp(H.u(ctx), "leg_prosthetic_r", true)), "=")
    return true
    end
    EOC["EOC_left_peg_leg_old_hp_set"] = function(ctx)
    H.set_char_hp(H.npc(ctx), "ALL", ((H.char_hp(H.u(ctx), "leg_peg_l", false) * H.char_hp(H.npc(ctx), "bp_null", true)) / H.char_hp(H.u(ctx), "leg_peg_l", true)), "=")
    return true
    end
    EOC["EOC_right_peg_leg_old_hp_set"] = function(ctx)
    H.set_char_hp(H.npc(ctx), "ALL", ((H.char_hp(H.u(ctx), "leg_peg_r", false) * H.char_hp(H.npc(ctx), "bp_null", true)) / H.char_hp(H.u(ctx), "leg_peg_r", true)), "=")
    return true
    end
    EOC["EOC_left_arm_hp_set"] = function(ctx)
    H.set_char_hp(H.npc(ctx), "ALL", ((H.char_hp(H.u(ctx), "arm_prosthetic_l", false) * H.char_hp(H.npc(ctx), "bp_null", true)) / H.char_hp(H.u(ctx), "arm_prosthetic_l", true)), "=")
    return true
    end
    EOC["EOC_right_arm_hp_set"] = function(ctx)
    H.set_char_hp(H.npc(ctx), "ALL", ((H.char_hp(H.u(ctx), "arm_prosthetic_r", false) * H.char_hp(H.npc(ctx), "bp_null", true)) / H.char_hp(H.u(ctx), "arm_prosthetic_r", true)), "=")
    return true
    end
    EOC["EOC_right_neuroarm_hp_set"] = function(ctx)
    H.set_char_hp(H.npc(ctx), "ALL", ((H.char_hp(H.u(ctx), "arm_neuroprosthetic_r", false) * H.char_hp(H.npc(ctx), "bp_null", true)) / H.char_hp(H.u(ctx), "arm_neuroprosthetic_r", true)), "=")
    return true
    end
    EOC["EOC_left_neuroarm_hp_set"] = function(ctx)
    H.set_char_hp(H.npc(ctx), "ALL", ((H.char_hp(H.u(ctx), "arm_neuroprosthetic_l", false) * H.char_hp(H.npc(ctx), "bp_null", true)) / H.char_hp(H.u(ctx), "arm_neuroprosthetic_l", true)), "=")
    return true
    end
    EOC["EOC_right_cosmetic_arm_hp_set"] = function(ctx)
    H.set_char_hp(H.npc(ctx), "ALL", ((H.char_hp(H.u(ctx), "arm_prosthetic_cosmetic_r", false) * H.char_hp(H.npc(ctx), "bp_null", true)) / H.char_hp(H.u(ctx), "arm_prosthetic_cosmetic_r", true)), "=")
    return true
    end
    EOC["EOC_left_cosmetic_arm_hp_set"] = function(ctx)
    H.set_char_hp(H.npc(ctx), "ALL", ((H.char_hp(H.u(ctx), "arm_prosthetic_cosmetic_l", false) * H.char_hp(H.npc(ctx), "bp_null", true)) / H.char_hp(H.u(ctx), "arm_prosthetic_cosmetic_l", true)), "=")
    return true
    end
end
