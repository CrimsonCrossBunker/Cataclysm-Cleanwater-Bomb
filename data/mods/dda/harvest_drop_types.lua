local ccb = require("ccb")
local content = ccb.content

-- Native harvest-drop types
do
local definition = content.HarvestDropType {
    id = "flesh",
    dissect_failure = "harvest_drop_tissue_dissect_failed",
    item_group = false,
    dissect_only = false,
}
content.add(definition)
end
do
local definition = content.HarvestDropType {
    id = "bone",
    dissect_failure = "harvest_drop_bone_dissect_failed",
    item_group = false,
    dissect_only = false,
}
content.add(definition)
end
do
local definition = content.HarvestDropType {
    id = "skin",
    dissect_failure = "harvest_drop_tissue_dissect_failed",
    item_group = false,
    dissect_only = false,
}
content.add(definition)
end
do
local definition = content.HarvestDropType {
    id = "blood",
    item_group = false,
    dissect_only = false,
}
content.add(definition)
end
do
local definition = content.HarvestDropType {
    id = "offal",
    dissect_failure = "harvest_drop_tissue_dissect_failed",
    item_group = false,
    dissect_only = false,
}
content.add(definition)
end
do
local definition = content.HarvestDropType {
    id = "mutagen",
    field_dress_failure = "harvest_drop_mutagen_field_dress",
    butcher_failure = "harvest_drop_mutagen_butcher",
    dissect_failure = "harvest_drop_mutagen_dissect_failed",
    item_group = false,
    dissect_only = true,
}
definition:skill("chemistry")
definition:skill("firstaid")
content.add(definition)
end
do
local definition = content.HarvestDropType {
    id = "mutagen_group",
    field_dress_failure = "harvest_drop_mutagen_field_dress",
    butcher_failure = "harvest_drop_mutagen_butcher",
    dissect_failure = "harvest_drop_mutagen_dissect_failed",
    item_group = true,
    dissect_only = true,
}
definition:skill("chemistry")
definition:skill("firstaid")
content.add(definition)
end
do
local definition = content.HarvestDropType {
    id = "bionic",
    field_dress_failure = "harvest_drop_bionic_field_dress",
    butcher_failure = "harvest_drop_bionic_butcher",
    item_group = false,
    dissect_only = true,
}
definition:skill("electronics")
definition:skill("firstaid")
content.add(definition)
end
do
local definition = content.HarvestDropType {
    id = "bionic_group",
    field_dress_failure = "harvest_drop_bionic_field_dress",
    butcher_failure = "harvest_drop_bionic_butcher",
    item_group = true,
    dissect_only = true,
}
definition:skill("electronics")
definition:skill("firstaid")
content.add(definition)
end
