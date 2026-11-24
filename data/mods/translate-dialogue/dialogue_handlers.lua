local ccb = require("ccb")
local services = ccb.services
local H = require("ccb_runtime_helpers").create()

ccb.runtime.handler("dlg_p_translate_dialogue_4a7841f056c7", function(ctx)
    return ((services.time.calendar().now.turns_since_cataclysm / 86400) >= 28)
end)

ccb.runtime.handler("dlg_p_translate_dialogue_be44d4d6304e", function(ctx)
    return (H.global_var_num("talked_to_hub") == 1)
end)

ccb.runtime.handler("dlg_p_translate_dialogue_0c73fc5311f1", function(ctx)
    return (H.global_var_num("exodii_knows_hub01") == 1)
end)

ccb.runtime.handler("dlg_p_translate_dialogue_3b4f437cadf3", function(ctx)
    return (H.npc_opinion(H.npc(ctx), "sold") >= 100)
end)

ccb.runtime.handler("dlg_p_translate_dialogue_eecffe980cd4", function(ctx)
    return (H.npc_faction_trust(H.npc(ctx)) >= (5))
end)
