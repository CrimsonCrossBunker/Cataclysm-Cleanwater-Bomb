local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local id = services.types.id

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function assign_mission(actor, mission)
    local reserved = checked(services.missions.reserve(id("mission", mission)))
    checked(services.missions.assign(actor, reserved.token))
end

ccb.runtime.handler("profession_start_convict_assassin", function(payload)
    local actor = payload.character
    local omt = checked(services.creatures.snapshot(actor)).position:project_to("omt")

    if services.overmap.matches_location_near(omt, "prison_1_5", 1) then
        assign_mission(actor, "MISSION_ASSASSIN_CONVICT_PRISON")
    end
    if services.overmap.matches_location_near(omt, "prison_alcatraz_3", 1) then
        assign_mission(actor, "MISSION_ASSASSIN_CONVICT_PRISON_ISLAND1")
    else
        assign_mission(actor, "MISSION_ASSASSIN_CONVICT_PRISON_ISLAND2")
    end

    if actor.subtype == "avatar" then
        local text = services.translate("Now… Where is your mark?")
        ccb.presentation.notice(text)
        services.activities.offer_interruption("")
        services.messages.add(text, "warning")
    end
end)

do
    local both = content.ItemGroup { id = "prof_convict_assassin_items_both", kind = "collection" }
    both:entry { item = "jumpsuit_pocketless", variant = "orange" }
    both:item("sneakers")
    both:item("socks")
    both:entry { item = "knife_rm42", container = "gartersheath1" }
    both:entry { item = "polaroid_photo", container = "ankle_wallet_pouch" }
    content.add(both)

    local male = content.ItemGroup { id = "prof_convict_assassin_items_male", kind = "collection" }
    male:item("briefs")
    content.add(male)

    local female = content.ItemGroup { id = "prof_convict_assassin_items_female", kind = "collection" }
    female:item("bra")
    female:item("panties")
    content.add(female)
end

content.add(content.Profession {
    id = "convict_assassin",
    name = "Undercover Assassin Convict",
    description = "You were given a target, a mission, but killing your mark seems to have become much more difficult now.  Your employer cut contact with you and now you have to make do with what you have.",
    npc_background = "BG_survival_story_PRISONER",
    points = 2,
    skills = {
        { id = "melee", level = 4 },
        { id = "stabbing", level = 4 },
        { id = "unarmed", level = 3 },
        { id = "dodge", level = 3 },
    },
    proficiencies = {
        "prof_knives_familiar",
        "prof_knives_pro",
        "prof_unarmed_familiar",
        "prof_unarmed_pro",
        "prof_shivs_familiar",
        "prof_gross_anatomy",
    },
    items_both = "prof_convict_assassin_items_both",
    items_male = "prof_convict_assassin_items_male",
    items_female = "prof_convict_assassin_items_female",
    flags = { "SCEN_ONLY" },
    age_lower = 25,
    on_start = "profession_start_convict_assassin",
})
