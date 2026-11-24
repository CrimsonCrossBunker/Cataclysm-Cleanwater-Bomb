local ccb = require("ccb")
local services = ccb.services
local H = require("ccb_runtime_helpers").create()

ccb.runtime.handler("dlg_p_perk_melee_dd59e3b64789", function(ctx)
    return ((ctx:evaluate_conditional("perk_condition") == true) and (H.var_num(H.u(ctx), "num_ma_perks") > 0))
end)

ccb.runtime.handler("dlg_a_perk_melee_8ccd5f544ce6", function(ctx)
    ctx:set_conditional("perk_condition", (0 == 0))
end)

ccb.runtime.handler("dlg_a_perk_melee_ebb3872ec2f7", function(ctx)
    ctx:set_conditional("perk_condition", (H.char_has_trait(H.u(ctx), "MELEE_PERK_COMBAT_TEMPO") == 1))
end)

ccb.runtime.handler("dlg_a_perk_melee_6b502c186d59", function(ctx)
    ctx:set_conditional("perk_condition", ((H.char_has_trait(H.u(ctx), "MELEE_PERK_COMBAT_TEMPO") == 1) and (H.char_has_trait(H.u(ctx), "MELEE_PERK_COMBAT_TEMPO_2") == 1)))
end)

ccb.runtime.handler("dlg_a_perk_melee_0fcf6c68bf37", function(ctx)
    ctx:set_conditional("perk_condition", (H.char_has_trait(H.u(ctx), "MELEE_PERK_MOMENTUM") == 1))
end)

ccb.runtime.handler("dlg_a_perk_melee_a6b5fcca89b7", function(ctx)
    ctx:set_conditional("perk_condition", ((H.char_has_trait(H.u(ctx), "MELEE_PERK_MOMENTUM") == 1) and (H.char_has_trait(H.u(ctx), "MELEE_PERK_DODGE") == 1)))
end)

ccb.runtime.handler("dlg_a_perk_melee_724cde31b873", function(ctx)
    ctx:set_conditional("perk_condition", (H.char_has_trait(H.u(ctx), "MELEE_PERK_INSIGHT") == 1))
end)

ccb.runtime.handler("dlg_a_perk_melee_f5541b229d19", function(ctx)
    ctx:set_conditional("perk_condition", (H.char_has_trait(H.u(ctx), "MELEE_PERK_MYSTIC_SHOT") == 1))
end)

ccb.runtime.handler("dlg_a_perk_melee_0f04e630b95f", function(ctx)
    ctx:set_conditional("perk_condition", (H.char_has_trait(H.u(ctx), "MELEE_PERK_SIXTH_SENSE") == 1))
end)

ccb.runtime.handler("dlg_a_perk_melee_3f1205ad201a", function(ctx)
    ctx:set_conditional("perk_condition", (H.char_has_trait(H.u(ctx), "MELEE_PERK_POISE") == 1))
end)

ccb.runtime.handler("dlg_a_perk_melee_d8171d3c5ec0", function(ctx)
    ctx:set_conditional("perk_condition", (H.char_has_trait(H.u(ctx), "MELEE_PERK_EXECUTION") == 1))
end)

ccb.runtime.handler("dlg_a_perk_melee_129bcec5a018", function(ctx)
    H.mutate_towards(H.u(ctx), H.var_str("context", nil, ctx, "trait_id", ""), "ANY", false)
    H.set_var("actor", H.u(ctx), ctx, "num_ma_perks", (H.var_num(H.u(ctx), "num_ma_perks")) - 1)
end)
