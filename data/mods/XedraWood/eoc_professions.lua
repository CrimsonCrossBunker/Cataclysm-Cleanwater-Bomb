local ccb = require("ccb")
local services = ccb.services
local E = require("eoc_runtime")
local H = E.H

ccb.runtime.handler("w16b_prof_xedrawood_0f95a35396fd", function(payload)
    local ctx = E.H.ctx_new(payload and payload.character or nil, nil, {})
    E.H.run_eoc("EOC_PROFESSION_PATTERN_TATTOO_MOUNTAIN", ctx)
end)

do
    local g = ccb.content.ItemGroup { id = "prof_pattern_tattoo_mountain_prof_items_both", kind = "collection" }
    g:item("grass_cloak")
    g:item("shirt_straw")
    g:item("skirt_grass")
    g:item("footrags_leather")
    g:entry { item = "water_clean", charges = 6, container = "waterskin" }
    g:entry { item = "primitive_knife", container = "sheath_birchbark" }
    ccb.content.add(g)
end
do
    local g = ccb.content.ItemGroup { id = "prof_pattern_tattoo_mountain_prof_items_male", kind = "collection" }
    g:item("loincloth_leather")
    ccb.content.add(g)
end
do
    local g = ccb.content.ItemGroup { id = "prof_pattern_tattoo_mountain_prof_items_female", kind = "collection" }
    g:item("chestwrap_leather")
    g:item("loincloth_leather")
    ccb.content.add(g)
end
ccb.content.add(ccb.content.Profession {
    id = "pattern_tattoo_mountain_prof",
    name = "Aspirant of the Mountain",
    description = "You are one of the warrior companions to the Wise, and have received the sacred tattoos that bond your soul with the spirits of the land.  In your case, the spirits of the Mountain, granting you resilience and skill in unarmed combat.  Hopefully these talents will help you now.",
    points = 7,
    proficiencies = { "prof_unarmed_familiar", "prof_unarmed_pro", "prof_gross_anatomy" },
    skills = {
        { id = "deduction", level = 2 },
        { id = "unarmed", level = 5 },
        { id = "dodge", level = 4 },
        { id = "melee", level = 4 },
    },
    cbms = {
        "mountain_tattoo_one",
        "mountain_tattoo_two",
        "mountain_tattoo_three",
        "mountain_tattoo_four",
    },
    traits = { "TATTOOS_BASIC_TRAIT", "PAINRESIST" },
    spells = {
        { id = "pattern_tattoo_mountain_meditation", level = 1 },
    },
    on_start = "w16b_prof_xedrawood_0f95a35396fd",
    items_both = "prof_pattern_tattoo_mountain_prof_items_both",
    items_male = "prof_pattern_tattoo_mountain_prof_items_male",
    items_female = "prof_pattern_tattoo_mountain_prof_items_female",
})
