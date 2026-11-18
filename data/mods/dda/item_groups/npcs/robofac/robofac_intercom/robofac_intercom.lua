local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_ROBOFAC_INTERCOM_trade", kind = "collection" }
    group:entry { group = "robofac_basic_trade", count = { 15, 25 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ROBOFAC_INTERCOM_trade_hm12", kind = "collection" }
    group:entry { item = "hm12", count = { 1, 1 }, probability = 50 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ROBOFAC_INTERCOM_trade_armor", kind = "collection" }
    group:entry { group = "robofac_armor_pieces", count = { 4, 8 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ROBOFAC_INTERCOM_trade_military", kind = "collection" }
    group:entry { group = "robofac_armor_pieces_military", count = { 0, 2 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ROBOFAC_INTERCOM_trade_envirosuit", kind = "collection" }
    group:entry { item = "robofac_enviro_suit", count = { 1, 1 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ROBOFAC_INTERCOM_XM_EXOSKELETONS", kind = "collection" }
    group:entry { item = "integrated_bio_robofac_xmleg", count = { 1, 2 }, probability = 70 }
    group:entry { item = "integrated_bio_robofac_xmarm", count = { 1, 2 }, probability = 70 }
    group:entry { item = "integrated_bio_robofac_xmback", count = { 1, 2 }, probability = 70 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ROBOFAC_INTERCOM_LENS", kind = "collection" }
    group:entry { item = "robofac_lens_helmet", count = { 1, 2 } }
    group:entry { item = "robofac_lens_mask_bal", count = { 1, 2 }, probability = 70 }
    group:entry { item = "robofac_lens_mask_filter", count = { 1, 2 }, probability = 70 }
    group:entry { item = "robofac_lens_mask_gas", count = { 1, 2 }, probability = 70 }
    group:entry { item = "robofac_lens_mask_papr", count = { 1, 2 }, probability = 70 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ROBOFAC_INTERCOM_MVAS", kind = "collection" }
    group:entry { item = "robofac_head_rig_ar", count = { 1, 1 } }
    content.add(group)
end
