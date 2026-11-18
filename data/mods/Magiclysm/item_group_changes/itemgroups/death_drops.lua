local content = require("ccb").content

do
    local group = content.ItemGroup { id = "feral_humans_death_drops_axe", kind = "collection" }
    group:item("denarius", 5)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "feral_humans_death_drops_pipe", kind = "collection" }
    group:item("denarius", 7)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "feral_humans_death_drops_crowbar", kind = "collection" }
    group:item("denarius", 7)
    content.extend_item_group(group)
end

do
    -- items people could have carried in their pockets prior to zombification
    local group = content.ItemGroup { id = "default_zombie_items_pockets", kind = "collection" }
    group:item("denarius", 7)
    content.extend_item_group(group)
end
