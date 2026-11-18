local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local id = services.types.id
local training = require("psychic_training")

local radiation_study = "psi_research_rad_powers"

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function message(character, text, severity)
    if character.subtype == "avatar" then
        services.messages.add(text, severity or "neutral")
    end
end

local function batch(handler, complete)
    ccb.runtime.handler(handler, function(craft)
        for _ = 1, craft.batch do
            complete(craft.character)
        end
    end, 1)
end

local function has_trait(character, trait)
    return checked(services.mutations.has_id_text(character, trait))
end

local function skill(character, key)
    return checked(services.skills.level(character, key))
end

local function meets_powers(character, groups)
    for _, group in ipairs(groups) do
        local met = false
        for _, threshold in ipairs(group) do
            if checked(services.spells.effective_level(character, threshold[1])) >= threshold[2] then
                met = true
                break
            end
        end
        if not met then
            return false
        end
    end
    return true
end

local function passes(character, name, difficulty)
    return services.random.native_int(1, 10) + skill(character, name) > difficulty
end

local function add_effect(character, effect, duration, unit)
    checked(services.effects.add(character, id("effect", effect), services.time.duration(duration, unit)))
end

local function learn_recipe(character, recipe)
    checked(services.recipes.learn(character, id("recipe", recipe)))
end

local function forget_recipe(character, recipe)
    checked(services.recipes.forget(character, id("recipe", recipe)))
end

local function meditation(character, multiplier)
    local attunement = training.attunement(character)
    local cost = 2 + skill(character, "metaphysics") * multiplier
    if attunement < cost then
        message(character, ccb.services.translate("After your meditations, your mind is free and clear.  The odd feelings caused by excessive psionic channeling have entirely left you."), "good")
    end
    training.set_attunement(character, math.max(attunement - cost, 0))
end

batch("finish_grounding_meditation", function(character)
    meditation(character, 2)
    checked(services.effects.remove(character, id("effect", "effect_noetic_resilience")))
    add_effect(character, "effect_noetic_resilience", 30, "minute")
end)

batch("finish_incandescent_meditation", function(character)
    meditation(character, 3)
end)

batch("finish_matrix_drain", function(character)
    message(character, ccb.services.translate("You channel all of your powers into the drained matrix crystal in your hands.  As you do, the faint light in its depths grows steadily brighter and the crystal begins to feel warm in your hands.  Suddenly, the crystal shatters…and with it, the strange feelings caused by using your powers vanish."))
    training.set_attunement(character, 0)
    checked(services.inventory.receive_item(character, id("item", "matrix_crystal_drained_dust"), 10))
    add_effect(character, "effect_noetic_resilience", 24, "hour")
end)

batch("finish_phavian_documents", function(character)
    if has_trait(character, "VITAKINETIC") or has_trait(character, "CLAIRSENTIENT") then
        learn_recipe(character, "psi_research_rad_powers_clair")
        learn_recipe(character, "psi_research_rad_powers_vita")
        message(character, ccb.services.translate("There's a lot here, but you've discovered that it's organized into two main tracks.  One has a lot of detailed scans of the body and health data and is labeled HONEY BRAVO, and the other has a series of photos that seem oddly distorted, charts with some kind of waveforms on them, and other documents and is labeled RED SAFARI."))
    else
        message(character, ccb.services.translate("You can understand the technical principles but the actual processes make no sense.  It must be some aspect of psionics that you don't possess or don't fully grasp."), "bad")
    end
end)

local function radiation_protocol(character, difficulty, groups, spell, recipe, summary, focus_first)
    local success = passes(character, "metaphysics", difficulty) and passes(character, "chemistry", 8)
        and meets_powers(character, groups)
    if success then
        message(character, summary, "good")
        checked(services.progression.grant_random_missing(character, "spell", { id("spell", spell) }))
        if not focus_first then
            learn_recipe(character, recipe)
        end
    else
        message(character, ccb.services.translate("There's a lot here.  Maybe you didn't understand it, or maybe your powers aren't advanced enough.  You'll need to try again."), "bad")
    end
    training.spend_focus(character)
    if success and focus_first then
        learn_recipe(character, recipe)
    end
    forget_recipe(character, radiation_study)
end

batch("finish_red_safari_research", function(character)
    radiation_protocol(character, 10, {
        { { "clair_spot_weakness", 6 } },
        { { "clair_danger_sense", 8 } },
        { { "clair_voyance", 5 } },
    }, "clair_sense_rads", "practice_clair_sense_rads",
        ccb.services.translate("This would have been so much easier if you had an actual tutor, but you finally understand.  All the documents, the videos, the reports, they're trying document a method of using clairsentience to detect radiation.  And you're pretty sure you can do it now."),
        false)
end)

batch("finish_honey_bravo_research", function(character)
    radiation_protocol(character, 11, {
        { { "vita_concentrated_healing", 8 } },
        { { "vita_stop_infection", 6 } },
        { { "vita_healing_trance", 2 } },
    }, "vita_purge_rads", "practice_vita_purge_rads",
        ccb.services.translate("This would have been so much easier if you had an actual tutor, but you finally understand.  All the documents, the videos, the reports, they're trying document a method of using vitakinesis to cure radiation poisoning.  And you're pretty sure you can do it now."),
        true)
end)

local function grant_trait(character, trait)
    checked(services.mutations.replace(character, id("mutation", trait)))
end

local function award(achievement)
    checked(services.achievements.complete(id("achievement", achievement)))
end

local function channeling_research(character, difficulty, trait, achievement, recipe, success, failure, failed_effect)
    local die = services.random.native_int(1, 10)
    local check = skill(character, "metaphysics")
    for _, proficiency in ipairs { "prof_psionic_ritual", "prof_psionic_basic" } do
        if checked(services.proficiencies.has_id_text(character, proficiency)) then
            check = check + 1
        end
    end
    if die + check > difficulty then
        message(character, success, "good")
        grant_trait(character, trait)
        award(achievement)
        forget_recipe(character, recipe)
    else
        message(character, failure, "bad")
        if failed_effect then
            add_effect(character, failed_effect, 24, "hour")
        end
    end
    training.spend_focus(character)
end

batch("finish_extended_channeling", function(character)
    channeling_research(character, 9, "PSI_EXTENDED_CHANNELING", "mom_learn_extended_channeling",
        "psi_research_extended_channeling",
        ccb.services.translate("You've figured it out.  The concept of \"taking more time\" wasn't exactly hard to grasp, but maintaining the images in your mind, keeping your focus on a single train of thought, that was harder.  Now you've got it down, though.  If you take meticulous care in channeling your powers, it will take much longer but you'll be more likely to succeed."),
        ccb.services.translate("There's just something you're not grasping.  You need more practice before you can get it down."))
end)

batch("finish_torrential_channeling", function(character)
    channeling_research(character, 15, "PSI_TORRENTIAL_CHANNELING", "mom_learn_torrential_channeling",
        "psi_research_torrential_channeling",
        ccb.services.translate("You've figured it out.  Your first few attempts were overwhelming, a raging crush of power than nearly knocked you unconscious…or perhaps worse.  But after you recovered, you tried again, and again, and you gained more and more control over the flood and now you can tame its flow.  Mostly."),
        ccb.services.translate("There's just something you're not grasping.  You need more practice before you can get it down…but you might want to wait.  The flow of Nether energy hasn't completely stopped."),
        "effect_nether_attunement_raiser")
end)

batch("finish_verdant_hand", function(character)
    if not meets_powers(character, {
        { { "biokin_physical_enhance", 8 }, { "biokin_reflex_enhance", 8 }, { "biokin_combat_dance", 5 } },
        { { "biokin_dash", 8 }, { "biokin_flexibility", 8 }, { "biokin_adrenaline", 8 }, { "biokin_perfected_motion", 4 } },
        { { "biokin_overcome_pain", 5 } },
        { { "biokin_armor_skin", 7 }, { "biokin_enhance_mobility", 6 } },
    }) then
        message(character, ccb.services.translate("Your mastery of biokinesis isn't deep enough to succeed.  You'll need to develop your powers and try again."))
    elseif passes(character, "unarmed", 13)
        and passes(character, "metaphysics", 10) then
        message(character, ccb.services.translate("You've done it.  After long effort, you've mastered the VERDANT HAND protocols.  Bring on the zombies; you'll smash them to pieces with your fists."), "good")
        grant_trait(character, "VERDANT_HAND_PROTOCOLS")
        award("mom_learn_verdant_hand_protocols")
    else
        message(character, ccb.services.translate("You just couldn't master the forms and the meditations eluded you.  You'll need to try again."), "bad")
    end
    training.add_attunement(character, services.random.native_float(10, 30))
    training.spend_focus(character)
end)

batch("finish_turquoise_keystone", function(character)
    if not meets_powers(character, {
        { { "teleport_blink", 12 }, { "teleport_phase", 8 } },
        { { "teleport_stride", 8 }, { "teleport_collapse", 6 } },
        { { "teleport_ephemeral_walk", 7 } },
        { { "teleport_warped_strikes", 6 } },
    }) then
        message(character, ccb.services.translate("Your mastery of teleportation isn't deep enough to succeed.  You'll need to develop your powers and try again."))
    elseif (passes(character, "unarmed", 13) or passes(character, "melee", 13))
        and passes(character, "metaphysics", 15) then
        message(character, ccb.services.translate("You've done it.  After long effort, you've mastered the TURQUOISE KEYSTONE protocols.  Your enemies will never be able to stop your blows now."), "good")
        checked(services.spells.set_level(character, id("spell", "teleport_warper_combat"), 1))
        award("mom_learn_flicker_flash_stance")
        learn_recipe(character, "practice_teleport_warper_combat")
    else
        message(character, ccb.services.translate("You just couldn't master the forms and the meditations eluded you.  You'll need to try again."), "bad")
    end
    training.add_attunement(character, services.random.native_float(50, 100))
    training.spend_focus(character)
end)

batch("finish_emerald_vanguard", function(character)
    if not meets_powers(character, {
        { { "biokin_vitaminosis", 10 } },
        { { "biokin_armor_skin", 8 }, { "biokin_flexibility", 6 } },
        { { "biokin_metabolism_enhance", 7 } },
        { { "biokin_reflex_enhance", 5 } },
    }) then
        message(character, ccb.services.translate("Your mastery of biokinesis isn't deep enough to succeed.  You'll need to develop your powers and try again."))
    elseif passes(character, "metaphysics", 15) then
        message(character, ccb.services.translate("You've done it.  After long effort, you've mastered the EMERALD VANGUARD techniques.  Any changes to your body are now under your control."), "good")
        checked(services.spells.set_level(character, id("spell", "biokin_guided_evolution"), 1))
        award("mom_learn_guided_evolution")
        learn_recipe(character, "practice_biokin_guided_evolution")
    else
        message(character, ccb.services.translate("You just couldn't master the techniques and the meditations eluded you.  You'll need to try again."), "bad")
    end
    training.add_attunement(character, services.random.native_float(50, 100))
    training.spend_focus(character)
end)

content.add(content.Recipe {
    id = "psi_centering_meditation_drain_reduce",
    name = ccb.content.text("grounding meditation"),
    description = ccb.content.text("Through practice, you've learned how to calm and focus yourself during meditation.  If you meditated properly, you could channel the additional nether energy you have accumulated out into your surroundings, though doing so will be extremely tiring.  It will also help shield you from nether energies for a short time afterwards."),
    category = "CC_PSIONIC",
    subcategory = "CSC_PSIONIC_OTHER",
    skill = "metaphysics",
    difficulty = 2,
    duration_moves = 90000,
    activity_level = 6,
    flags = { "SECRET", "BLIND_EASY", "NO_MANIP", "AFFECTED_BY_PAIN", "NO_BENCH", "NO_ENCHANTMENT" },
    scripted_output = true,
}:proficiency("prof_psionic_minimum_requirements", { required = true })
    :on_complete("finish_grounding_meditation"))

content.add(content.Recipe {
    id = "psi_centering_meditation_drain_reduce_heart_of_fire",
    name = ccb.content.text("incandescent meditation"),
    description = ccb.content.text("By gazing into the flames, you can reduce your exposure to the energies of the Nether."),
    category = "CC_PSIONIC",
    subcategory = "CSC_PSIONIC_OTHER",
    skill = "metaphysics",
    difficulty = 0,
    duration_moves = 120000,
    activity_level = 8,
    flags = { "SECRET", "NO_MANIP", "AFFECTED_BY_PAIN", "NO_BENCH", "NO_ENCHANTMENT" },
    scripted_output = true,
}:tool("fire", 1)
    :on_complete("finish_incandescent_meditation"))

content.add(content.Recipe {
    id = "psi_matrix_channeling_drain_reduce",
    name = ccb.content.text("channeling protocol PGS38"),
    description = ccb.content.text("That report indicated there was a way to channel the additional nether energy from long-term psionic use into a focusing object.  All you need is a drained matrix crystal and time."),
    category = "CC_PSIONIC",
    subcategory = "CSC_PSIONIC_OTHER",
    skill = "metaphysics",
    difficulty = 7,
    duration_moves = 360000,
    activity_level = 4,
    flags = { "SECRET", "BLIND_HARD" },
    scripted_output = true,
}:book("phavian_report_psionic_drain", 5)
    :component("matrix_crystal_drained", 1)
    :proficiency("prof_psionic_minimum_requirements", { required = true })
    :proficiency("prof_psionic_basic", { required = true })
    :proficiency("prof_psionic_containment", { required = false })
    :on_complete("finish_matrix_drain"))

content.add(content.Recipe {
    id = "psi_research_rad_powers",
    name = ccb.content.text("study the Phavian USB documents"),
    description = ccb.content.text("Study the plethora of documents and files found on the Project PHAVIAN USB.  It has something to do with radiation; beyond that, you're not sure."),
    category = "CC_PSIONIC",
    subcategory = "CSC_PSIONIC_OTHER",
    skill = "chemistry",
    difficulty = 4,
    duration_moves = 720000,
    activity_level = 2,
    flags = { "SECRET", "BLIND_HARD" },
    scripted_output = true,
}:tool("laptop", 1)
    :tool("psi_usb_rad_recipes", 1)
    :on_complete("finish_phavian_documents"))

content.add(content.Recipe {
    id = "psi_research_rad_powers_clair",
    name = ccb.content.text("study the RED SAFARI documents"),
    description = ccb.content.text("Study the plethora of documents and files found on the Project PHAVIAN USB relating to RED SAFARI.  It has something to do with radiation detection; beyond that, you're not sure."),
    category = "CC_PSIONIC",
    subcategory = "CSC_PSIONIC_OTHER",
    skill = "chemistry",
    difficulty = 6,
    duration_moves = 4320000,
    activity_level = 2,
    flags = { "SECRET", "BLIND_HARD" },
    scripted_output = true,
}:tool("laptop", 1)
    :tool("psi_usb_rad_recipes", 1)
    :tool_any { { id = "betavoltaic", count = 1 }, { id = "huge_atomic_battery_cell", count = 1 } }
    :proficiency("prof_intro_chemistry", { required = false })
    :proficiency("prof_intro_biology", { required = false })
    :proficiency("prof_psionic_minimum_requirements", { required = true })
    :proficiency("prof_psionic_basic", { required = true })
    :proficiency("prof_psionic_ritual", { required = false })
    :on_complete("finish_red_safari_research"))

content.add(content.Recipe {
    id = "psi_research_rad_powers_vita",
    name = ccb.content.text("study the HONEY BRAVO documents"),
    description = ccb.content.text("Study the plethora of documents and files found on the Project PHAVIAN USB relating to HONEY BRAVO.  It has something to do with radiation treatment; beyond that, you're not sure."),
    category = "CC_PSIONIC",
    subcategory = "CSC_PSIONIC_OTHER",
    skill = "chemistry",
    difficulty = 6,
    duration_moves = 5760000,
    activity_level = 2,
    flags = { "SECRET", "BLIND_HARD" },
    scripted_output = true,
}:tool("laptop", 1)
    :tool("psi_usb_rad_recipes", 1)
    :tool_any { { id = "betavoltaic", count = 1 }, { id = "huge_atomic_battery_cell", count = 1 } }
    :proficiency("prof_intro_chemistry", { required = false })
    :proficiency("prof_intro_biology", { required = false })
    :proficiency("prof_pharmaceutical", { required = false })
    :proficiency("prof_psionic_minimum_requirements", { required = true })
    :proficiency("prof_psionic_basic", { required = true })
    :proficiency("prof_psionic_ritual", { required = false })
    :on_complete("finish_honey_bravo_research"))

content.add(content.Recipe {
    id = "psi_research_extended_channeling",
    name = ccb.content.text("research extended channeling"),
    description = ccb.content.text("There has to be an easier way of evoking your powers than frantically concentrating and trying to get the energies out.  Maybe if you took more time, you wouldn't have to concentrate so hard?  It wouldn't help you when a zombie was trying to eat you but it would definitely be useful otherwise."),
    category = "CC_PSIONIC",
    subcategory = "CSC_PSIONIC_OTHER",
    skill = "metaphysics",
    difficulty = 1,
    duration_moves = 2160000,
    activity_level = 4,
    flags = { "SECRET", "BLIND_EASY", "NO_MANIP", "AFFECTED_BY_PAIN", "NO_BENCH", "NO_ENCHANTMENT" },
    scripted_output = true,
}:proficiency("prof_psionic_basic", { required = false })
    :proficiency("prof_psionic_ritual", { required = false })
    :on_complete("finish_extended_channeling"))

content.add(content.Recipe {
    id = "psi_research_torrential_channeling",
    name = ccb.content.text("research torrential channeling"),
    description = ccb.content.text("You have more of an understanding of the way the Nether ebbs and flows, sometimes surging forth like a flood when you least expect it.  There has to be a way to direct that more purposefully, to call forth more energy than you need and direct it into your powers instead of letting it wash over you.  It might be risky, sure, but you need every edge you can get in this post-Cataclysmic world."),
    category = "CC_PSIONIC",
    subcategory = "CSC_PSIONIC_OTHER",
    skill = "metaphysics",
    difficulty = 3,
    duration_moves = 5040000,
    activity_level = 4,
    flags = { "SECRET", "BLIND_EASY", "NO_MANIP", "AFFECTED_BY_PAIN", "NO_BENCH", "NO_ENCHANTMENT" },
    scripted_output = true,
}:proficiency("prof_psionic_basic", { required = false })
    :proficiency("prof_psionic_ritual", { required = false })
    :on_complete("finish_torrential_channeling"))

content.add(content.Recipe {
    id = "learn_psionic_combat",
    name = ccb.content.text("study VERDANT HAND combat protocols"),
    description = ccb.content.text("Study and attempt to internalize the practices in the VERDANT HAND Combat Protocol training manual.  There's a lot in there; it may take you more than one attempt to understand it."),
    category = "CC_PSIONIC",
    subcategory = "CSC_PSIONIC_RITUALS",
    skill = "unarmed",
    difficulty = 5,
    duration_moves = 1800000,
    activity_level = 2,
    flags = { "SECRET", "BLIND_HARD" },
    scripted_output = true,
}:book("phavian_psionic_martial_power_book", 5)
    :proficiency("prof_psionic_basic", { required = true })
    :proficiency("prof_psionic_ritual", { required = false })
    :proficiency("prof_psionic_containment", { required = false })
    :proficiency("prof_psionic_minimum_requirements_biokinesis", { required = true })
    :on_complete("finish_verdant_hand"))

content.add(content.Recipe {
    id = "learn_psionic_teleportation_warp_combat",
    name = ccb.content.text("study Proposal: TURQUOISE KEYSTONE"),
    description = ccb.content.text("Study and attempt to internalize the practices in the Proposal: TURQUOISE KEYSTONE document.  This seems extremely complex and demanding; it may take you more than one attempt to understand it."),
    category = "CC_PSIONIC",
    subcategory = "CSC_PSIONIC_RITUALS",
    skill = "metaphysics",
    difficulty = 8,
    duration_moves = 2880000,
    activity_level = 2,
    flags = { "SECRET", "BLIND_HARD" },
    scripted_output = true,
}:book("phavian_psionic_teleportation_combat_book", 8)
    :proficiency("prof_psionic_basic", { required = true })
    :proficiency("prof_psionic_ritual", { required = true })
    :proficiency("prof_psionic_containment", { required = false })
    :proficiency("prof_psionic_minimum_requirements_teleportation", { required = true })
    :on_complete("finish_turquoise_keystone"))

content.add(content.Recipe {
    id = "learn_psionic_mutation_control_power",
    name = ccb.content.text("study Progress Report: EMERALD VANGUARD"),
    description = ccb.content.text("Study and attempt to internalize the practices in the EMERALD VANGUARD progress report.  This seems extremely complex and demanding; it may take you more than one attempt to understand it."),
    category = "CC_PSIONIC",
    subcategory = "CSC_PSIONIC_RITUALS",
    skill = "metaphysics",
    difficulty = 8,
    duration_moves = 2880000,
    activity_level = 2,
    flags = { "SECRET", "BLIND_HARD" },
    scripted_output = true,
}:book("phavian_psionic_control_mutations_book", 8)
    :proficiency("prof_psionic_basic", { required = true })
    :proficiency("prof_psionic_ritual", { required = true })
    :proficiency("prof_psionic_containment", { required = false })
    :proficiency("prof_psionic_minimum_requirements_biokinesis", { required = true })
    :on_complete("finish_emerald_vanguard"))
