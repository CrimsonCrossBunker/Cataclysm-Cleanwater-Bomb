local ccb = require("ccb")

-- Append after the base loot pools and the other enabled Mods' additions.
for _, placement in ipairs({
    { "drugs_rare", 100 },
    { "hospital_lab", 10 },
    { "hospital_bed", 6 },
    { "virology_lab_fridge", 40 },
}) do
    local group = ccb.content.ItemGroup { id = placement[1], kind = "distribution" }
    group:item("antivirals", placement[2])
    ccb.content.extend_item_group(group)
end

local veterinary = ccb.content.ItemGroup { id = "vet_hardrug", kind = "distribution" }
veterinary:entry {
    item = "antivirals",
    probability = 20,
    count = { 1, 10 },
    container = "null",
    wrapper = "bottle_plastic_pill_prescription",
}
ccb.content.extend_item_group(veterinary)
