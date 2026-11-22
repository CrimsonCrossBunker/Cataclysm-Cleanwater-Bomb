local ccb = require("ccb")
local services = ccb.services
return function(E, H)
    local EOC = E.run
    local COND = E.cond
    COND["EOC_INNER_CABINS_INTERSTICE_COUNTER"] = function(ctx)
        return ((services.gameplay.environment.dimension() == "inner_cabins")) == true
    end
    EOC["EOC_INNER_CABINS_INTERSTICE_COUNTER"] = function(ctx)
    if ((services.gameplay.environment.dimension() == "inner_cabins")) then
        do local _t = math.max(1, math.floor((function() local a, b = math.floor(60), math.floor(120); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_INNER_CABINS_INTERSTICE_COUNTER"), nil) end end
        H.set_var("global", nil, ctx, "previous_interstice_counter", H.global_var_num("interstice_counter"))
        if (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) <= (-8)) then
            if services.random.native_probability(1, (500)) then
                H.set_var("global", nil, ctx, "interstice_counter", (H.global_var_num("interstice_counter")) - (10))
            end
        else
            if services.random.native_probability(1, (500)) then
                H.set_var("global", nil, ctx, "interstice_counter", (H.global_var_num("interstice_counter")) + (1))
            end
        end
        if (H.global_var_num("interstice_counter") < 100) then
            H.set_var("global", nil, ctx, "interstice_counter", 100)
        end
        if (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) <= (-8)) then
            H.lose_trait(H.u(ctx), "INTERSTICE_SHRINKING")
            do local _g = H.safe_id('mutation', "INTERSTICE_GROWING"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
            if services.random.native_probability(1, (H.global_var_num("interstice_counter"))) then
                services.messages.add((services.snippets.native_random("<inner_cabins_interstice_snippet>") or ''), "info")
                do local _g = H.safe_id('mutation_category', "INTERSTICE"); if H.u(ctx) and _g then services.mutations.mutate_category(H.u(ctx), _g, false, false) end end
            end
        else
            H.lose_trait(H.u(ctx), "INTERSTICE_GROWING")
            do local _g = H.safe_id('mutation', "INTERSTICE_SHRINKING"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("A thought passes through your mind:  after all that, are you still you?")), "neutral")
        H.lose_trait(H.u(ctx), "INTERSTICE_GROWING")
        H.lose_trait(H.u(ctx), "INTERSTICE_SHRINKING")
        return false
    end
    end
    EOC["EOC_START_SCARLET_STORM"] = function(ctx)
    H.set_var("global", nil, ctx, "scarlet_storm_active", 1)
    H.eoc_loc_var(H.u(ctx), ctx, "global", "scarlet_storm_focus_a1", nil, nil, nil, nil, { dz = math.floor(0) }, true, true, {  }, {  })
    H.eoc_loc_var(H.u(ctx), ctx, "global", "scarlet_storm_focus_a2", nil, nil, nil, nil, { dz = math.floor(0) }, true, true, {  }, {  })
    H.eoc_loc_var(H.u(ctx), ctx, "global", "scarlet_storm_focus_b1", nil, nil, nil, nil, { dz = math.floor(0) }, true, true, {  }, {  })
    H.eoc_loc_var(H.u(ctx), ctx, "global", "scarlet_storm_focus_b2", nil, nil, nil, nil, { dz = math.floor(0) }, true, true, {  }, {  })
    H.set_var("global", nil, ctx, "scarlet_storm_offset", (((services.time.calendar().now.turns_since_cataclysm / 86400) * 432) + services.random.native_float((-20200), 20200)))
    H.coord_set("global", nil, ctx, "scarlet_storm_focus_a1", "x", (50400 - H.global_var_num("scarlet_storm_offset")), "=")
    H.coord_set("global", nil, ctx, "scarlet_storm_focus_a1", "y", 1, "=")
    H.coord_set("global", nil, ctx, "scarlet_storm_focus_a2", "x", (50400 - H.global_var_num("scarlet_storm_offset")), "=")
    H.coord_set("global", nil, ctx, "scarlet_storm_focus_a2", "y", 1501, "=")
    H.coord_set("global", nil, ctx, "scarlet_storm_focus_b1", "x", ((50400 - H.global_var_num("scarlet_storm_offset")) + 900), "=")
    H.coord_set("global", nil, ctx, "scarlet_storm_focus_b1", "y", 1, "=")
    H.coord_set("global", nil, ctx, "scarlet_storm_focus_b2", "x", ((50400 - H.global_var_num("scarlet_storm_offset")) + 900), "=")
    H.coord_set("global", nil, ctx, "scarlet_storm_focus_b2", "y", 1101, "=")
    H.set_var("global", nil, ctx, "scarlet_storm_direction", 0)
    return true
    end
    COND["EOC_SCARLET_STORM"] = function(ctx)
        return (((H.global_var_num("scarlet_storm_active") == 1) and (H.global_var_num("scarlet_storm_died") ~= 1))) == true
    end
    EOC["EOC_SCARLET_STORM"] = function(ctx)
    if (((H.global_var_num("scarlet_storm_active") == 1) and (H.global_var_num("scarlet_storm_died") ~= 1))) then
        do local tp = H.get_tripoint_var("global", nil, ctx, "scarlet_storm_focus_a1"); if tp then local nt = services.coords.tripoint_abs_ms((tp.x or 0) + math.floor(-144) * 1, (tp.y or 0) + math.floor(0) * 1, (tp.z or 0) + math.floor(0)); H.set_var("global", nil, ctx, "scarlet_storm_focus_a1", nt) end end
        do local tp = H.get_tripoint_var("global", nil, ctx, "scarlet_storm_focus_a2"); if tp then local nt = services.coords.tripoint_abs_ms((tp.x or 0) + math.floor(-144) * 1, (tp.y or 0) + math.floor(0) * 1, (tp.z or 0) + math.floor(0)); H.set_var("global", nil, ctx, "scarlet_storm_focus_a2", nt) end end
        do local tp = H.get_tripoint_var("global", nil, ctx, "scarlet_storm_focus_b1"); if tp then local nt = services.coords.tripoint_abs_ms((tp.x or 0) + math.floor(-144) * 1, (tp.y or 0) + math.floor(0) * 1, (tp.z or 0) + math.floor(0)); H.set_var("global", nil, ctx, "scarlet_storm_focus_b1", nt) end end
        do local tp = H.get_tripoint_var("global", nil, ctx, "scarlet_storm_focus_b2"); if tp then local nt = services.coords.tripoint_abs_ms((tp.x or 0) + math.floor(-144) * 1, (tp.y or 0) + math.floor(0) * 1, (tp.z or 0) + math.floor(0)); H.set_var("global", nil, ctx, "scarlet_storm_focus_b2", nt) end end
        if (H.global_var_num("scarlet_storm_direction") == 0) then
            do local tp = H.get_tripoint_var("global", nil, ctx, "scarlet_storm_focus_a1"); if tp then local nt = services.coords.tripoint_abs_ms((tp.x or 0) + math.floor(0) * 1, (tp.y or 0) + math.floor(services.random.native_int(-48, 48)) * 1, (tp.z or 0) + math.floor(0)); H.set_var("global", nil, ctx, "scarlet_storm_focus_a1", nt) end end
            do local tp = H.get_tripoint_var("global", nil, ctx, "scarlet_storm_focus_a2"); if tp then local nt = services.coords.tripoint_abs_ms((tp.x or 0) + math.floor(0) * 1, (tp.y or 0) + math.floor(services.random.native_int(-48, 48)) * 1, (tp.z or 0) + math.floor(0)); H.set_var("global", nil, ctx, "scarlet_storm_focus_a2", nt) end end
            do local tp = H.get_tripoint_var("global", nil, ctx, "scarlet_storm_focus_b1"); if tp then local nt = services.coords.tripoint_abs_ms((tp.x or 0) + math.floor(0) * 1, (tp.y or 0) + math.floor(services.random.native_int(-48, 48)) * 1, (tp.z or 0) + math.floor(0)); H.set_var("global", nil, ctx, "scarlet_storm_focus_b1", nt) end end
            do local tp = H.get_tripoint_var("global", nil, ctx, "scarlet_storm_focus_b2"); if tp then local nt = services.coords.tripoint_abs_ms((tp.x or 0) + math.floor(0) * 1, (tp.y or 0) + math.floor(services.random.native_int(-48, 48)) * 1, (tp.z or 0) + math.floor(0)); H.set_var("global", nil, ctx, "scarlet_storm_focus_b2", nt) end end
            if services.random.native_probability(1, (60)) then
                H.set_var("global", nil, ctx, "scarlet_storm_direction", (-1))
            end
            if services.random.native_probability(1, (60)) then
                H.set_var("global", nil, ctx, "scarlet_storm_direction", 1)
            end
        else
            if (H.global_var_num("scarlet_storm_direction") == (-1)) then
                do local tp = H.get_tripoint_var("global", nil, ctx, "scarlet_storm_focus_a1"); if tp then local nt = services.coords.tripoint_abs_ms((tp.x or 0) + math.floor(0) * 1, (tp.y or 0) + math.floor(services.random.native_int(-144, 0)) * 1, (tp.z or 0) + math.floor(0)); H.set_var("global", nil, ctx, "scarlet_storm_focus_a1", nt) end end
                do local tp = H.get_tripoint_var("global", nil, ctx, "scarlet_storm_focus_a2"); if tp then local nt = services.coords.tripoint_abs_ms((tp.x or 0) + math.floor(0) * 1, (tp.y or 0) + math.floor(services.random.native_int(-144, 0)) * 1, (tp.z or 0) + math.floor(0)); H.set_var("global", nil, ctx, "scarlet_storm_focus_a2", nt) end end
                do local tp = H.get_tripoint_var("global", nil, ctx, "scarlet_storm_focus_b1"); if tp then local nt = services.coords.tripoint_abs_ms((tp.x or 0) + math.floor(0) * 1, (tp.y or 0) + math.floor(services.random.native_int(-144, 0)) * 1, (tp.z or 0) + math.floor(0)); H.set_var("global", nil, ctx, "scarlet_storm_focus_b1", nt) end end
                do local tp = H.get_tripoint_var("global", nil, ctx, "scarlet_storm_focus_b2"); if tp then local nt = services.coords.tripoint_abs_ms((tp.x or 0) + math.floor(0) * 1, (tp.y or 0) + math.floor(services.random.native_int(-144, 0)) * 1, (tp.z or 0) + math.floor(0)); H.set_var("global", nil, ctx, "scarlet_storm_focus_b2", nt) end end
                if services.random.native_probability(1, (60)) then
                    H.set_var("global", nil, ctx, "scarlet_storm_direction", (-2))
                end
                if services.random.native_probability(1, (30)) then
                    H.set_var("global", nil, ctx, "scarlet_storm_direction", 0)
                end
                if services.random.native_probability(1, (120)) then
                    H.set_var("global", nil, ctx, "scarlet_storm_direction", 1)
                end
            else
                if (H.global_var_num("scarlet_storm_direction") == 1) then
                    do local tp = H.get_tripoint_var("global", nil, ctx, "scarlet_storm_focus_a1"); if tp then local nt = services.coords.tripoint_abs_ms((tp.x or 0) + math.floor(0) * 1, (tp.y or 0) + math.floor(services.random.native_int(0, 144)) * 1, (tp.z or 0) + math.floor(0)); H.set_var("global", nil, ctx, "scarlet_storm_focus_a1", nt) end end
                    do local tp = H.get_tripoint_var("global", nil, ctx, "scarlet_storm_focus_a2"); if tp then local nt = services.coords.tripoint_abs_ms((tp.x or 0) + math.floor(0) * 1, (tp.y or 0) + math.floor(services.random.native_int(0, 144)) * 1, (tp.z or 0) + math.floor(0)); H.set_var("global", nil, ctx, "scarlet_storm_focus_a2", nt) end end
                    do local tp = H.get_tripoint_var("global", nil, ctx, "scarlet_storm_focus_b1"); if tp then local nt = services.coords.tripoint_abs_ms((tp.x or 0) + math.floor(0) * 1, (tp.y or 0) + math.floor(services.random.native_int(0, 144)) * 1, (tp.z or 0) + math.floor(0)); H.set_var("global", nil, ctx, "scarlet_storm_focus_b1", nt) end end
                    do local tp = H.get_tripoint_var("global", nil, ctx, "scarlet_storm_focus_b2"); if tp then local nt = services.coords.tripoint_abs_ms((tp.x or 0) + math.floor(0) * 1, (tp.y or 0) + math.floor(services.random.native_int(0, 144)) * 1, (tp.z or 0) + math.floor(0)); H.set_var("global", nil, ctx, "scarlet_storm_focus_b2", nt) end end
                    if services.random.native_probability(1, (60)) then
                        H.set_var("global", nil, ctx, "scarlet_storm_direction", 2)
                    end
                    if services.random.native_probability(1, (30)) then
                        H.set_var("global", nil, ctx, "scarlet_storm_direction", 0)
                    end
                    if services.random.native_probability(1, (120)) then
                        H.set_var("global", nil, ctx, "scarlet_storm_direction", (-1))
                    end
                else
                    if (H.global_var_num("scarlet_storm_direction") == (-2)) then
                        do local tp = H.get_tripoint_var("global", nil, ctx, "scarlet_storm_focus_a1"); if tp then local nt = services.coords.tripoint_abs_ms((tp.x or 0) + math.floor(0) * 1, (tp.y or 0) + math.floor(services.random.native_int(-144, -48)) * 1, (tp.z or 0) + math.floor(0)); H.set_var("global", nil, ctx, "scarlet_storm_focus_a1", nt) end end
                        do local tp = H.get_tripoint_var("global", nil, ctx, "scarlet_storm_focus_a2"); if tp then local nt = services.coords.tripoint_abs_ms((tp.x or 0) + math.floor(0) * 1, (tp.y or 0) + math.floor(services.random.native_int(-144, -48)) * 1, (tp.z or 0) + math.floor(0)); H.set_var("global", nil, ctx, "scarlet_storm_focus_a2", nt) end end
                        do local tp = H.get_tripoint_var("global", nil, ctx, "scarlet_storm_focus_b1"); if tp then local nt = services.coords.tripoint_abs_ms((tp.x or 0) + math.floor(0) * 1, (tp.y or 0) + math.floor(services.random.native_int(-144, -48)) * 1, (tp.z or 0) + math.floor(0)); H.set_var("global", nil, ctx, "scarlet_storm_focus_b1", nt) end end
                        do local tp = H.get_tripoint_var("global", nil, ctx, "scarlet_storm_focus_b2"); if tp then local nt = services.coords.tripoint_abs_ms((tp.x or 0) + math.floor(0) * 1, (tp.y or 0) + math.floor(services.random.native_int(-144, -48)) * 1, (tp.z or 0) + math.floor(0)); H.set_var("global", nil, ctx, "scarlet_storm_focus_b2", nt) end end
                        if services.random.native_probability(1, (30)) then
                            H.set_var("global", nil, ctx, "scarlet_storm_direction", (-1))
                        end
                        if services.random.native_probability(1, (60)) then
                            H.set_var("global", nil, ctx, "scarlet_storm_direction", 0)
                        end
                    else
                        if (H.global_var_num("scarlet_storm_direction") == 2) then
                            do local tp = H.get_tripoint_var("global", nil, ctx, "scarlet_storm_focus_a1"); if tp then local nt = services.coords.tripoint_abs_ms((tp.x or 0) + math.floor(0) * 1, (tp.y or 0) + math.floor(services.random.native_int(48, 144)) * 1, (tp.z or 0) + math.floor(0)); H.set_var("global", nil, ctx, "scarlet_storm_focus_a1", nt) end end
                            do local tp = H.get_tripoint_var("global", nil, ctx, "scarlet_storm_focus_a2"); if tp then local nt = services.coords.tripoint_abs_ms((tp.x or 0) + math.floor(0) * 1, (tp.y or 0) + math.floor(services.random.native_int(48, 144)) * 1, (tp.z or 0) + math.floor(0)); H.set_var("global", nil, ctx, "scarlet_storm_focus_a2", nt) end end
                            do local tp = H.get_tripoint_var("global", nil, ctx, "scarlet_storm_focus_b1"); if tp then local nt = services.coords.tripoint_abs_ms((tp.x or 0) + math.floor(0) * 1, (tp.y or 0) + math.floor(services.random.native_int(48, 144)) * 1, (tp.z or 0) + math.floor(0)); H.set_var("global", nil, ctx, "scarlet_storm_focus_b1", nt) end end
                            do local tp = H.get_tripoint_var("global", nil, ctx, "scarlet_storm_focus_b2"); if tp then local nt = services.coords.tripoint_abs_ms((tp.x or 0) + math.floor(0) * 1, (tp.y or 0) + math.floor(services.random.native_int(48, 144)) * 1, (tp.z or 0) + math.floor(0)); H.set_var("global", nil, ctx, "scarlet_storm_focus_b2", nt) end end
                            if services.random.native_probability(1, (30)) then
                                H.set_var("global", nil, ctx, "scarlet_storm_direction", 1)
                            end
                            if services.random.native_probability(1, (60)) then
                                H.set_var("global", nil, ctx, "scarlet_storm_direction", 0)
                            end
                        end
                    end
                end
            end
        end
        if (((H.coord_get("global", nil, ctx, "scarlet_storm_focus_a1", "y") - H.coord_get("global", nil, ctx, "scarlet_storm_focus_a2", "y")) < 1200) or ((H.coord_get("global", nil, ctx, "scarlet_storm_focus_a1", "y") - H.coord_get("global", nil, ctx, "scarlet_storm_focus_a2", "y")) > 1900)) then
            H.coord_set("global", nil, ctx, "scarlet_storm_focus_a2", "y", (H.coord_get("global", nil, ctx, "scarlet_storm_focus_a1", "y") + 1500), "=")
        end
        if (((H.coord_get("global", nil, ctx, "scarlet_storm_focus_b1", "y") - H.coord_get("global", nil, ctx, "scarlet_storm_focus_b2", "y")) < 1200) or ((H.coord_get("global", nil, ctx, "scarlet_storm_focus_b1", "y") - H.coord_get("global", nil, ctx, "scarlet_storm_focus_b2", "y")) > 1900)) then
            H.coord_set("global", nil, ctx, "scarlet_storm_focus_b2", "y", (H.coord_get("global", nil, ctx, "scarlet_storm_focus_b1", "y") + 1500), "=")
        end
        if ((services.time.calendar().now.turns_since_cataclysm / 86400) >= 730) then
            H.set_var("global", nil, ctx, "scarlet_storm_died", 1)
        end
        return true
    end
    return false
    end
    COND["scarlet_gust_1"] = function(ctx)
        return (((((services.weather.current().weather and services.weather.current().weather.value) == "scarlet_storm_1") or ((services.weather.current().weather and services.weather.current().weather.value) == "scarlet_storm_2") or ((services.weather.current().weather and services.weather.current().weather.value) == "scarlet_storm_3") or ((services.weather.current().weather and services.weather.current().weather.value) == "scarlet_storm_4")) and services.random.native_probability(1, (300)) and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) >= 0))) == true
    end
    EOC["scarlet_gust_1"] = function(ctx)
    if (((((services.weather.current().weather and services.weather.current().weather.value) == "scarlet_storm_1") or ((services.weather.current().weather and services.weather.current().weather.value) == "scarlet_storm_2") or ((services.weather.current().weather and services.weather.current().weather.value) == "scarlet_storm_3") or ((services.weather.current().weather and services.weather.current().weather.value) == "scarlet_storm_4")) and services.random.native_probability(1, (300)) and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) >= 0))) then
        services.messages.add(ctx:expand_text(services.translate("Winds whisper in the distance.")), "neutral")
        return true
    end
    return false
    end
    COND["scarlet_gust_2"] = function(ctx)
        return (((((services.weather.current().weather and services.weather.current().weather.value) == "scarlet_storm_3") or ((services.weather.current().weather and services.weather.current().weather.value) == "scarlet_storm_4")) and services.random.native_probability(1, (300)) and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) >= 0))) == true
    end
    EOC["scarlet_gust_2"] = function(ctx)
    if (((((services.weather.current().weather and services.weather.current().weather.value) == "scarlet_storm_3") or ((services.weather.current().weather and services.weather.current().weather.value) == "scarlet_storm_4")) and services.random.native_probability(1, (300)) and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) >= 0))) then
        services.messages.add(ctx:expand_text(services.translate("The wind moans through the fog.")), "neutral")
        do local _cur = H.weather_val('windpower'); local _nxt = 30; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.weather.set_windpower(_val) end
        return true
    end
    return false
    end
    COND["scarlet_gust_3"] = function(ctx)
        return ((((services.weather.current().weather and services.weather.current().weather.value) == "scarlet_storm_4") and services.random.native_probability(1, (300)) and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) >= 0))) == true
    end
    EOC["scarlet_gust_3"] = function(ctx)
    if ((((services.weather.current().weather and services.weather.current().weather.value) == "scarlet_storm_4") and services.random.native_probability(1, (300)) and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) >= 0))) then
        services.messages.add(ctx:expand_text(services.translate("You hear winds howl high in the sky!")), "neutral")
        do local _cur = H.weather_val('windpower'); local _nxt = 50; local _val = ("=" == '=') and _nxt or (("=" == '+=') and (_cur + _nxt) or (("=" == '-=') and (_cur - _nxt) or (("=" == '*=') and (_cur * _nxt) or (_cur / _nxt)))); services.weather.set_windpower(_val) end
        return true
    end
    return false
    end
    COND["scarlet_thunder"] = function(ctx)
        return (((((services.weather.current().weather and services.weather.current().weather.value) == "scarlet_storm_3") or ((services.weather.current().weather and services.weather.current().weather.value) == "scarlet_storm_4") or ((services.weather.current().weather and services.weather.current().weather.value) == "scarlet_storm_5")) and services.random.native_probability(1, (100)) and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) >= 0))) == true
    end
    EOC["scarlet_thunder"] = function(ctx)
    if (((((services.weather.current().weather and services.weather.current().weather.value) == "scarlet_storm_3") or ((services.weather.current().weather and services.weather.current().weather.value) == "scarlet_storm_4") or ((services.weather.current().weather and services.weather.current().weather.value) == "scarlet_storm_5")) and services.random.native_probability(1, (100)) and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) >= 0))) then
        services.messages.add(ctx:expand_text(services.translate("You hear a distant rumble of thunder.")), "neutral")
        services.sound.play_from_outdoors("thunder_far", "environment", math.floor(80))
        return true
    end
    return false
    end
    COND["scarlet_lightning"] = function(ctx)
        return (((((services.weather.current().weather and services.weather.current().weather.value) == "scarlet_storm_4") or ((services.weather.current().weather and services.weather.current().weather.value) == "scarlet_storm_5")) and services.random.native_probability(1, (200)) and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) >= 0))) == true
    end
    EOC["scarlet_lightning"] = function(ctx)
    if (((((services.weather.current().weather and services.weather.current().weather.value) == "scarlet_storm_4") or ((services.weather.current().weather and services.weather.current().weather.value) == "scarlet_storm_5")) and services.random.native_probability(1, (200)) and (((function() local cs = H.creature_snap(H.u(ctx)); return cs and cs.position and cs.position.z or 0 end)()) >= 0))) then
        services.messages.add(ctx:expand_text(services.translate("A flash of lightning illuminates the scarlet sky!")), "neutral")
        services.sound.play_if_audible("thunder_near", "environment", math.floor(80))
        services.weather.activate_lightning()
        services.weather.override_light(math.floor(100), services.time.duration_from_turns(math.floor((function() local a, b = math.floor(1), math.floor(12); if a > b then a, b = b, a end; return services.random.native_int(a, b) end)())), "")
        return true
    end
    return false
    end
    COND["EOC_SCARLET_STORM_WARNING"] = function(ctx)
        return (((H.global_var_num("player_saw_scarlet_storm") ~= 1) and (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and (((services.weather.current().weather and services.weather.current().weather.value) == "scarlet_storm_1") or ((services.weather.current().weather and services.weather.current().weather.value) == "scarlet_storm_2") or ((services.weather.current().weather and services.weather.current().weather.value) == "scarlet_storm_3") or ((services.weather.current().weather and services.weather.current().weather.value) == "scarlet_storm_4") or ((services.weather.current().weather and services.weather.current().weather.value) == "scarlet_storm_5")))) == true
    end
    EOC["EOC_SCARLET_STORM_WARNING"] = function(ctx)
    if (((H.global_var_num("player_saw_scarlet_storm") ~= 1) and (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and (((services.weather.current().weather and services.weather.current().weather.value) == "scarlet_storm_1") or ((services.weather.current().weather and services.weather.current().weather.value) == "scarlet_storm_2") or ((services.weather.current().weather and services.weather.current().weather.value) == "scarlet_storm_3") or ((services.weather.current().weather and services.weather.current().weather.value) == "scarlet_storm_4") or ((services.weather.current().weather and services.weather.current().weather.value) == "scarlet_storm_5")))) then
        ccb.presentation.notice((services.snippets.native_random("<scarlet_storm_warning>") or ''))
        services.activities.offer_interruption((services.snippets.native_random("<scarlet_storm_warning>") or ''))
        H.set_var("global", nil, ctx, "player_saw_scarlet_storm", 1)
        do local _mid = "MISSION_ROBOFAC_PAT_RECON_13"; if H.u(ctx) then local _pg = services.missions.active(H.u(ctx), { limit = 64 }); for _, _m in ipairs((_pg and _pg.items) or {}) do if _m.id and _m.id.value == _mid and _m.token then services.missions.abandon(H.u(ctx), _m.token); break end end end end
        return true
    end
    return false
    end
    COND["EOC_STRING_DIMENSION_ENTERED_EXODII_DOME"] = function(ctx)
        return (((services.gameplay.environment.dimension() == "string_dimension") and (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "string_dimension_dome_x1y1z-2", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "string_dimension_dome_x2y0z-2", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "string_dimension_dome_x2y0z-1", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "string_dimension_dome_x2y0z0", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "string_dimension_dome_x1y1z0", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "string_dimension_dome_x1y2z0", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "string_dimension_dome_x0y0z2", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "string_dimension_dome_x1y0z2", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "string_dimension_dome_x2y0z2", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "string_dimension_dome_x0y1z2", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "string_dimension_dome_x1y1z2", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "string_dimension_dome_x2y1z2", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "string_dimension_dome_x0y2z2", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "string_dimension_dome_x1y2z2", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "string_dimension_dome_x2y2z2", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "string_dimension_dome_x0y0z1", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "string_dimension_dome_x1y0z1", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "string_dimension_dome_x2y0z1", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "string_dimension_dome_x0y1z1", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "string_dimension_dome_x1y1z1", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "string_dimension_dome_x2y1z1", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "string_dimension_dome_x0y2z1", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "string_dimension_dome_x1y2z1", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "string_dimension_dome_x2y2z1", math.floor(1)) end)())) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "u_found_string_dimension_exodii", "")))))))) == true
    end
    EOC["EOC_STRING_DIMENSION_ENTERED_EXODII_DOME"] = function(ctx)
    if (((services.gameplay.environment.dimension() == "string_dimension") and (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "string_dimension_dome_x1y1z-2", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "string_dimension_dome_x2y0z-2", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "string_dimension_dome_x2y0z-1", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "string_dimension_dome_x2y0z0", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "string_dimension_dome_x1y1z0", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "string_dimension_dome_x1y2z0", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "string_dimension_dome_x0y0z2", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "string_dimension_dome_x1y0z2", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "string_dimension_dome_x2y0z2", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "string_dimension_dome_x0y1z2", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "string_dimension_dome_x1y1z2", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "string_dimension_dome_x2y1z2", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "string_dimension_dome_x0y2z2", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "string_dimension_dome_x1y2z2", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "string_dimension_dome_x2y2z2", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "string_dimension_dome_x0y0z1", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "string_dimension_dome_x1y0z1", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "string_dimension_dome_x2y0z1", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "string_dimension_dome_x0y1z1", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "string_dimension_dome_x1y1z1", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "string_dimension_dome_x2y1z1", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "string_dimension_dome_x0y2z1", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "string_dimension_dome_x1y2z1", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "string_dimension_dome_x2y2z1", math.floor(1)) end)())) and (not (((("yes") == (H.var_str("actor", H.u(ctx), ctx, "u_found_string_dimension_exodii", "")))))))) then
        H.set_var("actor", H.u(ctx), ctx, "u_found_string_dimension_exodii", "yes")
        if ((("yes") == (H.var_str("actor", H.u(ctx), ctx, "general_meeting_u_met_Rubik", "")))) then
            services.messages.add(ctx:expand_text(services.translate("This scrap-metal dome reminds you of Rubik and the Exodii castle.  Maybe you should ask them about it?")), "neutral")
        end
        return true
    end
    return false
    end
    EOC["EOC_SD_Computer"] = function(ctx)
    if H.npc(ctx) then services.npcs.open_dialogue(H.npc(ctx), H.u(ctx)) end
    return true
    end
    COND["EOC_quietfarm_nearby"] = function(ctx)
        return (((((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "unvitrified_farm_0", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "unvitrified_orchard", math.floor(1)) end)())) and (H.var_num(H.u(ctx), "vitri_glass_entered") < 1))) == true
    end
    EOC["EOC_quietfarm_nearby"] = function(ctx)
    if (((((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "unvitrified_farm_0", math.floor(1)) end)()) or ((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "unvitrified_orchard", math.floor(1)) end)())) and (H.var_num(H.u(ctx), "vitri_glass_entered") < 1))) then
        ccb.presentation.notice(ctx:expand_text(services.translate("<color_red>There is a soft, sonorous tone filling the air, like wind over brittle ice.  It sets your teeth on edge.</color>")))
        H.set_var("actor", H.u(ctx), ctx, "vitri_glass_entered", 1)
        H.set_var("actor", H.u(ctx), ctx, "back_from_vitri_glass", 0)
        return true
    end
    return false
    end
    COND["EOC_vitrified_farm_entry_event"] = function(ctx)
        return ((H.char_at_om_location(H.u(ctx), "unvitrified_farm_0") or H.char_at_om_location(H.u(ctx), "unvitrified_orchard"))) == true
    end
    EOC["EOC_vitrified_farm_entry_event"] = function(ctx)
    if ((H.char_at_om_location(H.u(ctx), "unvitrified_farm_0") or H.char_at_om_location(H.u(ctx), "unvitrified_orchard"))) then
        H.run_eoc("EOC_vitrified_farm_init", ctx, nil, nil, nil)
        return true
    end
    return false
    end
    COND["EOC_vitrified_farm_init"] = function(ctx)
        return (((H.char_at_om_location(H.u(ctx), "unvitrified_farm_0") or H.char_at_om_location(H.u(ctx), "unvitrified_orchard")) and ((not (((function() local eg = H.safe_id('effect', "VITRIFYING"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not ((H.char_has_trait(H.u(ctx), "NOT_GLASS") == 1))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_quietfarm_border_ground" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_quietfarm_border_fence" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_quietfarm_border_fence_closed" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_quietfarm_border_fence_open" end)()))) and (H.var_num(H.u(ctx), "vitri_glass_entered") < 2)))) == true
    end
    EOC["EOC_vitrified_farm_init"] = function(ctx)
    if (((H.char_at_om_location(H.u(ctx), "unvitrified_farm_0") or H.char_at_om_location(H.u(ctx), "unvitrified_orchard")) and ((not (((function() local eg = H.safe_id('effect', "VITRIFYING"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and (not ((H.char_has_trait(H.u(ctx), "NOT_GLASS") == 1))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_quietfarm_border_ground" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_quietfarm_border_fence" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_quietfarm_border_fence_closed" end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; local t = services.gameplay.environment.terrain_id(s.creature.position); return t and t.value == "t_quietfarm_border_fence_open" end)()))) and (H.var_num(H.u(ctx), "vitri_glass_entered") < 2)))) then
        services.world.override_place_name(H.var_str("global", nil, ctx, "place_name", "Quiet Farmhouse"), services.time.duration_from_turns(math.floor(86400)))
        services.weather.override_light(math.floor(70), services.time.duration_from_turns(math.floor(86400)), "vitrified_farm_escape_key")
        H.set_var("actor", H.u(ctx), ctx, "glass_health_head", H.char_hp(H.u(ctx), "head", false))
        H.set_var("actor", H.u(ctx), ctx, "glass_health_torso", H.char_hp(H.u(ctx), "torso", false))
        H.set_var("actor", H.u(ctx), ctx, "glass_health_arm_l", H.char_hp(H.u(ctx), "arm_l", false))
        H.set_var("actor", H.u(ctx), ctx, "glass_health_arm_r", H.char_hp(H.u(ctx), "arm_r", false))
        H.set_var("actor", H.u(ctx), ctx, "glass_health_leg_l", H.char_hp(H.u(ctx), "leg_l", false))
        H.set_var("actor", H.u(ctx), ctx, "glass_health_leg_r", H.char_hp(H.u(ctx), "leg_r", false))
        H.set_var("actor", H.u(ctx), ctx, "glass_sleepiness", (((H.char_snap(H.u(ctx)) or {}).needs or {}).sleepiness or 0))
        H.eoc_loc_var(H.u(ctx), ctx, "global", "vitrified_farm_ground", { terrain = "unvitrified_farm_0" }, { z = math.floor(0), min_distance = math.floor(0) }, nil, nil, { dz = math.floor(6) }, true, true, {  }, {  })
        H.eoc_loc_var(H.u(ctx), ctx, "global", "vitrified_farm_upper", { terrain = "unvitrified_farm_1" }, { z = math.floor(0), min_distance = math.floor(0) }, nil, nil, { dz = math.floor(7) }, true, true, {  }, {  })
        H.eoc_loc_var(H.u(ctx), ctx, "global", "vitrified_farm_basement", { terrain = "unvitrified_farm_neg_1" }, { z = math.floor(0), min_distance = math.floor(0) }, nil, nil, { dz = math.floor(5) }, true, true, {  }, {  })
        H.eoc_loc_var(H.u(ctx), ctx, "global", "vitrified_farm_roof", { terrain = "unvitrified_farm_2" }, { z = math.floor(0), min_distance = math.floor(0) }, nil, nil, { dz = math.floor(8) }, true, true, {  }, {  })
        H.eoc_loc_var(H.u(ctx), ctx, "global", "vitrified_sky_1", { terrain = "unvitrified_farm_2" }, { z = math.floor(0), min_distance = math.floor(0) }, nil, nil, { dz = math.floor(9) }, true, true, {  }, {  })
        H.eoc_loc_var(H.u(ctx), ctx, "global", "vitrified_apples", { terrain = "unvitrified_orchard" }, { z = math.floor(0), min_distance = math.floor(0) }, nil, nil, { dz = math.floor(6) }, true, true, {  }, {  })
        H.eoc_loc_var(H.u(ctx), ctx, "global", "vitrified_apples_sky_lower", { terrain = "unvitrified_orchard" }, { z = math.floor(0), min_distance = math.floor(0) }, nil, nil, { dz = math.floor(7) }, true, true, {  }, {  })
        H.eoc_loc_var(H.u(ctx), ctx, "global", "vitrified_apples_sky_upper", { terrain = "unvitrified_orchard" }, { z = math.floor(0), min_distance = math.floor(0) }, nil, nil, { dz = math.floor(8) }, true, true, {  }, {  })
        H.eoc_loc_var(H.u(ctx), ctx, "global", "vitrified_sky_2", { terrain = "unvitrified_orchard" }, { z = math.floor(0), min_distance = math.floor(0) }, nil, nil, { dz = math.floor(9) }, true, true, {  }, {  })
        do local _p = H.get_tripoint_var("global", nil, ctx, "vitrified_farm_ground"); if _p then services.world.schedule_location_revert(_p, services.time.duration_from_turns(math.floor(-1)), "vitrified_farm_escape_key") end end
        do local _p = H.get_tripoint_var("global", nil, ctx, "vitrified_farm_upper"); if _p then services.world.schedule_location_revert(_p, services.time.duration_from_turns(math.floor(-1)), "vitrified_farm_escape_key") end end
        do local _p = H.get_tripoint_var("global", nil, ctx, "vitrified_farm_basement"); if _p then services.world.schedule_location_revert(_p, services.time.duration_from_turns(math.floor(-1)), "vitrified_farm_escape_key") end end
        do local _p = H.get_tripoint_var("global", nil, ctx, "vitrified_farm_roof"); if _p then services.world.schedule_location_revert(_p, services.time.duration_from_turns(math.floor(-1)), "vitrified_farm_escape_key") end end
        do local _p = H.get_tripoint_var("global", nil, ctx, "vitrified_sky_1"); if _p then services.world.schedule_location_revert(_p, services.time.duration_from_turns(math.floor(-1)), "vitrified_farm_escape_key") end end
        do local _p = H.get_tripoint_var("global", nil, ctx, "vitrified_apples"); if _p then services.world.schedule_location_revert(_p, services.time.duration_from_turns(math.floor(-1)), "vitrified_farm_escape_key") end end
        do local _p = H.get_tripoint_var("global", nil, ctx, "vitrified_apples_sky_lower"); if _p then services.world.schedule_location_revert(_p, services.time.duration_from_turns(math.floor(-1)), "vitrified_farm_escape_key") end end
        do local _p = H.get_tripoint_var("global", nil, ctx, "vitrified_apples_sky_upper"); if _p then services.world.schedule_location_revert(_p, services.time.duration_from_turns(math.floor(-1)), "vitrified_farm_escape_key") end end
        do local _p = H.get_tripoint_var("global", nil, ctx, "vitrified_sky_2"); if _p then services.world.schedule_location_revert(_p, services.time.duration_from_turns(math.floor(-1)), "vitrified_farm_escape_key") end end
        do local _p = H.get_tripoint_var("global", nil, ctx, "vitrified_farm_ground"); if _p then local _omt = _p:project_to('omt'); local _om = nil; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "vitrified_farm_0" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        do local _p = H.get_tripoint_var("global", nil, ctx, "vitrified_farm_upper"); if _p then local _omt = _p:project_to('omt'); local _om = nil; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "vitrified_farm_1" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        do local _p = H.get_tripoint_var("global", nil, ctx, "vitrified_farm_basement"); if _p then local _omt = _p:project_to('omt'); local _om = nil; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "vitrified_farm_-1" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        do local _p = H.get_tripoint_var("global", nil, ctx, "vitrified_farm_roof"); if _p then local _omt = _p:project_to('omt'); local _om = nil; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "vitrified_farm_2" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        do local _p = H.get_tripoint_var("global", nil, ctx, "vitrified_sky_1"); if _p then local _omt = _p:project_to('omt'); local _om = nil; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "vitrified_sky" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        do local _p = H.get_tripoint_var("global", nil, ctx, "vitrified_apples"); if _p then local _omt = _p:project_to('omt'); local _om = nil; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "vitrified_orchard" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        do local _p = H.get_tripoint_var("global", nil, ctx, "vitrified_apples_sky_lower"); if _p then local _omt = _p:project_to('omt'); local _om = nil; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "vitrified_orchard_sky" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        do local _p = H.get_tripoint_var("global", nil, ctx, "vitrified_apples_sky_upper"); if _p then local _omt = _p:project_to('omt'); local _om = nil; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "vitrified_orchard_sky" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        do local _p = H.get_tripoint_var("global", nil, ctx, "vitrified_sky_2"); if _p then local _omt = _p:project_to('omt'); local _om = nil; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "vitrified_sky" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
        H.eoc_loc_var(H.u(ctx), ctx, "actor", "vitrifaction_entry", nil, nil, nil, nil, { dz = math.floor(6) }, false, true, {  }, {  })
        do local _p = H.get_tripoint_var("actor", H.u(ctx), ctx, "vitrifaction_entry"); if _p then if ctx and ctx.proxy_teleport then ctx.proxy_teleport(_p, { force = true }) elseif ctx.avatar_death then services.relocation.teleport_deceased_avatar(_p, { force = true }) elseif H.u(ctx) then services.relocation.teleport_character(H.u(ctx), _p, { force = true }) end end end
        H.run_eoc("EOC_quietfarm_nearby_popup_welcome_message", ctx, nil, nil, nil)
        H.set_var("actor", H.u(ctx), ctx, "vitri_vitrified", 1)
        H.set_var("actor", H.u(ctx), ctx, "vitri_glassed", 0)
        H.set_var("actor", H.u(ctx), ctx, "vitri_glass_entered", 2)
        H.eoc_add_effect(H.u(ctx), "VITRIFYING", -1, nil, H.var_num(H.u(ctx), "vitri_vitrified"), nil)
        do local _t = math.max(1, math.floor(60)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_vitrified_farm_explore"), nil) end end
        return true
    else
        if ((not ((H.char_has_trait(H.u(ctx), "NOT_GLASS") == 1))) and (H.char_at_om_location(H.u(ctx), "unvitrified_farm_0") or H.char_at_om_location(H.u(ctx), "unvitrified_orchard"))) then
            do local _t = math.max(1, math.floor(1)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_vitrified_farm_init"), nil) end end
        end
        return false
    end
    end
    EOC["EOC_quietfarm_nearby_popup_welcome_message"] = function(ctx)
    ccb.presentation.notice(ctx:expand_text(services.translate("You arrive at the farmhouse, after what feels like an eternity.  It's not quite what you were expecting, but it's very peaceful.")))
    return true
    end
    COND["EOC_vitrified_farm_explore"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "VITRIFYING"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["EOC_vitrified_farm_explore"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "VITRIFYING"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        do local _t = math.max(1, math.floor(60)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_vitrified_farm_explore"), nil) end end
        do
            local _sw22 = H.var_num(H.u(ctx), "vitri_vitrified")
            if _sw22 == 1 then
                services.messages.add((services.snippets.native_random("Vitrifaction_Ambient_1") or ''), "good")
                H.set_var("actor", H.u(ctx), ctx, "vitri_glassed", (H.var_num(H.u(ctx), "vitri_glassed")) + (1))
                do local _g = H.safe_id('morale', "morale_vitri_placid"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(3), math.floor(50), { duration = services.time.duration(1, 'hour'), decay_start = services.time.duration(30, 'minutes') }) end end
                H.run_eoc("EOC_queue_vitrified_int_drain", ctx, nil, nil, nil)
            elseif _sw22 == 2 then
                services.messages.add((services.snippets.native_random("Vitrifaction_Ambient_2") or ''), "good")
                H.set_var("actor", H.u(ctx), ctx, "vitri_glassed", (H.var_num(H.u(ctx), "vitri_glassed")) + (1))
                do local _g = H.safe_id('morale', "morale_vitri_placid"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(5), math.floor(99), { duration = services.time.duration(1, 'hour'), decay_start = services.time.duration(30, 'minutes') }) end end
                H.run_eoc("EOC_queue_vitrified_int_drain", ctx, nil, nil, nil)
            elseif _sw22 == 3 then
                services.messages.add((services.snippets.native_random("Vitrifaction_Ambient_3") or ''), "good")
                H.set_var("actor", H.u(ctx), ctx, "vitri_glassed", (H.var_num(H.u(ctx), "vitri_glassed")) + (1))
                do local _g = H.safe_id('morale', "morale_vitri_placid"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(7), math.floor(99), { duration = services.time.duration(1, 'hour'), decay_start = services.time.duration(30, 'minutes') }) end end
                H.run_eoc("EOC_queue_vitrified_int_drain", ctx, nil, nil, nil)
            elseif _sw22 == 4 then
                services.messages.add((services.snippets.native_random("Vitrifaction_Ambient_4") or ''), "good")
                H.set_var("actor", H.u(ctx), ctx, "vitri_glassed", (H.var_num(H.u(ctx), "vitri_glassed")) + (1))
                do local _g = H.safe_id('morale', "morale_vitri_placid"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(10), math.floor(99), { duration = services.time.duration(1, 'hour'), decay_start = services.time.duration(30, 'minutes') }) end end
                H.run_eoc("EOC_queue_vitrified_int_drain", ctx, nil, nil, nil)
            elseif _sw22 == 5 then
                services.messages.add((services.snippets.native_random("Vitrifaction_Ambient_5") or ''), "good")
                H.set_var("actor", H.u(ctx), ctx, "vitri_glassed", (H.var_num(H.u(ctx), "vitri_glassed")) + (1))
                do local _g = H.safe_id('morale', "morale_vitri_placid"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(15), math.floor(99), { duration = services.time.duration(1, 'hour'), decay_start = services.time.duration(30, 'minutes') }) end end
                H.run_eoc("EOC_queue_vitrified_int_drain", ctx, nil, nil, nil)
            elseif _sw22 == 6 then
                services.messages.add((services.snippets.native_random("Vitrifaction_Ambient_6") or ''), "good")
                H.set_var("actor", H.u(ctx), ctx, "vitri_glassed", (H.var_num(H.u(ctx), "vitri_glassed")) + (1))
                do local _g = H.safe_id('morale', "morale_vitri_placid"); if H.u(ctx) and _g then services.morale.add(H.u(ctx), _g, math.floor(20), math.floor(99), { duration = services.time.duration(1, 'hour'), decay_start = services.time.duration(30, 'minutes') }) end end
                H.run_eoc("EOC_queue_vitrified_int_drain", ctx, nil, nil, nil)
            elseif _sw22 == 7 then
                ccb.presentation.notice((services.snippets.native_random("Vitrifaction_Final") or ''))
                H.set_char_hp(H.u(ctx), "ALL", 0, "=")
            end
        end
        return true
    end
    return false
    end
    COND["vitrified_bleed_check"] = function(ctx)
        return ((((function() local eg = H.safe_id('effect', "VITRIFYING"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and ((function() local eg = H.safe_id('effect', "bleed"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) == true
    end
    EOC["vitrified_bleed_check"] = function(ctx)
    if ((((function() local eg = H.safe_id('effect', "VITRIFYING"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()) and ((function() local eg = H.safe_id('effect', "bleed"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) then
        do
            local _sw23 = H.var_num(H.u(ctx), "vitri_vitrified")
            if _sw23 == 0 then
                services.messages.add((services.snippets.native_random("Vitrifaction_Bleed_1") or ''), "good")
            elseif _sw23 == 3 then
                services.messages.add((services.snippets.native_random("Vitrifaction_Bleed_2") or ''), "good")
            elseif _sw23 == 5 then
                services.messages.add((services.snippets.native_random("Vitrifaction_Bleed_3") or ''), "good")
            end
        end
        return true
    end
    return false
    end
    COND["vitrified_death"] = function(ctx)
        return (((function() local eg = H.safe_id('effect', "VITRIFYING"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) == true
    end
    EOC["vitrified_death"] = function(ctx)
    if (((function() local eg = H.safe_id('effect', "VITRIFYING"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)())) then
        services.messages.add((services.snippets.native_random("Vitrifaction_Final") or ''), "good")
        return true
    end
    return false
    end
    EOC["EOC_queue_vitrified_int_drain"] = function(ctx)
    do local _t = math.max(1, math.floor(1)); if services.characters then ccb.tasks.after(_t, 'eoc:' .. tostring("EOC_vitrified_int_drain"), nil) end end
    return true
    end
    COND["EOC_vitrified_int_drain"] = function(ctx)
        return ((services.random.native_probability((1), (2)) and (H.var_num(H.u(ctx), "vitri_glassed") >= 5))) == true
    end
    EOC["EOC_vitrified_int_drain"] = function(ctx)
    if ((services.random.native_probability((1), (2)) and (H.var_num(H.u(ctx), "vitri_glassed") >= 5))) then
        H.set_var("actor", H.u(ctx), ctx, "vitri_vitrified", (H.var_num(H.u(ctx), "vitri_vitrified")) + (1))
        H.eoc_add_effect(H.u(ctx), "VITRIFYING", -1, nil, H.var_num(H.u(ctx), "vitri_vitrified"), nil)
        H.set_var("actor", H.u(ctx), ctx, "vitri_glassed", 0)
        return true
    end
    return false
    end
    EOC["EOC_vitrified_succession"] = function(ctx)
    services.time.reschedule("vitrified_farm_escape_key", services.time.duration_from_turns(0))
    return true
    end
    COND["EOC_hair_growth_tracking"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "natural_hair_growth") == 1)) == true
    end
    EOC["EOC_hair_growth_tracking"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "natural_hair_growth") == 1)) then
        if (H.char_has_trait(H.u(ctx), "hair_buzzcut") == 1) then
            H.lose_trait(H.u(ctx), "hair_buzzcut")
            H.run_eoc("reset_natural_hair_color", ctx, { ["trait_id"] = "hair_crewcut" }, nil, nil)
        else
            if (H.char_has_trait(H.u(ctx), "hair_crewcut") == 1) then
                H.lose_trait(H.u(ctx), "hair_crewcut")
                H.run_eoc("reset_natural_hair_color", ctx, { ["trait_id"] = "hair_short" }, nil, nil)
            else
                if ((H.char_has_trait(H.u(ctx), "hair_short") == 1) or (H.char_has_trait(H.u(ctx), "hair_short_no_fringe") == 1) or (H.char_has_trait(H.u(ctx), "hair_short_over_eye") == 1) or (H.char_has_trait(H.u(ctx), "hair_modern") == 1) or (H.char_has_trait(H.u(ctx), "hair_detective") == 1)) then
                    H.lose_trait(H.u(ctx), "hair_short")
                    H.lose_trait(H.u(ctx), "hair_short_no_fringe")
                    H.lose_trait(H.u(ctx), "hair_short_over_eye")
                    H.lose_trait(H.u(ctx), "hair_modern")
                    H.lose_trait(H.u(ctx), "hair_detective")
                    H.run_eoc("reset_natural_hair_color", ctx, { ["trait_id"] = "hair_medium" }, nil, nil)
                else
                    if ((H.char_has_trait(H.u(ctx), "hair_medium") == 1) or (H.char_has_trait(H.u(ctx), "hair_puff") == 1) or (H.char_has_trait(H.u(ctx), "hair_beaded") == 1) or (H.char_has_trait(H.u(ctx), "hair_curls") == 1)) then
                        H.lose_trait(H.u(ctx), "hair_medium")
                        H.lose_trait(H.u(ctx), "hair_puff")
                        H.lose_trait(H.u(ctx), "hair_beaded")
                        H.lose_trait(H.u(ctx), "hair_curls")
                        H.run_eoc("reset_natural_hair_color", ctx, { ["trait_id"] = "hair_long" }, nil, nil)
                    else
                        if (H.char_has_trait(H.u(ctx), "hair_mohawk") == 1) then
                            H.lose_trait(H.u(ctx), "hair_mohawk")
                            H.run_eoc("reset_natural_hair_color", ctx, { ["trait_id"] = "hair_long_mohawk" }, nil, nil)
                        else
                            if ((H.char_has_trait(H.u(ctx), "hair_super_princess") == 1) or (H.char_has_trait(H.u(ctx), "hair_long_mohawk") == 1) or (H.char_has_trait(H.u(ctx), "hair_long") == 1) or (H.char_has_trait(H.u(ctx), "hair_long_over_eye") == 1) or (H.char_has_trait(H.u(ctx), "hair_mullet") == 1) or (H.char_has_trait(H.u(ctx), "hair_bun") == 1)) then
                                H.lose_trait(H.u(ctx), "hair_super_princess")
                                H.lose_trait(H.u(ctx), "hair_long_mohawk")
                                H.lose_trait(H.u(ctx), "hair_long")
                                H.lose_trait(H.u(ctx), "hair_long_over_eye")
                                H.lose_trait(H.u(ctx), "hair_mullet")
                                H.lose_trait(H.u(ctx), "hair_bun")
                                H.run_eoc("reset_natural_hair_color", ctx, { ["trait_id"] = "hair_messy" }, nil, nil)
                            else
                                if ((H.char_has_trait(H.u(ctx), "hair_messy") == 1) or (H.char_has_trait(H.u(ctx), "hair_punk_long") == 1)) then
                                    H.lose_trait(H.u(ctx), "hair_messy")
                                    H.lose_trait(H.u(ctx), "hair_punk_long")
                                    H.run_eoc("reset_natural_hair_color", ctx, { ["trait_id"] = "hair_very_long" }, nil, nil)
                                else
                                    if ((H.char_has_trait(H.u(ctx), "hair_very_long") == 1) or (H.char_has_trait(H.u(ctx), "hair_twintails") == 1) or (H.char_has_trait(H.u(ctx), "hair_braid") == 1)) then
                                        H.lose_trait(H.u(ctx), "hair_very_long")
                                        H.lose_trait(H.u(ctx), "hair_twintails")
                                        H.lose_trait(H.u(ctx), "hair_braid")
                                        H.run_eoc("reset_natural_hair_color", ctx, { ["trait_id"] = "hair_extremely_long" }, nil, nil)
                                    else
                                        if ((H.char_has_trait(H.u(ctx), "hair_extremely_long") == 1)) then
                                            H.lose_trait(H.u(ctx), "hair_extremely_long")
                                            H.run_eoc("reset_natural_hair_color", ctx, { ["trait_id"] = "hair_body_length" }, nil, nil)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        return true
    end
    return false
    end
    COND["EOC_beard_growth_tracking"] = function(ctx)
        return ((H.char_has_trait(H.u(ctx), "natural_beard_growth") == 1)) == true
    end
    EOC["EOC_beard_growth_tracking"] = function(ctx)
    if ((H.char_has_trait(H.u(ctx), "natural_beard_growth") == 1)) then
        if (H.char_has_trait(H.u(ctx), "FACIAL_HAIR_NONE") == 1) then
            H.lose_trait(H.u(ctx), "FACIAL_HAIR_NONE")
            do local _g = H.safe_id('mutation', "FACIAL_HAIR_NECKBEARD"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
        else
            if ((H.char_has_trait(H.u(ctx), "FACIAL_HAIR_NECKBEARD") == 1) or (H.char_has_trait(H.u(ctx), "FACIAL_HAIR_SIDEBURNS") == 1) or (H.char_has_trait(H.u(ctx), "FACIAL_HAIR_SOUL_PATCH") == 1) or (H.char_has_trait(H.u(ctx), "FACIAL_HAIR_CHIN_STRIP") == 1)) then
                H.lose_trait(H.u(ctx), "FACIAL_HAIR_NECKBEARD")
                H.lose_trait(H.u(ctx), "FACIAL_HAIR_SIDEBURNS")
                H.lose_trait(H.u(ctx), "FACIAL_HAIR_SOUL_PATCH")
                H.lose_trait(H.u(ctx), "FACIAL_HAIR_CHIN_STRIP")
                do local _g = H.safe_id('mutation', "FACIAL_HAIR_3DAYSTUBBLE"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
            else
                if ((H.char_has_trait(H.u(ctx), "FACIAL_HAIR_3DAYSTUBBLE") == 1) or (H.char_has_trait(H.u(ctx), "FACIAL_HAIR_TOOTHBRUSH") == 1) or (H.char_has_trait(H.u(ctx), "FACIAL_HAIR_CHIN_STRAP") == 1) or (H.char_has_trait(H.u(ctx), "FACIAL_HAIR_MUSTACHE") == 1) or (H.char_has_trait(H.u(ctx), "FACIAL_HAIR_NECKBEARD") == 1) or (H.char_has_trait(H.u(ctx), "FACIAL_HAIR_WALRUS") == 1) or (H.char_has_trait(H.u(ctx), "FACIAL_HAIR_ZAPPA") == 1)) then
                    H.lose_trait(H.u(ctx), "FACIAL_HAIR_3DAYSTUBBLE")
                    H.lose_trait(H.u(ctx), "FACIAL_HAIR_TOOTHBRUSH")
                    H.lose_trait(H.u(ctx), "FACIAL_HAIR_CHIN_STRAP")
                    H.lose_trait(H.u(ctx), "FACIAL_HAIR_MUSTACHE")
                    H.lose_trait(H.u(ctx), "FACIAL_HAIR_NECKBEARD")
                    H.lose_trait(H.u(ctx), "FACIAL_HAIR_WALRUS")
                    H.lose_trait(H.u(ctx), "FACIAL_HAIR_ZAPPA")
                    do local _g = H.safe_id('mutation', "FACIAL_HAIR_GOATEE"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
                else
                    if ((H.char_has_trait(H.u(ctx), "FACIAL_HAIR_GOATEE") == 1) or (H.char_has_trait(H.u(ctx), "FACIAL_HAIR_CIRCLE") == 1) or (H.char_has_trait(H.u(ctx), "FACIAL_HAIR_SHORTBOXED") == 1) or (H.char_has_trait(H.u(ctx), "FACIAL_HAIR_HORSESHOE") == 1) or (H.char_has_trait(H.u(ctx), "FACIAL_HAIR_MUTTONCHOPS") == 1) or (H.char_has_trait(H.u(ctx), "FACIAL_HAIR_GUNSLINGER") == 1) or (H.char_has_trait(H.u(ctx), "FACIAL_HAIR_CHIN_CURTAIN") == 1) or (H.char_has_trait(H.u(ctx), "FACIAL_HAIR_HANDLEBAR") == 1) or (H.char_has_trait(H.u(ctx), "FACIAL_HAIR_VANDYKE") == 1)) then
                        H.lose_trait(H.u(ctx), "FACIAL_HAIR_GOATEE")
                        H.lose_trait(H.u(ctx), "FACIAL_HAIR_CIRCLE")
                        H.lose_trait(H.u(ctx), "FACIAL_HAIR_SHORTBOXED")
                        H.lose_trait(H.u(ctx), "FACIAL_HAIR_HORSESHOE")
                        H.lose_trait(H.u(ctx), "FACIAL_HAIR_MUTTONCHOPS")
                        H.lose_trait(H.u(ctx), "FACIAL_HAIR_GUNSLINGER")
                        H.lose_trait(H.u(ctx), "FACIAL_HAIR_CHIN_CURTAIN")
                        H.lose_trait(H.u(ctx), "FACIAL_HAIR_HANDLEBAR")
                        H.lose_trait(H.u(ctx), "FACIAL_HAIR_VANDYKE")
                        do local _g = H.safe_id('mutation', "FACIAL_HAIR_BEARD"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
                    else
                        if ((H.char_has_trait(H.u(ctx), "FACIAL_HAIR_BEARD") == 1) or (H.char_has_trait(H.u(ctx), "FACIAL_HAIR_ANCHOR") == 1) or (H.char_has_trait(H.u(ctx), "FACIAL_HAIR_ROYALE") == 1)) then
                            H.lose_trait(H.u(ctx), "FACIAL_HAIR_BEARD")
                            H.lose_trait(H.u(ctx), "FACIAL_HAIR_ANCHOR")
                            H.lose_trait(H.u(ctx), "FACIAL_HAIR_ROYALE")
                            do local _g = H.safe_id('mutation', "FACIAL_HAIR_SHENANDOAH"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
                        else
                            if ((H.char_has_trait(H.u(ctx), "FACIAL_HAIR_SHENANDOAH") == 1)) then
                                H.lose_trait(H.u(ctx), "FACIAL_HAIR_SHENANDOAH")
                                do local _g = H.safe_id('mutation', "FACIAL_HAIR_BEARD_LONG"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
                            else
                                if ((H.char_has_trait(H.u(ctx), "FACIAL_HAIR_BEARD_LONG") == 1)) then
                                    H.lose_trait(H.u(ctx), "FACIAL_HAIR_BEARD_LONG")
                                    do local _g = H.safe_id('mutation', "FACIAL_HAIR_BEARD_VERY_LONG"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
                                end
                            end
                        end
                    end
                end
            end
        end
        return true
    end
    return false
    end
    COND["reset_natural_hair_color"] = function(ctx)
        return ((H.var_exists('context', nil, ctx, "trait_id"))) == true
    end
    EOC["reset_natural_hair_color"] = function(ctx)
    if ((H.var_exists('context', nil, ctx, "trait_id"))) then
        H.run_eoc("assign_random_natural_hair_color", ctx, nil, nil, nil)
        if (H.char_has_trait(H.u(ctx), "natural_hair_color_black") == 1) then
            do local _g = H.safe_id('mutation', H.var_str("context", nil, ctx, "trait_id", "")); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g, "black") end end
        else
            if (H.char_has_trait(H.u(ctx), "natural_hair_color_blond") == 1) then
                do local _g = H.safe_id('mutation', H.var_str("context", nil, ctx, "trait_id", "")); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g, "blond") end end
            else
                if (H.char_has_trait(H.u(ctx), "natural_hair_color_brown") == 1) then
                    do local _g = H.safe_id('mutation', H.var_str("context", nil, ctx, "trait_id", "")); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g, "brown") end end
                else
                    if (H.char_has_trait(H.u(ctx), "natural_hair_color_gray") == 1) then
                        do local _g = H.safe_id('mutation', H.var_str("context", nil, ctx, "trait_id", "")); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g, "gray") end end
                    else
                        if (H.char_has_trait(H.u(ctx), "natural_hair_color_red") == 1) then
                            do local _g = H.safe_id('mutation', H.var_str("context", nil, ctx, "trait_id", "")); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g, "red") end end
                        else
                            if (H.char_has_trait(H.u(ctx), "natural_hair_color_white") == 1) then
                                do local _g = H.safe_id('mutation', H.var_str("context", nil, ctx, "trait_id", "")); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g, "white") end end
                            end
                        end
                    end
                end
            end
        end
        return true
    end
    return false
    end
    COND["apply_hair_dye"] = function(ctx)
        return ((H.var_exists('context', nil, ctx, "color_id"))) == true
    end
    EOC["apply_hair_dye"] = function(ctx)
    if ((H.var_exists('context', nil, ctx, "color_id"))) then
        if (H.char_has_trait(H.u(ctx), "hair_buzzcut") == 1) then
            H.lose_trait(H.u(ctx), "hair_buzzcut")
            do local _g = H.safe_id('mutation', "hair_buzzcut"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g, H.var_str("context", nil, ctx, "color_id", "")) end end
        else
            if (H.char_has_trait(H.u(ctx), "hair_crewcut") == 1) then
                H.lose_trait(H.u(ctx), "hair_crewcut")
                do local _g = H.safe_id('mutation', "hair_crewcut"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g, H.var_str("context", nil, ctx, "color_id", "")) end end
            else
                if (H.char_has_trait(H.u(ctx), "hair_short") == 1) then
                    H.lose_trait(H.u(ctx), "hair_short")
                    do local _g = H.safe_id('mutation', "hair_short"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g, H.var_str("context", nil, ctx, "color_id", "")) end end
                else
                    if (H.char_has_trait(H.u(ctx), "hair_short_no_fringe") == 1) then
                        H.lose_trait(H.u(ctx), "hair_short_no_fringe")
                        do local _g = H.safe_id('mutation', "hair_short_no_fringe"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g, H.var_str("context", nil, ctx, "color_id", "")) end end
                    else
                        if (H.char_has_trait(H.u(ctx), "hair_short_over_eye") == 1) then
                            H.lose_trait(H.u(ctx), "hair_short_over_eye")
                            do local _g = H.safe_id('mutation', "hair_short_over_eye"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g, H.var_str("context", nil, ctx, "color_id", "")) end end
                        else
                            if ((H.char_has_trait(H.u(ctx), "hair_medium") == 1)) then
                                H.lose_trait(H.u(ctx), "hair_medium")
                                do local _g = H.safe_id('mutation', "hair_medium"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g, H.var_str("context", nil, ctx, "color_id", "")) end end
                            else
                                if (H.char_has_trait(H.u(ctx), "hair_mohawk") == 1) then
                                    H.lose_trait(H.u(ctx), "hair_mohawk")
                                    do local _g = H.safe_id('mutation', "hair_mohawk"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g, H.var_str("context", nil, ctx, "color_id", "")) end end
                                else
                                    if (H.char_has_trait(H.u(ctx), "hair_long") == 1) then
                                        H.lose_trait(H.u(ctx), "hair_long")
                                        do local _g = H.safe_id('mutation', "hair_long"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g, H.var_str("context", nil, ctx, "color_id", "")) end end
                                    else
                                        if (H.char_has_trait(H.u(ctx), "hair_long_mohawk") == 1) then
                                            H.lose_trait(H.u(ctx), "hair_long_mohawk")
                                            do local _g = H.safe_id('mutation', "hair_long_mohawk"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g, H.var_str("context", nil, ctx, "color_id", "")) end end
                                        else
                                            if (H.char_has_trait(H.u(ctx), "hair_mullet") == 1) then
                                                H.lose_trait(H.u(ctx), "hair_mullet")
                                                do local _g = H.safe_id('mutation', "hair_mullet"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g, H.var_str("context", nil, ctx, "color_id", "")) end end
                                            else
                                                if (H.char_has_trait(H.u(ctx), "hair_long_over_eye") == 1) then
                                                    H.lose_trait(H.u(ctx), "hair_long_over_eye")
                                                    do local _g = H.safe_id('mutation', "hair_long_over_eye"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g, H.var_str("context", nil, ctx, "color_id", "")) end end
                                                else
                                                    if ((H.char_has_trait(H.u(ctx), "hair_messy") == 1)) then
                                                        H.lose_trait(H.u(ctx), "hair_messy")
                                                        do local _g = H.safe_id('mutation', "hair_messy"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g, H.var_str("context", nil, ctx, "color_id", "")) end end
                                                    else
                                                        if ((H.char_has_trait(H.u(ctx), "hair_very_long") == 1)) then
                                                            H.lose_trait(H.u(ctx), "hair_very_long")
                                                            do local _g = H.safe_id('mutation', "hair_very_long"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g, H.var_str("context", nil, ctx, "color_id", "")) end end
                                                        else
                                                            if ((H.char_has_trait(H.u(ctx), "hair_extremely_long") == 1)) then
                                                                H.lose_trait(H.u(ctx), "hair_extremely_long")
                                                                do local _g = H.safe_id('mutation', "hair_extremely_long"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g, H.var_str("context", nil, ctx, "color_id", "")) end end
                                                            else
                                                                if ((H.char_has_trait(H.u(ctx), "hair_body_length") == 1)) then
                                                                    H.lose_trait(H.u(ctx), "hair_body_length")
                                                                    do local _g = H.safe_id('mutation', "hair_body_length"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g, H.var_str("context", nil, ctx, "color_id", "")) end end
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        return true
    end
    return false
    end
    COND["use_hair_dye_kit"] = function(ctx)
        return (((not ((H.char_has_trait(H.u(ctx), "EXODII_BODY_1") == 1))) and (not ((H.char_has_trait(H.u(ctx), "EXODII_BODY_1b") == 1))) and (not (H.char_has_bionic(H.u(ctx), "bio_robofac_xmlens"))))) == true
    end
    EOC["use_hair_dye_kit"] = function(ctx)
    if (((not ((H.char_has_trait(H.u(ctx), "EXODII_BODY_1") == 1))) and (not ((H.char_has_trait(H.u(ctx), "EXODII_BODY_1b") == 1))) and (not (H.char_has_bionic(H.u(ctx), "bio_robofac_xmlens"))))) then
        do
            local _choices, _targets = {}, {}
            do local _en = (E.cond["black_hair_dye"] == nil or E.cond["black_hair_dye"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(1), label = ctx:expand_text(services.translate("Black Dye")), description = ctx:expand_text(services.translate("Dye your hair black.")), enabled = _en, hotkey = "1" }); _targets[tostring(1)] = "black_hair_dye" end end
            do local _en = (E.cond["blond_hair_dye"] == nil or E.cond["blond_hair_dye"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(2), label = ctx:expand_text(services.translate("Blond Dye")), description = ctx:expand_text(services.translate("Dye your hair blond.")), enabled = _en, hotkey = "2" }); _targets[tostring(2)] = "blond_hair_dye" end end
            do local _en = (E.cond["blue_hair_dye"] == nil or E.cond["blue_hair_dye"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(3), label = ctx:expand_text(services.translate("Blue Dye")), description = ctx:expand_text(services.translate("Dye your hair blue.")), enabled = _en, hotkey = "3" }); _targets[tostring(3)] = "blue_hair_dye" end end
            do local _en = (E.cond["brown_hair_dye"] == nil or E.cond["brown_hair_dye"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(4), label = ctx:expand_text(services.translate("Brown Dye")), description = ctx:expand_text(services.translate("Dye your hair brown.")), enabled = _en, hotkey = "4" }); _targets[tostring(4)] = "brown_hair_dye" end end
            do local _en = (E.cond["gray_hair_dye"] == nil or E.cond["gray_hair_dye"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(5), label = ctx:expand_text(services.translate("Gray Dye")), description = ctx:expand_text(services.translate("Dye your hair gray.")), enabled = _en, hotkey = "5" }); _targets[tostring(5)] = "gray_hair_dye" end end
            do local _en = (E.cond["green_hair_dye"] == nil or E.cond["green_hair_dye"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(6), label = ctx:expand_text(services.translate("Green Dye")), description = ctx:expand_text(services.translate("Dye your hair green.")), enabled = _en, hotkey = "6" }); _targets[tostring(6)] = "green_hair_dye" end end
            do local _en = (E.cond["red_hair_dye"] == nil or E.cond["red_hair_dye"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(7), label = ctx:expand_text(services.translate("Red Dye")), description = ctx:expand_text(services.translate("Dye your hair red.")), enabled = _en, hotkey = "7" }); _targets[tostring(7)] = "red_hair_dye" end end
            do local _en = (E.cond["pink_hair_dye"] == nil or E.cond["pink_hair_dye"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(8), label = ctx:expand_text(services.translate("Pink Dye")), description = ctx:expand_text(services.translate("Dye your hair pink.")), enabled = _en, hotkey = "8" }); _targets[tostring(8)] = "pink_hair_dye" end end
            do local _en = (E.cond["white_hair_dye"] == nil or E.cond["white_hair_dye"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(9), label = ctx:expand_text(services.translate("White Dye")), description = ctx:expand_text(services.translate("Dye your hair white.")), enabled = _en, hotkey = "9" }); _targets[tostring(9)] = "white_hair_dye" end end
            do local _en = (E.cond["EOC_NONE"] == nil or E.cond["EOC_NONE"](ctx) == true); if _en or (not false) then table.insert(_choices, { id = tostring(10), label = ctx:expand_text(services.translate("Nevermind")), description = ctx:expand_text(services.translate("Don't do anything.")), enabled = _en, hotkey = "0" }); _targets[tostring(10)] = "EOC_NONE" end end
            if #_choices > 0 then
                local _res = services.interaction.choose(_choices, { title = ctx:expand_text(services.translate("Select an option")), allow_cancel = false })
                if _res and _res.accepted and _res.id and _targets[_res.id] then
                    H.run_eoc(_targets[_res.id], ctx)
                end
            end
        end
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You don't have any hair to dye!")), "neutral")
        return false
    end
    end
    EOC["black_hair"] = function(ctx)
    do local _g = H.safe_id('mutation', "natural_hair_color_black"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
    return true
    end
    EOC["blond_hair"] = function(ctx)
    do local _g = H.safe_id('mutation', "natural_hair_color_blond"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
    return true
    end
    EOC["brown_hair"] = function(ctx)
    do local _g = H.safe_id('mutation', "natural_hair_color_brown"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
    return true
    end
    EOC["gray_hair"] = function(ctx)
    do local _g = H.safe_id('mutation', "natural_hair_color_gray"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
    return true
    end
    EOC["white_hair"] = function(ctx)
    do local _g = H.safe_id('mutation', "natural_hair_color_white"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
    return true
    end
    EOC["red_hair"] = function(ctx)
    do local _g = H.safe_id('mutation', "natural_hair_color_red"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
    return true
    end
    COND["assign_random_natural_hair_color"] = function(ctx)
        return ((not (H.char_has_any_trait(H.u(ctx), { "natural_hair_color_black", "natural_hair_color_blond", "natural_hair_color_brown", "natural_hair_color_gray", "natural_hair_color_red", "natural_hair_color_white" })))) == true
    end
    EOC["assign_random_natural_hair_color"] = function(ctx)
    if ((not (H.char_has_any_trait(H.u(ctx), { "natural_hair_color_black", "natural_hair_color_blond", "natural_hair_color_brown", "natural_hair_color_gray", "natural_hair_color_red", "natural_hair_color_white" })))) then
        do
            local _ids, _wts = {}, {}
            table.insert(_ids, "black_hair"); table.insert(_wts, math.max(0, 1))
            table.insert(_ids, "blond_hair"); table.insert(_wts, math.max(0, 1))
            table.insert(_ids, "brown_hair"); table.insert(_wts, math.max(0, 1))
            table.insert(_ids, "gray_hair"); table.insert(_wts, math.max(0, 1))
            table.insert(_ids, "white_hair"); table.insert(_wts, math.max(0, 1))
            table.insert(_ids, "red_hair"); table.insert(_wts, math.max(0, 1))
            local _wi = services.random.weighted_index(_wts)
            if _wi and _ids[_wi] then H.run_eoc(_ids[_wi], ctx) end
        end
        return true
    end
    return false
    end
    COND["black_hair_dye"] = function(ctx)
        return (H.char_has_item(H.u(ctx), "hair_dye_black")) == true
    end
    EOC["black_hair_dye"] = function(ctx)
    if (H.char_has_item(H.u(ctx), "hair_dye_black")) then
        services.messages.add(ctx:expand_text(services.translate("You finish dyeing your hair.")), "neutral")
        H.run_eoc("apply_hair_dye", ctx, { ["color_id"] = "black" }, nil, nil)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You don't have any black hair dye!")), "neutral")
        return false
    end
    end
    COND["blond_hair_dye"] = function(ctx)
        return (H.char_has_item(H.u(ctx), "hair_dye_blond")) == true
    end
    EOC["blond_hair_dye"] = function(ctx)
    if (H.char_has_item(H.u(ctx), "hair_dye_blond")) then
        services.messages.add(ctx:expand_text(services.translate("You finish dyeing your hair.")), "neutral")
        H.run_eoc("apply_hair_dye", ctx, { ["color_id"] = "blond" }, nil, nil)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You don't have any blond hair dye!")), "neutral")
        return false
    end
    end
    COND["blue_hair_dye"] = function(ctx)
        return (H.char_has_item(H.u(ctx), "hair_dye_blue")) == true
    end
    EOC["blue_hair_dye"] = function(ctx)
    if (H.char_has_item(H.u(ctx), "hair_dye_blue")) then
        services.messages.add(ctx:expand_text(services.translate("You finish dyeing your hair.")), "neutral")
        H.run_eoc("apply_hair_dye", ctx, { ["color_id"] = "blue" }, nil, nil)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You don't have any blue hair dye!")), "neutral")
        return false
    end
    end
    COND["brown_hair_dye"] = function(ctx)
        return (H.char_has_item(H.u(ctx), "hair_dye_brown")) == true
    end
    EOC["brown_hair_dye"] = function(ctx)
    if (H.char_has_item(H.u(ctx), "hair_dye_brown")) then
        services.messages.add(ctx:expand_text(services.translate("You finish dyeing your hair.")), "neutral")
        H.run_eoc("apply_hair_dye", ctx, { ["color_id"] = "brown" }, nil, nil)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You don't have any brown hair dye!")), "neutral")
        return false
    end
    end
    COND["gray_hair_dye"] = function(ctx)
        return (H.char_has_item(H.u(ctx), "hair_dye_gray")) == true
    end
    EOC["gray_hair_dye"] = function(ctx)
    if (H.char_has_item(H.u(ctx), "hair_dye_gray")) then
        services.messages.add(ctx:expand_text(services.translate("You finish dyeing your hair.")), "neutral")
        H.run_eoc("apply_hair_dye", ctx, { ["color_id"] = "gray" }, nil, nil)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You don't have any gray hair dye!")), "neutral")
        return false
    end
    end
    COND["green_hair_dye"] = function(ctx)
        return (H.char_has_item(H.u(ctx), "hair_dye_green")) == true
    end
    EOC["green_hair_dye"] = function(ctx)
    if (H.char_has_item(H.u(ctx), "hair_dye_green")) then
        services.messages.add(ctx:expand_text(services.translate("You finish dyeing your hair.")), "neutral")
        H.run_eoc("apply_hair_dye", ctx, { ["color_id"] = "green" }, nil, nil)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You don't have any green hair dye!")), "neutral")
        return false
    end
    end
    COND["red_hair_dye"] = function(ctx)
        return (H.char_has_item(H.u(ctx), "hair_dye_red")) == true
    end
    EOC["red_hair_dye"] = function(ctx)
    if (H.char_has_item(H.u(ctx), "hair_dye_red")) then
        services.messages.add(ctx:expand_text(services.translate("You finish dyeing your hair.")), "neutral")
        H.run_eoc("apply_hair_dye", ctx, { ["color_id"] = "red" }, nil, nil)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You don't have any red hair dye!")), "neutral")
        return false
    end
    end
    COND["pink_hair_dye"] = function(ctx)
        return (H.char_has_item(H.u(ctx), "hair_dye_pink")) == true
    end
    EOC["pink_hair_dye"] = function(ctx)
    if (H.char_has_item(H.u(ctx), "hair_dye_pink")) then
        services.messages.add(ctx:expand_text(services.translate("You finish dyeing your hair.")), "neutral")
        H.run_eoc("apply_hair_dye", ctx, { ["color_id"] = "pink" }, nil, nil)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You don't have any pink hair dye!")), "neutral")
        return false
    end
    end
    COND["white_hair_dye"] = function(ctx)
        return (H.char_has_item(H.u(ctx), "hair_dye_white")) == true
    end
    EOC["white_hair_dye"] = function(ctx)
    if (H.char_has_item(H.u(ctx), "hair_dye_white")) then
        services.messages.add(ctx:expand_text(services.translate("You finish dyeing your hair.")), "neutral")
        H.run_eoc("apply_hair_dye", ctx, { ["color_id"] = "white" }, nil, nil)
        return true
    else
        services.messages.add(ctx:expand_text(services.translate("You don't have any white hair dye!")), "neutral")
        return false
    end
    end
    EOC["EOC_START_BALTHAZAR_COUNTERS"] = function(ctx)
    H.set_var("global", nil, ctx, "balthazar_power", 10)
    H.set_var("global", nil, ctx, "balthazar_daily_power_gain", (services.random.native_int(0, H.round_half_away(2)) - 1))
    H.run_eoc("EOC_DAILY_BALTHAZAR_POWER", ctx, nil, nil, nil)
    return true
    end
    EOC["EOC_DAILY_BALTHAZAR_POWER"] = function(ctx)
    H.set_var("global", nil, ctx, "balthazar_power", (H.global_var_num("balthazar_power")) + (H.global_var_num("balthazar_daily_power_gain")))
    H.run_eoc("EOC_BALTHAZAR_CHECK_PROGRESS", ctx, nil, nil, nil)
    return true
    end
    COND["EOC_BALTHAZAR_CHECK_PROGRESS"] = function(ctx)
        return ((H.global_var_num("balthazar_destroyed") ~= 1)) == true
    end
    EOC["EOC_BALTHAZAR_CHECK_PROGRESS"] = function(ctx)
    if ((H.global_var_num("balthazar_destroyed") ~= 1)) then
        if (H.global_var_num("balthazar_power") <= 0) then
            H.run_eoc("EOC_BALTHAZAR_GONE", ctx, nil, nil, nil)
        end
        if ((H.global_var_num("balthazar_solar_power") ~= 1) and (H.global_var_num("balthazar_power") >= 50)) then
            H.run_eoc("EOC_BALTHAZAR_SET_UP_SOLAR", ctx, nil, nil, nil)
        end
        return true
    end
    return false
    end
    EOC["EOC_BALTHAZAR_SET_UP_SOLAR"] = function(ctx)
    do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "balthazar_bunker_02"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "balthazar_bunker_solar_panel_row_l" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
    do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "balthazar_bunker_03"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "balthazar_bunker_solar_panel_row_r" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
    H.set_var("global", nil, ctx, "balthazar_power", (H.global_var_num("balthazar_power")) + (20))
    H.set_var("global", nil, ctx, "balthazar_daily_power_gain", (H.global_var_num("balthazar_daily_power_gain")) + (1))
    H.set_var("global", nil, ctx, "balthazar_solar_power", 1)
    return true
    end
    EOC["EOC_BALTHAZAR_GONE"] = function(ctx)
    do local _p = (H.creature_snap(H.u(ctx)) or {}).position; if _p then local _omt = _p:project_to('omt'); local _om = "balthazar_bunker_01"; local _sp = nil; if _om and _om ~= '' then local opts = _sp and { special = H.safe_id('overmap_special', _sp) } or nil; _omt = services.overmap.find_target(_omt, _om, opts) end; if _omt then local _tr = services.overmap.tile_token(_omt); local _dl = nil; if _tr.ok and _tr.value then for _, _uid in ipairs({ "remove_balthazar_intercom" }) do local _ug = H.safe_id('update_mapgen', _uid); if _ug then local _ur = services.mapgen.update_token(_ug); if _ur.ok and _ur.value then if _dl then services.mapgen.schedule_update(_tr.value, _ur.value, services.time.duration_from_turns(math.max(1, math.floor(_dl)))) else services.mapgen.run_update(_tr.value, _ur.value) end end end end end end end end
    H.set_var("global", nil, ctx, "balthazar_power", 0)
    H.set_var("global", nil, ctx, "balthazar_destroyed", 1)
    H.set_var("global", nil, ctx, "balthazar_daily_power_gain", 0)
    return true
    end
    EOC["EOC_BALTHAZAR_SECUBOT_DEATH"] = function(ctx)
    H.set_var("global", nil, ctx, "balthazar_power", (H.global_var_num("balthazar_power")) - (5))
    H.run_eoc("EOC_BALTHAZAR_CHECK_PROGRESS", ctx, nil, nil, nil)
    return true
    end
    EOC["EOC_BALTHAZAR_TURRET_DEATH"] = function(ctx)
    H.set_var("global", nil, ctx, "balthazar_power", (H.global_var_num("balthazar_power")) - (2))
    H.run_eoc("EOC_BALTHAZAR_CHECK_PROGRESS", ctx, nil, nil, nil)
    return true
    end
    EOC["EOC_EXODII_HATES_YOU"] = function(ctx)
    do local g = H.safe_id("faction", "exodii"); if g then local r = services.factions.get(g); local cur = (r.ok and r.value and r.value.reputation and r.value.reputation.likes) or 0; local nxt = (-100); local val = ("=" == "=") and nxt or (("=" == "+=") and (cur + nxt) or (cur - nxt)); services.factions.set_reputation(g, { likes = math.floor(val + 0.5) }) end end
    do local g = H.safe_id("faction", "exodii"); if g then local r = services.factions.get(g); local cur = (r.ok and r.value and r.value.reputation and r.value.reputation.respects) or 0; local nxt = (-100); local val = ("=" == "=") and nxt or (("=" == "+=") and (cur + nxt) or (cur - nxt)); services.factions.set_reputation(g, { respects = math.floor(val + 0.5) }) end end
    do local g = H.safe_id("faction", "exodii"); if g then local r = services.factions.get(g); local cur = (r.ok and r.value and r.value.reputation and r.value.reputation.trusts) or 0; local nxt = (-100); local val = ("=" == "=") and nxt or (("=" == "+=") and (cur + nxt) or (cur - nxt)); services.factions.set_reputation(g, { trusts = math.floor(val + 0.5) }) end end
    do local _g = H.safe_id('mutation', "EXODII_WRATH"); if H.u(ctx) and _g then services.mutations.grant(H.u(ctx), _g) end end
    return true
    end
    EOC["EOC_EXODII_MERCHANT_Exodize_Cyberframe_done"] = function(ctx)
    if H.u(ctx) then services.characters.open_topic(H.u(ctx), "TALK_EXODII_MERCHANT_Exodize_Cyberframe_done") end
    return true
    end
    COND["EOC_BANDIT_ASSASSIN"] = function(ctx)
        return (((((function() local g = H.safe_id('faction', "hells_raiders"); local r = g and services.factions.get(g); return (r and r.ok and r.value and r.value.reputation and r.value.reputation.likes) or 0 end)()) < (-40)) and (((function() local g = H.safe_id('faction', "hells_raiders"); local r = g and services.factions.get(g); return (r and r.ok and r.value and r.value.reputation and r.value.reputation.likes) or 0 end)()) > (-60)) and (H.var_num(H.u(ctx), "bandit_assassins_sent") <= 10) and ((services.time.calendar().now.turns_since_cataclysm / 86400) >= 9) and (not (((services.weather.current().weather and services.weather.current().weather.value) == "portal_storm"))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "godco_enter", math.floor(8)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "evac_center_18", math.floor(4)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "pagan_cult_enter", math.floor(4)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "lumbermill_0_0_ocu", math.floor(4)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "smallscrapyard_ocu", math.floor(4)) end)()))))) == true
    end
    EOC["EOC_BANDIT_ASSASSIN"] = function(ctx)
    if (((((function() local g = H.safe_id('faction', "hells_raiders"); local r = g and services.factions.get(g); return (r and r.ok and r.value and r.value.reputation and r.value.reputation.likes) or 0 end)()) < (-40)) and (((function() local g = H.safe_id('faction', "hells_raiders"); local r = g and services.factions.get(g); return (r and r.ok and r.value and r.value.reputation and r.value.reputation.likes) or 0 end)()) > (-60)) and (H.var_num(H.u(ctx), "bandit_assassins_sent") <= 10) and ((services.time.calendar().now.turns_since_cataclysm / 86400) >= 9) and (not (((services.weather.current().weather and services.weather.current().weather.value) == "portal_storm"))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "godco_enter", math.floor(8)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "evac_center_18", math.floor(4)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "pagan_cult_enter", math.floor(4)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "lumbermill_0_0_ocu", math.floor(4)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "smallscrapyard_ocu", math.floor(4)) end)()))))) then
        H.spawn_npc(H.u(ctx), "hells_raiders_assassin", { min_radius = math.floor(15), max_radius = math.floor(25) }, nil)
        H.set_var("actor", H.u(ctx), ctx, "bandit_assassins_sent", (H.var_num(H.u(ctx), "bandit_assassins_sent")) + (1))
        return true
    end
    return false
    end
    COND["EOC_BANDIT_ASSASSIN_2"] = function(ctx)
        return (((((function() local g = H.safe_id('faction', "hells_raiders"); local r = g and services.factions.get(g); return (r and r.ok and r.value and r.value.reputation and r.value.reputation.likes) or 0 end)()) < (-60)) and (((function() local g = H.safe_id('faction', "hells_raiders"); local r = g and services.factions.get(g); return (r and r.ok and r.value and r.value.reputation and r.value.reputation.likes) or 0 end)()) > (-90)) and (H.var_num(H.u(ctx), "bandit_assassins_sent") <= 10) and ((services.time.calendar().now.turns_since_cataclysm / 86400) >= 15) and (not (((services.weather.current().weather and services.weather.current().weather.value) == "portal_storm"))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "godco_enter", math.floor(8)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "evac_center_18", math.floor(4)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "pagan_cult_enter", math.floor(4)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "lumbermill_0_0_ocu", math.floor(4)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "smallscrapyard_ocu", math.floor(4)) end)()))))) == true
    end
    EOC["EOC_BANDIT_ASSASSIN_2"] = function(ctx)
    if (((((function() local g = H.safe_id('faction', "hells_raiders"); local r = g and services.factions.get(g); return (r and r.ok and r.value and r.value.reputation and r.value.reputation.likes) or 0 end)()) < (-60)) and (((function() local g = H.safe_id('faction', "hells_raiders"); local r = g and services.factions.get(g); return (r and r.ok and r.value and r.value.reputation and r.value.reputation.likes) or 0 end)()) > (-90)) and (H.var_num(H.u(ctx), "bandit_assassins_sent") <= 10) and ((services.time.calendar().now.turns_since_cataclysm / 86400) >= 15) and (not (((services.weather.current().weather and services.weather.current().weather.value) == "portal_storm"))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "godco_enter", math.floor(8)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "evac_center_18", math.floor(4)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "pagan_cult_enter", math.floor(4)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "lumbermill_0_0_ocu", math.floor(4)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "smallscrapyard_ocu", math.floor(4)) end)()))))) then
        H.spawn_npc(H.u(ctx), "hells_raiders_assassin", { min_radius = math.floor(15), max_radius = math.floor(25) }, nil)
        H.spawn_npc(H.u(ctx), "hells_raiders_assassin", { min_radius = math.floor(15), max_radius = math.floor(25) }, nil)
        H.set_var("actor", H.u(ctx), ctx, "bandit_assassins_sent", (H.var_num(H.u(ctx), "bandit_assassins_sent")) + (2))
        return true
    end
    return false
    end
    COND["EOC_BANDIT_ASSASSIN_3"] = function(ctx)
        return (((((function() local g = H.safe_id('faction', "hells_raiders"); local r = g and services.factions.get(g); return (r and r.ok and r.value and r.value.reputation and r.value.reputation.likes) or 0 end)()) < (-90)) and (H.var_num(H.u(ctx), "bandit_assassins_sent") <= 10) and ((services.time.calendar().now.turns_since_cataclysm / 86400) >= 21) and (not (((services.weather.current().weather and services.weather.current().weather.value) == "portal_storm"))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "godco_enter", math.floor(8)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "evac_center_18", math.floor(4)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "pagan_cult_enter", math.floor(4)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "lumbermill_0_0_ocu", math.floor(4)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "smallscrapyard_ocu", math.floor(4)) end)()))))) == true
    end
    EOC["EOC_BANDIT_ASSASSIN_3"] = function(ctx)
    if (((((function() local g = H.safe_id('faction', "hells_raiders"); local r = g and services.factions.get(g); return (r and r.ok and r.value and r.value.reputation and r.value.reputation.likes) or 0 end)()) < (-90)) and (H.var_num(H.u(ctx), "bandit_assassins_sent") <= 10) and ((services.time.calendar().now.turns_since_cataclysm / 86400) >= 21) and (not (((services.weather.current().weather and services.weather.current().weather.value) == "portal_storm"))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "godco_enter", math.floor(8)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "evac_center_18", math.floor(4)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "pagan_cult_enter", math.floor(4)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "lumbermill_0_0_ocu", math.floor(4)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "smallscrapyard_ocu", math.floor(4)) end)()))))) then
        H.spawn_npc(H.u(ctx), "hells_raiders_assassin", { min_radius = math.floor(15), max_radius = math.floor(25) }, nil)
        H.spawn_npc(H.u(ctx), "hells_raiders_assassin", { min_radius = math.floor(15), max_radius = math.floor(25) }, nil)
        H.spawn_npc(H.u(ctx), "hells_raiders_assassin", { min_radius = math.floor(15), max_radius = math.floor(25) }, nil)
        H.set_var("actor", H.u(ctx), ctx, "bandit_assassins_sent", (H.var_num(H.u(ctx), "bandit_assassins_sent")) + (3))
        return true
    end
    return false
    end
    COND["EOC_OLD_GUARD_ASSASSIN"] = function(ctx)
        return (((((function() local g = H.safe_id('faction', "old_guard"); local r = g and services.factions.get(g); return (r and r.ok and r.value and r.value.reputation and r.value.reputation.likes) or 0 end)()) < (-45)) and (H.var_num(H.u(ctx), "government_assassins_sent") <= 6) and ((services.time.calendar().now.turns_since_cataclysm / 86400) >= 9) and (not (((services.weather.current().weather and services.weather.current().weather.value) == "portal_storm"))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "godco_enter", math.floor(8)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "evac_center_18", math.floor(4)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "pagan_cult_enter", math.floor(4)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "lumbermill_0_0_ocu", math.floor(4)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "smallscrapyard_ocu", math.floor(4)) end)()))))) == true
    end
    EOC["EOC_OLD_GUARD_ASSASSIN"] = function(ctx)
    if (((((function() local g = H.safe_id('faction', "old_guard"); local r = g and services.factions.get(g); return (r and r.ok and r.value and r.value.reputation and r.value.reputation.likes) or 0 end)()) < (-45)) and (H.var_num(H.u(ctx), "government_assassins_sent") <= 6) and ((services.time.calendar().now.turns_since_cataclysm / 86400) >= 9) and (not (((services.weather.current().weather and services.weather.current().weather.value) == "portal_storm"))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "godco_enter", math.floor(8)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "evac_center_18", math.floor(4)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "pagan_cult_enter", math.floor(4)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "lumbermill_0_0_ocu", math.floor(4)) end)()))) and (not (((function() local s = H.char_snap(H.u(ctx)); if not s or not s.creature then return false end; return services.overmap.matches_location_near(s.creature.position:project_to('omt'), "smallscrapyard_ocu", math.floor(4)) end)()))))) then
        H.spawn_npc(H.u(ctx), "old_guard_assassin", { min_radius = math.floor(15), max_radius = math.floor(25) }, nil)
        H.spawn_npc(H.u(ctx), "old_guard_assassin", { min_radius = math.floor(15), max_radius = math.floor(25) }, nil)
        H.set_var("actor", H.u(ctx), ctx, "government_assassins_sent", (H.var_num(H.u(ctx), "government_assassins_sent")) + (2))
        return true
    end
    return false
    end
    COND["EOC_REFUGEE_CENTER_NPC_MOVEMENT"] = function(ctx)
        return ((services.gameplay.environment.dimension() == "default")) == true
    end
    EOC["EOC_REFUGEE_CENTER_NPC_MOVEMENT"] = function(ctx)
    if ((services.gameplay.environment.dimension() == "default")) then
        do
            local _sw24 = ((services.turn() % 86400) / 3600)
            if _sw24 == 0 then
                H.run_eoc("EOC_REFUGEE_CENTER_GUARD_FIRST_POSITION", ctx, nil, nil, nil)
            elseif _sw24 == 2 then
                H.run_eoc("EOC_REFUGEE_CENTER_GUARD_SECOND_POSITION", ctx, nil, nil, nil)
            elseif _sw24 == 4 then
                H.run_eoc("EOC_REFUGEE_CENTER_GUARD_FIRST_POSITION", ctx, nil, nil, nil)
            elseif _sw24 == 6 then
                H.run_eoc("EOC_REFUGEE_CENTER_GUARD_SECOND_POSITION", ctx, nil, nil, nil)
            elseif _sw24 == 8 then
                H.run_eoc("EOC_REFUGEE_CENTER_GUARD_FIRST_POSITION", ctx, nil, nil, nil)
            elseif _sw24 == 10 then
                H.run_eoc("EOC_REFUGEE_CENTER_GUARD_SECOND_POSITION", ctx, nil, nil, nil)
            elseif _sw24 == 12 then
                H.run_eoc("EOC_REFUGEE_CENTER_GUARD_FIRST_POSITION", ctx, nil, nil, nil)
            elseif _sw24 == 14 then
                H.run_eoc("EOC_REFUGEE_CENTER_GUARD_SECOND_POSITION", ctx, nil, nil, nil)
            elseif _sw24 == 16 then
                H.run_eoc("EOC_REFUGEE_CENTER_GUARD_FIRST_POSITION", ctx, nil, nil, nil)
            elseif _sw24 == 18 then
                H.run_eoc("EOC_REFUGEE_CENTER_GUARD_SECOND_POSITION", ctx, nil, nil, nil)
            elseif _sw24 == 20 then
                H.run_eoc("EOC_REFUGEE_CENTER_GUARD_FIRST_POSITION", ctx, nil, nil, nil)
            elseif _sw24 == 22 then
                H.run_eoc("EOC_REFUGEE_CENTER_GUARD_SECOND_POSITION", ctx, nil, nil, nil)
            end
        end
        return true
    end
    return false
    end
    EOC["EOC_REFUGEE_CENTER_GUARD_FIRST_SHIFT"] = function(ctx)
    do local _a = H.u(ctx); local _ns = H.npc_snap(_a); if _a and _ns and _ns.unique_id then local _p = H.get_tripoint_var("global", _a, ctx, (_ns.unique_id .. "_First")); if _p then services.npcs.set_guard_position(_a, _p) end end end
    return true
    end
    EOC["EOC_REFUGEE_CENTER_GUARD_FIRST_POSITION"] = function(ctx)
    do for _, _uid in ipairs({ "GUARD1", "GUARD2", "GUARD3", "GUARD4", "GUARD5", "GUARD6", "GUARD7" }) do local r = services.npcs.find_unique(_uid); if r.ok and r.value then for _, _eid in ipairs({ "EOC_REFUGEE_CENTER_GUARD_FIRST_SHIFT" }) do H.run_eoc(_eid, ctx, nil, r.value, ctx.u) end end end end
    return true
    end
    EOC["EOC_REFUGEE_CENTER_GUARD_SECOND_SHIFT"] = function(ctx)
    do local _a = H.u(ctx); local _ns = H.npc_snap(_a); if _a and _ns and _ns.unique_id then local _p = H.get_tripoint_var("global", _a, ctx, (_ns.unique_id .. "_Second")); if _p then services.npcs.set_guard_position(_a, _p) end end end
    return true
    end
    EOC["EOC_REFUGEE_CENTER_GUARD_SECOND_POSITION"] = function(ctx)
    do for _, _uid in ipairs({ "GUARD1", "GUARD2", "GUARD3", "GUARD4", "GUARD5", "GUARD6", "GUARD7" }) do local r = services.npcs.find_unique(_uid); if r.ok and r.value then for _, _eid in ipairs({ "EOC_REFUGEE_CENTER_GUARD_SECOND_SHIFT" }) do H.run_eoc(_eid, ctx, nil, r.value, ctx.u) end end end end
    return true
    end
end
