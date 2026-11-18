local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local id = services.types.id

local knacks_only = content.is_mod_active("mom_knacks_only")
local disciplines = {
    "BIOKINETIC", "CLAIRSENTIENT", "PHOTOKINETIC", "PYROKINETIC",
    "TELEKINETIC", "TELEPATH", "TELEPORTER", "VITAKINETIC",
}

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function has_trait(character, trait)
    return character.subtype ~= "monster" and checked(services.mutations.has_id_text(character, trait))
end

local function already_psionic(character)
    for _, discipline in ipairs(disciplines) do
        if has_trait(character, discipline) then
            return true
        end
    end
    return false
end

local function overload(character)
    local result = services.effects.add(character, id("effect", "psionic_overload"),
        services.time.duration(30, "minute"), { body_part = id("body_part", "head") })
    if not result.ok and result.error.code ~= "rejected" then
        checked(result)
    end
end

local function assess_potential(subject)
    if has_trait(subject, "CANNOT_GAIN_PSIONICS") then
        return -100
    end
    if knacks_only then
        return 100
    end
    local progress = checked(services.variables.get_number(subject, "awakening_countup")).value or 0
    local modifier = subject.subtype ~= "monster"
        and checked(services.characters.enchantment_value(subject, "awakening_odds_traits_mod", 0)) or 0
    return 100 - 100 * math.exp(1) ^ ((progress - math.max(modifier * 0.75, 0)) / -1.7)
end

local function scan(character)
    if character.subtype ~= "avatar" or not services.interaction.confirm(
        ccb.services.translate("Do you wish to test someone else?")) then
        return character
    end
    local center = checked(services.creatures.snapshot(character)).position
    local picked = services.targeting.choose_adjacent_where_at(center,
        ccb.services.translate("Select noetic testing target"), "")
    if not picked then
        return nil
    end
    local creature = services.creatures.at(picked, false)
    if not creature.ok and creature.error.code == "not_found" then
        return nil
    end
    return checked(creature)
end

local function report(subject)
    if not subject then
        services.messages.add(ccb.services.translate("The machine requires a test subject to report any results."), "neutral")
        return
    end
    local psionic = already_psionic(subject)
    if has_trait(subject, "ALWAYS_GAIN_PSIONICS") then
        services.messages.add(ccb.services.translate("The lights inside in the machine blink and swirl for what seems like forever until the machine beeps.  On the output screen, the words \"<color_magenta>Potential: Excellent.  Mathematician Target</color>\" are visible."), "neutral")
        overload(subject)
    end
    local potential = assess_potential(subject)
    if potential == -100 then
        services.messages.add(ccb.services.translate("The lights inside in the machine blink and swirl for what seems like forever until the machine beeps.  On the output screen, the words \"<color_light_red>Potential: Null</color>\" are visible."), "neutral")
    elseif potential >= 0 and potential <= 5 then
        services.messages.add(ccb.services.translate("The lights inside in the machine blink and swirl for what seems like forever until the machine beeps.  On the output screen, the words \"<color_light_red>Potential: Negligible</color>\" are visible."), "neutral")
    elseif potential > 5 and potential <= 15 then
        services.messages.add(ccb.services.translate("The lights inside in the machine blink and swirl for what seems like forever until the machine beeps.  On the output screen, the words \"<color_yellow>Potential: Minor</color>\" are visible."), "neutral")
    elseif potential > 15 and potential <= 45 then
        services.messages.add(ccb.services.translate("The lights inside in the machine blink and swirl for what seems like forever until the machine beeps.  On the output screen, the words \"<color_light_green>Potential: Moderate</color>\" are visible."), "neutral")
    elseif potential > 45 and potential <= 99 then
        services.messages.add(ccb.services.translate("The lights inside in the machine blink and swirl for what seems like forever until the machine beeps.  On the output screen, the words \"<color_light_blue>Potential: Good</color>\" are visible."), "neutral")
    end
    if psionic then
        services.messages.add(ccb.services.translate("Below it in red are the words: <color_light_red>WARNING: Noetic activity detected."), "neutral")
        overload(subject)
    elseif not has_trait(subject, "CANNOT_GAIN_PSIONICS") then
        overload(subject)
    end
end

ccb.runtime.handler("finish_noetic_resonance_scan", function(craft)
    for _ = 1, craft.batch do
        report(scan(craft.character))
    end
end, 1)

content.add(content.Recipe {
    id = "psi_noetic_resonance_detector_usage",
    name = ccb.content.text("use the noetic resonance detector"),
    description = ccb.content.text("Follow the usage instructions of the noetic resonance detector to determine your \"noetic potential\"."),
    category = "CC_PSIONIC",
    subcategory = "CSC_PSIONIC_OTHER",
    skill = "computer",
    difficulty = 3,
    duration_moves = 180000,
    activity_level = 2,
    flags = { "SECRET", "BLIND_HARD" },
    scripted_output = true,
}:requires_skill("metaphysics", 3)
    :book("phavian_noetic_resonance_detector_instructions", 3)
    :proficiency("prof_matrix_technology_beginner", { required = false })
    :tool_charges("psi_noetic_resonance_detector_tool", 500)
    :on_complete("finish_noetic_resonance_scan"))
