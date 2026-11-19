local ccb = require("ccb")
local services = ccb.services
local variables = services.variables
local id = services.types.id

local glands = {
    { trait = "MUTAGEN_GLAND_ALPHA", vitamin = "mutagen_alpha", threshold = "THRESH_ALPHA" },
    { trait = "MUTAGEN_GLAND_BATRACHIAN", vitamin = "mutagen_batrachian", threshold = "THRESH_BATRACHIAN" },
    { trait = "MUTAGEN_GLAND_BEAST", vitamin = "mutagen_beast", threshold = "THRESH_BEAST" },
    { trait = "MUTAGEN_GLAND_BIRD", vitamin = "mutagen_bird", threshold = "THRESH_BIRD" },
    { trait = "MUTAGEN_GLAND_CATTLE", vitamin = "mutagen_cattle", threshold = "THRESH_CATTLE" },
    { trait = "MUTAGEN_GLAND_CEPHALOPOD", vitamin = "mutagen_cephalopod", threshold = "THRESH_CEPHALOPOD" },
    { trait = "MUTAGEN_GLAND_CHIMERA", vitamin = "mutagen_chimera", threshold = "THRESH_CHIMERA" },
    { trait = "MUTAGEN_GLAND_CHIROPTERAN", vitamin = "mutagen_chiropteran", threshold = "THRESH_CHIROPTERAN" },
    { trait = "MUTAGEN_GLAND_CRUSTACEAN", vitamin = "mutagen_crustacean", threshold = "THRESH_CRUSTACEAN" },
    { trait = "MUTAGEN_GLAND_ELFA", vitamin = "mutagen_elfa", threshold = "THRESH_ELFA" },
    { trait = "MUTAGEN_GLAND_FELINE", vitamin = "mutagen_feline", threshold = "THRESH_FELINE" },
    { trait = "MUTAGEN_GLAND_FISH", vitamin = "mutagen_fish", threshold = "THRESH_FISH" },
    { trait = "MUTAGEN_GLAND_GASTROPOD", vitamin = "mutagen_gastropod", threshold = "THRESH_GASTROPOD" },
    { trait = "MUTAGEN_GLAND_INSECT", vitamin = "mutagen_insect", threshold = "THRESH_INSECT" },
    { trait = "MUTAGEN_GLAND_LAGOMORPH", vitamin = "mutagen_rabbit", threshold = "THRESH_RABBIT" },
    { trait = "MUTAGEN_GLAND_LIZARD", vitamin = "mutagen_lizard", threshold = "THRESH_LIZARD" },
    { trait = "MUTAGEN_GLAND_LUPINE", vitamin = "mutagen_lupine", threshold = "THRESH_LUPINE" },
    { trait = "MUTAGEN_GLAND_MEDICAL", vitamin = "mutagen_medical", threshold = "THRESH_MEDICAL" },
    { trait = "MUTAGEN_GLAND_MOUSE", vitamin = "mutagen_mouse", threshold = "THRESH_MOUSE" },
    { trait = "MUTAGEN_GLAND_PLANT", vitamin = "mutagen_plant", threshold = "THRESH_PLANT" },
    { trait = "MUTAGEN_GLAND_RAPTOR", vitamin = "mutagen_raptor", threshold = "THRESH_RAPTOR" },
    { trait = "MUTAGEN_GLAND_RAT", vitamin = "mutagen_rat", threshold = "THRESH_RAT" },
    { trait = "MUTAGEN_GLAND_SLIME", vitamin = "mutagen_slime", threshold = "THRESH_SLIME" },
    { trait = "MUTAGEN_GLAND_SPIDER", vitamin = "mutagen_spider", threshold = "THRESH_SPIDER" },
    { trait = "MUTAGEN_GLAND_TROGLOBITE", vitamin = "mutagen_troglobite", threshold = "THRESH_TROGLOBITE" },
    { trait = "MUTAGEN_GLAND_URSINE", vitamin = "mutagen_ursine", threshold = "THRESH_URSINE" },
}

local function checked(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function get_var_string(character, key)
    local result = checked(variables.get(character, key))
    if result.exists and type(result.value) == "string" and result.value ~= "" then
        return result.value
    end
    return nil
end

local function get_var_num(character, key)
    return checked(variables.get_number(character, key)).value or 0
end

local function set_var(character, key, value)
    checked(variables.set(character, key, value, { include_before = false }))
end

local function has_trait_id(character, trait_str)
    return checked(services.mutations.has_id_text(character, trait_str))
end

local function has_any_gland(character)
    for _, entry in ipairs(glands) do
        if has_trait_id(character, entry.trait) then
            return true
        end
    end
    return false
end

local function get_vitamin_safe(character, name)
    local vid = id("vitamin", name)
    if not vid:is_valid() then return 0 end
    return checked(services.needs.get_vitamin(character, vid))
end

local function set_vitamin_safe(character, name, target_val)
    local vid = id("vitamin", name)
    if vid:is_valid() then
        checked(services.needs.set_vitamin(character, vid, math.modf(target_val)))
    end
end

local function adjust_thirst(character, delta, max_thirst)
    local thirst = checked(services.needs.get(character)).thirst + delta
    if max_thirst ~= nil then
        thirst = math.min(max_thirst, thirst)
    end
    checked(services.needs.set(character, { thirst = math.modf(thirst) }))
end

local function add_gland_mutagen_dose(character, vit_name, amount)
    set_vitamin_safe(character, vit_name, get_vitamin_safe(character, vit_name) + amount)
    set_vitamin_safe(character, "mutagen", get_vitamin_safe(character, "mutagen") + amount)
    adjust_thirst(character, amount)
end

local function setup_gland(character)
    if not has_any_gland(character) then return end
    set_var(character, "mutations_gained", 0)
    set_var(character, "recently_mutated_cooldown", 0)
    set_var(character, "mutagen_gland_surplus", 0)
    for _, entry in ipairs(glands) do
        if has_trait_id(character, entry.trait) then
            set_var(character, "mutagen_gland_vitamin", entry.vitamin)
            set_var(character, "mutagen_gland_threshold", entry.threshold)
        end
    end
end

ccb.runtime.handler("extra_mut_scen_gland_setup_due", function(payload)
    local character = payload.character
    if not character or not character:is_valid() or get_var_num(character, "setup_gland") == 1 then
        return
    end
    setup_gland(character)
    set_var(character, "setup_gland", 1)
end)

ccb.runtime.handler("extra_mut_scen_gland_setup_ready", function(event)
    local character = event.actors.character
    if character and character:is_valid() and get_var_num(character, "setup_gland") ~= 1
        and not ccb.tasks.has_character_turn(character, "extra_mut_scen_gland_setup_due") then
        ccb.tasks.after_character_turn(character, 1, "extra_mut_scen_gland_setup_due")
    end
end)
ccb.runtime.on("character_ready", "extra_mut_scen_gland_setup_ready")

ccb.runtime.handler("extra_mut_scen_on_gains_mutation", function(event)
    local character = event.actors.character
    if not character or not character:is_valid() then return end

    local vit_name = get_var_string(character, "mutagen_gland_vitamin")
    if not has_any_gland(character) and vit_name then
        local gained = get_var_num(character, "mutations_gained")
        local surplus = get_var_num(character, "mutagen_gland_surplus")
        set_var(character, "recently_mutated_cooldown", 36 + gained)
        set_var(character, "mutations_gained", gained + 1)
        set_vitamin_safe(character, "mutagen", math.max(0, get_vitamin_safe(character, "mutagen") - surplus))
        set_vitamin_safe(character, vit_name, math.max(0, get_vitamin_safe(character, vit_name) - surplus))
        adjust_thirst(character, surplus, 400)
        set_var(character, "mutagen_gland_surplus", 0)
    end

    setup_gland(character)
end)
ccb.runtime.on("game:gains_mutation", "extra_mut_scen_on_gains_mutation")

ccb.runtime.handler("extra_mut_scen_on_threshold", function(event)
    local character = event.actors.character
    if not character or not character:is_valid() then return end
    if has_any_gland(character) or not get_var_string(character, "mutagen_gland_vitamin") then return end

    local thresh = get_var_string(character, "mutagen_gland_threshold") or ""
    if thresh ~= "" and has_trait_id(character, thresh) then
        if character.subtype == "avatar" then
            services.messages.add(services.translate("You feel as though your experimental gland will fight your body less from now on."))
        end
    else
        if character.subtype == "avatar" then
            services.messages.add(services.translate("You've somehow overcome the genetic reprogramming you were unwillingly made subject to, your gland wilting and becoming benign."))
        end
        for _, entry in ipairs(glands) do
            local mut_id = id("mutation", entry.trait)
            if mut_id:is_valid() then
                checked(services.mutations.erase(character, mut_id))
            end
        end
    end
end)
ccb.runtime.on("game:crosses_mutation_threshold", "extra_mut_scen_on_threshold")

ccb.runtime.handler("extra_mut_scen_become_mutant", function(payload)
    local character = payload.character
    if not character or not character:is_valid() then return end

    local vit_name = get_var_string(character, "mutagen_gland_vitamin")
    if not vit_name then return end

    add_gland_mutagen_dose(character, vit_name, 1)

    local cooldown = get_var_num(character, "recently_mutated_cooldown")
    if cooldown <= 0 then
        local thresh = get_var_string(character, "mutagen_gland_threshold") or ""
        local has_thresh = thresh ~= "" and has_trait_id(character, thresh)
        if services.random.native_float(0, has_thresh and 30 or 5) < 1 then
            add_gland_mutagen_dose(character, vit_name, 50)
            set_var(character, "mutagen_gland_surplus", get_var_num(character, "mutagen_gland_surplus") + 50)
        end
    else
        set_var(character, "recently_mutated_cooldown", cooldown - 1)
    end
end)
