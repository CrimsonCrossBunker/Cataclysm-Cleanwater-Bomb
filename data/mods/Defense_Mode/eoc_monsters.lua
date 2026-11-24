local ccb = require("ccb")
local services = ccb.services
local E = require("eoc_runtime")
local H = E.H

ccb.runtime.handler("w16b_mon_when_defense_mode_8d44ce7161f9", function(payload)
    local ctx = E.H.ctx_new(payload and payload.attacker or nil, payload and payload.target or nil, {})
    return (((not (((function() local eg = H.safe_id('effect', "Shadow_Reveal"); local bpg = (nil ~= nil) and H.safe_id('body_part', nil) or nil; if not H.npc(ctx) or not eg then return false end; return services.effects.has(H.npc(ctx), eg, bpg, nil).value == true end)()))) and (((H.char_snap(H.npc(ctx)) or {}).male == true) or ((H.char_snap(H.npc(ctx)) or {}).male == false)))) == true
end)
