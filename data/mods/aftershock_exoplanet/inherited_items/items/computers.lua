local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "afs_data_shard",
        copy_from = "memory_card",
        looks_like = "memory_card",
        name = ccb.content.plural_text("memory shard", "memory shards"),
        description = ccb.content.text("A tiny rectangle made of memory glass.  Compatible with most computer systems, modern or otherwise."),
        price_cents = 0,
        price_postapoc_cents = 0,
        replace_pockets = true,
    }
    item:tool()
    item:file_storage_pocket {
        max_volume_ml = 1,
        max_weight_milligrams = 1000,
        rigid = true,
        weight_multiplier = 0.0,
        memory_kb = 16000000,
    }
    content.add(item)
end
