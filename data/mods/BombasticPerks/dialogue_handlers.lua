local ccb = require("ccb")
local services = ccb.services
local H = require("ccb_runtime_helpers").create()

ccb.runtime.handler("dlg_p_bombasticperks_9920859920ca", function(ctx)
    return (((H.var_num(H.u(ctx), "no_prerecs") > 0) or (ctx:evaluate_conditional("perk_condition") == true)) and (H.var_num(H.u(ctx), "num_perks") > 0))
end)

ccb.runtime.handler("dlg_p_bombasticperks_393c21bf0c6a", function(ctx)
    return (((H.var_num(H.u(ctx), "no_prerecs") > 0) or (ctx:evaluate_conditional("perk_condition") == true)) and (H.var_num(H.u(ctx), "playstyle_perks_available") >= 1) and (H.var_num(H.u(ctx), "num_perks") > 0))
end)

ccb.runtime.handler("dlg_p_bombasticperks_46543877c07e", function(ctx)
    return (H.var_num(H.u(ctx), "no_playstyle") == 0)
end)

ccb.runtime.handler("dlg_p_bombasticperks_60ff7b3ba237", function(ctx)
    return services.gameplay.mods.is_loaded("magiclysm")
end)

ccb.runtime.handler("dlg_p_bombasticperks_2ece40359f04", function(ctx)
    return services.gameplay.mods.is_loaded("mindovermatter")
end)

ccb.runtime.handler("dlg_p_bombasticperks_d804613dc489", function(ctx)
    return (not (((H.char_has_trait(H.u(ctx), "perk_secret_closet_teleporter_paths") == 1) or services.gameplay.mods.is_loaded("skyisland"))))
end)

ccb.runtime.handler("dlg_p_bombasticperks_a0bfd7f30fc5", function(ctx)
    return ((not ((H.char_has_trait(H.u(ctx), "perk_metamagic_silent") == 1))) and (services.gameplay.mods.is_loaded("magiclysm") or services.gameplay.mods.is_loaded("xedra_evolved")))
end)

ccb.runtime.handler("dlg_p_bombasticperks_eec48403faf4", function(ctx)
    return ((not ((H.char_has_trait(H.u(ctx), "perk_metamagic_still") == 1))) and (services.gameplay.mods.is_loaded("magiclysm") or services.gameplay.mods.is_loaded("xedra_evolved")))
end)

ccb.runtime.handler("dlg_p_bombasticperks_dc438cae4f88", function(ctx)
    return (H.var_num(H.u(ctx), "no_notifications") ~= 0)
end)

ccb.runtime.handler("dlg_p_bombasticperks_71b0d0c3afec", function(ctx)
    return (H.var_num(H.u(ctx), "no_notifications") ~= 1)
end)

ccb.runtime.handler("dlg_p_bombasticperks_a2a3bf53d567", function(ctx)
    return (H.var_num(H.u(ctx), "exp_per_level") ~= 0)
end)

ccb.runtime.handler("dlg_p_bombasticperks_e2eab097807c", function(ctx)
    return (H.var_num(H.u(ctx), "exp_per_level") ~= 300)
end)

ccb.runtime.handler("dlg_p_bombasticperks_8f9f1603b746", function(ctx)
    return (H.var_num(H.u(ctx), "exp_per_level") ~= 1000)
end)

ccb.runtime.handler("dlg_p_bombasticperks_428170bfb771", function(ctx)
    return (H.var_num(H.u(ctx), "exp_per_level") ~= 10000)
end)

ccb.runtime.handler("dlg_p_bombasticperks_017b4e708f52", function(ctx)
    return (H.var_num(H.u(ctx), "no_prerecsl") ~= 0)
end)

ccb.runtime.handler("dlg_p_bombasticperks_377d73361911", function(ctx)
    return (H.var_num(H.u(ctx), "no_prerecsl") ~= 1)
end)

ccb.runtime.handler("dlg_a_bombasticperks_45c4c5af4786", function(ctx)
    H.mutate_towards(H.u(ctx), H.var_str("context", nil, ctx, "trait_id", ""), "ANY", false)
    H.set_var("actor", H.u(ctx), ctx, "num_perks", (H.var_num(H.u(ctx), "num_perks")) - 1)
end)

ccb.runtime.handler("dlg_a_bombasticperks_f347a8013f73", function(ctx)
    H.mutate_towards(H.u(ctx), H.var_str("context", nil, ctx, "trait_id", ""), "ANY", false)
    H.set_var("actor", H.u(ctx), ctx, "num_perks", (H.var_num(H.u(ctx), "num_perks")) - 1)
    H.set_var("actor", H.u(ctx), ctx, "playstyle_perks_available", (H.var_num(H.u(ctx), "playstyle_perks_available")) - 1)
end)

ccb.runtime.handler("dlg_a_bombasticperks_4a547a6d5c7b", function(ctx)
    ctx:set_conditional("perk_condition", ((H.var_num(H.u(ctx), "current_level") >= 8) and (not ((H.char_has_trait(H.u(ctx), "perk_STR_UP_2") == 1)))))
end)

ccb.runtime.handler("dlg_a_bombasticperks_2c0157bf049c", function(ctx)
    ctx:set_conditional("perk_condition", ((H.char_has_trait(H.u(ctx), "perk_STR_UP") == 1) and (H.var_num(H.u(ctx), "current_level") >= 20)))
end)

ccb.runtime.handler("dlg_a_bombasticperks_b4f835a21133", function(ctx)
    ctx:set_conditional("perk_condition", ((H.var_num(H.u(ctx), "current_level") >= 8) and (not ((H.char_has_trait(H.u(ctx), "perk_DEX_UP_2") == 1)))))
end)

ccb.runtime.handler("dlg_a_bombasticperks_1ace8c2bca76", function(ctx)
    ctx:set_conditional("perk_condition", ((H.char_has_trait(H.u(ctx), "perk_DEX_UP") == 1) and (H.var_num(H.u(ctx), "current_level") >= 20)))
end)

ccb.runtime.handler("dlg_a_bombasticperks_3ab8913a254d", function(ctx)
    ctx:set_conditional("perk_condition", ((H.var_num(H.u(ctx), "current_level") >= 8) and (not ((H.char_has_trait(H.u(ctx), "perk_INT_UP_2") == 1)))))
end)

ccb.runtime.handler("dlg_a_bombasticperks_dfe77231b78d", function(ctx)
    ctx:set_conditional("perk_condition", ((H.char_has_trait(H.u(ctx), "perk_INT_UP") == 1) and (H.var_num(H.u(ctx), "current_level") >= 20)))
end)

ccb.runtime.handler("dlg_a_bombasticperks_a18c1e53bdf6", function(ctx)
    ctx:set_conditional("perk_condition", ((H.var_num(H.u(ctx), "current_level") >= 8) and (not ((H.char_has_trait(H.u(ctx), "perk_PER_UP_2") == 1)))))
end)

ccb.runtime.handler("dlg_a_bombasticperks_23ebd77a6c0d", function(ctx)
    ctx:set_conditional("perk_condition", ((H.char_has_trait(H.u(ctx), "perk_PER_UP") == 1) and (H.var_num(H.u(ctx), "current_level") >= 20)))
end)

ccb.runtime.handler("dlg_a_bombasticperks_77c7c9419c0b", function(ctx)
    ctx:set_conditional("perk_condition", (((H.char_stat(H.u(ctx), "perception_base") + H.char_stat(H.u(ctx), "perception_bonus")) >= 13) or (H.char_has_trait(H.u(ctx), "SPIRITUAL") == 1)))
end)

ccb.runtime.handler("dlg_a_bombasticperks_4c8d098de87f", function(ctx)
    ctx:set_conditional("perk_condition", (((H.char_stat(H.u(ctx), "strength_base") + H.char_stat(H.u(ctx), "strength_bonus")) >= 13) and (H.var_num(H.u(ctx), "current_level") >= 12)))
end)

ccb.runtime.handler("dlg_a_bombasticperks_751f27f798c2", function(ctx)
    ctx:set_conditional("perk_condition", (((H.char_stat(H.u(ctx), "dexterity_base") + H.char_stat(H.u(ctx), "dexterity_bonus")) >= 13) and (H.var_num(H.u(ctx), "current_level") >= 12)))
end)

ccb.runtime.handler("dlg_a_bombasticperks_66fc3ef57e5d", function(ctx)
    ctx:set_conditional("perk_condition", (((H.char_stat(H.u(ctx), "perception_base") + H.char_stat(H.u(ctx), "perception_bonus")) >= 13) and (H.var_num(H.u(ctx), "current_level") >= 12)))
end)

ccb.runtime.handler("dlg_a_bombasticperks_401c8300de7d", function(ctx)
    ctx:set_conditional("perk_condition", (((H.char_stat(H.u(ctx), "strength_base") + H.char_stat(H.u(ctx), "strength_bonus")) >= 12) or (H.char_has_trait(H.u(ctx), "perk_STR_UP_2") == 1) or (H.char_has_trait(H.u(ctx), "perk_way_closedfist") == 1)))
end)

ccb.runtime.handler("dlg_a_bombasticperks_2c75df54e7c3", function(ctx)
    ctx:set_conditional("perk_condition", (0 == 0))
end)

ccb.runtime.handler("dlg_a_bombasticperks_a4e62a4574a0", function(ctx)
    ctx:set_conditional("perk_condition", (not (H.char_has_any_trait(H.u(ctx), { "FLIMSY", "FLIMSY2", "FLIMSY3", "GLASSJAW" }))))
end)

ccb.runtime.handler("dlg_a_bombasticperks_b3c498258a4d", function(ctx)
    ctx:set_conditional("perk_condition", ((H.char_has_trait(H.u(ctx), "perk_built_tough") == 1) and (H.var_num(H.u(ctx), "current_level") >= 6)))
end)

ccb.runtime.handler("dlg_a_bombasticperks_d7c3031a186a", function(ctx)
    ctx:set_conditional("perk_condition", (H.char_skill(H.u(ctx), "swimming") >= 4))
end)

ccb.runtime.handler("dlg_a_bombasticperks_7f786196359f", function(ctx)
    ctx:set_conditional("perk_condition", (H.char_skill(H.u(ctx), "swimming") >= 3))
end)

ccb.runtime.handler("dlg_a_bombasticperks_b79092f78eaf", function(ctx)
    ctx:set_conditional("perk_condition", ((H.char_skill(H.u(ctx), "bashing") >= 4) or (H.char_skill(H.u(ctx), "unarmed") >= 4)))
end)

ccb.runtime.handler("dlg_a_bombasticperks_4c5b28d9b314", function(ctx)
    ctx:set_conditional("perk_condition", ((not ((H.char_has_trait(H.u(ctx), "GLASSJAW") == 1))) and ((H.char_skill(H.u(ctx), "unarmed") >= 4) or (H.char_skill(H.u(ctx), "melee") >= 4))))
end)

ccb.runtime.handler("dlg_a_bombasticperks_50fe52a9082c", function(ctx)
    ctx:set_conditional("perk_condition", ((not (((H.char_has_trait(H.u(ctx), "perk_way_closedfist") == 1) or (H.char_has_trait(H.u(ctx), "perk_way_pinchedfingers") == 1)))) and ((H.char_skill(H.u(ctx), "unarmed") >= 4) and (H.char_skill(H.u(ctx), "cutting") >= 4))))
end)

ccb.runtime.handler("dlg_a_bombasticperks_e4b564d2c938", function(ctx)
    ctx:set_conditional("perk_condition", ((not (((H.char_has_trait(H.u(ctx), "perk_way_openpalm") == 1) or (H.char_has_trait(H.u(ctx), "perk_way_pinchedfingers") == 1)))) and ((H.char_skill(H.u(ctx), "unarmed") >= 4) and (H.char_skill(H.u(ctx), "bashing") >= 4))))
end)

ccb.runtime.handler("dlg_a_bombasticperks_2ccee4661779", function(ctx)
    ctx:set_conditional("perk_condition", ((not (((H.char_has_trait(H.u(ctx), "perk_way_closedfist") == 1) or (H.char_has_trait(H.u(ctx), "perk_way_openpalm") == 1)))) and ((H.char_skill(H.u(ctx), "unarmed") >= 4) and (H.char_skill(H.u(ctx), "stabbing") >= 4))))
end)

ccb.runtime.handler("dlg_a_bombasticperks_7ca88efc958d", function(ctx)
    ctx:set_conditional("perk_condition", ((not ((H.char_has_trait(H.u(ctx), "perk_bloody_mess") == 1))) and ((H.char_skill(H.u(ctx), "melee") >= 5) or (H.char_skill(H.u(ctx), "gun") >= 5))))
end)

ccb.runtime.handler("dlg_a_bombasticperks_ad21da99dfcb", function(ctx)
    ctx:set_conditional("perk_condition", (H.char_skill(H.u(ctx), "survival") >= 6))
end)

ccb.runtime.handler("dlg_a_bombasticperks_7132bf957547", function(ctx)
    ctx:set_conditional("perk_condition", (H.char_skill(H.u(ctx), "pistol") >= 3))
end)

ccb.runtime.handler("dlg_a_bombasticperks_7fc17147262b", function(ctx)
    ctx:set_conditional("perk_condition", (not ((H.char_has_trait(H.u(ctx), "perk_twice_shy") == 1))))
end)

ccb.runtime.handler("dlg_a_bombasticperks_291d29e99698", function(ctx)
    ctx:set_conditional("perk_condition", (not ((H.char_has_trait(H.u(ctx), "perk_vengeful") == 1))))
end)

ccb.runtime.handler("dlg_a_bombasticperks_b9f502ae89db", function(ctx)
    ctx:set_conditional("perk_condition", (((H.char_has_trait(H.u(ctx), "SOCIAL1") == 1) or (H.char_has_trait(H.u(ctx), "SOCIAL2") == 1)) and (not (H.char_has_any_trait(H.u(ctx), { "PRED1", "PRED2", "PRED3", "PRED4", "SAPIOVORE" })))))
end)

ccb.runtime.handler("dlg_a_bombasticperks_6e08f6672672", function(ctx)
    ctx:set_conditional("perk_condition", (not ((H.char_has_trait(H.u(ctx), "LIGHTEATER") == 1))))
end)

ccb.runtime.handler("dlg_a_bombasticperks_19b3898d1ea2", function(ctx)
    ctx:set_conditional("perk_condition", (H.char_skill(H.u(ctx), "swimming") >= 5))
end)

ccb.runtime.handler("dlg_a_bombasticperks_9156b3c90f3b", function(ctx)
    ctx:set_conditional("perk_condition", (((H.char_has_trait(H.u(ctx), "perk_tuck_and_roll") == 1) and (H.char_skill(H.u(ctx), "swimming") >= 7)) or (services.proficiencies.has_id_text(H.u(ctx), "prof_parkour").value == true) or (((H.char_stat(H.u(ctx), "dexterity_base") + H.char_stat(H.u(ctx), "dexterity_bonus")) >= 13) and (H.char_skill(H.u(ctx), "swimming") >= 5))))
end)

ccb.runtime.handler("dlg_a_bombasticperks_b6f96e5330b9", function(ctx)
    ctx:set_conditional("perk_condition", ((H.char_has_trait(H.u(ctx), "perk_built_tough") == 1) and (not (H.char_has_any_trait(H.u(ctx), { "MORE_PAIN", "MORE_PAIN2", "MORE_PAIN3" })))))
end)

ccb.runtime.handler("dlg_a_bombasticperks_e44b07da4503", function(ctx)
    ctx:set_conditional("perk_condition", (H.char_skill(H.u(ctx), "survival") >= 4))
end)

ccb.runtime.handler("dlg_a_bombasticperks_aa1ceb6d9b10", function(ctx)
    ctx:set_conditional("perk_condition", ((H.char_has_trait(H.u(ctx), "perk_tingly") == 1) and (H.var_num(H.u(ctx), "current_level") >= 8)))
end)

ccb.runtime.handler("dlg_a_bombasticperks_ec227f8afa47", function(ctx)
    ctx:set_conditional("perk_condition", ((((H.char_stat(H.u(ctx), "dexterity_base") + H.char_stat(H.u(ctx), "dexterity_bonus")) >= 12) or (H.char_has_trait(H.u(ctx), "perk_DEX_UP_2") == 1)) and (H.var_num(H.u(ctx), "current_level") >= 6)))
end)

ccb.runtime.handler("dlg_a_bombasticperks_a2e2f151f178", function(ctx)
    ctx:set_conditional("perk_condition", ((H.var_num(H.u(ctx), "current_level") >= 6) and (((H.char_stat(H.u(ctx), "dexterity_base") + H.char_stat(H.u(ctx), "dexterity_bonus")) >= 10) or (H.char_has_trait(H.u(ctx), "perk_jumpy") == 1))))
end)

ccb.runtime.handler("dlg_a_bombasticperks_b6e102fad850", function(ctx)
    ctx:set_conditional("perk_condition", ((((((H.char_skill(H.u(ctx), "chemistry") + H.char_skill(H.u(ctx), "cooking")) + H.char_skill(H.u(ctx), "fabrication")) + H.char_skill(H.u(ctx), "tailor")) + H.char_skill(H.u(ctx), "electronics")) + H.char_skill(H.u(ctx), "survival")) >= 12))
end)

ccb.runtime.handler("dlg_a_bombasticperks_c6c28a62ba15", function(ctx)
    ctx:set_conditional("perk_condition", (H.char_has_trait(H.u(ctx), "PACIFIST") == 1))
end)

ccb.runtime.handler("dlg_a_bombasticperks_99bee8a92e0d", function(ctx)
    ctx:set_conditional("perk_condition", (H.char_skill(H.u(ctx), "swimming") >= 6))
end)

ccb.runtime.handler("dlg_a_bombasticperks_f2354d3a6eea", function(ctx)
    ctx:set_conditional("perk_condition", (not (H.char_has_any_trait(H.u(ctx), { "SQUEAMISH", "VEGETARIAN", "HERBIVORE", "VEGAN" }))))
end)

ccb.runtime.handler("dlg_a_bombasticperks_640088ea2062", function(ctx)
    ctx:set_conditional("perk_condition", ((H.char_has_trait(H.u(ctx), "perk_blood_drinker") == 1) and (H.var_num(H.u(ctx), "current_level") >= 9)))
end)

ccb.runtime.handler("dlg_a_bombasticperks_f1296edb55e2", function(ctx)
    ctx:set_conditional("perk_condition", (((H.char_stat(H.u(ctx), "perception_base") + H.char_stat(H.u(ctx), "perception_bonus")) >= 10) or (services.proficiencies.has_id_text(H.u(ctx), "prof_spotting").value == true)))
end)

ccb.runtime.handler("dlg_a_bombasticperks_8b2e16e1258e", function(ctx)
    ctx:set_conditional("perk_condition", (H.char_has_trait(H.u(ctx), "SPIRITUAL") == 1))
end)

ccb.runtime.handler("dlg_a_bombasticperks_1e90e6688f0c", function(ctx)
    ctx:set_conditional("perk_condition", (H.char_skill(H.u(ctx), "firstaid") >= 4))
end)

ccb.runtime.handler("dlg_a_bombasticperks_9e2a1a9a7536", function(ctx)
    ctx:set_conditional("perk_condition", ((H.char_skill(H.u(ctx), "melee") >= 5) and ((H.char_stat(H.u(ctx), "dexterity_base") + H.char_stat(H.u(ctx), "dexterity_bonus")) >= 10) and (H.char_proficiency(H.u(ctx), "prof_fencing_weapons_pro", "percent") >= 100)))
end)

ccb.runtime.handler("dlg_a_bombasticperks_b20c1c7dd863", function(ctx)
    ctx:set_conditional("perk_condition", ((H.char_has_trait(H.u(ctx), "perk_artifact_resonance_detection") == 1) and (not ((H.char_has_trait(H.u(ctx), "perk_artifact_resonance_exploitation") == 1)))))
end)

ccb.runtime.handler("dlg_a_bombasticperks_7e086ae1abad", function(ctx)
    ctx:set_conditional("perk_condition", ((H.char_has_trait(H.u(ctx), "perk_artifact_resonance_detection") == 1) and (not ((H.char_has_trait(H.u(ctx), "perk_artifact_resonance_reduction") == 1)))))
end)

ccb.runtime.handler("dlg_a_bombasticperks_b180c5a63826", function(ctx)
    ctx:set_conditional("perk_condition", ((H.char_skill(H.u(ctx), "chemistry") >= 4) or (H.char_skill(H.u(ctx), "cooking") >= 4) or (H.char_skill(H.u(ctx), "fabrication") >= 4) or (H.char_skill(H.u(ctx), "tailor") >= 4) or (H.char_skill(H.u(ctx), "electronics") >= 4)))
end)

ccb.runtime.handler("dlg_a_bombasticperks_1ea9a9f6aab7", function(ctx)
    ctx:set_conditional("perk_condition", (not (H.char_has_any_trait(H.u(ctx), { "perk_nocturnal", "INSOMNIA" }))))
end)

ccb.runtime.handler("dlg_a_bombasticperks_fd0f97a35c91", function(ctx)
    ctx:set_conditional("perk_condition", ((H.char_stat(H.u(ctx), "dexterity_base") + H.char_stat(H.u(ctx), "dexterity_bonus")) >= 10))
end)

ccb.runtime.handler("dlg_a_bombasticperks_caa7c29bbb66", function(ctx)
    ctx:set_conditional("perk_condition", (not ((H.char_has_trait(H.u(ctx), "perk_noctural") == 1))))
end)

ccb.runtime.handler("dlg_a_bombasticperks_06eee29c85ef", function(ctx)
    ctx:set_conditional("perk_condition", (((H.char_stat(H.u(ctx), "dexterity_base") + H.char_stat(H.u(ctx), "dexterity_bonus")) >= 12) or (H.char_skill(H.u(ctx), "dodge") >= 6)))
end)

ccb.runtime.handler("dlg_a_bombasticperks_33a2515ae43f", function(ctx)
    ctx:set_conditional("perk_condition", ((H.char_skill(H.u(ctx), "dodge") >= 8) and (H.char_has_trait(H.u(ctx), "perk_lucky_dodge") == 1)))
end)

ccb.runtime.handler("dlg_a_bombasticperks_e2060c2c1f41", function(ctx)
    ctx:set_conditional("perk_condition", ((services.proficiencies.has_id_text(H.u(ctx), "prof_welding_basic").value == true) or ((H.char_stat(H.u(ctx), "intelligence_base") + H.char_stat(H.u(ctx), "intelligence_bonus")) >= 11)))
end)

ccb.runtime.handler("dlg_a_bombasticperks_4cf42a9b580e", function(ctx)
    ctx:set_conditional("perk_condition", ((not ((H.char_has_trait(H.u(ctx), "HATES_BOOKS") == 1))) and (not ((H.char_has_trait(H.u(ctx), "ILLITERATE") == 1)))))
end)

ccb.runtime.handler("dlg_a_bombasticperks_45633b44df16", function(ctx)
    ctx:set_conditional("perk_condition", ((H.char_skill(H.u(ctx), "melee") >= 4) or (H.char_skill(H.u(ctx), "unarmed") >= 4)))
end)

ccb.runtime.handler("dlg_a_bombasticperks_8a7f97657fa9", function(ctx)
    ctx:set_conditional("perk_condition", (((H.char_has_trait(H.u(ctx), "PRETTY") == 1) or (H.char_has_trait(H.u(ctx), "BEAUTIFUL") == 1) or (H.char_has_trait(H.u(ctx), "BEAUTIFUL2") == 1) or (H.char_has_trait(H.u(ctx), "BEAUTIFUL3") == 1))))
end)

ccb.runtime.handler("dlg_a_bombasticperks_4d7c672d7dcd", function(ctx)
    ctx:set_conditional("perk_condition", (H.char_has_any_trait(H.u(ctx), { "SLEEPY", "perk_sleepy" }) and (not (H.char_has_any_trait(H.u(ctx), { "WAKEFUL", "WAKEFUL2", "WAKEFUL3" })))))
end)

ccb.runtime.handler("dlg_a_bombasticperks_6e535c005419", function(ctx)
    ctx:set_conditional("perk_condition", (H.var_num(H.u(ctx), "current_level") >= 6))
end)

ccb.runtime.handler("dlg_a_bombasticperks_8f9919f7683e", function(ctx)
    ctx:set_conditional("perk_condition", (H.char_skill(H.u(ctx), "chemistry") >= 4))
end)

ccb.runtime.handler("dlg_a_bombasticperks_0bb31d1fee7d", function(ctx)
    ctx:set_conditional("perk_condition", (H.char_skill(H.u(ctx), "melee") >= 3))
end)

ccb.runtime.handler("dlg_a_bombasticperks_e988ffa24645", function(ctx)
    ctx:set_conditional("perk_condition", (H.char_has_trait(H.u(ctx), "PROF_DICEMASTER") == 1))
end)

ccb.runtime.handler("dlg_a_bombasticperks_61f8d2cddef2", function(ctx)
    ctx:set_conditional("perk_condition", ((H.char_skill(H.u(ctx), "electronics") >= 4) and (H.char_skill(H.u(ctx), "firstaid") >= 6)))
end)

ccb.runtime.handler("dlg_a_bombasticperks_6a136c3cb11e", function(ctx)
    ctx:set_conditional("perk_condition", ((H.char_skill(H.u(ctx), "gun") >= 3) and ((H.char_skill(H.u(ctx), "pistol") >= 5) or (H.char_skill(H.u(ctx), "rifle") >= 5) or (H.char_skill(H.u(ctx), "shotgun") >= 5) or (H.char_skill(H.u(ctx), "smg") >= 5))))
end)

ccb.runtime.handler("dlg_a_bombasticperks_32ef060eb6bf", function(ctx)
    ctx:set_conditional("perk_condition", (H.char_skill(H.u(ctx), "pistol") >= 6))
end)

ccb.runtime.handler("dlg_a_bombasticperks_ed7b88253f85", function(ctx)
    ctx:set_conditional("perk_condition", (H.char_skill(H.u(ctx), "gun") >= 5))
end)

ccb.runtime.handler("dlg_a_bombasticperks_8a1ad08b906e", function(ctx)
    ctx:set_conditional("perk_condition", (H.char_skill(H.u(ctx), "archery") >= 8))
end)

ccb.runtime.handler("dlg_a_bombasticperks_474f01a97a08", function(ctx)
    ctx:set_conditional("perk_condition", ((not ((H.char_has_trait(H.u(ctx), "PSYCHOPATH") == 1))) and (H.char_skill(H.u(ctx), "speech") >= 7)))
end)

ccb.runtime.handler("dlg_a_bombasticperks_af3b29847978", function(ctx)
    ctx:set_conditional("perk_condition", ((((H.char_stat(H.u(ctx), "strength_base") + H.char_stat(H.u(ctx), "strength_bonus")) >= 12)) and (H.char_has_trait(H.u(ctx), "perk_STR_UP_2") == 1) and (H.char_skill(H.u(ctx), "cutting") >= 5)))
end)

ccb.runtime.handler("dlg_a_bombasticperks_8aa27ed4fa1c", function(ctx)
    ctx:set_conditional("perk_condition", (not (H.char_has_any_trait(H.u(ctx), { "GOURMAND", "perk_big_eater" }))))
end)

ccb.runtime.handler("dlg_a_bombasticperks_97e6c436581a", function(ctx)
    ctx:set_conditional("perk_condition", ((H.char_skill(H.u(ctx), "melee") >= 7) or (H.char_skill(H.u(ctx), "unarmed") >= 7)))
end)

ccb.runtime.handler("dlg_a_bombasticperks_45d3dae50239", function(ctx)
    ctx:set_conditional("perk_condition", (H.char_skill(H.u(ctx), "cooking") >= 5))
end)

ccb.runtime.handler("dlg_a_bombasticperks_a48e2caf44bf", function(ctx)
    ctx:set_conditional("perk_condition", (not (H.char_has_any_trait(H.u(ctx), { "perk_early_to_rise", "perk_sleepy" }))))
end)

ccb.runtime.handler("dlg_a_bombasticperks_66197d0bb619", function(ctx)
    ctx:set_conditional("perk_condition", (H.var_num(H.u(ctx), "current_level") >= 12))
end)

ccb.runtime.handler("dlg_a_bombasticperks_e35f2b9118cc", function(ctx)
    ctx:set_conditional("perk_condition", ((H.char_skill(H.u(ctx), "gun") >= 7) and (H.char_skill(H.u(ctx), "pistol") >= 7) and (H.var_num(H.u(ctx), "current_level") >= 12)))
end)

ccb.runtime.handler("dlg_a_bombasticperks_e28a45b8bb48", function(ctx)
    ctx:set_conditional("perk_condition", ((H.char_has_trait(H.u(ctx), "LIGHTEATER") == 1) and (not (H.char_has_any_trait(H.u(ctx), { "GOURMAND", "perk_big_eater" })))))
end)

ccb.runtime.handler("dlg_a_bombasticperks_7c9792c2b71d", function(ctx)
    ctx:set_conditional("perk_condition", H.char_has_any_trait(H.u(ctx), { "ADDICTIVE", "STIMBOOST" }))
end)

ccb.runtime.handler("dlg_a_bombasticperks_fa6c31cba75c", function(ctx)
    ctx:set_conditional("perk_condition", (not ((H.char_has_trait(H.u(ctx), "perk_surgical_strikes") == 1))))
end)

ccb.runtime.handler("dlg_a_bombasticperks_340998e76d29", function(ctx)
    ctx:set_conditional("perk_condition", (H.char_has_trait(H.u(ctx), "GOODMEMORY") == 1))
end)

ccb.runtime.handler("dlg_a_bombasticperks_627aad59c1b2", function(ctx)
    ctx:set_conditional("perk_condition", (H.char_skill(H.u(ctx), "fabrication") >= 6))
end)

ccb.runtime.handler("dlg_a_bombasticperks_51eee32e19e8", function(ctx)
    ctx:set_conditional("perk_condition", (H.char_need(H.u(ctx), "kcal_percent") >= 200))
end)

ccb.runtime.handler("dlg_a_bombasticperks_09b11fc33d6f", function(ctx)
    ctx:set_conditional("perk_condition", (H.char_skill(H.u(ctx), "shotgun") >= 6))
end)

ccb.runtime.handler("dlg_a_bombasticperks_8054176e2728", function(ctx)
    ctx:set_conditional("perk_condition", ((H.char_has_trait(H.u(ctx), "perk_secret_closet_storage") == 1) and (H.var_num(H.u(ctx), "current_level") >= 16)))
end)

ccb.runtime.handler("dlg_a_bombasticperks_62a403d957d5", function(ctx)
    ctx:set_conditional("perk_condition", ((H.char_skill(H.u(ctx), "cooking") >= 4) and (H.char_skill(H.u(ctx), "chemistry") >= 5)))
end)

ccb.runtime.handler("dlg_a_bombasticperks_6340dba7bbc7", function(ctx)
    ctx:set_conditional("perk_condition", ((H.char_skill(H.u(ctx), "speech") >= 4) and (H.char_skill(H.u(ctx), "survival") >= 8) and (not ((H.char_has_trait(H.u(ctx), "perk_hive_queen") == 1)))))
end)

ccb.runtime.handler("dlg_a_bombasticperks_ae70a741e12b", function(ctx)
    ctx:set_conditional("perk_condition", ((H.char_skill(H.u(ctx), "speech") >= 9) and (not ((H.char_has_trait(H.u(ctx), "perk_soothing_the_savage_beast") == 1)))))
end)

ccb.runtime.handler("dlg_a_bombasticperks_2ea5dd6a6047", function(ctx)
    ctx:set_conditional("perk_condition", (((H.char_has_trait(H.u(ctx), "perk_DEX_UP_2") == 1) or ((H.char_stat(H.u(ctx), "dexterity_base") + H.char_stat(H.u(ctx), "dexterity_bonus")) >= 13)) and (H.var_num(H.u(ctx), "current_level") >= 12)))
end)

ccb.runtime.handler("dlg_a_bombasticperks_88aa5f99229a", function(ctx)
    ctx:set_conditional("perk_condition", (not (H.char_has_any_trait(H.u(ctx), { "perk_portal_storm_mutator_bird", "perk_portal_storm_mutator_feline", "perk_portal_storm_mutator_insect", "perk_portal_storm_mutator_lupine", "perk_portal_storm_mutator_plant", "perk_portal_storm_mutator_spider" }))))
end)

ccb.runtime.handler("dlg_a_bombasticperks_78d23d9e9799", function(ctx)
    ctx:set_conditional("perk_condition", ((H.char_spell_level(H.u(ctx), "null") >= 12) and (H.var_num(H.u(ctx), "current_level") >= 9)))
end)

ccb.runtime.handler("dlg_a_bombasticperks_a0c04fd0f5bd", function(ctx)
    ctx:set_conditional("perk_condition", (H.char_spell_level(H.u(ctx), "null") >= 6))
end)

ccb.runtime.handler("dlg_a_bombasticperks_4a12c71410ac", function(ctx)
    ctx:set_conditional("perk_condition", ((H.char_spell_level(H.u(ctx), "null") >= 6) and (H.var_num(H.u(ctx), "current_level") >= 6)))
end)

ccb.runtime.handler("dlg_a_bombasticperks_ff160fc5e3c0", function(ctx)
    ctx:set_conditional("perk_condition", (H.char_spell_level(H.u(ctx), "null") >= 4))
end)

ccb.runtime.handler("dlg_a_bombasticperks_6af55c78739c", function(ctx)
    ctx:set_conditional("perk_condition", (H.char_spell_level(H.u(ctx), "null") >= 5))
end)

ccb.runtime.handler("dlg_a_bombasticperks_5c5eeb8c28f7", function(ctx)
    ctx:set_conditional("perk_condition", (H.char_spell_level(H.u(ctx), "null") >= 0))
end)

ccb.runtime.handler("dlg_a_bombasticperks_99dba4f1a4af", function(ctx)
    ctx:set_conditional("perk_condition", ((H.char_spell_level(H.u(ctx), "null") >= 14) and (H.var_num(H.u(ctx), "current_level") >= 12)))
end)

ccb.runtime.handler("dlg_a_bombasticperks_30f11bba1ce4", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "no_notifications", 0)
end)

ccb.runtime.handler("dlg_a_bombasticperks_cc661ab8e241", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "no_notifications", 1)
end)

ccb.runtime.handler("dlg_a_bombasticperks_aa346ea52a2f", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "exp_per_level", 0)
end)

ccb.runtime.handler("dlg_a_bombasticperks_a9b50a016adf", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "exp_per_level", 300)
end)

ccb.runtime.handler("dlg_a_bombasticperks_15e2b9fe1396", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "exp_per_level", 1000)
end)

ccb.runtime.handler("dlg_a_bombasticperks_fedd5c37b47b", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "exp_per_level", 10000)
end)

ccb.runtime.handler("dlg_a_bombasticperks_3d3d57b35045", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "no_prerecs", 0)
end)

ccb.runtime.handler("dlg_a_bombasticperks_6da35b6693a4", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "no_prerecs", 1)
end)

ccb.runtime.handler("dlg_a_bombasticperks_faf98775bee5", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "exp_to_perk", 100)
end)

ccb.runtime.handler("dlg_a_bombasticperks_74a2a4e87416", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "exp_to_perk", (services.interaction.input_number(services.translate("Exp until first level?"), math.floor(100)).value))
end)

ccb.runtime.handler("dlg_a_bombasticperks_4294d34cab8d", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "exp_per_level", (services.interaction.input_number(services.translate("Exp increase?"), math.floor(300)).value))
end)

ccb.runtime.handler("dlg_a_bombasticperks_01b6c388a2e6", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "perks_toward_playstyle_setting", 6)
    H.set_var("actor", H.u(ctx), ctx, "no_playstyle", 0)
end)

ccb.runtime.handler("dlg_a_bombasticperks_c2566afa7fc4", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "perks_toward_playstyle_setting", (services.interaction.input_number(services.translate("Lifestyle perks per playstyle perk?"), math.floor(6)).value))
    H.set_var("actor", H.u(ctx), ctx, "no_playstyle", 0)
end)

ccb.runtime.handler("dlg_a_bombasticperks_8509fcf26aa1", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "no_playstyle", 1)
end)

ccb.runtime.handler("dlg_a_bombasticperks_7a20bb3492bf", function(ctx)
    H.set_var("actor", H.u(ctx), ctx, "num_perks", 0)
    H.set_var("actor", H.u(ctx), ctx, "available_exp", 0)
    H.set_var("actor", H.u(ctx), ctx, "current_level", 0)
    H.set_var("actor", H.u(ctx), ctx, "playssty", 0)
    H.set_var("actor", H.u(ctx), ctx, "upgraded_to_new_bombastic_version", 1)
    H.set_var("actor", H.u(ctx), ctx, "playstyle_perks_available", 0)
end)
