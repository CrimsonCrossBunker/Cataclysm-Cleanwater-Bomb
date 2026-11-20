local ccb = require("ccb")
local services = ccb.services
local mutations = services.mutations

local function checked(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function trait(name)
    return services.types.id("mutation", name)
end

local function limb(side, part, replacements, targets)
    local prosthetics = {}
    for _, replacement in ipairs(replacements) do
        prosthetics[#prosthetics + 1] = trait(side .. "_" .. replacement)
    end
    local name = side .. "_" .. part
    local suffix = side == "LEFT" and "l" or "r"
    local parts = {}
    for index, target in ipairs(targets) do
        parts[index] = services.types.id("body_part", target .. "_" .. suffix)
    end
    return {
        name = name:lower(),
        blocker = services.types.id("effect", "prosthetic_" .. part:lower() .. "_" .. suffix .. "_fake_blocker"),
        targets = parts,
        missing = trait("NO_" .. name),
        present = trait("HAS_" .. name),
        marker = "traits_limbs_missing_" .. name:lower(),
        prosthetics = prosthetics,
    }
end

local arm_prosthetics = { "PROSTHETIC_ARM", "NEUROPROSTHETIC_ARM", "COSMETIC_PROSTHETIC_ARM" }
local leg_prosthetics = { "PROSTHETIC_LEG", "PEG_LEG" }
local arm_targets = { "arm_prosthetic", "arm_neuroprosthetic", "arm_prosthetic_cosmetic" }
local leg_targets = { "leg_prosthetic", "leg_prosthetic" }
local arms = { limb("LEFT", "ARM", arm_prosthetics, arm_targets), limb("RIGHT", "ARM", arm_prosthetics, arm_targets) }
local legs = { limb("LEFT", "LEG", leg_prosthetics, leg_targets), limb("RIGHT", "LEG", leg_prosthetics, leg_targets) }

local function has_any(character, traits)
    for _, mutation in ipairs(traits) do
        if checked(mutations.has(character, mutation)) then return true end
    end
    return false
end

local function initialize(event, limbs)
    local character = event.actors.speaker or services.characters.avatar()
    for _, part in ipairs(limbs) do
        if not checked(mutations.has(character, part.missing)) and not has_any(character, part.prosthetics) then
            checked(mutations.replace(character, part.present))
        end
    end
end

ccb.runtime.handler("initialize_arm_traits", function(event) initialize(event, arms) end)
ccb.runtime.on("game:game_begin", "initialize_arm_traits")
ccb.runtime.handler("initialize_leg_traits", function(event) initialize(event, legs) end)
ccb.runtime.on("game:game_start", "initialize_leg_traits")

local arm_mutations = {
    trait("INSECT_ARMS"), trait("INSECT_ARMS_OK"), trait("ARACHNID_ARMS"), trait("ARACHNID_ARMS_OK"),
    trait("AMORPHOUS"), trait("ARM_TENTACLES"), trait("ARM_TENTACLES_4"), trait("ARM_TENTACLES_8"),
}
local leg_mutations = {
    trait("CRAB_LEGS"), trait("GASTROPOD_FOOT"), trait("AMORPHOUS"), trait("ROOTS1"), trait("LEG_TENTACLES"),
}

local function restore(character, limbs, triggers)
    if not has_any(character, triggers) then return end
    for _, part in ipairs(limbs) do checked(mutations.erase(character, part.missing)) end
    for _, part in ipairs(limbs) do checked(mutations.replace(character, part.present)) end
    for _, part in ipairs(limbs) do
        checked(services.variables.remove(character, part.marker, { include_before = false }))
    end
end

ccb.runtime.handler("restore_mutated_limbs", function(event)
    local character = event.actors.speaker or event.actors.character or services.characters.avatar()
    restore(character, arms, arm_mutations)
    restore(character, legs, leg_mutations)
end)
ccb.runtime.on("game:gains_mutation", "restore_mutated_limbs")
ccb.runtime.on("game:evolves_mutation", "restore_mutated_limbs")

local blocker_order = { legs[2], legs[1], arms[2], arms[1] }
local one_turn = services.time.duration(1, "turn")

local function update_blocker(character, part)
    for index, prosthetic in ipairs(part.prosthetics) do
        if checked(mutations.has(character, prosthetic)) then
            checked(services.effects.add(character, part.blocker, one_turn, {
                permanent = true, body_part = part.targets[index],
            }))
            return
        end
    end
    checked(services.effects.remove(character, part.blocker))
end

for _, part in ipairs(blocker_order) do
    ccb.runtime.handler("wear_" .. part.name .. "_prosthetic", function(context)
        local character = context.character
        if checked(mutations.has(character, part.missing)) and has_any(character, part.prosthetics) then
            checked(mutations.erase(character, part.missing))
            checked(services.variables.set(character, part.marker, "yes", { include_before = false }))
        end
        for _, limb_part in ipairs(blocker_order) do update_blocker(character, limb_part) end
    end)

    local due = "check_missing_" .. part.name
    ccb.runtime.handler(due, function(context)
        local character = context.character
        if not has_any(character, part.prosthetics)
            and checked(services.variables.get_string(character, part.marker)).value == "yes" then
            checked(mutations.replace(character, part.missing))
        end
        ccb.tasks.after_character_turn(character, 5, due)
    end)
end

ccb.runtime.handler("schedule_missing_limbs", function(event)
    local character = event.actors.character
    for _, part in ipairs(blocker_order) do
        local due = "check_missing_" .. part.name
        if not ccb.tasks.has_character_turn(character, due) then
            ccb.tasks.after_character_turn(character, 5, due)
        end
    end
end)
ccb.runtime.on("character_ready", "schedule_missing_limbs")
