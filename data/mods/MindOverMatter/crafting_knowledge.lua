local ccb = require("ccb")
local services = ccb.services
local id = services.types.id
local state = ccb.state.character
local disciplines = require("matrix_awakening_data")

local function checked(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function has_trait(character, trait)
    return checked(services.mutations.has_id_text(character, trait))
end

local function psion(character, include_knacks)
    for _, discipline in ipairs(disciplines) do
        if has_trait(character, discipline.trait) then return true end
    end
    return include_knacks and has_trait(character, "PSYCHIC_KNACK")
end

-- Recipe conditions historically read the avatar's knowledge even when an NPC is learning.
local function avatar_knows(recipe)
    return checked(services.recipes.knows(services.characters.avatar(), id("recipe", recipe)))
end

local function skill(character)
    return math.modf(checked(services.skills.level(character, "metaphysics")))
end

local rules = {}
local function recurring(handler, activate, dormant)
    rules[#rules + 1] = { handler = handler, dormant = dormant }
    ccb.runtime.handler(handler, function(task)
        local character = task.character
        if activate(character) or not dormant(character) then
            ccb.tasks.after_character_turn(character, 1, handler)
        else
            state.set(handler, "dormant")
        end
    end)
end

local meditation = "psi_centering_meditation_drain_reduce"
recurring("grant_grounding_meditation", function(character)
    if psion(character) and skill(character) >= 4 then
        checked(services.recipes.learn(character, id("recipe", meditation)))
        return true
    end
end, function(character)
    return avatar_knows(meditation) or not psion(character)
end)

local function crafting_proficiency(school, trait, knacks)
    local proficiency = "prof_psionic_minimum_requirements" .. (school and "_" .. school or "")
    local handler = "grant_psionic_crafting_" .. (school or "basics")
    local function has_school(character)
        if not trait then return psion(character, true) end
        return has_trait(character, trait)
    end
    local function has_qualifying_knack(character)
        if knacks and has_trait(character, "PSYCHIC_KNACK") then
            for _, spell in ipairs(knacks) do
                if checked(services.spells.effective_level(character, spell)) >= 5 then return true end
            end
        end
        return false
    end
    recurring(handler, function(character)
        if not has_school(character) and not has_qualifying_knack(character) then return false end
        if not checked(services.proficiencies.has_id_text(character, proficiency)) then
            local prof = id("proficiency", proficiency)
            checked(services.proficiencies.set_practiced_time(character, prof, services.proficiencies.definition(prof).time_to_learn))
        end
        return true
    end, function(character)
        return checked(services.proficiencies.has_id_text(character, proficiency))
            or not (has_school(character) or (knacks and has_trait(character, "PSYCHIC_KNACK")))
    end)
end

crafting_proficiency()
crafting_proficiency("biokinesis", "BIOKINETIC", { "biokin_flexibility_knack", "biokin_adrenaline_knack" })
crafting_proficiency("pyrokinesis", "PYROKINETIC", {
    "pyrokinetic_flash_knack", "pyrokinetic_intensify_flames_knack", "pyrokinetic_eruption_knack",
    "pyrokinetic_call_flames_knack", "pyrokinetic_cloak_knack", "pyrokinetic_flamethrower_knack",
    "pyrokinetic_aura_knack", "pyrokinetic_blast_knack",
})
crafting_proficiency("teleportation", "TELEPORTER")
crafting_proficiency("vitakinesis", "VITAKINETIC", {
    "vita_health_power_knack", "vita_concentrated_healing_knack", "vita_remove_poison_knack",
    "vita_cure_disease_knack", "vita_banish_illness_knack",
})

ccb.runtime.handler("initialize_psionic_crafting", function(event)
    local character = event.actors.character
    for _, rule in ipairs(rules) do
        if state.get(rule.handler) ~= "dormant" and not ccb.tasks.has_character_turn(character, rule.handler) then
            ccb.tasks.after_character_turn(character, 1, rule.handler)
        end
    end
end)
ccb.runtime.on("character_ready", "initialize_psionic_crafting")

ccb.runtime.handler("resume_psionic_crafting", function(event)
    local character = event.actors.character
    for _, rule in ipairs(rules) do
        if state.get(rule.handler) == "dormant" and not rule.dormant(character) then
            state.set(rule.handler, nil)
            ccb.tasks.after_character_turn(character, 1, rule.handler)
        end
    end
end)
ccb.runtime.on("character_conditions_changed", "resume_psionic_crafting")

local schools = { PSYCHIC_KNACK = true }
for _, discipline in ipairs(disciplines) do schools[discipline.trait] = true end

local function research_channeling(name, pressure, message)
    local trait = "PSI_" .. name:upper() .. "_CHANNELING"
    local recipe = "psi_research_" .. name .. "_channeling"
    local trigger = "discover_" .. name .. "_channeling"
    local function can_learn(character)
        return not has_trait(character, trait) and not avatar_knows(recipe)
    end

    ccb.runtime.handler(trigger, function(task)
        local character = task.character
        if can_learn(character) then
            checked(services.recipes.learn(character, id("recipe", recipe)))
            if character.subtype == "avatar" then
                local text = message()
                ccb.presentation.notice(text)
                services.activities.offer_interruption("")
                services.messages.add(text, "neutral")
            end
        end
    end)
    local casting = trigger .. "_after_cast"
    ccb.runtime.handler(casting, function(event)
        local character = event.actors.character or services.characters.avatar()
        if not schools[event.data.school] or not psion(character, true) or not can_learn(character) then return end
        local multiplier = pressure(character)
        if not multiplier then return end
        local intelligence = checked(services.characters.snapshot(character, 1)).stats.intelligence
        local chance = math.max((1000 - skill(character) * 50 - intelligence * 25) * multiplier, 1)
        if services.random.native_probability(1, chance) and event.data.success then
            ccb.tasks.after_character_turn(character, services.random.native_int(21600, 86400), trigger)
        end
    end)
    ccb.runtime.on("game:spellcasting_finish", casting)
end

research_channeling("extended", function(character)
    if checked(services.needs.get_vitamin(character, id("vitamin", "vitamin_maintained_powers"))) >= 2
        or checked(services.creatures.snapshot(character)).pain >= 35
        or checked(services.needs.get(character)).focus <= 15 then return 1 end
end, function()
    return ccb.services.translate("The state of mind necessary to channel while maintaining other powers has you thinking.  It requires fine control to maintain your concentration on multiple things at once, but what if you applied that level of control to a single power at a time?  If you slowly and carefully drew on just as much energy as you needed, maybe there would be fewer side effects?  With some experimentation, perhaps you can discover a way.")
end)
research_channeling("torrential", function(character)
    local drain = checked(services.needs.get_vitamin(character, id("vitamin", "vitamin_psionic_drain")))
    if drain >= 135 then return 1 - math.max(0, math.min((drain - 155) / 200, 0.5)) end
end, function()
    return ccb.services.translate("Safety is all well and good, but sometimes you need power.  The ebb and flow of Nether energy…if you deliberately drew on it more deeply, could you charge your powers up more quickly?  Maybe you can figure out a way with some more experimentation.")
end)

ccb.runtime.handler("read_phavian_usb", function(use)
    local character = use.character
    if not character then return 0 end
    if checked(services.inventory.has_type(character, id("item", "laptop")))
        or checked(services.inventory.has_type(character, id("item", "laptop_screen_lit"))) then
        checked(services.recipes.learn(character, id("recipe", "psi_research_rad_powers")))
        if character.subtype == "avatar" then
            services.messages.add(ccb.services.translate("You plug in the USB and find a series of powerpoint presentations, long technical-looking documents, video files, and other documents.  It's going to take a long while to sort through these."), "neutral")
        end
    elseif character.subtype == "avatar" then
        services.messages.add(ccb.services.translate("Without a laptop, you can't access the data on the USB"), "bad")
    end
    return 0
end)

local drive = ccb.content.Item {
    id = "psi_usb_rad_recipes",
    name = ccb.content.plural_text("USB drive (Phavian)", "USB drives (Phavian)"),
    description = ccb.content.text("A USB thumb drive with the XEDRA logo over a large Ψ symbol printed on it.  You'd bet there's something important on here."),
    symbol = ",",
    color = "white",
    mass_milligrams = 4536,
    volume_ml = 4,
    longest_side_mm = 50,
    price_cents = 1200,
    price_postapoc_cents = 10,
    melee_accuracy = { grip = "bad", length = "hand", surface = "any", balance = "clumsy" },
}
drive:material("plastic", 1):material("aluminum", 1):tool()
drive:on_use("read_phavian_usb", ccb.content.text("Activate"), ccb.content.text("Use a laptop to access the data."))
ccb.content.add(drive)
