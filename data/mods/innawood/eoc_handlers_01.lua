local ccb = require("ccb")
local services = ccb.services
return function(E, H)
    local EOC = E.run
    local COND = E.cond
    COND["EOC_LIEUTENANT_ACTIVATE_SHADOW"] = function(ctx)
        return ((((services.time.calendar().now.turns_since_cataclysm / 86400) >= 270) and (H.global_var_num("Lieutenants_active") < 1))) == true
    end
    EOC["EOC_LIEUTENANT_ACTIVATE_SHADOW"] = function(ctx)
    if ((((services.time.calendar().now.turns_since_cataclysm / 86400) >= 270) and (H.global_var_num("Lieutenants_active") < 1))) then
        H.set_var("global", nil, ctx, "Lieutenants_active", 1)
        H.set_var("global", nil, ctx, "Shadow_Lurking", 1)
        return true
    end
    return false
    end
    COND["EOC_LIEUTENANT_SHADOW_WARN"] = function(ctx)
        return (((not ((not services.gameplay.environment.is_night()))) and (not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and ((H.global_var_num("Shadow_Lurking") > 0) or (not (((services.time.calendar().now.turns_since_cataclysm / 86400) >= 270)))) and ((H.global_var_num("Shadow_Lurking") > 0) or ((services.time.calendar().now.turns_since_cataclysm / 86400) >= 263)) and ((H.global_var_num("Shadow_Warnings") < 1) or ((services.time.calendar().now.turns_since_cataclysm / 86400) >= 270)) and (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and (H.char_at_om_location(H.u(ctx), "field") or H.char_at_om_location(H.u(ctx), "forest") or H.char_at_om_location(H.u(ctx), "forest_thick")))) == true
    end
    EOC["EOC_LIEUTENANT_SHADOW_WARN"] = function(ctx)
    if (((not ((not services.gameplay.environment.is_night()))) and (not (((function() local eg = H.safe_id('effect', "sleep"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.u(ctx) or not eg then return false end; return services.effects.has(H.u(ctx), eg, bpg, nil).value == true end)()))) and ((H.global_var_num("Shadow_Lurking") > 0) or (not (((services.time.calendar().now.turns_since_cataclysm / 86400) >= 270)))) and ((H.global_var_num("Shadow_Lurking") > 0) or ((services.time.calendar().now.turns_since_cataclysm / 86400) >= 263)) and ((H.global_var_num("Shadow_Warnings") < 1) or ((services.time.calendar().now.turns_since_cataclysm / 86400) >= 270)) and (((H.char_snap(H.u(ctx)) or {}).creature or {}).outside == true) and (H.char_at_om_location(H.u(ctx), "field") or H.char_at_om_location(H.u(ctx), "forest") or H.char_at_om_location(H.u(ctx), "forest_thick")))) then
        H.set_var("global", nil, ctx, "Shadow_Warnings", (H.global_var_num("Shadow_Warnings")) + (1))
        if ((services.time.calendar().now.turns_since_cataclysm / 86400) >= 270) then
            if (H.global_var_num("Shadow_Warnings") < 2) then
                ccb.presentation.notice((services.snippets.native_random("Shadow_Warnings_Snippets_late") or ''))
            else
                services.messages.add((services.snippets.native_random("Shadow_Warnings_Snippets_late") or ''), "neutral")
            end
        else
            if (H.global_var_num("Shadow_Warnings") < 2) then
                ccb.presentation.notice((services.snippets.native_random("Shadow_Warnings_Snippets_early") or ''))
            else
                services.messages.add((services.snippets.native_random("Shadow_Warnings_Snippets_early") or ''), "neutral")
            end
        end
        return true
    end
    return false
    end
    EOC["EOC_BALTHAZAR_CHECK_PROGRESS"] = function(ctx)
    return true
    end
end
