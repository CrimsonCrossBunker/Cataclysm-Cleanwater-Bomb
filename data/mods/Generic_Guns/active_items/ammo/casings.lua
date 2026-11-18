local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "ammolinkrifle",
        copy_from = "ammolink",
        name = ccb.content.plural_text("rifle belt linkage", "rifle belt linkages"),
    }
    item:clear_use_actions()
    item:assemble_ammo_belt("rifle_belt")
    content.add(item)
end

do
    local item = content.Item {
        id = "ammolinkgrenade",
        copy_from = "ammolink",
        name = ccb.content.plural_text("grenade belt linkage", "grenade belt linkages"),
    }
    item:clear_use_actions()
    item:assemble_ammo_belt("grenade_belt")
    content.add(item)
end

do
    local item = content.Item {
        id = "ammolinkrifle_huge",
        copy_from = "ammolink",
        name = ccb.content.plural_text("heavy machinegun belt linkage", "heavy machinegun belt linkages"),
    }
    item:clear_use_actions()
    item:assemble_ammo_belt("rifle_huge_belt")
    content.add(item)
end
