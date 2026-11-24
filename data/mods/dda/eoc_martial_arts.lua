local ccb = require("ccb")
local services = ccb.services
local E = require("eoc_runtime")
local H = E.H

local EOC = E.run
local COND = E.cond
EOC["EOC_MA_DEBUG_GETHIT"] = function(ctx)
    services.messages.add(ctx:expand_text(services.translate("The wound triggers your rare disease, Bleedalotitis - fortunately you have a lot of blood.")), "mixed")
    do local _p, _g = (H.creature_snap(H.u(ctx)) or {}).position, H.safe_id('field', "fd_blood"); if _p and _g then services.gameplay.environment.add_field_area(_p, _g, { radius = math.floor(10), intensity = math.floor(1) }) end end
    return true
end
ccb.runtime.handler("eoc:" .. "EOC_MA_DEBUG_GETHIT", function(payload)
    local p = type(payload) == "table" and payload or nil
    local u = p and (p.u or p.creature or p.character or p.avatar_id) or (not p and payload) or services.characters.avatar()
    local npc = p and p.npc or nil
    local vars = (p and p.vars) or {}
    EOC["EOC_MA_DEBUG_GETHIT"](H.ctx_new(u, npc, vars))
end)

ccb.runtime.handler("w16b_ma_kill_dda_aed99c898b9c", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, nil, {})
    E.H.run_eoc("EOC_BIOLUM3_activated", ctx)
end)
ccb.runtime.handler("w16b_ma_gethit_dda_09fdc7e52b5c", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, nil, {})
    E.H.run_eoc("EOC_MA_DEBUG_GETHIT", ctx)
end)
