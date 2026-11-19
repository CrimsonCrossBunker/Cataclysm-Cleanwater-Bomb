local ccb = require("ccb")
local services = ccb.services

ccb.runtime.handler("examine_f_biokinetic_physiology_improver", function(ctx)
    local actor = ctx.character
    services.interaction.open_topic(actor, "TALK_MOM_SHADOW_URGE_MACHINE")
end)
