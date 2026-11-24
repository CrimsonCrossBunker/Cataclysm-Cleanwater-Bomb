local ccb = require("ccb")
local services = ccb.services
local E = require("eoc_runtime")
local H = E.H

ccb.runtime.handler("w16b_iuse_mindovermatter_249c39767f35", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, payload and payload.item or nil, {})
    E.H.run_eoc("EOC_FORCE_FIELD_GENERATOR_ACTIVATION", ctx)
    return 0
end)
ccb.runtime.handler("w16b_iuse_mindovermatter_689591a5ef59", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, payload and payload.item or nil, {})
    E.H.run_eoc("EOC_NETHER_EFFECT_APPLY_TELEPORT_MISJUMP", ctx)
    return 1
end)
ccb.runtime.handler("w16b_iuse_mindovermatter_e8ad1e783e14", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, payload and payload.item or nil, {})
    E.H.run_eoc("EOC_MOM_ABJURATION_STONE_EFFECTS", ctx)
    return 1
end)
ccb.runtime.handler("w16b_iuse_mindovermatter_6ec411df2494", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, payload and payload.item or nil, {})
    E.H.run_eoc("EOC_MOM_CASCADE_STONE_EFFECTS", ctx)
    return 1
end)
ccb.runtime.handler("w16b_iuse_mindovermatter_f05b237859cf", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, payload and payload.item or nil, {})
    E.H.run_eoc("EOC_PSI_TRANSPORTER_REMOTE_TELEPORT", ctx)
    return 0
end)

do
    local item = ccb.content.Item { id = "force_field_generator", copy_from = "force_field_generator" }
    item:on_use("w16b_iuse_mindovermatter_249c39767f35", "Activate", "Insert a black matrix crystal and flip the toggle.")
    ccb.content.replace(item)
end
do
    local item = ccb.content.Item { id = "translation_stone", copy_from = "translation_stone" }
    item:on_use("w16b_iuse_mindovermatter_689591a5ef59", "Activate", "Seems like movement in solid form.")
    ccb.content.replace(item)
end
do
    local item = ccb.content.Item { id = "abjuration_stone", copy_from = "abjuration_stone" }
    item:on_use("w16b_iuse_mindovermatter_e8ad1e783e14", "Activate", "Seems like a localized disruption.")
    ccb.content.replace(item)
end
do
    local item = ccb.content.Item { id = "cascade_stone", copy_from = "cascade_stone" }
    item:on_use("w16b_iuse_mindovermatter_6ec411df2494", "Activate", "Seems like compressed power.")
    ccb.content.replace(item)
end
do
    local item = ccb.content.Item { id = "psionic_transporter_remote_on", copy_from = "psionic_transporter_remote_on" }
    item:on_use("w16b_iuse_mindovermatter_f05b237859cf", "Activate the remote", "Begin the transportation process.  It will take several minutes for the remote to zero in on the beacon location.")
    ccb.content.replace(item)
end
