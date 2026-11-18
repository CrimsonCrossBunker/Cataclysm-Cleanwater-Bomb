local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "broken_turret_rifle",
        name = ccb.content.plural_text("broken CROWS II", "broken CROWS II"),
        copy_from = "broken_turret_rifle",
        looks_like = "broken_turret_rifle",
    }
    content.replace(item)
end

do
    local item = content.Item {
        id = "broken_turret_artisans",
        name = ccb.content.plural_text("broken CROWS II", "broken CROWS II"),
        copy_from = "broken_turret_artisans",
        looks_like = "broken_turret_artisans",
    }
    content.replace(item)
end

do
    local item = content.Item {
        id = "broken_crows_m240",
        name = ccb.content.plural_text("broken CROWS II", "broken CROWS II"),
        copy_from = "broken_crows_m240",
        looks_like = "broken_crows_m240",
    }
    content.replace(item)
end

do
    local item = content.Item {
        id = "broken_turret_bmg",
        name = ccb.content.plural_text("broken CROWS II Heavy", "broken CROWS II Heavy"),
        copy_from = "broken_turret_bmg",
        looks_like = "broken_turret_bmg",
    }
    content.replace(item)
end

do
    local item = content.Item {
        id = "broken_talon_m202a1",
        copy_from = "broken_talon_m202a1",
        looks_like = "broken_talon_m202a1",
        name = ccb.content.plural_text("broken launcher TALON UGV", "broken launcher TALON UGVs"),
        description = ccb.content.text("A broken TALON UGV, with its casing broken and fluid drained.  Could be gutted for parts."),
    }
    content.replace(item)
end

do
    local item = content.Item {
        id = "broken_secubot",
        copy_from = "broken_secubot",
        looks_like = "broken_secubot",
        name = ccb.content.plural_text("broken rifle TALON UGV", "broken rifle TALON UGVs"),
        description = ccb.content.text("A broken TALON UGV, with its casing broken and fluid drained.  Could be gutted for parts."),
    }
    content.replace(item)
end
