local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "body_astral_projection",
        copy_from = "corpse",
        name = ccb.content.plural_text("your body", "your body"),
        description = ccb.content.text("Your body, lying on the ground while your spirit walks free.  Hopefully nothing happens to it while you're gone."),
        looks_like = "corpse_generic_human",
    }
    item:material("hflesh", 1)
    content.upsert_item(item)
end

do
    local snippets = content.SnippetCategory { id = "auto:corpse_fae" }
    snippets:entry {
        id = "generic_fae_corpse_01",
        text = ccb.content.text("The dead body of a changeling.  There are multiple bites across the body and numerous scratches.  It looks like blood loss might have brought them down."),
    }
    snippets:entry {
        id = "generic_fae_corpse_02",
        text = ccb.content.text("Extreme burns cover the body of this changeling.  In multiple locations the charring goes all the way to the bone."),
    }
    snippets:entry {
        id = "generic_fae_corpse_03",
        text = ccb.content.text("Several ballistic wounds seem to have brought down this changeling.  It probably happened elsewhere and they escaped to here."),
    }
    snippets:entry {
        id = "generic_fae_corpse_04",
        text = ccb.content.text("This lifeless body is covered in a rime of frost, that seems resistant to the prevailing weather."),
    }
    snippets:entry {
        id = "generic_fae_corpse_05",
        text = ccb.content.text("This changeling seems to have gotten themselves impaled upon an unhealthy number of large thorns.  What kind of plant could do this?"),
    }
    snippets:entry {
        id = "generic_fae_corpse_06",
        text = ccb.content.text("This changeling corpse has a belly wound that appears to be caused by a sword and is also missing its hand."),
    }
    content.add(snippets)
end

do
    -- Changeling corpses.
    local item = content.Item {
        id = "corpse_fae",
        copy_from = "corpse",
        name = ccb.content.plural_text("fae corpse", "fae corpses"),
        volume_ml = 810000,
        description = ccb.content.text("The dead body of a changeling.  There are multiple bites across the body and numerous scratches.  It looks like blood loss might have brought them down."),
        looks_like = "corpse_generic_human",
        snippet_category = "auto:corpse_fae",
    }
    item:material("fae_flesh", 1)
    content.add(item)
end
