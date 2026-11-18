local content = require("ccb").content

do
    local group = content.ItemGroup { id = "modular_m4a1", kind = "collection" }
    group:entry {
        item = "modular_m4_carbine",
        contents = {
            { item = "retool_ar15_223rem_medium" },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "m4_cqbr", kind = "collection" }
    group:entry {
        item = "modular_m4_carbine",
        variant = "m4_cqbr",
        contents = {
            { item = "retool_ar15_223rem_short" },
            { item = "suppressor" },
            { item = "adjustable_stock" },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "ar15_22", kind = "collection" }
    group:entry {
        item = "modular_ar15",
        contents = {
            { item = "retool_ar15_22" },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "h&k416a5_any", kind = "distribution" }
    group:entry {
        item = "modular_m27_assault_rifle",
        variant = "modular_h&k416a5",
        contents = {
            { item = "retool_ar15_223rem" },
        },
    }
    group:entry {
        item = "modular_m27_assault_rifle",
        variant = "modular_h&k416a5",
        contents = {
            { item = "retool_ar15_223rem_short" },
        },
    }
    group:entry {
        item = "modular_m27_assault_rifle",
        variant = "modular_h&k416a5",
        contents = {
            { item = "retool_ar15_223rem_medium" },
        },
    }
    group:entry {
        item = "modular_m27_assault_rifle",
        variant = "modular_h&k416a5",
        contents = {
            { item = "retool_ar15_223rem_extended" },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "h&k416a5_default_or_short", kind = "distribution" }
    group:entry {
        item = "modular_m27_assault_rifle",
        variant = "modular_h&k416a5",
        contents = {
            { item = "retool_ar15_223rem" },
        },
    }
    group:entry {
        item = "modular_m27_assault_rifle",
        variant = "modular_h&k416a5",
        contents = {
            { item = "retool_ar15_223rem_short" },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "m27iar", kind = "collection" }
    group:entry {
        item = "modular_m27_assault_rifle",
        variant = "modular_m27iar",
        contents = {
            { item = "retool_ar15_223rem" },
            { item = "shoulder_strap" },
            { item = "bipod" },
            { item = "grip" },
            { item = "mipim" },
            { item = "red_dot_sight" },
            { item = "hybrid_sight_4x" },
            { item = "suppressor" },
            { item = "adjustable_stock" },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "m38dmr", kind = "collection" }
    group:entry {
        item = "modular_m27_assault_rifle",
        variant = "modular_m38dmr",
        contents = {
            { item = "retool_ar15_223rem" },
            { item = "shoulder_strap" },
            { item = "bipod" },
            { item = "grip" },
            { item = "mipim" },
            { item = "rifle_scope" },
            { item = "suppressor" },
            { item = "adjustable_stock" },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "ar_pistol", kind = "collection" }
    group:entry {
        item = "modular_ar_pistol",
        contents = {
            { item = "retool_ar15_223rem_pistol" },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "ar_pistol_long", kind = "collection" }
    group:entry {
        item = "modular_ar_pistol",
        contents = {
            { item = "retool_ar15_223rem_short" },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "ar_pistol_300", kind = "collection" }
    group:entry {
        item = "modular_ar_pistol",
        contents = {
            { item = "retool_ar15_300blk_short" },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "ar_pistol_300_long", kind = "collection" }
    group:entry {
        item = "modular_ar_pistol",
        contents = {
            { item = "retool_ar15_300blk_medium" },
        },
    }
    content.add(group)
end
