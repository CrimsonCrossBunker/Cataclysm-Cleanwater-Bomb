local ccb = require("ccb")
local services = ccb.services
return function(E, H)
    local EOC = E.run
    local COND = E.cond
    COND["EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_TORRENTIAL_maintenance"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "PSI_TORRENTIAL_CHANNELING_active") == 1)) == true
    end
    EOC["EOC_PSIONICS_GAIN_NETHER_ATTUNEMENT_TORRENTIAL_maintenance"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "PSI_TORRENTIAL_CHANNELING_active") == 1)) then
        do local _a, _v = H.u(ctx), "vitamin_psionic_drain"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = (services.random.native_int(0, H.round_half_away(6)) + 1); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        return true
    end
    return false
    end
    COND["EOC_PSIONICS_SET_NETHER_ATTUNEMENT_BOOST_2"] = function(ctx)
        return ((not ((H.char_has_trait(H.u(ctx), "PSI_TORRENTIAL_CHANNELING_active") == 1)))) == true
    end
    EOC["EOC_PSIONICS_SET_NETHER_ATTUNEMENT_BOOST_2"] = function(ctx)
    if ((not ((H.char_has_trait(H.u(ctx), "PSI_TORRENTIAL_CHANNELING_active") == 1)))) then
        do
            local _sw9 = H.char_vitamin(H.u(ctx), "vitamin_psionic_drain")
            if _sw9 == 0 then
                H.set_var("actor", H.u(ctx), ctx, "nether_attunement_power_scaling", 0.75)
            elseif _sw9 == 15 then
                H.set_var("actor", H.u(ctx), ctx, "nether_attunement_power_scaling", 1)
            elseif _sw9 == 35 then
                H.set_var("actor", H.u(ctx), ctx, "nether_attunement_power_scaling", 1.04)
            elseif _sw9 == 55 then
                H.set_var("actor", H.u(ctx), ctx, "nether_attunement_power_scaling", 1.08)
            elseif _sw9 == 75 then
                H.set_var("actor", H.u(ctx), ctx, "nether_attunement_power_scaling", 1.13)
            elseif _sw9 == 95 then
                H.set_var("actor", H.u(ctx), ctx, "nether_attunement_power_scaling", 1.19)
            elseif _sw9 == 115 then
                H.set_var("actor", H.u(ctx), ctx, "nether_attunement_power_scaling", 1.26)
            elseif _sw9 == 135 then
                H.set_var("actor", H.u(ctx), ctx, "nether_attunement_power_scaling", 1.35)
            elseif _sw9 == 155 then
                H.set_var("actor", H.u(ctx), ctx, "nether_attunement_power_scaling", 1.45)
            elseif _sw9 == 175 then
                H.set_var("actor", H.u(ctx), ctx, "nether_attunement_power_scaling", 1.6)
            elseif _sw9 == 195 then
                H.set_var("actor", H.u(ctx), ctx, "nether_attunement_power_scaling", 1.8)
            elseif _sw9 == 215 then
                H.set_var("actor", H.u(ctx), ctx, "nether_attunement_power_scaling", 2.1)
            elseif _sw9 == 235 then
                H.set_var("actor", H.u(ctx), ctx, "nether_attunement_power_scaling", 3)
            elseif _sw9 == 245 then
                H.set_var("actor", H.u(ctx), ctx, "nether_attunement_power_scaling", 4)
            end
        end
        return true
    else
        do
            local _sw10 = H.char_vitamin(H.u(ctx), "vitamin_psionic_drain")
            if _sw10 == 0 then
                H.set_var("actor", H.u(ctx), ctx, "nether_attunement_power_scaling", 1)
            elseif _sw10 == 15 then
                H.set_var("actor", H.u(ctx), ctx, "nether_attunement_power_scaling", 1.15)
            elseif _sw10 == 35 then
                H.set_var("actor", H.u(ctx), ctx, "nether_attunement_power_scaling", 1.3)
            elseif _sw10 == 55 then
                H.set_var("actor", H.u(ctx), ctx, "nether_attunement_power_scaling", 1.45)
            elseif _sw10 == 75 then
                H.set_var("actor", H.u(ctx), ctx, "nether_attunement_power_scaling", 1.6)
            elseif _sw10 == 95 then
                H.set_var("actor", H.u(ctx), ctx, "nether_attunement_power_scaling", 1.8)
            elseif _sw10 == 115 then
                H.set_var("actor", H.u(ctx), ctx, "nether_attunement_power_scaling", 2)
            elseif _sw10 == 135 then
                H.set_var("actor", H.u(ctx), ctx, "nether_attunement_power_scaling", 2.25)
            elseif _sw10 == 155 then
                H.set_var("actor", H.u(ctx), ctx, "nether_attunement_power_scaling", 2.6)
            elseif _sw10 == 175 then
                H.set_var("actor", H.u(ctx), ctx, "nether_attunement_power_scaling", 3)
            elseif _sw10 == 195 then
                H.set_var("actor", H.u(ctx), ctx, "nether_attunement_power_scaling", 3.5)
            elseif _sw10 == 215 then
                H.set_var("actor", H.u(ctx), ctx, "nether_attunement_power_scaling", 4)
            elseif _sw10 == 235 then
                H.set_var("actor", H.u(ctx), ctx, "nether_attunement_power_scaling", 4.8)
            elseif _sw10 == 245 then
                H.set_var("actor", H.u(ctx), ctx, "nether_attunement_power_scaling", 6.5)
            end
        end
        return false
    end
    end
    COND["EOC_PSIONICS_SET_NETHER_ATTUNEMENT_BOOST"] = function(ctx)
        return (((not (((function() local eg = H.safe_id('effect', "effect_noetic_resilience"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not ((H.char_has_trait(H.u(ctx), "PSI_EXTENDED_CHANNELING_active") == 1))))) == true
    end
    EOC["EOC_PSIONICS_SET_NETHER_ATTUNEMENT_BOOST"] = function(ctx)
    if (((not (((function() local eg = H.safe_id('effect', "effect_noetic_resilience"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not ((H.char_has_trait(H.u(ctx), "PSI_EXTENDED_CHANNELING_active") == 1))))) then
        H.run_eoc("EOC_PSIONICS_SET_NETHER_ATTUNEMENT_BOOST_2", ctx, nil, nil, nil)
        return true
    else
        if ((function() local eg = H.safe_id('effect', "effect_noetic_resilience"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) then
            H.set_var("actor", H.u(ctx), ctx, "nether_attunement_power_scaling", 1.05)
        else
            do
                local _sw11 = H.char_vitamin(H.u(ctx), "vitamin_psionic_drain")
                if _sw11 == 0 then
                    H.set_var("actor", H.u(ctx), ctx, "nether_attunement_power_scaling", 0.6)
                elseif _sw11 == 15 then
                    H.set_var("actor", H.u(ctx), ctx, "nether_attunement_power_scaling", 0.75)
                elseif _sw11 == 35 then
                    H.set_var("actor", H.u(ctx), ctx, "nether_attunement_power_scaling", 0.82)
                elseif _sw11 == 55 then
                    H.set_var("actor", H.u(ctx), ctx, "nether_attunement_power_scaling", 0.9)
                elseif _sw11 == 75 then
                    H.set_var("actor", H.u(ctx), ctx, "nether_attunement_power_scaling", 0.97)
                elseif _sw11 == 95 then
                    H.set_var("actor", H.u(ctx), ctx, "nether_attunement_power_scaling", 1.04)
                elseif _sw11 == 115 then
                    H.set_var("actor", H.u(ctx), ctx, "nether_attunement_power_scaling", 1.1)
                elseif _sw11 == 135 then
                    H.set_var("actor", H.u(ctx), ctx, "nether_attunement_power_scaling", 1.18)
                elseif _sw11 == 155 then
                    H.set_var("actor", H.u(ctx), ctx, "nether_attunement_power_scaling", 1.26)
                elseif _sw11 == 175 then
                    H.set_var("actor", H.u(ctx), ctx, "nether_attunement_power_scaling", 1.35)
                elseif _sw11 == 195 then
                    H.set_var("actor", H.u(ctx), ctx, "nether_attunement_power_scaling", 1.45)
                elseif _sw11 == 215 then
                    H.set_var("actor", H.u(ctx), ctx, "nether_attunement_power_scaling", 1.6)
                elseif _sw11 == 235 then
                    H.set_var("actor", H.u(ctx), ctx, "nether_attunement_power_scaling", 1.8)
                elseif _sw11 == 245 then
                    H.set_var("actor", H.u(ctx), ctx, "nether_attunement_power_scaling", 2)
                end
            end
        end
        return false
    end
    end
    COND["EOC_PSIONICS_NETHER_ATTUNEMENT_CONSEQUENCES_SETUP"] = function(ctx)
        return ((H.test_eoc("EOC_CONDITION_SPELLCASTING_FINISH_TRAIT_AND_SCHOOL_LIST", ctx) and (H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 15))) == true
    end
    EOC["EOC_PSIONICS_NETHER_ATTUNEMENT_CONSEQUENCES_SETUP"] = function(ctx)
    if ((H.test_eoc("EOC_CONDITION_SPELLCASTING_FINISH_TRAIT_AND_SCHOOL_LIST", ctx) and (H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 15))) then
        H.set_var("actor", H.u(ctx), ctx, "latest_channeled_power_difficulty", (ctx:get_number("difficulty") or 0))
        H.run_eoc("EOC_PSIONICS_NETHER_ATTUNEMENT_CONSEQUENCES_CHECK_EXTENDED", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_PSIONICS_NETHER_ATTUNEMENT_CONSEQUENCES_CHECK_EXTENDED_2"] = function(ctx)
        return (services.random.native_probability((H.creature_effect_intensity(H.u(ctx), "effect_disease_psionic_drain")), (15))) == true
    end
    EOC["EOC_PSIONICS_NETHER_ATTUNEMENT_CONSEQUENCES_CHECK_EXTENDED_2"] = function(ctx)
    if (services.random.native_probability((H.creature_effect_intensity(H.u(ctx), "effect_disease_psionic_drain")), (15))) then
        H.run_eoc("EOC_PSIONICS_NETHER_ATTUNEMENT_CONSEQUENCES", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_PSIONICS_NETHER_ATTUNEMENT_CONSEQUENCES_CHECK_EXTENDED"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "PSI_EXTENDED_CHANNELING_active") == 1)) == true
    end
    EOC["EOC_PSIONICS_NETHER_ATTUNEMENT_CONSEQUENCES_CHECK_EXTENDED"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "PSI_EXTENDED_CHANNELING_active") == 1)) then
        H.run_eoc("EOC_PSIONICS_NETHER_ATTUNEMENT_CONSEQUENCES_CHECK_EXTENDED_2", ctx, nil, nil, nil)
        return true
    else
        H.run_eoc("EOC_PSIONICS_NETHER_ATTUNEMENT_CONSEQUENCES", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_PSIONICS_NETHER_ATTUNEMENT_CONSEQUENCES"] = function(ctx)
        return (((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 15) or ((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 15) and (H.char_has_trait(H.u(ctx), "PSI_EXTENDED_CHANNELING_active") == 1) and services.random.native_probability((1), (4))))) == true
    end
    EOC["EOC_PSIONICS_NETHER_ATTUNEMENT_CONSEQUENCES"] = function(ctx)
    if (((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 15) or ((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 15) and (H.char_has_trait(H.u(ctx), "PSI_EXTENDED_CHANNELING_active") == 1) and services.random.native_probability((1), (4))))) then
        do
            local _ids, _wts = {}, {}
            table.insert(_ids, "EOC_DRAIN_EFFECT_CHECK_HEADACHE"); table.insert(_wts, math.max(0, 12))
            table.insert(_ids, "EOC_DRAIN_EFFECT_CHECK_EXTRA_ATTUNEMENT"); table.insert(_wts, math.max(0, 9))
            table.insert(_ids, "EOC_NETHER_EFFECT_CHECK_COLD_WIND"); table.insert(_wts, math.max(0, 6))
            table.insert(_ids, "EOC_DRAIN_EFFECT_CHECK_HEALTH_CHANGE"); table.insert(_wts, math.max(0, 6))
            table.insert(_ids, "EOC_NETHER_EFFECT_CHECK_VOMIT"); table.insert(_wts, math.max(0, 9))
            table.insert(_ids, "EOC_DRAIN_EFFECT_CHECK_NOSEBLEED"); table.insert(_wts, math.max(0, 12))
            table.insert(_ids, "EOC_DRAIN_EFFECT_CHECK_STAMINA_LOSS"); table.insert(_wts, math.max(0, 8))
            table.insert(_ids, "EOC_NETHER_EFFECT_CHECK_CLAIR_BLURRED_SIGHT"); table.insert(_wts, math.max(0, 6))
            table.insert(_ids, "EOC_DRAIN_EFFECT_CHECK_POWER_SURGE"); table.insert(_wts, math.max(0, 5))
            table.insert(_ids, "EOC_DRAIN_EFFECT_CHECK_SLEEPINESS"); table.insert(_wts, math.max(0, 5))
            table.insert(_ids, "EOC_NETHER_EFFECT_CHECK_ATTUNEMENT_RAISING_EFFECT"); table.insert(_wts, math.max(0, 9))
            table.insert(_ids, "EOC_NETHER_EFFECT_CHECK_WEARINESS_EXTRA_CALORIE_EFFECT"); table.insert(_wts, math.max(0, 7))
            table.insert(_ids, "EOC_NETHER_EFFECT_CHECK_FEEDBACK"); table.insert(_wts, math.max(0, 9))
            table.insert(_ids, "EOC_NETHER_EFFECT_CHECK_OBSERVED"); table.insert(_wts, math.max(0, 6))
            table.insert(_ids, "EOC_NETHER_EFFECT_CHECK_PYROKINETIC_FEVER"); table.insert(_wts, math.max(0, 7))
            table.insert(_ids, "EOC_NETHER_EFFECT_CHECK_TELEPORTATION_INCORPOREALITY"); table.insert(_wts, math.max(0, 4))
            table.insert(_ids, "EOC_DRAIN_EFFECT_CHECK_TELEPORT_LOCK"); table.insert(_wts, math.max(0, 5))
            table.insert(_ids, "EOC_NETHER_EFFECT_CHECK_BIOKIN_METABOLIC_INVERSION"); table.insert(_wts, math.max(0, 5))
            table.insert(_ids, "EOC_NETHER_EFFECT_CHECK_ELECTROKINETIC_POWER_DRAIN"); table.insert(_wts, math.max(0, 5))
            table.insert(_ids, "EOC_DRAIN_EFFECT_CHECK_WEAKNESS"); table.insert(_wts, math.max(0, 5))
            table.insert(_ids, "EOC_NETHER_EFFECT_CHECK_PYROKINETIC_FOG"); table.insert(_wts, math.max(0, 4))
            table.insert(_ids, "EOC_NETHER_EFFECT_CHECK_EXTRA_KCAL"); table.insert(_wts, math.max(0, 6))
            table.insert(_ids, "EOC_NETHER_EFFECT_CHECK_MINDSHOCK_STUN"); table.insert(_wts, math.max(0, 6))
            table.insert(_ids, "EOC_NETHER_EFFECT_CHECK_ATTENUATION"); table.insert(_wts, math.max(0, 8))
            table.insert(_ids, "EOC_NETHER_EFFECT_CHECK_BREATHING"); table.insert(_wts, math.max(0, 5))
            table.insert(_ids, "EOC_NETHER_EFFECT_CHECK_FORCE_WAVE"); table.insert(_wts, math.max(0, 5))
            table.insert(_ids, "EOC_NETHER_EFFECT_CHECK_TELEPORT_MISJUMP"); table.insert(_wts, math.max(0, 4))
            table.insert(_ids, "EOC_NETHER_EFFECT_CHECK_PHOTOKIN_EMP"); table.insert(_wts, math.max(0, 3))
            table.insert(_ids, "EOC_NETHER_EFFECT_CHECK_NETHER_LIGHTNING"); table.insert(_wts, math.max(0, 3))
            table.insert(_ids, "EOC_NETHER_EFFECT_CHECK_TEMPORARY_TEAR_IN_REALITY"); table.insert(_wts, math.max(0, 2))
            table.insert(_ids, "EOC_NETHER_EFFECT_CHECK_NO_PSIONICS"); table.insert(_wts, math.max(0, 3))
            table.insert(_ids, "EOC_NETHER_EFFECT_CHECK_SUMMON_HOUNDS"); table.insert(_wts, math.max(0, 2))
            table.insert(_ids, "EOC_NETHER_EFFECT_CHECK_MUTATION"); table.insert(_wts, math.max(0, 2))
            table.insert(_ids, "EOC_NETHER_EFFECT_CHECK_RIFT"); table.insert(_wts, math.max(0, 1))
            local _wi = services.random.weighted_index(_wts)
            if _wi and _ids[_wi] then H.run_eoc(_ids[_wi], ctx) end
        end
        return true
    end
    return false
    end
    COND["EOC_DRAIN_EFFECT_CHECK_HEADACHE"] = function(ctx)
        return ((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 15)) == true
    end
    EOC["EOC_DRAIN_EFFECT_CHECK_HEADACHE"] = function(ctx)
    if ((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 15)) then
        if services.random.native_probability(((((H.clamp_num((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 60), 0, 100) + H.clamp_num(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 160) * 2.5), 0, 375)) + H._jm_nether_attune_difficulty_scaler(ctx, H.var_num(H.u(ctx), "latest_channeled_power_difficulty"))) + 5)), (1000)) then
            services.messages.add(ctx:expand_text(services.translate("Your head begins to throb.")), "bad")
            H.eoc_add_effect(H.u(ctx), "psionic_overload", (30 * services.random.native_float((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") / 2), (H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") * 2))), nil, nil, nil)
        end
        return true
    else
        H.run_eoc("EOC_PSIONICS_NETHER_ATTUNEMENT_CONSEQUENCES", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_NETHER_EFFECT_CHECK_COLD_WIND"] = function(ctx)
        return ((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 15)) == true
    end
    EOC["EOC_NETHER_EFFECT_CHECK_COLD_WIND"] = function(ctx)
    if ((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 15)) then
        if services.random.native_probability((((((H.clamp_num((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 50), 0, 80) + H.clamp_num(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 130) * 2.5), 0, 375)) + H._jm_nether_attune_difficulty_scaler(ctx, H.var_num(H.u(ctx), "latest_channeled_power_difficulty"))) + 30) + H._jm_nether_attune_torrential_channeling_influence(ctx))), (1000)) then
            services.messages.add(ctx:expand_text(services.translate("The temperature suddenly drops!")), "bad")
            H.eoc_cast_spell(H.u(ctx), "nether_attunement_cold_chill", false, { hit_self = true })
        end
        return true
    else
        H.run_eoc("EOC_PSIONICS_NETHER_ATTUNEMENT_CONSEQUENCES", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_DRAIN_EFFECT_CHECK_EXTRA_ATTUNEMENT"] = function(ctx)
        return ((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 15)) == true
    end
    EOC["EOC_DRAIN_EFFECT_CHECK_EXTRA_ATTUNEMENT"] = function(ctx)
    if ((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 15)) then
        if services.random.native_probability(((((((H.clamp_num((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 75), 0, 75) + H.clamp_num(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") * 2) - 150), 0, 145)) + H.clamp_num(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") * 3) - 225), 0, 75)) + H._jm_nether_attune_difficulty_scaler(ctx, H.var_num(H.u(ctx), "latest_channeled_power_difficulty"))) + 20) + H._jm_nether_attune_torrential_channeling_influence(ctx))), (1000)) then
            services.messages.add(ctx:expand_text(services.translate("You feel a strange tingling sensation.")), "mixed")
            do local _a, _v = H.u(ctx), "vitamin_psionic_drain"; local _g = H.safe_id('vitamin', _v); if _a and _g then local _r = services.needs.get_vitamin(_a, _g); local _cur = (_r.ok and _r.value) or 0; local _nxt = (services.random.native_int(0, H.round_half_away(5)) + 2); local _val = ("+=" == '=') and _nxt or (("+=" == '+=') and (_cur + _nxt) or (("+=" == '-=') and (_cur - _nxt) or (("+=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.needs.set_vitamin(_a, _g, math.floor(_val + 0.5)) end end
        end
        return true
    else
        H.run_eoc("EOC_PSIONICS_NETHER_ATTUNEMENT_CONSEQUENCES", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_DRAIN_EFFECT_CHECK_HEALTH_CHANGE"] = function(ctx)
        return ((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 25)) == true
    end
    EOC["EOC_DRAIN_EFFECT_CHECK_HEALTH_CHANGE"] = function(ctx)
    if ((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 25)) then
        if services.random.native_probability((((((H.clamp_num((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 70), 0, 50) + H.clamp_num(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 120) * 2), 0, 310)) + H._jm_nether_attune_difficulty_scaler(ctx, H.var_num(H.u(ctx), "latest_channeled_power_difficulty"))) + 15) + H._jm_nether_attune_torrential_channeling_influence(ctx))), (1000)) then
            if (services.random.native_int(0, H.round_half_away(2)) >= 2) then
                H.set_char_health(H.u(ctx), (services.random.native_int(0, H.round_half_away(25)) + 5), "+=")
                services.messages.add(ctx:expand_text(services.translate("You feel filled with vigor.")), "good")
            else
                H.set_char_health(H.u(ctx), (services.random.native_int(0, H.round_half_away(25)) + 5), "-=")
                services.messages.add(ctx:expand_text(services.translate("You feel drained of vitality.")), "bad")
            end
        end
        return true
    else
        H.run_eoc("EOC_PSIONICS_NETHER_ATTUNEMENT_CONSEQUENCES", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_NETHER_EFFECT_CHECK_VOMIT"] = function(ctx)
        return ((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 50)) == true
    end
    EOC["EOC_NETHER_EFFECT_CHECK_VOMIT"] = function(ctx)
    if ((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 50)) then
        if services.random.native_probability((((((H.clamp_num(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 80) * 1.25), 0, 87.5) + H.clamp_num(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 150) * 2.5), 0, 300)) + H._jm_nether_attune_difficulty_scaler(ctx, H.var_num(H.u(ctx), "latest_channeled_power_difficulty"))) + 20) + H._jm_nether_attune_torrential_channeling_influence(ctx))), (1000)) then
            services.messages.add(ctx:expand_text(services.translate("As you unleash your powers, your stomach churns!")), "bad")
            H.eoc_cast_spell(H.u(ctx), "nether_attunement_vomit", false, { hit_self = true })
        end
        return true
    else
        H.run_eoc("EOC_PSIONICS_NETHER_ATTUNEMENT_CONSEQUENCES", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_DRAIN_EFFECT_CHECK_NOSEBLEED"] = function(ctx)
        return ((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 25)) == true
    end
    EOC["EOC_DRAIN_EFFECT_CHECK_NOSEBLEED"] = function(ctx)
    if ((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 25)) then
        if services.random.native_probability((((((H.clamp_num(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 60) * 1.25), 0, 112.5) + H.clamp_num(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 150) * 2.5), 0, 372.5)) + H._jm_nether_attune_difficulty_scaler(ctx, H.var_num(H.u(ctx), "latest_channeled_power_difficulty"))) + 10) + H._jm_nether_attune_torrential_channeling_influence(ctx))), (1000)) then
            services.messages.add(ctx:expand_text(services.translate("Blood drips from your nose.")), "bad")
            H.eoc_add_effect(H.u(ctx), "bleed", 300, "head", 1, nil)
            H.set_char_hp(H.u(ctx), "head", 1, "-=")
        end
        return true
    else
        H.run_eoc("EOC_PSIONICS_NETHER_ATTUNEMENT_CONSEQUENCES", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_DRAIN_EFFECT_CHECK_STAMINA_LOSS"] = function(ctx)
        return ((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 50)) == true
    end
    EOC["EOC_DRAIN_EFFECT_CHECK_STAMINA_LOSS"] = function(ctx)
    if ((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 50)) then
        if services.random.native_probability(((((((H.clamp_num((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 100), 0, 60) + H.clamp_num(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 160) * 2), 0, 80)) + H.clamp_num(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 200) * 3), 0, 150)) + H._jm_nether_attune_difficulty_scaler(ctx, H.var_num(H.u(ctx), "latest_channeled_power_difficulty"))) + 20) + H._jm_nether_attune_torrential_channeling_influence(ctx))), (1000)) then
            services.messages.add(ctx:expand_text(services.translate("You feel a sudden wave of fatigue.")), "bad")
            H.set_char_val_extra(H.u(ctx), "stamina", services.random.native_float(3000, 9000), "-=")
        end
        return true
    else
        H.run_eoc("EOC_PSIONICS_NETHER_ATTUNEMENT_CONSEQUENCES", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_NETHER_EFFECT_CHECK_CLAIR_BLURRED_SIGHT"] = function(ctx)
        return ((((("CLAIRSENTIENT") == (H.var_str("context", nil, ctx, "school", "")))) and (H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 55))) == true
    end
    EOC["EOC_NETHER_EFFECT_CHECK_CLAIR_BLURRED_SIGHT"] = function(ctx)
    if ((((("CLAIRSENTIENT") == (H.var_str("context", nil, ctx, "school", "")))) and (H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 55))) then
        if services.random.native_probability((((((H.clamp_num(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 95) * 1.5), 0, 90) + H.clamp_num(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 155) * 2.5), 0, 300)) + H._jm_nether_attune_difficulty_scaler(ctx, H.var_num(H.u(ctx), "latest_channeled_power_difficulty"))) + 30) + H._jm_nether_attune_torrential_channeling_influence(ctx))), (1000)) then
            services.messages.add(ctx:expand_text(services.translate("As you unleash your powers, your vision blurs!")), "bad")
            H.eoc_add_effect(H.u(ctx), "effect_nether_attunement_clair_blurred_sight", (1200 * services.random.native_float((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") / 2), (H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") * 2))), nil, nil, nil)
        end
        return true
    else
        H.run_eoc("EOC_PSIONICS_NETHER_ATTUNEMENT_CONSEQUENCES", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_DRAIN_EFFECT_CHECK_SLEEPINESS"] = function(ctx)
        return ((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 70)) == true
    end
    EOC["EOC_DRAIN_EFFECT_CHECK_SLEEPINESS"] = function(ctx)
    if ((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 70)) then
        if services.random.native_probability(((((((H.clamp_num(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") * 1.5) - 125), 0, 75) + H.clamp_num(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 175) * 4.5), 0, 225)) + H.clamp_num(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 225) * 6.5), 0, 300)) + H._jm_nether_attune_difficulty_scaler(ctx, H.var_num(H.u(ctx), "latest_channeled_power_difficulty"))) + 20) + H._jm_nether_attune_torrential_channeling_influence(ctx))), (1000)) then
            services.messages.add(ctx:expand_text(services.translate("You feel a sudden wave of exhaustion and stifle a yawn.")), "bad")
            H.set_char_val_extra(H.u(ctx), "sleepiness", services.random.native_float(30, 90), "+=")
        end
        return true
    else
        H.run_eoc("EOC_PSIONICS_NETHER_ATTUNEMENT_CONSEQUENCES", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_NETHER_EFFECT_CHECK_ATTUNEMENT_RAISING_EFFECT"] = function(ctx)
        return ((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 70)) == true
    end
    EOC["EOC_NETHER_EFFECT_CHECK_ATTUNEMENT_RAISING_EFFECT"] = function(ctx)
    if ((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 70)) then
        if services.random.native_probability((((((H.clamp_num(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 90) * 1.5), 0, 127.5) + H.clamp_num(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 175) * 3), 0, 375)) + H._jm_nether_attune_difficulty_scaler(ctx, H.var_num(H.u(ctx), "latest_channeled_power_difficulty"))) + 30) + H._jm_nether_attune_torrential_channeling_influence(ctx))), (1000)) then
            services.messages.add(ctx:expand_text(services.translate("You feel a strange tingling sensation that does not go away.")), "mixed")
            H.eoc_add_effect(H.u(ctx), "effect_nether_attunement_raiser", (600 * services.random.native_float((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") / 2), (H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") * 2))), nil, nil, nil)
        end
        return true
    else
        H.run_eoc("EOC_PSIONICS_NETHER_ATTUNEMENT_CONSEQUENCES", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_NETHER_EFFECT_CHECK_WEARINESS_EXTRA_CALORIE_EFFECT"] = function(ctx)
        return (((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 70) or (H.char_has_trait(H.u(ctx), "PSI_TORRENTIAL_CHANNELING_active") == 1))) == true
    end
    EOC["EOC_NETHER_EFFECT_CHECK_WEARINESS_EXTRA_CALORIE_EFFECT"] = function(ctx)
    if (((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 70) or (H.char_has_trait(H.u(ctx), "PSI_TORRENTIAL_CHANNELING_active") == 1))) then
        if services.random.native_probability((((((H.clamp_num(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 90) * 1.5), 0, 127.5) + H.clamp_num(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 175) * 3), 0, 375)) + H._jm_nether_attune_difficulty_scaler(ctx, H.var_num(H.u(ctx), "latest_channeled_power_difficulty"))) + 30) + H._jm_nether_attune_torrential_channeling_influence(ctx))), (1000)) then
            services.messages.add(ctx:expand_text(services.translate("You feel a wave of bone-deep weariness.")), "bad")
            do local _a = H.u(ctx); if _a then if "-=" == '=' then services.needs.set_calories(_a, math.floor(services.random.native_float((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") * 4), (H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") * 10)) + 0.5)) else local _cur = (((H.char_snap(_a) or {}).needs or {}).stored_kcal or 0); local _nxt = services.random.native_float((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") * 4), (H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") * 10)); local _d = ("-=" == '+=') and _nxt or (("-=" == '-=') and -_nxt or (("-=" == '*=') and (_cur * _nxt - _cur) or (_cur / _nxt - _cur))); services.needs.modify_calories(_a, math.floor(_d + 0.5), false) end end end
        end
        return true
    else
        H.run_eoc("EOC_PSIONICS_NETHER_ATTUNEMENT_CONSEQUENCES", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_NETHER_EFFECT_CHECK_FEEDBACK"] = function(ctx)
        return ((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 100)) == true
    end
    EOC["EOC_NETHER_EFFECT_CHECK_FEEDBACK"] = function(ctx)
    if ((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 100)) then
        if services.random.native_probability(((((((H.clamp_num(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 135) * 1.5), 0, 60) + H.clamp_num(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 175) * 2.5), 0, 87.5)) + H.clamp_num(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 210) * 5), 0, 300)) + H._jm_nether_attune_difficulty_scaler(ctx, H.var_num(H.u(ctx), "latest_channeled_power_difficulty"))) + 30) + H._jm_nether_attune_torrential_channeling_influence(ctx))), (1000)) then
            services.messages.add(ctx:expand_text(services.translate("You feel a stabbing pain!")), "good")
            local _a12 = H.u(ctx)
            if _a12 then services.characters.adjust(_a12, { pain = math.floor((services.random.native_int(0, H.round_half_away(7)) + 3)) }) end
            H.eoc_add_effect(H.u(ctx), "effect_nether_attunement_feedback", (120 * services.random.native_float((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") / 2), (H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") * 2))), nil, nil, nil)
        end
        return true
    else
        H.run_eoc("EOC_PSIONICS_NETHER_ATTUNEMENT_CONSEQUENCES", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_DRAIN_EFFECT_CHECK_POWER_SURGE"] = function(ctx)
        return (((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 85) or (H.char_has_trait(H.u(ctx), "PSI_TORRENTIAL_CHANNELING_active") == 1))) == true
    end
    EOC["EOC_DRAIN_EFFECT_CHECK_POWER_SURGE"] = function(ctx)
    if (((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 85) or (H.char_has_trait(H.u(ctx), "PSI_TORRENTIAL_CHANNELING_active") == 1))) then
        if services.random.native_probability((((((H.clamp_num(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 120) * 2), 0, 120) + H.clamp_num(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 180) * 3.5), 0, 250)) + H._jm_nether_attune_difficulty_scaler(ctx, H.var_num(H.u(ctx), "latest_channeled_power_difficulty"))) + 15) + H._jm_nether_attune_torrential_channeling_influence(ctx))), (1000)) then
            services.messages.add(ctx:expand_text(services.translate("You feel a surge of strength!")), "good")
            H.eoc_add_effect(H.u(ctx), "effect_nether_attunement_power_surge", (H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") * services.random.native_float(1, 10)), nil, nil, nil)
        end
        return true
    else
        H.run_eoc("EOC_PSIONICS_NETHER_ATTUNEMENT_CONSEQUENCES", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_NETHER_EFFECT_CHECK_OBSERVED"] = function(ctx)
        return ((((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 75) or (H.char_has_trait(H.u(ctx), "PSI_TORRENTIAL_CHANNELING_active") == 1)) and (not ((H.char_has_trait(H.u(ctx), "PSI_EXTENDED_CHANNELING_active") == 1))))) == true
    end
    EOC["EOC_NETHER_EFFECT_CHECK_OBSERVED"] = function(ctx)
    if ((((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 75) or (H.char_has_trait(H.u(ctx), "PSI_TORRENTIAL_CHANNELING_active") == 1)) and (not ((H.char_has_trait(H.u(ctx), "PSI_EXTENDED_CHANNELING_active") == 1))))) then
        if services.random.native_probability((((((H.clamp_num(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 130) * 1.5), 0, 90) + H.clamp_num(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 190) * 3), 0, 250)) + H._jm_nether_attune_difficulty_scaler(ctx, H.var_num(H.u(ctx), "latest_channeled_power_difficulty"))) + 20) + H._jm_nether_attune_torrential_channeling_influence(ctx))), (1000)) then
            services.messages.add(ctx:expand_text(services.translate("You feel like you're being watched.")), "bad")
            H.set_var("context", nil, ctx, "duration", ((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") * services.random.native_float(150, 600)) + 86400))
            if ((function() local eg = H.safe_id('effect', "psi_nether_attention"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) then
                H.eoc_add_effect(H.u(ctx), "psi_nether_attention", ((ctx:get_number("duration") or 0) / 4), nil, nil, nil)
            else
                H.eoc_add_effect(H.u(ctx), "psi_nether_attention", (ctx:get_number("duration") or 0), nil, nil, nil)
            end
        end
        return true
    else
        H.run_eoc("EOC_PSIONICS_NETHER_ATTUNEMENT_CONSEQUENCES", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_NETHER_EFFECT_CHECK_PYROKINETIC_FEVER"] = function(ctx)
        return ((((("PYROKINETIC") == (H.var_str("context", nil, ctx, "school", "")))) and (H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 75))) == true
    end
    EOC["EOC_NETHER_EFFECT_CHECK_PYROKINETIC_FEVER"] = function(ctx)
    if ((((("PYROKINETIC") == (H.var_str("context", nil, ctx, "school", "")))) and (H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 75))) then
        if services.random.native_probability((((((H.clamp_num(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 120) * 1.5), 0, 105) + H.clamp_num(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 180) * 3), 0, 375)) + H._jm_nether_attune_difficulty_scaler(ctx, H.var_num(H.u(ctx), "latest_channeled_power_difficulty"))) + 25) + H._jm_nether_attune_torrential_channeling_influence(ctx))), (1000)) then
            services.messages.add(ctx:expand_text(services.translate("You feel feverish and weak.")), "bad")
            H.eoc_add_effect(H.u(ctx), "effect_nether_attunement_pyrokinetic_fever", (600 * services.random.native_float((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") / 2), (H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") * 2))), nil, nil, nil)
        end
        return true
    else
        H.run_eoc("EOC_PSIONICS_NETHER_ATTUNEMENT_CONSEQUENCES", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_NETHER_EFFECT_CHECK_TELEPORTATION_INCORPOREALITY"] = function(ctx)
        return ((((("teleport_ephemeral_walk") == (H.var_str("context", nil, ctx, "spell", "")))) and (H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 85))) == true
    end
    EOC["EOC_NETHER_EFFECT_CHECK_TELEPORTATION_INCORPOREALITY"] = function(ctx)
    if ((((("teleport_ephemeral_walk") == (H.var_str("context", nil, ctx, "spell", "")))) and (H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 85))) then
        if services.random.native_probability(((((((H.clamp_num(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 125) * 1.5), 0, 75) + H.clamp_num(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 175) * 3), 0, 180)) + H.clamp_num(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 235) * 5), 0, 300)) + H._jm_nether_attune_difficulty_scaler(ctx, H.var_num(H.u(ctx), "latest_channeled_power_difficulty"))) + 40) + H._jm_nether_attune_torrential_channeling_influence(ctx))), (1000)) then
            services.messages.add(ctx:expand_text(services.translate("Your body has as much substance as smoke!")), "bad")
            H.eoc_add_effect(H.u(ctx), "incorporeal", (1 * services.random.native_float((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") / 2), (H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") * 2))), nil, nil, nil)
        end
        return true
    else
        H.run_eoc("EOC_PSIONICS_NETHER_ATTUNEMENT_CONSEQUENCES", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_DRAIN_EFFECT_CHECK_TELEPORT_LOCK"] = function(ctx)
        return ((((("TELEPORTER") == (H.var_str("context", nil, ctx, "school", "")))) and (H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 85))) == true
    end
    EOC["EOC_DRAIN_EFFECT_CHECK_TELEPORT_LOCK"] = function(ctx)
    if ((((("TELEPORTER") == (H.var_str("context", nil, ctx, "school", "")))) and (H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 85))) then
        if services.random.native_probability((((((H.clamp_num(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 120) * 1.5), 0, 105) + H.clamp_num(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 190) * 3.5), 0, 375)) + H._jm_nether_attune_difficulty_scaler(ctx, H.var_num(H.u(ctx), "latest_channeled_power_difficulty"))) + 20) + H._jm_nether_attune_torrential_channeling_influence(ctx))), (1000)) then
            services.messages.add(ctx:expand_text(services.translate("Your skin feels tight!")), "bad")
            H.eoc_add_effect(H.u(ctx), "effect_psi_teleport_lock", (30 * services.random.native_float((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") / 2), (H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") * 2))), nil, nil, nil)
        end
        return true
    else
        H.run_eoc("EOC_PSIONICS_NETHER_ATTUNEMENT_CONSEQUENCES", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_NETHER_EFFECT_CHECK_BIOKIN_METABOLIC_INVERSION"] = function(ctx)
        return ((((("BIOKINETIC") == (H.var_str("context", nil, ctx, "school", "")))) and (H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 85))) == true
    end
    EOC["EOC_NETHER_EFFECT_CHECK_BIOKIN_METABOLIC_INVERSION"] = function(ctx)
    if ((((("BIOKINETIC") == (H.var_str("context", nil, ctx, "school", "")))) and (H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 85))) then
        if services.random.native_probability((((((H.clamp_num((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 120), 0, 70) + H.clamp_num(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 190) * 2.5), 0, 375)) + H._jm_nether_attune_difficulty_scaler(ctx, H.var_num(H.u(ctx), "latest_channeled_power_difficulty"))) + 10) + H._jm_nether_attune_torrential_channeling_influence(ctx))), (1000)) then
            services.messages.add(ctx:expand_text(services.translate("Your throat and stomach feel warm.")), "bad")
            H.eoc_add_effect(H.u(ctx), "effect_nether_attunement_biokinetic_inversion", (600 * services.random.native_float((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") / 2), (H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") * 2))), nil, nil, nil)
        end
        return true
    else
        H.run_eoc("EOC_PSIONICS_NETHER_ATTUNEMENT_CONSEQUENCES", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_NETHER_EFFECT_CHECK_ELECTROKINETIC_POWER_DRAIN"] = function(ctx)
        return ((((("ELECTROKINETIC") == (H.var_str("context", nil, ctx, "school", "")))) and (H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 85))) == true
    end
    EOC["EOC_NETHER_EFFECT_CHECK_ELECTROKINETIC_POWER_DRAIN"] = function(ctx)
    if ((((("ELECTROKINETIC") == (H.var_str("context", nil, ctx, "school", "")))) and (H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 85))) then
        if services.random.native_probability((((((H.clamp_num((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 120), 0, 70) + H.clamp_num(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 190) * 3.5), 0, 375)) + H._jm_nether_attune_difficulty_scaler(ctx, H.var_num(H.u(ctx), "latest_channeled_power_difficulty"))) + 10) + H._jm_nether_attune_torrential_channeling_influence(ctx))), (1000)) then
            services.messages.add(ctx:expand_text(services.translate("Your skin breaks out in goosebumps.")), "bad")
            H.eoc_add_effect(H.u(ctx), "effect_nether_attunement_electrokinetic_power_drain", (900 * services.random.native_float((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") / 2), (H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") * 2))), nil, nil, nil)
            H.run_eoc("EOC_NETHER_EFFECT_ELECTROKINETIC_POWER_DRAIN", ctx, nil, nil, nil)
        end
        return true
    else
        H.run_eoc("EOC_PSIONICS_NETHER_ATTUNEMENT_CONSEQUENCES", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_DRAIN_EFFECT_CHECK_WEAKNESS"] = function(ctx)
        return ((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 100)) == true
    end
    EOC["EOC_DRAIN_EFFECT_CHECK_WEAKNESS"] = function(ctx)
    if ((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 100)) then
        if services.random.native_probability((((((H.clamp_num(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 150) * 2), 0, 140) + H.clamp_num(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 220) * 5), 0, 300)) + H._jm_nether_attune_difficulty_scaler(ctx, H.var_num(H.u(ctx), "latest_channeled_power_difficulty"))) + 20) + H._jm_nether_attune_torrential_channeling_influence(ctx))), (1000)) then
            services.messages.add(ctx:expand_text(services.translate("Your muscles tremble and weaken.")), "bad")
            H.eoc_add_effect(H.u(ctx), "effect_biokin_overload", (30 * services.random.native_float((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") / 2), (H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") * 2))), nil, nil, nil)
        end
        return true
    else
        H.run_eoc("EOC_PSIONICS_NETHER_ATTUNEMENT_CONSEQUENCES", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_NETHER_EFFECT_CHECK_PYROKINETIC_FOG"] = function(ctx)
        return ((((("PYROKINETIC") == (H.var_str("context", nil, ctx, "school", "")))) and (H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 85))) == true
    end
    EOC["EOC_NETHER_EFFECT_CHECK_PYROKINETIC_FOG"] = function(ctx)
    if ((((("PYROKINETIC") == (H.var_str("context", nil, ctx, "school", "")))) and (H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 85))) then
        if services.random.native_probability((((((H.clamp_num((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 120), 0, 70) + H.clamp_num(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 190) * 2.5), 0, 375)) + H._jm_nether_attune_difficulty_scaler(ctx, H.var_num(H.u(ctx), "latest_channeled_power_difficulty"))) + 10) + H._jm_nether_attune_torrential_channeling_influence(ctx))), (1000)) then
            services.messages.add(ctx:expand_text(services.translate("Your skin feels a cycle of hot and cold flashes as the temperature drops and humidity rises.")), "bad")
            H.eoc_add_effect(H.u(ctx), "effect_nether_attunement_pyrokinetic_fog", (240 * services.random.native_float((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") / 2), (H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") * 2))), nil, nil, nil)
        end
        return true
    else
        H.run_eoc("EOC_PSIONICS_NETHER_ATTUNEMENT_CONSEQUENCES", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_NETHER_EFFECT_CHECK_EXTRA_KCAL"] = function(ctx)
        return ((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 110)) == true
    end
    EOC["EOC_NETHER_EFFECT_CHECK_EXTRA_KCAL"] = function(ctx)
    if ((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 110)) then
        if services.random.native_probability((((((H.clamp_num(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 150) * 2), 0, 60) + H.clamp_num(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 180) * 4), 0, 300)) + H._jm_nether_attune_difficulty_scaler(ctx, H.var_num(H.u(ctx), "latest_channeled_power_difficulty"))) + 40) + H._jm_nether_attune_torrential_channeling_influence(ctx))), (1000)) then
            services.messages.add(ctx:expand_text(services.translate("As you unleash your powers, your stomach rumbles!")), "bad")
            H.eoc_add_effect(H.u(ctx), "effect_nether_attunement_extra_kcal", (7200 + services.random.native_int(0, H.round_half_away(86400))), nil, nil, nil)
        end
        return true
    else
        H.run_eoc("EOC_PSIONICS_NETHER_ATTUNEMENT_CONSEQUENCES", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_NETHER_EFFECT_CHECK_MINDSHOCK_STUN"] = function(ctx)
        return (((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 115) or (H.char_has_trait(H.u(ctx), "PSI_TORRENTIAL_CHANNELING_active") == 1))) == true
    end
    EOC["EOC_NETHER_EFFECT_CHECK_MINDSHOCK_STUN"] = function(ctx)
    if (((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 115) or (H.char_has_trait(H.u(ctx), "PSI_TORRENTIAL_CHANNELING_active") == 1))) then
        if services.random.native_probability((((((H.clamp_num(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 150) * 2), 0, 60) + H.clamp_num(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 180) * 3.5), 0, 300)) + H._jm_nether_attune_difficulty_scaler(ctx, H.var_num(H.u(ctx), "latest_channeled_power_difficulty"))) + 30) + H._jm_nether_attune_torrential_channeling_influence(ctx))), (1000)) then
            services.messages.add(ctx:expand_text(services.translate("Power floods into your mind, washing away all other thought!")), "bad")
            H.eoc_add_effect(H.u(ctx), "stunned", (2 + services.random.native_int(0, H.round_half_away((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") / 50)))), nil, nil, nil)
            H.eoc_add_effect(H.u(ctx), "psi_stunned", (2 + services.random.native_int(0, H.round_half_away((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") / 50)))), nil, nil, nil)
        end
        return true
    else
        H.run_eoc("EOC_PSIONICS_NETHER_ATTUNEMENT_CONSEQUENCES", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_NETHER_EFFECT_CHECK_ATTENUATION"] = function(ctx)
        return (((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 125) or (H.char_has_trait(H.u(ctx), "PSI_TORRENTIAL_CHANNELING_active") == 1))) == true
    end
    EOC["EOC_NETHER_EFFECT_CHECK_ATTENUATION"] = function(ctx)
    if (((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 125) or (H.char_has_trait(H.u(ctx), "PSI_TORRENTIAL_CHANNELING_active") == 1))) then
        if services.random.native_probability((((((H.clamp_num(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 160) * 1.5), 0, 75) + H.clamp_num(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 210) * 3.5), 0, 300)) + H._jm_nether_attune_difficulty_scaler(ctx, H.var_num(H.u(ctx), "latest_channeled_power_difficulty"))) + 40) + H._jm_nether_attune_torrential_channeling_influence(ctx))), (1000)) then
            services.messages.add(ctx:expand_text(services.translate("The flow of Netherum energy resists your control.")), "bad")
            H.eoc_add_effect(H.u(ctx), "effect_nether_attunement_attenuation", (30 * services.random.native_float((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") / 2), (H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") * 2))), nil, nil, nil)
        end
        return true
    else
        H.run_eoc("EOC_PSIONICS_NETHER_ATTUNEMENT_CONSEQUENCES", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_NETHER_EFFECT_CHECK_BREATHING"] = function(ctx)
        return ((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 100)) == true
    end
    EOC["EOC_NETHER_EFFECT_CHECK_BREATHING"] = function(ctx)
    if ((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 100)) then
        if services.random.native_probability((((((H.clamp_num(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 150) * 1.5), 0, 105) + H.clamp_num(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 220) * 4), 0, 300)) + H._jm_nether_attune_difficulty_scaler(ctx, H.var_num(H.u(ctx), "latest_channeled_power_difficulty"))) + 30) + H._jm_nether_attune_torrential_channeling_influence(ctx))), (1000)) then
            services.messages.add(ctx:expand_text(services.translate("You gasp and your breath gives out.")), "bad")
            H.eoc_add_effect(H.u(ctx), "effect_psi_reduced_breathing", (30 * services.random.native_float((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") / 2), (H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") * 2))), nil, nil, nil)
        end
        return true
    else
        H.run_eoc("EOC_PSIONICS_NETHER_ATTUNEMENT_CONSEQUENCES", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_NETHER_EFFECT_CHECK_HALLUCINATIONS"] = function(ctx)
        return ((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 125)) == true
    end
    EOC["EOC_NETHER_EFFECT_CHECK_HALLUCINATIONS"] = function(ctx)
    if ((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 125)) then
        if services.random.native_probability((((((H.clamp_num((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 160), 0, 50) + H.clamp_num(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 210) * 3.5), 0, 160)) + H._jm_nether_attune_difficulty_scaler(ctx, H.var_num(H.u(ctx), "latest_channeled_power_difficulty"))) + 10) + H._jm_nether_attune_torrential_channeling_influence(ctx))), (1000)) then
            services.messages.add(ctx:expand_text(services.translate("You begin to feel a sudden sense of dread and paranoia!")), "bad")
            H.eoc_add_effect(H.u(ctx), "hallu", (90 * services.random.native_float((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") / 2), (H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") * 2))), nil, nil, nil)
        end
        return true
    else
        H.run_eoc("EOC_PSIONICS_NETHER_ATTUNEMENT_CONSEQUENCES", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_NETHER_EFFECT_CHECK_FORCE_WAVE"] = function(ctx)
        return ((((("TELEKINETIC") == (H.var_str("context", nil, ctx, "school", "")))) and (H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 125))) == true
    end
    EOC["EOC_NETHER_EFFECT_CHECK_FORCE_WAVE"] = function(ctx)
    if ((((("TELEKINETIC") == (H.var_str("context", nil, ctx, "school", "")))) and (H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 125))) then
        if services.random.native_probability((((((H.clamp_num(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") * 1.5) - 160), 0, 67.5) + H.clamp_num(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 205) * 4.5), 0, 300)) + H._jm_nether_attune_difficulty_scaler(ctx, H.var_num(H.u(ctx), "latest_channeled_power_difficulty"))) + 30) + H._jm_nether_attune_torrential_channeling_influence(ctx))), (1000)) then
            services.messages.add(ctx:expand_text(services.translate("A soundless explosion hurls you off your feet.")), "bad")
            H.eoc_cast_spell(H.u(ctx), "nether_attunement_everyone_downed", false, { hit_self = true })
        end
        return true
    else
        H.run_eoc("EOC_PSIONICS_NETHER_ATTUNEMENT_CONSEQUENCES", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_NETHER_EFFECT_CHECK_NO_PSIONICS"] = function(ctx)
        return ((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 150)) == true
    end
    EOC["EOC_NETHER_EFFECT_CHECK_NO_PSIONICS"] = function(ctx)
    if ((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 150)) then
        if services.random.native_probability((((((H.clamp_num(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") * 1.5) - 200), 0, 37.5) + H.clamp_num(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 225) * 5), 0, 300)) + H._jm_nether_attune_difficulty_scaler(ctx, H.var_num(H.u(ctx), "latest_channeled_power_difficulty"))) + 20) + H._jm_nether_attune_torrential_channeling_influence(ctx))), (1000)) then
            services.messages.add(ctx:expand_text(services.translate("The flow of Nether energy is suddenly cut off!")), "bad")
            H.eoc_add_effect(H.u(ctx), "effect_psi_null_unbound", (180 * services.random.native_float((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") / 2), (H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") * 2))), nil, nil, nil)
            H.eoc_add_effect(H.u(ctx), "effect_psi_neutralized", 2, nil, nil, nil)
        end
        return true
    else
        H.run_eoc("EOC_PSIONICS_NETHER_ATTUNEMENT_CONSEQUENCES", ctx, nil, nil, nil)
        return false
    end
    end
    EOC["EOC_NETHER_EFFECT_APPLY_TELEPORT_MISJUMP"] = function(ctx)
    do
        local _sw13 = services.random.native_int(0, H.round_half_away(30))
        if _sw13 == 0 then
            H.eoc_loc_var(H.u(ctx), ctx, "context", "teleport_mishap_location", { terrain = "field", match = "CONTAINS" }, { z = math.floor(0), search_range = math.floor((300 + (50 * H.clamp_num(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 149) / 10), 1, 15)))), min_distance = math.floor((100 + (10 * H.clamp_num(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 149) / 10), 1, 15)))), random = true }, nil, nil, nil, false, true, {  }, {  })
        elseif _sw13 == 10 then
            H.eoc_loc_var(H.u(ctx), ctx, "context", "teleport_mishap_location", { terrain = "forest", match = "CONTAINS" }, { z = math.floor(0), search_range = math.floor((300 + (50 * H.clamp_num(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 149) / 10), 1, 15)))), min_distance = math.floor((100 + (10 * H.clamp_num(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 149) / 10), 1, 15)))), random = true }, nil, nil, nil, false, true, {  }, {  })
        elseif _sw13 == 20 then
            H.eoc_loc_var(H.u(ctx), ctx, "context", "teleport_mishap_location", { terrain = "house", match = "CONTAINS" }, { z = math.floor(0), search_range = math.floor((300 + (50 * H.clamp_num(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 149) / 10), 1, 15)))), min_distance = math.floor((100 + (10 * H.clamp_num(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 149) / 10), 1, 15)))), random = true }, nil, nil, nil, false, true, {  }, {  })
        elseif _sw13 == 30 then
            H.eoc_loc_var(H.u(ctx), ctx, "context", "teleport_mishap_location", { terrain = "nether_glass_deep" }, { z = math.floor(-10), search_range = math.floor((300 + (50 * H.clamp_num(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 149) / 10), 1, 15)))), min_distance = math.floor(1), random = true }, nil, nil, nil, false, true, {  }, {  })
        end
    end
    do local _p = H.get_tripoint_var("context", nil, ctx, "teleport_mishap_location"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, { force_safe = true }) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, { force_safe = true }) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, { force_safe = true }) end end end
    services.messages.add(ctx:expand_text(services.translate("The world around you abruptly vanishes, and you careen wildly through a darkness so cold you feel like your bones will freeze before abruptly emerging somewhere unfamiliar.")), "mixed")
    return true
    end
    EOC["EOC_NETHER_EFFECT_CHECK_TELEPORT_MISJUMP_APPLY_HOUNDS"] = function(ctx)
    H.eoc_add_effect(H.u(ctx), "effect_teleport_mishap_tindrift_warning", (10800 + (600 * services.random.native_float((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") / 2), (H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") * 2)))), nil, nil, nil)
    return true
    end
    COND["EOC_NETHER_EFFECT_CHECK_TELEPORT_MISJUMP"] = function(ctx)
        return (((((("teleport_blink") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("teleport_phase") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("teleport_transpose") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("teleport_farstep") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("teleport_loci_technique") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("teleport_gateway") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("teleport_dilated_gateway") == (H.var_str("context", nil, ctx, "spell", ""))))) and (H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 150))) == true
    end
    EOC["EOC_NETHER_EFFECT_CHECK_TELEPORT_MISJUMP"] = function(ctx)
    if (((((("teleport_blink") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("teleport_phase") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("teleport_transpose") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("teleport_farstep") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("teleport_loci_technique") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("teleport_gateway") == (H.var_str("context", nil, ctx, "spell", "")))) or ((("teleport_dilated_gateway") == (H.var_str("context", nil, ctx, "spell", ""))))) and (H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 150))) then
        H.eoc_add_effect(H.u(ctx), "effect_psi_teleport_lock", 1, nil, nil, nil)
        H.eoc_add_effect(H.u(ctx), "blind", 1, nil, nil, nil)
        if services.random.native_probability((((((H.clamp_num(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 190) * 2), 0, 60) + H.clamp_num(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 220) * 4), 0, 375)) + H._jm_nether_attune_difficulty_scaler(ctx, H.var_num(H.u(ctx), "latest_channeled_power_difficulty"))) + 30) + H._jm_nether_attune_torrential_channeling_influence(ctx))), (1000)) then
            H.run_eoc("EOC_NETHER_EFFECT_APPLY_TELEPORT_MISJUMP", ctx, nil, nil, nil)
            do local _t = math.max(1, math.floor(0)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_NETHER_EFFECT_CHECK_TELEPORT_MISJUMP_APPLY_HOUNDS"), nil) end end
        end
        return true
    else
        H.run_eoc("EOC_PSIONICS_NETHER_ATTUNEMENT_CONSEQUENCES", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_NETHER_EFFECT_CHECK_PHOTOKIN_EMP"] = function(ctx)
        return ((((("PHOTOKINETIC") == (H.var_str("context", nil, ctx, "school", "")))) and (H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 160))) == true
    end
    EOC["EOC_NETHER_EFFECT_CHECK_PHOTOKIN_EMP"] = function(ctx)
    if ((((("PHOTOKINETIC") == (H.var_str("context", nil, ctx, "school", "")))) and (H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 160))) then
        if services.random.native_probability((((((H.clamp_num(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 195) * 2.5), 0, 87.5) + H.clamp_num(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 230) * 4), 0, 375)) + H._jm_nether_attune_difficulty_scaler(ctx, H.var_num(H.u(ctx), "latest_channeled_power_difficulty"))) + 20) + H._jm_nether_attune_torrential_channeling_influence(ctx))), (1000)) then
            services.messages.add(ctx:expand_text(services.translate("There's a sudden burst of light and your hair stands on end!")), "bad")
            if H.u(ctx) then services.characters.explosion(H.u(ctx), { power = 10, emp_blast = true }) end
        end
        return true
    else
        H.run_eoc("EOC_PSIONICS_NETHER_ATTUNEMENT_CONSEQUENCES", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_NETHER_EFFECT_CHECK_NETHER_LIGHTNING"] = function(ctx)
        return (((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 175) or (H.char_has_trait(H.u(ctx), "PSI_TORRENTIAL_CHANNELING_active") == 1))) == true
    end
    EOC["EOC_NETHER_EFFECT_CHECK_NETHER_LIGHTNING"] = function(ctx)
    if (((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 175) or (H.char_has_trait(H.u(ctx), "PSI_TORRENTIAL_CHANNELING_active") == 1))) then
        if services.random.native_probability((((((H.clamp_num(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 200) * 2), 0, 50) + H.clamp_num(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 225) * 4.5), 0, 375)) + H._jm_nether_attune_difficulty_scaler(ctx, H.var_num(H.u(ctx), "latest_channeled_power_difficulty"))) + 30) + H._jm_nether_attune_torrential_channeling_influence(ctx))), (1000)) then
            services.messages.add(ctx:expand_text(services.translate("Crackling energy erupts all around you!")), "bad")
            H.eoc_cast_spell(H.u(ctx), "nether_attunement_nether_lightning", false, nil)
        end
        return true
    else
        H.run_eoc("EOC_PSIONICS_NETHER_ATTUNEMENT_CONSEQUENCES", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_NETHER_EFFECT_CHECK_TEMPORARY_TEAR_IN_REALITY"] = function(ctx)
        return (((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 175) or (H.char_has_trait(H.u(ctx), "PSI_TORRENTIAL_CHANNELING_active") == 1))) == true
    end
    EOC["EOC_NETHER_EFFECT_CHECK_TEMPORARY_TEAR_IN_REALITY"] = function(ctx)
    if (((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 175) or (H.char_has_trait(H.u(ctx), "PSI_TORRENTIAL_CHANNELING_active") == 1))) then
        if services.random.native_probability((((((H.clamp_num(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 200) * 1), 0, 25) + H.clamp_num(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 225) * 2), 0, 375)) + H._jm_nether_attune_difficulty_scaler(ctx, H.var_num(H.u(ctx), "latest_channeled_power_difficulty"))) + 20) + H._jm_nether_attune_torrential_channeling_influence(ctx))), (1000)) then
            H.eoc_loc_var(H.u(ctx), ctx, "context", "loc", nil, nil, nil, { min_radius = math.floor(1), max_radius = math.floor(3) }, nil, false, true, {  }, {  })
            do local _p, _g = H.get_tripoint_var("context", nil, ctx, "loc"), H.safe_id('field', "fd_tear_in_reality_temporary"); if _p and _g then services.gameplay.environment.add_field_area(_p, _g, { radius = math.floor(0), intensity = math.floor(3) }) end end
            services.messages.add(ctx:expand_text(services.translate("The nearby air cracks.")), "bad")
        end
        return true
    else
        H.run_eoc("EOC_PSIONICS_NETHER_ATTUNEMENT_CONSEQUENCES", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_NETHER_EFFECT_CHECK_SUMMON_HOUNDS"] = function(ctx)
        return (((((function() local eg = H.safe_id('effect', "psi_nether_attention"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "effect_nether_attunement_raiser"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) and (H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 200))) == true
    end
    EOC["EOC_NETHER_EFFECT_CHECK_SUMMON_HOUNDS"] = function(ctx)
    if (((((function() local eg = H.safe_id('effect', "psi_nether_attention"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "effect_nether_attunement_raiser"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) and (H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 200))) then
        if services.random.native_probability(((((H.clamp_num((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 200), 0, 50) + H._jm_nether_attune_difficulty_scaler(ctx, H.var_num(H.u(ctx), "latest_channeled_power_difficulty"))) + 30) + H._jm_nether_attune_torrential_channeling_influence(ctx))), (1000)) then
            H.eoc_add_effect(H.u(ctx), "tindrift", 86400, nil, nil, nil)
            services.messages.add(ctx:expand_text(services.translate("You feel a horrible sensation of watching eyes.")), "bad")
            local _ach14 = H.safe_id("achievement", "mom_get_the_hounds_on_your_trail")
            if _ach14 then services.achievements.complete(_ach14) end
        end
        return true
    else
        H.run_eoc("EOC_PSIONICS_NETHER_ATTUNEMENT_CONSEQUENCES", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_NETHER_EFFECT_CHECK_MUTATION"] = function(ctx)
        return ((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 235)) == true
    end
    EOC["EOC_NETHER_EFFECT_CHECK_MUTATION"] = function(ctx)
    if ((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 235)) then
        if services.random.native_probability(((((H.clamp_num(((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 235) * 2), 0, 30) + H._jm_nether_attune_difficulty_scaler(ctx, H.var_num(H.u(ctx), "latest_channeled_power_difficulty"))) + 30) + H._jm_nether_attune_torrential_channeling_influence(ctx))), (1000)) then
            H.run_eoc("EOC_NETHER_ATTUNEMENT_MUTATION_GAINER", ctx, nil, nil, nil)
            services.messages.add(ctx:expand_text(services.translate("You feel an internal wrenching sensation.")), "bad")
        end
        return true
    else
        H.run_eoc("EOC_PSIONICS_NETHER_ATTUNEMENT_CONSEQUENCES", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_NETHER_EFFECT_CHECK_RIFT"] = function(ctx)
        return (((((function() local eg = H.safe_id('effect', "psi_nether_attention"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "effect_nether_attunement_raiser"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) and (H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 235))) == true
    end
    EOC["EOC_NETHER_EFFECT_CHECK_RIFT"] = function(ctx)
    if (((((function() local eg = H.safe_id('effect', "psi_nether_attention"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) or ((function() local eg = H.safe_id('effect', "effect_nether_attunement_raiser"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) and (H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") >= 235))) then
        if services.random.native_probability(((((H.clamp_num((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain") - 235), 0, 15) + H._jm_nether_attune_difficulty_scaler(ctx, H.var_num(H.u(ctx), "latest_channeled_power_difficulty"))) + 20) + H._jm_nether_attune_torrential_channeling_influence(ctx))), (1000)) then
            do local _p, _g = (H.creature_snap(H.u(ctx)) or {}).position, H.safe_id('field', "fd_fatigue"); if _p and _g then services.gameplay.environment.add_field_area(_p, _g, { radius = math.floor(0), intensity = math.floor(3) }) end end
            services.messages.add(ctx:expand_text(services.translate("The air around you twists and warps in on itself.")), "bad")
        end
        return true
    else
        H.run_eoc("EOC_PSIONICS_NETHER_ATTUNEMENT_CONSEQUENCES", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_NETHER_ATTUNEMENT_FEEDBACK_CHECK"] = function(ctx)
        return ((H.test_eoc("EOC_CONDITION_SPELLCASTING_FINISH_TRAIT_AND_SCHOOL_LIST", ctx) and ((function() local eg = H.safe_id('effect', "effect_nether_attunement_feedback"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and services.random.native_probability((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain")), (250)))) == true
    end
    EOC["EOC_NETHER_ATTUNEMENT_FEEDBACK_CHECK"] = function(ctx)
    if ((H.test_eoc("EOC_CONDITION_SPELLCASTING_FINISH_TRAIT_AND_SCHOOL_LIST", ctx) and ((function() local eg = H.safe_id('effect', "effect_nether_attunement_feedback"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and services.random.native_probability((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain")), (250)))) then
        services.messages.add(ctx:expand_text(services.translate("As you unleash your powers, you feel a burning sensation in your veins!")), "bad")
        local _a15 = H.u(ctx)
        if _a15 then services.characters.adjust(_a15, { pain = math.floor((services.random.native_int(0, H.round_half_away(4)) + 1)) }) end
        return true
    end
    return false
    end
    EOC["EOC_NETHER_ATTUNEMENT_MUTATION_GAINER"] = function(ctx)
    do local _ok = false; local _ids = {}; for _, s in ipairs({ "BADTEMPER", "INSOMNIA", "ANIMALDISCORD", "MOODSWINGS", "CHEMIMBALANCE", "SCHIZOPHRENIC", "JITTERY" }) do local g = H.safe_id("mutation", s); if g then table.insert(_ids, g) end end; if H.u(ctx) and #_ids > 0 then local r = services.progression.grant_random_missing(H.u(ctx), "mutation", _ids); _ok = (r.ok and r.value and r.value.granted ~= nil) end; 
    end
    return true
    end
    COND["EOC_NETHER_ATTUNEMENT_FEEDBACK_CHECK_CONCENTRATION"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "effect_nether_attunement_feedback"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and services.random.native_probability((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain")), (250)))) == true
    end
    EOC["EOC_NETHER_ATTUNEMENT_FEEDBACK_CHECK_CONCENTRATION"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "effect_nether_attunement_feedback"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and services.random.native_probability((H.char_vitamin(H.u(ctx), "vitamin_psionic_drain")), (250)))) then
        services.messages.add(ctx:expand_text(services.translate("As you concentrate on your powers, you feel a burning sensation in your veins!")), "bad")
        local _a16 = H.u(ctx)
        if _a16 then services.characters.adjust(_a16, { pain = math.floor((services.random.native_int(0, H.round_half_away(4)) + 1)) }) end
        return true
    end
    return false
    end
    COND["EOC_POWERS_IN_NETHER_CHECK_BIOKINESIS_2"] = function(ctx)
        return (((function() local fg = H.safe_id('json_flag', "MATRIX_CRYSTAL_BIOKINESIS"); return H.u(ctx) ~= nil and fg ~= nil and services.inventory.wielded_matches(H.u(ctx), fg).value == true end)())) == true
    end
    EOC["EOC_POWERS_IN_NETHER_CHECK_BIOKINESIS_2"] = function(ctx)
    if (((function() local fg = H.safe_id('json_flag', "MATRIX_CRYSTAL_BIOKINESIS"); return H.u(ctx) ~= nil and fg ~= nil and services.inventory.wielded_matches(H.u(ctx), fg).value == true end)())) then
        H.run_eoc("EOC_POWERS_IN_NETHER_HOLDING_MATRIX_CRYSTAL_WARNING", ctx, nil, nil, nil)
        H.run_eoc("EOC_POWERS_IN_NETHER_LOCATION_CHECKER", ctx, nil, nil, nil)
        return true
    else
        H.run_eoc("EOC_POWERS_IN_NETHER_NOT_HOLDING_MATRIX_CRYSTAL_WARNING", ctx, nil, nil, nil)
        H.run_eoc("EOC_POWERS_IN_NETHER_LOCATION_CHECKER", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_POWERS_IN_NETHER_CHECK_BIOKINESIS"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "BIOKINETIC") == 1) and ((("BIOKINETIC") == (H.var_str("context", nil, ctx, "school", "")))) and (H.test_eoc("EOC_CONDITION_NEAR_NETHER_RELATED_LOCATION", ctx) or H.test_eoc("EOC_CONDITION_YOU_ARE_IN_NETHER_LOCATION", ctx)))) == true
    end
    EOC["EOC_POWERS_IN_NETHER_CHECK_BIOKINESIS"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "BIOKINETIC") == 1) and ((("BIOKINETIC") == (H.var_str("context", nil, ctx, "school", "")))) and (H.test_eoc("EOC_CONDITION_NEAR_NETHER_RELATED_LOCATION", ctx) or H.test_eoc("EOC_CONDITION_YOU_ARE_IN_NETHER_LOCATION", ctx)))) then
        H.run_eoc("EOC_POWERS_IN_NETHER_CHECK_BIOKINESIS_2", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_POWERS_IN_NETHER_CHECK_CLAIRSENTIENCE_2"] = function(ctx)
        return (((function() local fg = H.safe_id('json_flag', "MATRIX_CRYSTAL_CLAIRSENTIENCE"); return H.u(ctx) ~= nil and fg ~= nil and services.inventory.wielded_matches(H.u(ctx), fg).value == true end)())) == true
    end
    EOC["EOC_POWERS_IN_NETHER_CHECK_CLAIRSENTIENCE_2"] = function(ctx)
    if (((function() local fg = H.safe_id('json_flag', "MATRIX_CRYSTAL_CLAIRSENTIENCE"); return H.u(ctx) ~= nil and fg ~= nil and services.inventory.wielded_matches(H.u(ctx), fg).value == true end)())) then
        H.run_eoc("EOC_POWERS_IN_NETHER_HOLDING_MATRIX_CRYSTAL_WARNING", ctx, nil, nil, nil)
        H.run_eoc("EOC_POWERS_IN_NETHER_LOCATION_CHECKER", ctx, nil, nil, nil)
        return true
    else
        H.run_eoc("EOC_POWERS_IN_NETHER_NOT_HOLDING_MATRIX_CRYSTAL_WARNING", ctx, nil, nil, nil)
        H.run_eoc("EOC_POWERS_IN_NETHER_LOCATION_CHECKER", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_POWERS_IN_NETHER_CHECK_CLAIRSENTIENCE"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "CLAIRSENTIENT") == 1) and ((("CLAIRSENTIENT") == (H.var_str("context", nil, ctx, "school", "")))) and (H.test_eoc("EOC_CONDITION_NEAR_NETHER_RELATED_LOCATION", ctx) or H.test_eoc("EOC_CONDITION_YOU_ARE_IN_NETHER_LOCATION", ctx)))) == true
    end
    EOC["EOC_POWERS_IN_NETHER_CHECK_CLAIRSENTIENCE"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "CLAIRSENTIENT") == 1) and ((("CLAIRSENTIENT") == (H.var_str("context", nil, ctx, "school", "")))) and (H.test_eoc("EOC_CONDITION_NEAR_NETHER_RELATED_LOCATION", ctx) or H.test_eoc("EOC_CONDITION_YOU_ARE_IN_NETHER_LOCATION", ctx)))) then
        H.run_eoc("EOC_POWERS_IN_NETHER_CHECK_CLAIRSENTIENCE_2", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_POWERS_IN_NETHER_CHECK_ELECTROKINESIS_2"] = function(ctx)
        return (((function() local fg = H.safe_id('json_flag', "MATRIX_CRYSTAL_ELECTROKINESIS"); return H.u(ctx) ~= nil and fg ~= nil and services.inventory.wielded_matches(H.u(ctx), fg).value == true end)())) == true
    end
    EOC["EOC_POWERS_IN_NETHER_CHECK_ELECTROKINESIS_2"] = function(ctx)
    if (((function() local fg = H.safe_id('json_flag', "MATRIX_CRYSTAL_ELECTROKINESIS"); return H.u(ctx) ~= nil and fg ~= nil and services.inventory.wielded_matches(H.u(ctx), fg).value == true end)())) then
        H.run_eoc("EOC_POWERS_IN_NETHER_HOLDING_MATRIX_CRYSTAL_WARNING", ctx, nil, nil, nil)
        H.run_eoc("EOC_POWERS_IN_NETHER_LOCATION_CHECKER", ctx, nil, nil, nil)
        return true
    else
        H.run_eoc("EOC_POWERS_IN_NETHER_NOT_HOLDING_MATRIX_CRYSTAL_WARNING", ctx, nil, nil, nil)
        H.run_eoc("EOC_POWERS_IN_NETHER_LOCATION_CHECKER", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_POWERS_IN_NETHER_CHECK_ELECTROKINESIS"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "ELECTROKINETIC") == 1) and ((("ELECTROKINETIC") == (H.var_str("context", nil, ctx, "school", "")))) and (H.test_eoc("EOC_CONDITION_NEAR_NETHER_RELATED_LOCATION", ctx) or H.test_eoc("EOC_CONDITION_YOU_ARE_IN_NETHER_LOCATION", ctx)))) == true
    end
    EOC["EOC_POWERS_IN_NETHER_CHECK_ELECTROKINESIS"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "ELECTROKINETIC") == 1) and ((("ELECTROKINETIC") == (H.var_str("context", nil, ctx, "school", "")))) and (H.test_eoc("EOC_CONDITION_NEAR_NETHER_RELATED_LOCATION", ctx) or H.test_eoc("EOC_CONDITION_YOU_ARE_IN_NETHER_LOCATION", ctx)))) then
        H.run_eoc("EOC_POWERS_IN_NETHER_CHECK_ELECTROKINESIS_2", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_POWERS_IN_NETHER_CHECK_PHOTOKINESIS_2"] = function(ctx)
        return (((function() local fg = H.safe_id('json_flag', "MATRIX_CRYSTAL_PHOTOKINESIS"); return H.u(ctx) ~= nil and fg ~= nil and services.inventory.wielded_matches(H.u(ctx), fg).value == true end)())) == true
    end
    EOC["EOC_POWERS_IN_NETHER_CHECK_PHOTOKINESIS_2"] = function(ctx)
    if (((function() local fg = H.safe_id('json_flag', "MATRIX_CRYSTAL_PHOTOKINESIS"); return H.u(ctx) ~= nil and fg ~= nil and services.inventory.wielded_matches(H.u(ctx), fg).value == true end)())) then
        H.run_eoc("EOC_POWERS_IN_NETHER_HOLDING_MATRIX_CRYSTAL_WARNING", ctx, nil, nil, nil)
        H.run_eoc("EOC_POWERS_IN_NETHER_LOCATION_CHECKER", ctx, nil, nil, nil)
        return true
    else
        H.run_eoc("EOC_POWERS_IN_NETHER_NOT_HOLDING_MATRIX_CRYSTAL_WARNING", ctx, nil, nil, nil)
        H.run_eoc("EOC_POWERS_IN_NETHER_LOCATION_CHECKER", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_POWERS_IN_NETHER_CHECK_PHOTOKINESIS"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "PHOTOKINETIC") == 1) and ((("PHOTOKINETIC") == (H.var_str("context", nil, ctx, "school", "")))) and (H.test_eoc("EOC_CONDITION_NEAR_NETHER_RELATED_LOCATION", ctx) or H.test_eoc("EOC_CONDITION_YOU_ARE_IN_NETHER_LOCATION", ctx)))) == true
    end
    EOC["EOC_POWERS_IN_NETHER_CHECK_PHOTOKINESIS"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "PHOTOKINETIC") == 1) and ((("PHOTOKINETIC") == (H.var_str("context", nil, ctx, "school", "")))) and (H.test_eoc("EOC_CONDITION_NEAR_NETHER_RELATED_LOCATION", ctx) or H.test_eoc("EOC_CONDITION_YOU_ARE_IN_NETHER_LOCATION", ctx)))) then
        H.run_eoc("EOC_POWERS_IN_NETHER_CHECK_PHOTOKINESIS_2", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_POWERS_IN_NETHER_CHECK_PYROKINESIS_2"] = function(ctx)
        return (((function() local fg = H.safe_id('json_flag', "MATRIX_CRYSTAL_PYROKINESIS"); return H.u(ctx) ~= nil and fg ~= nil and services.inventory.wielded_matches(H.u(ctx), fg).value == true end)())) == true
    end
    EOC["EOC_POWERS_IN_NETHER_CHECK_PYROKINESIS_2"] = function(ctx)
    if (((function() local fg = H.safe_id('json_flag', "MATRIX_CRYSTAL_PYROKINESIS"); return H.u(ctx) ~= nil and fg ~= nil and services.inventory.wielded_matches(H.u(ctx), fg).value == true end)())) then
        H.run_eoc("EOC_POWERS_IN_NETHER_HOLDING_MATRIX_CRYSTAL_WARNING", ctx, nil, nil, nil)
        H.run_eoc("EOC_POWERS_IN_NETHER_LOCATION_CHECKER", ctx, nil, nil, nil)
        return true
    else
        H.run_eoc("EOC_POWERS_IN_NETHER_NOT_HOLDING_MATRIX_CRYSTAL_WARNING", ctx, nil, nil, nil)
        H.run_eoc("EOC_POWERS_IN_NETHER_LOCATION_CHECKER", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_POWERS_IN_NETHER_CHECK_PYROKINESIS"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "PYROKINETIC") == 1) and ((("PYROKINETIC") == (H.var_str("context", nil, ctx, "school", "")))) and (H.test_eoc("EOC_CONDITION_NEAR_NETHER_RELATED_LOCATION", ctx) or H.test_eoc("EOC_CONDITION_YOU_ARE_IN_NETHER_LOCATION", ctx)))) == true
    end
    EOC["EOC_POWERS_IN_NETHER_CHECK_PYROKINESIS"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "PYROKINETIC") == 1) and ((("PYROKINETIC") == (H.var_str("context", nil, ctx, "school", "")))) and (H.test_eoc("EOC_CONDITION_NEAR_NETHER_RELATED_LOCATION", ctx) or H.test_eoc("EOC_CONDITION_YOU_ARE_IN_NETHER_LOCATION", ctx)))) then
        H.run_eoc("EOC_POWERS_IN_NETHER_CHECK_PYROKINESIS_2", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_POWERS_IN_NETHER_CHECK_TELEKINESIS_2"] = function(ctx)
        return (((function() local fg = H.safe_id('json_flag', "MATRIX_CRYSTAL_TELEKINESIS"); return H.u(ctx) ~= nil and fg ~= nil and services.inventory.wielded_matches(H.u(ctx), fg).value == true end)())) == true
    end
    EOC["EOC_POWERS_IN_NETHER_CHECK_TELEKINESIS_2"] = function(ctx)
    if (((function() local fg = H.safe_id('json_flag', "MATRIX_CRYSTAL_TELEKINESIS"); return H.u(ctx) ~= nil and fg ~= nil and services.inventory.wielded_matches(H.u(ctx), fg).value == true end)())) then
        H.run_eoc("EOC_POWERS_IN_NETHER_HOLDING_MATRIX_CRYSTAL_WARNING", ctx, nil, nil, nil)
        H.run_eoc("EOC_POWERS_IN_NETHER_LOCATION_CHECKER", ctx, nil, nil, nil)
        return true
    else
        H.run_eoc("EOC_POWERS_IN_NETHER_NOT_HOLDING_MATRIX_CRYSTAL_WARNING", ctx, nil, nil, nil)
        H.run_eoc("EOC_POWERS_IN_NETHER_LOCATION_CHECKER", ctx, nil, nil, nil)
        return false
    end
    end
    COND["EOC_POWERS_IN_NETHER_CHECK_TELEKINESIS"] = function(ctx)
        return (((H.char_has_trait(H.u(ctx), "TELEKINETIC") == 1) and ((("TELEKINETIC") == (H.var_str("context", nil, ctx, "school", "")))) and (H.test_eoc("EOC_CONDITION_NEAR_NETHER_RELATED_LOCATION", ctx) or H.test_eoc("EOC_CONDITION_YOU_ARE_IN_NETHER_LOCATION", ctx)))) == true
    end
    EOC["EOC_POWERS_IN_NETHER_CHECK_TELEKINESIS"] = function(ctx)
    if (((H.char_has_trait(H.u(ctx), "TELEKINETIC") == 1) and ((("TELEKINETIC") == (H.var_str("context", nil, ctx, "school", "")))) and (H.test_eoc("EOC_CONDITION_NEAR_NETHER_RELATED_LOCATION", ctx) or H.test_eoc("EOC_CONDITION_YOU_ARE_IN_NETHER_LOCATION", ctx)))) then
        H.run_eoc("EOC_POWERS_IN_NETHER_CHECK_TELEKINESIS_2", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_POWERS_IN_NETHER_CHECK_TELEPATHY_2"] = function(ctx)
        return (((function() local fg = H.safe_id('json_flag', "MATRIX_CRYSTAL_TELEPATHY"); return H.u(ctx) ~= nil and fg ~= nil and services.inventory.wielded_matches(H.u(ctx), fg).value == true end)())) == true
    end
    EOC["EOC_POWERS_IN_NETHER_CHECK_TELEPATHY_2"] = function(ctx)
    if (((function() local fg = H.safe_id('json_flag', "MATRIX_CRYSTAL_TELEPATHY"); return H.u(ctx) ~= nil and fg ~= nil and services.inventory.wielded_matches(H.u(ctx), fg).value == true end)())) then
        H.run_eoc("EOC_POWERS_IN_NETHER_HOLDING_MATRIX_CRYSTAL_WARNING", ctx, nil, nil, nil)
        H.run_eoc("EOC_POWERS_IN_NETHER_LOCATION_CHECKER", ctx, nil, nil, nil)
        return true
    else
        H.run_eoc("EOC_POWERS_IN_NETHER_NOT_HOLDING_MATRIX_CRYSTAL_WARNING", ctx, nil, nil, nil)
        H.run_eoc("EOC_POWERS_IN_NETHER_LOCATION_CHECKER", ctx, nil, nil, nil)
        return false
    end
    end
end
