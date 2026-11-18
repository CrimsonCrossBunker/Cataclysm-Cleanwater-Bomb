local ccb = require("ccb")
local content = ccb.content
local services = ccb.services

local ACTIVE_EXERCISE = 8
local completion = "finish_dreamforged_equipment"

ccb.runtime.handler(completion, function(payload)
    local group = services.types.id("item_group", payload.recipe_id)
    for _ = 1, payload.batch do
        local result = services.inventory.receive_group(payload.character, group)
        if not result.ok then
            error(result.error.message)
        end
    end
end, 1)

local function register_recipes(family, recipes)
    for _, recipe in ipairs(recipes) do
        local id, name, hours, ingots, difficulty = table.unpack(recipe)
        content.add(content.Recipe {
            id = id,
            name = name,
            description = family.description,
            duration_moves = hours * 60 * 60 * 100,
            activity_level = ACTIVE_EXERCISE,
            category = "CC_XEDRA",
            subcategory = family.subcategory,
            skill = "deduction",
            difficulty = difficulty,
            autolearn = false,
            flags = { "SECRET" },
            scripted_output = true,
        }
            :quality("DREAM_HAMMER", 1, 1)
            :component("forged_dreamstuff_ingot", ingots)
            :proficiency("prof_dreamsmithing")
            :proficiency(family.proficiency)
            :on_complete(completion)
        )
    end
end

register_recipes({
    description = content.text(
        "Shape the armor you imagine, using your powers and some dreamdross ingots.  The result is unclear, and the effects are uncontrollable."
    ),
    subcategory = "CSC_XEDRA_ARMOR",
    proficiency = "prof_dreamsmithing_armor",
}, {
    { "dreamforged_fullhelmet_ench", content.text("dreamforged full helmet"), 16, 2, 5 },
    { "dreamforged_helmet_ench", content.text("dreamforged helmet"), 8, 1, 4 },
    { "dreamforged_plate_armor_ench", content.text("dreamforged plate armor"), 22, 8, 7 },
    { "dreamforged_armguard_plate_ench", content.text("dreamforged arm guards"), 11, 3, 5 },
    { "dreamforged_boots_ench", content.text("dreamforged boots"), 12, 3, 5 },
})

register_recipes({
    description = content.text(
        "Shape the weapon you imagine, using your powers and some dreamdross ingots.  The result is unclear, and the effects are uncontrollable."
    ),
    subcategory = "CSC_XEDRA_WEAPONS",
    proficiency = "prof_dreamsmithing_weapon",
}, {
    { "dreamforged_longsword_ench", content.text("dreamforged longsword"), 10, 1, 6 },
    { "dreamforged_q_staff_ench", content.text("dreamforged quarterstaff"), 7, 5, 4 },
    { "dreamforged_warhammer_ench", content.text("dreamforged warhammer"), 11, 3, 6 },
    { "dreamforged_spear_ench", content.text("dreamforged spear"), 9, 5, 6 },
    { "dreamforged_halberd_ench", content.text("dreamforged halberd"), 12, 5, 7 },
    { "dreamforged_glaive_ench", content.text("dreamforged glaive"), 11, 5, 7 },
    { "dreamforged_naginata_ench", content.text("dreamforged naginata"), 13, 5, 6 },
    { "dreamforged_mace_ench", content.text("dreamforged mace"), 6, 3, 4 },
    { "dreamforged_morningstar_ench", content.text("dreamforged morningstar"), 8, 3, 5 },
    { "dreamforged_estoc_ench", content.text("dreamforged estoc"), 7, 1, 4 },
    { "dreamforged_arming_sword_ench", content.text("dreamforged arming sword"), 9, 1, 5 },
    { "dreamforged_broadsword_ench", content.text("dreamforged broadsword"), 9, 1, 5 },
    { "dreamforged_battleaxe_ench", content.text("dreamforged battle axe"), 9, 3, 5 },
    { "dreamforged_katana_ench", content.text("dreamforged katana"), 12, 1, 6 },
    { "dreamforged_knife_combat_ench", content.text("dreamforged combat knife"), 9, 1, 6 },
    { "dreamforged_kris_ench", content.text("dreamforged kris"), 10, 1, 5 },
    { "dreamforged_kukri_ench", content.text("dreamforged kukri"), 7, 1, 4 },
    { "dreamforged_nodachi_ench", content.text("dreamforged nodachi"), 7, 2, 5 },
    { "dreamforged_rapier_ench", content.text("dreamforged rapier"), 7, 2, 5 },
    { "dreamforged_tanto_ench", content.text("dreamforged tanto"), 6, 1, 5 },
    { "dreamforged_wakizashi_ench", content.text("dreamforged wakizashi"), 5, 1, 5 },
    { "dreamforged_zweihander_ench", content.text("dreamforged zweihänder"), 16, 2, 6 },
    { "dreamforged_khopesh_ench", content.text("dreamforged khopesh"), 13, 1, 6 },
    { "dreamforged_lucerne_ench", content.text("dreamforged lucerne hammer"), 20, 5, 7 },
    { "dreamforged_knuckle_ench", content.text("dreamforged knuckles"), 7, 2, 5 },
})
