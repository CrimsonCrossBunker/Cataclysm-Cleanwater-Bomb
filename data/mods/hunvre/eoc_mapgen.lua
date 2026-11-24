local ccb = require("ccb")
local services = ccb.services
local E = require("eoc_runtime")
local H = E.H

ccb.runtime.handler("w16b_comp_elevator_controls", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, nil, {})
    E.H.set_var("global", nil, ctx, "elevator_present", 0)
    local snap = E.H.char_snap(E.H.u(ctx))
    local _o = snap and snap.creature and snap.creature.position or nil
    if _o then
        local _pg = services.world.points_nearby(_o, { max_radius = 10 })
        for _, _pt in ipairs((_pg and _pg.items) or {}) do
            local _p = _pt.position
            E.H.set_var("context", nil, ctx, "elevator_controls_start", _p)
            local p = E.H.get_tripoint_var("context", nil, ctx, "elevator_controls_start")
            if p then
                local t = services.gameplay.environment.terrain_id(p)
                if t and t.value == "t_central_elevator" then
                    E.H.run_eoc("EOC_elevator_state_check", ctx)
                    break
                end
            end
        end
    end
    return true
end)
