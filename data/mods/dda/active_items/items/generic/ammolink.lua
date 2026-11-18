local ccb = require("ccb")
local content = ccb.content

do
    -- NO_I18N
    local item = content.Item {
        id = "ammolink",
        abstract = true,
        category = "spare_parts",
        name = content.plural_text("ammo belt linkage", "ammo belt linkages"),
        description = ccb.content.text("A small metal linkage from a disintegrating ammo belt."),
        mass_milligrams = 2000,
        volume_ml = 2,
        stackable = true,
        symbol = "=",
        color = "yellow",
    }
    item:material("steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "ammolink223",
        copy_from = "ammolink",
        name = ccb.content.plural_text(".223 ammo belt linkage", ".223 ammo belt linkages"),
    }
    item:clear_use_actions()
    item:assemble_ammo_belt("belt223")
    content.add(item)
end

do
    local item = content.Item {
        id = "ammolink308",
        copy_from = "ammolink",
        name = ccb.content.plural_text(".308 ammo belt linkage", ".308 ammo belt linkages"),
    }
    item:clear_use_actions()
    item:assemble_ammo_belt("belt308")
    content.add(item)
end

do
    local item = content.Item {
        id = "ammolink40mm",
        copy_from = "ammolink",
        name = ccb.content.plural_text("40mm grenade belt linkage", "40mm grenade belt linkages"),
        mass_milligrams = 10000,
        volume_ml = 10,
    }
    item:clear_use_actions()
    item:assemble_ammo_belt("belt40mm")
    content.add(item)
end

do
    local item = content.Item {
        id = "ammolink50",
        copy_from = "ammolink",
        name = ccb.content.plural_text(".50 ammo belt linkage", ".50 ammo belt linkages"),
    }
    item:clear_use_actions()
    item:assemble_ammo_belt("belt50")
    content.add(item)
end
