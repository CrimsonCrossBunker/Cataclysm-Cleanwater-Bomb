local content = require("ccb").content

do
    local group = content.ItemGroup { id = "modular_ar15", kind = "collection" }
    group:entry {
        item = "modular_ar15",
        contents = {
            { item = "retool_ar15_223rem" },
        },
    }
    content.upsert_item_group(group)
end

do
    local group = content.ItemGroup { id = "ar15_223long", kind = "collection" }
    group:entry {
        item = "modular_ar15",
        contents = {
            { item = "retool_ar15_223rem_extended" },
        },
    }
    content.upsert_item_group(group)
end

do
    local group = content.ItemGroup { id = "ar15_223medium", kind = "collection" }
    group:entry {
        item = "modular_ar15",
        contents = {
            { item = "retool_ar15_223rem_medium" },
        },
    }
    content.upsert_item_group(group)
end

do
    local group = content.ItemGroup { id = "ar15_223short", kind = "collection" }
    group:entry {
        item = "modular_ar15",
        contents = {
            { item = "retool_ar15_223rem_short" },
        },
    }
    content.upsert_item_group(group)
end

do
    local group = content.ItemGroup { id = "ar15_300", kind = "collection" }
    group:entry {
        item = "modular_ar15",
        contents = {
            { item = "retool_ar15_300blk" },
        },
    }
    content.upsert_item_group(group)
end

do
    local group = content.ItemGroup { id = "ar15_300medium", kind = "collection" }
    group:entry {
        item = "modular_ar15",
        contents = {
            { item = "retool_ar15_300blk_medium" },
        },
    }
    content.upsert_item_group(group)
end

do
    local group = content.ItemGroup { id = "ar15_300short", kind = "collection" }
    group:entry {
        item = "modular_ar15",
        contents = {
            { item = "retool_ar15_300blk_short" },
        },
    }
    content.upsert_item_group(group)
end

do
    local group = content.ItemGroup { id = "ar15_50", kind = "collection" }
    group:entry {
        item = "modular_ar15",
        contents = {
            { item = "retool_ar15_50beowulf" },
        },
    }
    content.upsert_item_group(group)
end

do
    local group = content.ItemGroup { id = "ar15_50medium", kind = "collection" }
    group:entry {
        item = "modular_ar15",
        contents = {
            { item = "retool_ar15_50beowulf_medium" },
        },
    }
    content.upsert_item_group(group)
end

do
    local group = content.ItemGroup { id = "ar15_50short", kind = "collection" }
    group:entry {
        item = "modular_ar_pistol",
        contents = {
            { item = "retool_ar15_50beowulf_short" },
        },
    }
    content.upsert_item_group(group)
end

do
    local group = content.ItemGroup { id = "ar15_450", kind = "collection" }
    group:entry {
        item = "modular_ar15",
        contents = {
            { item = "retool_ar15_450" },
        },
    }
    content.upsert_item_group(group)
end

do
    local group = content.ItemGroup { id = "ar15_450medium", kind = "collection" }
    group:entry {
        item = "modular_ar15",
        contents = {
            { item = "retool_ar15_450_medium" },
        },
    }
    content.upsert_item_group(group)
end

do
    local group = content.ItemGroup { id = "ar15_450short", kind = "collection" }
    group:entry {
        item = "modular_ar_pistol",
        contents = {
            { item = "retool_ar15_450_short" },
        },
    }
    content.upsert_item_group(group)
end

do
    local group = content.ItemGroup { id = "ar15_762", kind = "collection" }
    group:entry {
        item = "modular_ar15",
        contents = {
            { item = "retool_ar15_762" },
        },
    }
    content.upsert_item_group(group)
end

do
    local group = content.ItemGroup { id = "mdrx_223", kind = "collection" }
    group:entry {
        item = "mdrx",
        contents = {
            { item = "retool_mdrx_223rem" },
        },
    }
    content.upsert_item_group(group)
end

do
    local group = content.ItemGroup { id = "mdrx_223short", kind = "collection" }
    group:entry {
        item = "mdrx",
        contents = {
            { item = "retool_mdrx_223rem_short" },
        },
    }
    content.upsert_item_group(group)
end

do
    local group = content.ItemGroup { id = "mdrx", kind = "collection" }
    group:entry {
        item = "mdrx",
        contents = {
            { item = "retool_mdrx_223rem_medium" },
        },
    }
    content.upsert_item_group(group)
end

do
    local group = content.ItemGroup { id = "mdrx_300", kind = "collection" }
    group:entry {
        item = "mdrx",
        contents = {
            { item = "retool_mdrx_300blk" },
        },
    }
    content.upsert_item_group(group)
end

do
    local group = content.ItemGroup { id = "mdrx_308", kind = "collection" }
    group:entry {
        item = "mdrx",
        contents = {
            { item = "retool_mdrx_308win" },
        },
    }
    content.upsert_item_group(group)
end

do
    local group = content.ItemGroup { id = "mdrx_308medium", kind = "collection" }
    group:entry {
        item = "mdrx",
        contents = {
            { item = "retool_mdrx_308win_medium" },
        },
    }
    content.upsert_item_group(group)
end

do
    local group = content.ItemGroup { id = "axmc", kind = "collection" }
    group:entry {
        item = "axmc",
        contents = {
            { item = "retool_axmc_338lapua" },
        },
    }
    content.upsert_item_group(group)
end

do
    local group = content.ItemGroup { id = "modular_deagle_357", kind = "collection" }
    group:entry {
        item = "modular_deagle",
        contents = {
            { item = "retool_deagle_357" },
        },
    }
    content.upsert_item_group(group)
end

do
    local group = content.ItemGroup { id = "modular_deagle_44", kind = "collection" }
    group:entry {
        item = "modular_deagle",
        contents = {
            { item = "retool_deagle_44" },
        },
    }
    content.upsert_item_group(group)
end

do
    local group = content.ItemGroup { id = "modular_deagle_50", kind = "collection" }
    group:entry {
        item = "modular_deagle",
        contents = {
            { item = "retool_deagle_50" },
        },
    }
    content.upsert_item_group(group)
end

do
    local group = content.ItemGroup { id = "modular_ump_9", kind = "collection" }
    group:entry {
        item = "modular_ump",
        contents = {
            { item = "retool_ump_9" },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "modular_ump_40", kind = "collection" }
    group:entry {
        item = "modular_ump",
        contents = {
            { item = "retool_ump_40" },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "modular_ump_45", kind = "collection" }
    group:entry {
        item = "modular_ump",
        contents = {
            { item = "retool_ump_45" },
        },
    }
    content.add(group)
end
