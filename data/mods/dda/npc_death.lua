local ccb = require("ccb")
local state = require("portal_storm_state")

ccb.runtime.handler("record_hub_pat_death", function()
    state.set("robofac_pat_is_dead", 1)
end)

ccb.runtime.handler("prevent_debug_npc_death", function(context)
    context.prevent_death()
end)
