local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "pistol_tiny_casing",
        copy_from = "32_casing",
        looks_like = "32_casing",
        name = ccb.content.plural_text("tiny pistol casing", "tiny pistol casings"),
        description = ccb.content.text("An empty casing from a tiny pistol round."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "pistol_casing",
        copy_from = "9mm_casing",
        looks_like = "9mm_casing",
        name = ccb.content.plural_text("pistol casing", "pistol casings"),
        description = ccb.content.text("An empty casing from a standard pistol round."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "pistol_magnum_casing",
        copy_from = "44_casing",
        looks_like = "44_casing",
        name = ccb.content.plural_text("magnum pistol casing", "magnum pistol casings"),
        description = ccb.content.text("An empty casing from a magnum pistol round."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "rifle_casing",
        copy_from = "308_casing",
        looks_like = "308_casing",
        name = ccb.content.plural_text("rifle casing", "rifle casings"),
        description = ccb.content.text("An empty casing from a rifle round."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "rifle_huge_casing",
        copy_from = "50_casing",
        looks_like = "50_casing",
        name = ccb.content.plural_text("huge rifle casing", "huge rifle casings"),
        description = ccb.content.text("An empty casing from a huge rifle round."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "shot_casing",
        copy_from = "shot_hull",
        looks_like = "shot_hull",
        name = ccb.content.plural_text("shotshell hull", "shotshell hulls"),
        description = ccb.content.text("A shotshell's casing, a plastic tube with a brass casehead, commonly referred to as a hull."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "grenade_casing",
        copy_from = "40x46mm_m199_casing",
        looks_like = "40x46mm_m199_casing",
        name = ccb.content.plural_text("grenade casing", "grenade casings"),
        description = ccb.content.text("A large casing from a grenade round."),
    }
    content.add(item)
end
