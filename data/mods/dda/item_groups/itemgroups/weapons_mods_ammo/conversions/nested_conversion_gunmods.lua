local content = require("ccb").content

do
    -- Miscellaneous items assigned to spawn within conversion kits, including some tools and the instructions.
    local group = content.ItemGroup { id = "nested_retool_extras", kind = "collection" }
    group:item("retool_instructions")
    group:item("bubblewrap")
    content.add(group)
end

do
    -- a conversion kit packed along with an appropriate empty magazine and miscellaneous items.
    local group = content.ItemGroup {
        id = "boxed_223rem_ar15kit_long",
        kind = "collection",
        container = "box_retool_huge",
        overflow = "spill",
    }
    group:item("retool_ar15_223rem_extended")
    group:entry { item = "stanag30", charges = { 0, 0 } }
    group:group("nested_retool_extras")
    content.add(group)
end

do
    -- a conversion kit packed along with an appropriate empty magazine and miscellaneous items.
    local group = content.ItemGroup {
        id = "boxed_223rem_ar15kit",
        kind = "collection",
        container = "box_retool_large",
        overflow = "spill",
    }
    group:item("retool_ar15_223rem")
    group:entry { item = "stanag30", charges = { 0, 0 } }
    group:group("nested_retool_extras")
    content.add(group)
end

do
    -- a conversion kit packed along with an appropriate empty magazine and miscellaneous items.
    local group = content.ItemGroup {
        id = "boxed_223rem_ar15kit_medium",
        kind = "collection",
        container = "box_retool_large",
        overflow = "spill",
    }
    group:item("retool_ar15_223rem_medium")
    group:entry { item = "stanag30", charges = { 0, 0 } }
    group:group("nested_retool_extras")
    content.add(group)
end

do
    -- a conversion kit packed along with an appropriate empty magazine and miscellaneous items.
    local group = content.ItemGroup {
        id = "boxed_223rem_ar15kit_short",
        kind = "collection",
        container = "box_retool_sbr",
        overflow = "spill",
    }
    group:item("retool_ar15_223rem_short")
    group:entry { item = "stanag30", charges = { 0, 0 } }
    group:group("nested_retool_extras")
    content.add(group)
end

do
    -- a conversion kit packed along with an appropriate empty magazine and miscellaneous items.
    local group = content.ItemGroup {
        id = "boxed_300blk_ar15kit",
        kind = "collection",
        container = "box_retool_large",
        overflow = "spill",
    }
    group:item("retool_ar15_300blk")
    group:entry { item = "stanag30", charges = { 0, 0 } }
    group:group("nested_retool_extras")
    content.add(group)
end

do
    -- a conversion kit packed along with an appropriate empty magazine and miscellaneous items.
    local group = content.ItemGroup {
        id = "boxed_300blk_ar15kit_medium",
        kind = "collection",
        container = "box_retool_sbr",
        overflow = "spill",
    }
    group:item("retool_ar15_300blk_medium")
    group:entry { item = "stanag30", charges = { 0, 0 } }
    group:group("nested_retool_extras")
    content.add(group)
end

do
    -- a conversion kit packed along with an appropriate empty magazine and miscellaneous items.
    local group = content.ItemGroup {
        id = "boxed_300blk_ar15kit_short",
        kind = "collection",
        container = "box_retool_sbr_micro",
        overflow = "spill",
    }
    group:item("retool_ar15_300blk_short")
    group:entry { item = "stanag30", charges = { 0, 0 } }
    group:group("nested_retool_extras")
    content.add(group)
end

do
    -- a conversion kit packed along with an appropriate empty magazine and miscellaneous items.
    local group = content.ItemGroup {
        id = "boxed_50beowulf_ar15kit",
        kind = "collection",
        container = "box_retool_large",
        overflow = "spill",
    }
    group:item("retool_ar15_50beowulf")
    group:entry { item = "50beowulf_ar15mag", charges = { 0, 0 } }
    group:group("nested_retool_extras")
    content.add(group)
end

do
    -- a conversion kit packed along with an appropriate empty magazine and miscellaneous items.
    local group = content.ItemGroup {
        id = "boxed_50beowulf_ar15kit_medium",
        kind = "collection",
        container = "box_retool_large",
        overflow = "spill",
    }
    group:item("retool_ar15_50beowulf_medium")
    group:entry { item = "50beowulf_ar15mag", charges = { 0, 0 } }
    group:group("nested_retool_extras")
    content.add(group)
end

do
    -- a conversion kit packed along with an appropriate empty magazine and miscellaneous items.
    local group = content.ItemGroup {
        id = "boxed_50beowulf_ar15kit_short",
        kind = "collection",
        container = "box_retool_sbr_micro",
        overflow = "spill",
    }
    group:item("retool_ar15_50beowulf_short")
    group:entry { item = "50beowulf_ar15mag", charges = { 0, 0 } }
    group:group("nested_retool_extras")
    content.add(group)
end

do
    -- a conversion kit packed along with an appropriate empty magazine and miscellaneous items.
    local group = content.ItemGroup {
        id = "boxed_450bushmaster_ar15kit",
        kind = "collection",
        container = "box_retool_large",
        overflow = "spill",
    }
    group:item("retool_ar15_450")
    group:entry { item = "450_ar15mag", charges = { 0, 0 } }
    group:group("nested_retool_extras")
    content.add(group)
end

do
    -- a conversion kit packed along with an appropriate empty magazine and miscellaneous items.
    local group = content.ItemGroup {
        id = "boxed_450bushmaster_ar15kit_medium",
        kind = "collection",
        container = "box_retool_sbr",
        overflow = "spill",
    }
    group:item("retool_ar15_450_medium")
    group:entry { item = "450_ar15mag", charges = { 0, 0 } }
    group:group("nested_retool_extras")
    content.add(group)
end

do
    -- a conversion kit packed along with an appropriate empty magazine and miscellaneous items.
    local group = content.ItemGroup {
        id = "boxed_450bushmaster_ar15kit_short",
        kind = "collection",
        container = "box_retool_sbr_micro",
        overflow = "spill",
    }
    group:item("retool_ar15_450_short")
    group:entry { item = "450_ar15mag", charges = { 0, 0 } }
    group:group("nested_retool_extras")
    content.add(group)
end

do
    -- a conversion kit packed along with an appropriate empty magazine and miscellaneous items.
    local group = content.ItemGroup {
        id = "boxed_762_ar15kit",
        kind = "collection",
        container = "box_retool_large",
        overflow = "spill",
    }
    group:item("retool_ar15_762")
    group:entry { item = "762_ar15mag_30rd", charges = { 0, 0 } }
    group:group("nested_retool_extras")
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "boxed_22_ar15kit",
        kind = "collection",
        container = "box_retool_large",
        overflow = "spill",
    }
    group:item("retool_ar15_22")
    group:entry {
        distribution = {
            { item = "22_ar15mag_10", count = { 2, 2 }, charges = { 0, 0 } },
            { item = "22_ar15mag_28", count = { 2, 2 }, charges = { 0, 0 } },
        },
    }
    group:group("nested_retool_extras")
    content.add(group)
end

do
    -- a conversion kit packed along with an appropriate empty magazine and miscellaneous items.
    local group = content.ItemGroup {
        id = "boxed_223rem_mdrxkit",
        kind = "collection",
        container = "box_retool_large",
        overflow = "spill",
    }
    group:item("retool_mdrx_223rem")
    group:entry { item = "stanag30", charges = { 0, 0 } }
    group:group("nested_retool_extras")
    content.add(group)
end

do
    -- a conversion kit packed along with an appropriate empty magazine and miscellaneous items.
    local group = content.ItemGroup { id = "boxed_223rem_mdrxkit_medium", kind = "collection", container = "box_retool" }
    group:item("retool_mdrx_223rem_medium")
    group:entry { item = "stanag30", charges = { 0, 0 } }
    group:group("nested_retool_extras")
    content.add(group)
end

do
    -- a conversion kit packed along with an appropriate empty magazine and miscellaneous items.
    local group = content.ItemGroup { id = "boxed_223rem_mdrxkit_short", kind = "collection", container = "box_retool_sbr" }
    group:item("retool_mdrx_223rem_short")
    group:entry { item = "stanag30", charges = { 0, 0 } }
    group:group("nested_retool_extras")
    content.add(group)
end

do
    -- a conversion kit packed along with an appropriate empty magazine and miscellaneous items.
    local group = content.ItemGroup {
        id = "boxed_300blk_mdrxkit",
        kind = "collection",
        container = "box_retool",
        overflow = "spill",
    }
    group:item("retool_mdrx_300blk")
    group:entry { item = "stanag30", charges = { 0, 0 } }
    group:group("nested_retool_extras")
    content.add(group)
end

do
    -- a conversion kit packed along with an appropriate empty magazine and miscellaneous items.
    local group = content.ItemGroup {
        id = "boxed_308win_mdrxkit",
        kind = "collection",
        container = "box_retool_large",
        overflow = "spill",
    }
    group:item("retool_mdrx_308win")
    group:entry { item = "ar10mag_20rd", charges = { 0, 0 } }
    group:group("nested_retool_extras")
    content.add(group)
end

do
    -- a conversion kit packed along with an appropriate empty magazine and miscellaneous items.
    local group = content.ItemGroup {
        id = "boxed_308win_mdrxkit_medium",
        kind = "collection",
        container = "box_retool",
        overflow = "spill",
    }
    group:item("retool_mdrx_308win_medium")
    group:entry { item = "ar10mag_20rd", charges = { 0, 0 } }
    group:group("nested_retool_extras")
    content.add(group)
end

do
    -- a conversion kit packed along with an appropriate empty magazine and miscellaneous items.
    local group = content.ItemGroup {
        id = "boxed_300win_axmckit",
        kind = "collection",
        container = "box_retool_huge",
        overflow = "spill",
    }
    group:item("retool_axmc_300win")
    group:entry { item = "ai_338mag_10", charges = { 0, 0 } }
    group:group("nested_retool_extras")
    content.add(group)
end

do
    -- a conversion kit packed along with an appropriate empty magazine and miscellaneous items.
    local group = content.ItemGroup {
        id = "boxed_308win_axmckit",
        kind = "collection",
        container = "box_retool_huge",
        overflow = "spill",
    }
    group:item("retool_axmc_308win")
    group:entry { item = "ai_308mag_10", charges = { 0, 0 } }
    group:group("nested_retool_extras")
    content.add(group)
end

do
    -- a conversion kit packed along with appropriate empty magazines and miscellaneous items.
    local group = content.ItemGroup { id = "boxed_50ae_deaglekit", kind = "collection", container = "box_small" }
    group:item("retool_deagle_50")
    group:entry { item = "deaglemag_50", charges = { 0, 0 } }
    group:entry { item = "deaglemag_50", charges = { 0, 0 } }
    group:group("nested_retool_extras")
    content.add(group)
end

do
    -- a conversion kit packed along with appropriate empty magazines and miscellaneous items.
    local group = content.ItemGroup { id = "boxed_44_deaglekit", kind = "collection", container = "box_small" }
    group:item("retool_deagle_44")
    group:entry { item = "deaglemag", charges = { 0, 0 } }
    group:entry { item = "deaglemag", charges = { 0, 0 } }
    group:group("nested_retool_extras")
    content.add(group)
end

do
    -- a conversion kit packed along with appropriate empty magazines and miscellaneous items.
    local group = content.ItemGroup { id = "boxed_357_deaglekit", kind = "collection", container = "box_small" }
    group:item("retool_deagle_357")
    group:entry { item = "deaglemag_357", charges = { 0, 0 } }
    group:entry { item = "deaglemag_357", charges = { 0, 0 } }
    group:group("nested_retool_extras")
    content.add(group)
end

do
    -- A pistol packaged with a complete set of conversion kits and magazines, mirroring the real-life Desert Eagle Component System.
    local group = content.ItemGroup { id = "modular_deagle_complete", kind = "collection", container = "briefcase" }
    group:group("modular_deagle_50")
    group:entry { item = "deaglemag_50", charges = { 0, 0 } }
    group:item("retool_deagle_357")
    group:entry { item = "deaglemag_357", charges = { 0, 0 } }
    group:item("retool_deagle_44")
    group:entry { item = "deaglemag", charges = { 0, 0 } }
    content.add(group)
end

do
    -- An item group for a specific weapon platform's possible conversion kits .
    local group = content.ItemGroup { id = "boxed_ar15kits", kind = "collection" }
    group:entry {
        distribution = {
            { group = "boxed_223rem_ar15kit_long", probability = 25 },
            { group = "boxed_223rem_ar15kit", probability = 30 },
            { group = "boxed_223rem_ar15kit_medium", probability = 25 },
            { group = "boxed_223rem_ar15kit_short", probability = 15 },
            { group = "boxed_300blk_ar15kit", probability = 25 },
            { group = "boxed_300blk_ar15kit_medium", probability = 20 },
            { group = "boxed_300blk_ar15kit_short", probability = 15 },
            { group = "boxed_50beowulf_ar15kit", probability = 20 },
            { group = "boxed_50beowulf_ar15kit_medium", probability = 15 },
            { group = "boxed_50beowulf_ar15kit_short", probability = 10 },
            { group = "boxed_450bushmaster_ar15kit", probability = 20 },
            { group = "boxed_450bushmaster_ar15kit_medium", probability = 15 },
            { group = "boxed_450bushmaster_ar15kit_short", probability = 10 },
            { group = "boxed_762_ar15kit", probability = 30 },
            { group = "boxed_22_ar15kit", probability = 30 },
        },
    }
    content.add(group)
end

do
    -- An item group for a specific weapon platform's possible conversion kits .
    local group = content.ItemGroup { id = "boxed_mdrxkits", kind = "collection" }
    group:entry {
        distribution = {
            { group = "boxed_223rem_mdrxkit", probability = 30 },
            { group = "boxed_223rem_mdrxkit_medium", probability = 25 },
            { group = "boxed_223rem_mdrxkit_short", probability = 15 },
            { group = "boxed_300blk_mdrxkit", probability = 10 },
            { group = "boxed_308win_mdrxkit", probability = 25 },
            { group = "boxed_308win_mdrxkit_medium", probability = 20 },
        },
    }
    content.add(group)
end

do
    -- An item group for a specific weapon platform's possible conversion kits .
    local group = content.ItemGroup { id = "boxed_axmckits", kind = "collection" }
    group:entry {
        distribution = {
            { group = "boxed_300win_axmckit", probability = 30 },
            { group = "boxed_308win_axmckit", probability = 30 },
        },
    }
    content.add(group)
end

do
    -- An item group for a specific weapon platform's possible conversion kits .
    local group = content.ItemGroup { id = "boxed_deaglekits", kind = "collection" }
    group:entry {
        distribution = {
            { group = "boxed_357_deaglekit", probability = 25 },
            { group = "boxed_44_deaglekit", probability = 30 },
            { group = "boxed_50ae_deaglekit", probability = 30 },
        },
    }
    content.add(group)
end

do
    -- An item group for an empty rifle to spawn alongside one of a number of compatible conversion kits. Intended for use in gun store racks and adjacent locations.
    local group = content.ItemGroup { id = "nested_ar15_with_kits", kind = "collection" }
    group:group("boxed_ar15kits")
    group:group("modular_ar15")
    content.add(group)
end

do
    -- An item group for an empty rifle to spawn alongside one of a number of compatible conversion kits. Intended for use in gun store racks and adjacent locations.
    local group = content.ItemGroup { id = "nested_mdrx_with_kits", kind = "collection" }
    group:group("boxed_mdrxkits")
    group:group("mdrx")
    content.add(group)
end

do
    -- An item group for an empty rifle to spawn alongside one of a number of compatible conversion kits. Intended for use in gun store racks and adjacent locations.
    local group = content.ItemGroup { id = "nested_axmc_with_kits", kind = "collection" }
    group:group("boxed_axmckits")
    group:group("axmc")
    content.add(group)
end

do
    -- An item group for an empty pistol to spawn alongside one of a number of compatible conversion kits. Intended for use in gun store racks and adjacent locations.
    local group = content.ItemGroup { id = "nested_deagle_with_kits", kind = "collection" }
    group:group("boxed_deaglekits")
    group:group("modular_deagle_50")
    content.add(group)
end

do
    -- An item group for a randomly selected conversion kit to spawn, regardless of type. Intended for use in gun stores and other sensible locations.
    local group = content.ItemGroup { id = "conversion_kits", kind = "collection" }
    group:entry {
        distribution = {
            { group = "boxed_ar15kits", probability = 30 },
            { group = "boxed_mdrxkits", probability = 15 },
            { group = "boxed_axmckits", probability = 5 },
        },
    }
    content.add(group)
end
