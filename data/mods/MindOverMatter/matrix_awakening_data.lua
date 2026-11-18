local ccb = require("ccb")
local services = ccb.services

return {
    {
        name = "biokinesis",
        trait = "BIOKINETIC",
        ability = "BIOKIN_NEEDS",
        failure_stun = 10,
        success_text = function()
            return ccb.services.translate("You gaze into the strange crystal and the light slowly grows brighter.  As it fills your vision, you become aware of the sound of your heartbeat, of the blood rushing through your veins, of the oxygen fueling your muscles.  You see the connections between them all and, only partially aware of how you're doing it, you reach out and adjust the flow.  Strength and power suddenly fill your body, and as you watch the connections with your inner eye, you see what exactly you did and you know how to do it again.  As the light from the crystal fades, leaving it dull and colorless, your vision clears.")
        end,
        failure_text = function()
            return ccb.services.translate("You gaze into the strange crystal and the light slowly grows brighter.  As it fills your vision, you become aware of the sound of your heartbeat, of the blood rushing through your veins… and then a searing headache crashes through your brain, blotting out all other sensations.  You tear your gaze away from the now-dark crystal but the pounding in your head remains.")
        end,
        effects = {
            { "effect_biokin_physical", 300 },
        },
        recipes = {
            { "biokin_physical_enhance" },
            { "biokin_overcome_pain" },
            { "biokin_breathe_skin" },
            { "biokin_dash" },
            { "biokin_flexibility" },
            { "biokin_adrenaline" },
            { "biokin_armor_skin" },
            { "biokin_climate_control" },
            { "biokin_enhance_mobility" },
            { "biokin_hammerhand" },
            { "biokin_reflex_enhance" },
            { "biokin_sealed_system" },
            { "biokin_metabolism_enhance" },
            { "biokin_combat_dance" },
            { "biokin_perfected_motion" },
            { "biokin_hurricane_blows" },
        },
        knacks = {
            { "biokin_flexibility_knack", "biokin_flexibility" },
            { "biokin_adrenaline_knack", "biokin_adrenaline" },
        },
    },
    {
        name = "clairsentience",
        trait = "CLAIRSENTIENT",
        ability = "CLAIR_SENSES",
        failure_stun = 10,
        failure_drains_first = true,
        success_text = function()
            return ccb.services.translate("You gaze into the strange crystal and the light slowly grows brighter.  You remember your childhood, before the end of the world, and then the memories diverge.  You see yourself on an aircraft carrier bridge, looking out the window as a colossal tentacle breaches the surface of the ocean; you stand in a clear white room, watching through a reinforced glass window as your colleague reanimates; you are caught up in the riots and shot by soldiers manning a road block; you are on a camping trip with friends when a nest of pig-sized wasps descend from a formerly-clear sky.  Dozens of lives in quick succession, might-have-beens and never-weres, fragments that fade even as you try to grasp each one in succession.  When the last one ends, you can see through the crystal, through your hands, through the ground.  You can see forever.")
        end,
        failure_text = function()
            return ccb.services.translate("You gaze into the strange crystal and the light slowly grows brighter.  You see yourself as you could have been, if you had taken that job, if you had sent that text, if you had moved across the country, but only for a moment before your head starts pounding.  You look down at the crystal as its light fades, but the visions do not return.")
        end,
        effects = {
            { "effect_clair_clear_sight", 60 },
        },
        recipes = {
            { "clair_better_senses" },
            { "clair_night_vision" },
            { "clair_speed_reading" },
            { "clair_danger_sense" },
            { "clair_spot_weakness" },
            { "clair_see_auras", "practice_clair_aura_sight" },
            { "clair_ranged_enhance" },
            { "clair_examine_item" },
            { "clair_sense_hostile_creatures" },
            { "clair_voyance" },
            { "clair_dodge_power" },
            { "clair_craft_bonus" },
            { "clair_see_map" },
            { "clair_perfect_shot" },
            { "clair_clear_sight" },
            { "clair_group_tactics" },
            { "clair_omniscience" },
        },
        knacks = {
            { "clair_better_senses_knack", "clair_better_senses" },
            { "clair_danger_sense_knack", "clair_danger_sense" },
            { "clair_astral_projection_knack", "clair_astral_projection" },
        },
    },
    {
        name = "electrokinesis",
        trait = "ELECTROKINETIC",
        ability = "ELECTRO_SHIELD",
        failure_stun = 10,
        success_text = function()
            return ccb.services.translate("You gaze into the strange crystal and the light slowly grows brighter.  As it fills your vision, you see thin lines beneath your skin.  They pulse with energy, bright sparks traveling to your fingers as you flex them and a burst of internal lightning when you touch the crystal with your free hand.  You raise your hand and hold up two fingers, and a thunderbolt jumps between them accompanied by a loud crackle.  Your hair stands on end as lightning travels down your arm, filling the air with the scent of ozone.  As the light from the crystal fades, leaving it dull and colorless, your skin tingles.")
        end,
        failure_text = function()
            return ccb.services.translate("You gaze into the strange crystal and the light slowly grows brighter.  As it fills your vision, your muscles tremble.  You see bursts of internal lightning traveling down your limbs for a moment, and then your muscles seize up in a sudden shower of internal sparks.  As the crystal's light fades you crash to the floor.")
        end,
        effects = {
            { "effect_electrokin_zap_enemies", 300 },
        },
        recipes = {
            { "electrokinetic_see_electric" },
            { "electrokinetic_shock_touch" },
            { "electrokinetic_zap_enemies" },
            { "electrokinetic_melee_attacks" },
            { "electrokinetic_hacking_interface" },
            { "electrokinetic_robot_interface" },
            { "electrokinetic_personal_battery" },
            { "electrokinetic_paralysis" },
            { "electrokinetic_reduce_pain" },
            { "electrokinetic_lightning_bolt" },
            { "electrokinetic_recharge_vehicle" },
            { "electrokinetic_pain_immune" },
            { "electrokinetic_speed_boost" },
            { "electrokinetic_kill_robot" },
            { "electrokinetic_lightning_aura" },
            { "electrokinetic_lightning_blast" },
            { "electrokinetic_revive" },
        },
        knacks = {
            { "electrokinetic_see_electric_knack", "electrokinetic_see_electric" },
            { "electrokinetic_pain_immune_knack", "electrokinetic_pain_immune" },
            { "electrokinetic_hacking_interface_knack", "electrokinetic_hacking_interface" },
        },
    },
    {
        name = "photokinesis",
        trait = "PHOTOKINETIC",
        ability = "PHOTO_EYES",
        failure_stun = 5,
        failure_drains_first = true,
        success_text = function()
            return ccb.services.translate("You gaze into the strange crystal and the light slowly grows brighter.  The crystal's inner light gradually intensifies, starting by revealing the hidden details of your surroundings and then unveiling the world in vivid clarity.  It's not merely light, but a gentle luminescence that emanates a tranquil warmth.  The air around you becomes suffused with a subtle, almost otherworldly radiance, as if you're witnessing a scene from a dream.  Within this radiant spectacle, subtle patterns of light perform an elegant dance, and you find yourself captivated by their graceful movements.  You reach out your free hand, allowing your fingers to interact with the delicate light which seems to respond to your thoughts, and as the crystal's glow ultimately dissipates into obscurity, you're left with a lingering sense of wonder.")
        end,
        failure_text = function()
            return ccb.services.translate("You gaze into the strange crystal and the light slowly grows brighter.  You start emanating light, but as time progresses, it hardens around your skin and tightens, causing you pain, its brightness leaving your head pounding and your eyes burning.  As the light fades you look once more into the crystal, realizing it is now dark.")
        end,
        effects = {
            { "effect_photokin_arms", 300 },
            { "effect_photokin_invisibility", 300 },
        },
        recipes = {
            { "photokinetic_light_local" },
            { "photokinetic_create_light" },
            { "photokinetic_snuff_light" },
            { "photokinetic_light_dodge" },
            { "photokinetic_light_beam" },
            { "photokinetic_camouflage" },
            { "photokinetic_rad_immunity" },
            { "photokinetic_light_arms" },
            { "photokinetic_hide_ugly" },
            { "photokinetic_flash_bang" },
            { "photokinetic_light_image" },
            { "photokinetic_radio" },
            { "photokinetic_sterilize_food" },
            { "photokinetic_stun_robots" },
            { "photokinetic_invisibility" },
            { "photokinetic_light_flash" },
            { "photokinetic_blinding_glare", "practice_photokinetic_light_blinding_glare" },
            { "photokinetic_light_disintegrate" },
            { "photokinetic_light_army" },
        },
        knacks = {
            { "photokinetic_camouflage_knack", "photokinetic_camouflage" },
            { "photokinetic_hide_ugly_knack", "photokinetic_hide_ugly" },
            { "photokinetic_radio_knack", "photokinetic_radio" },
        },
    },
    {
        name = "pyrokinesis",
        trait = "PYROKINETIC",
        ability = "PYROKIN_ADAPTATION",
        failure_stun = 10,
        failure_drains_first = true,
        success_text = function()
            return ccb.services.translate("You gaze into the strange crystal and the light slowly grows brighter.  The crystal begins glowing, the faint light at its core gradually brightening, first shedding light on your surroundings and then throwing everything into sharp relief.  As it blazes in your hands, it begins growing slowly warmer.  The warmth spreads down your arms and across your entire body, filling it with a comfortable heat, and then the air around you takes on the heat and the light.  The air wavers like a summer haze, but even as it sparks and flames dance on the air, you feel only a comfortable warmth.  You reach out your free hand, letting the fire play between your fingers, and when the crystal's glow dims and fades into nothingness, you don't even notice it.")
        end,
        failure_text = function()
            return ccb.services.translate("You gaze into the strange crystal and the light slowly grows brighter.  You feel a pleasant heat in your veins, but as you look down at your hands, the heat turns into a searing pain.  The crystal flashes once, the light drives spikes into your brain, and then goes dark.")
        end,
        effects = {
            { "effect_pyrokinetic_cloak", 300 },
            { "effect_pyrokinetic_aura", 300 },
        },
        recipes = {
            { "pyrokinetic_intensify_flames" },
            { "pyrokinetic_eruption" },
            { "pyrokinetic_flash" },
            { "pyrokinetic_cauterize" },
            { "pyrokinetic_call_flames" },
            { "pyrokinetic_quell_flames" },
            { "pyrokinetic_cloak" },
            { "pyrokinetic_lance" },
            { "pyrokinetic_flamethrower" },
            { "pyrokinetic_thermogenesis" },
            { "pyrokinetic_aura" },
            { "pyrokinetic_flame_immunity" },
            { "pyrokinetic_blast" },
            { "pyrokinetic_aoe_blast" },
            { "pyrokinetic_incineration" },
        },
        knacks = {
            { "pyrokinetic_eruption_knack", "pyrokinetic_eruption" },
            { "pyrokinetic_flash_knack", "pyrokinetic_flash" },
            { "pyrokinetic_call_flames_knack", "pyrokinetic_call_flames" },
            { "pyrokinetic_cloak_knack", "pyrokinetic_cloak" },
        },
    },
    {
        name = "telekinesis",
        trait = "TELEKINETIC",
        ability = "TELEKINETIC_GRAB_POCKETS",
        failure_stun = 10,
        failure_drains_first = true,
        suppress_in_psychic_scream = true,
        success_text = function()
            return ccb.services.translate("You gaze into the strange crystal and the light slowly grows brighter.  You release your grasp on the crystal but it doesn't fall.  It floats, supported on nothingness, and as you watch it you become aware of the connections between objects.  Gravity, attraction and repulsion, reveal themselves--you can see the weakened influence of gravity on the crystal, and with a thought you nudge it slightly.  The crystal floats up in the air, stretching the connections between it at the ground, before they adjust to its new place.  You tug on the connections, rotating the crystal, moving it from left to right, and as the light within it slowly fades away, you let go and the crystal drops back to your hand.")
        end,
        failure_text = function()
            return ccb.services.translate("You gaze into the strange crystal and the light slowly grows brighter.  It slowly rises in the air, the light pulsing gently, before it freezes in place.  The crystal suddenly starts strobing, each pulse of light a dagger in your brain, and as you grab your temples the now-dark crystal falls to the ground.")
        end,
        effects = {
            { "effect_telekinetic_armor", 60 },
        },
        recipes = {
            { "telekinetic_push" },
            { "telekinetic_pull" },
            { "telekinetic_slam_down" },
            { "telekinetic_momentum" },
            { "telekinetic_slowfall" },
            { "telekinetic_wave" },
            { "telekinetic_lifting_field" },
            { "telekinetic_strength" },
            { "telekinetic_hammer" },
            { "telekinetic_vehicle_lift" },
            { "telekinetic_shield" },
            { "telekinetic_explosion" },
            { "telekinetic_levitation" },
            { "telekinetic_aegis" },
            { "telekinetic_earthshaker" },
        },
        knacks = {
            { "telekinetic_pull_knack", "telekinetic_pull" },
            { "telekinetic_push_knack", "telekinetic_push" },
            { "telekinetic_slam_down_knack", "telekinetic_slam_down" },
            { "telekinetic_wave_knack", "telekinetic_wave" },
        },
    },
    {
        name = "telepathy",
        trait = "TELEPATH",
        ability = "TELEPATHIC_SUGGESTION",
        failure_stun = 5,
        failure_drains_first = true,
        suppress_in_psychic_scream = true,
        success_text = function()
            return ccb.services.translate("You gaze into the strange crystal and the light slowly grows brighter.  In the light, you can see yourself, standing there holding a glowing crystal, in which you can see another light and a tiny version of yourself in an endless hall of mirrors.  Time slows down--you decide to move your hand and you can feel the thought form in your brain and the signal travel through your nerves to your spine and then on your hands, and you watch as the motion finally occurs.  The light grows brighter as you stand outside yourself observing your own thoughts, and as you feel your attention being drawn to the light, you reach out, nudge your own mind, your awareness of yourself sharpens into laser focus.  As the light and the vision fades, leaving the crystal dull and nearly lifeless, you turn your full attention--FULL attention--to your next task.")
        end,
        failure_text = function()
            return ccb.services.translate("You gaze into the strange crystal and the light slowly grows brighter.  In the light, you can see yourself, standing there holding a glowing crystal, and then there's a flare of light and you close your eyes against its intensity.  Your head pounds, and when you manage to open your eyes again, the crystal is dark.")
        end,
        effects = {
            { "effect_telepathic_learning_bonus", 60 },
        },
        recipes = {
            { "telepathic_concentration" },
            { "telepathic_shield" },
            { "telepathic_mesmerize" },
            { "telepathic_morale" },
            { "telepathic_mind_sense" },
            { "telepathic_blast" },
            { "telepathic_animal_mind_control", "practice_telepathic_beastmaster" },
            { "telepathic_confusion" },
            { "telepathic_invisibility" },
            { "telepathic_fear" },
            { "telepathic_blast_radius", "practice_telepathic_scream" },
            { "telepathic_beast_taming" },
            { "telepathic_mind_control" },
            { "telepathic_network" },
        },
        knacks = {
            { "telepathic_shield_knack", "telepathic_shield" },
            { "telepathic_mind_sense_knack", "telepathic_mind_sense" },
            { "telepathic_morale_knack", "telepathic_morale" },
            { "telepathic_blast_knack", "telepathic_blast", "telepathic_mesmerize_knack" },
            { "telepathic_mesmerize_knack", "telepathic_mesmerize" },
            { "telepathic_animal_mind_control_knack", "telepathic_animal_mind_control" },
            { "telepathic_invisibility_knack", "telepathic_invisibility" },
            { "telepathic_blast_radius_knack", "telepathic_blast_radius" },
        },
    },
    {
        name = "teleportation",
        trait = "TELEPORTER",
        ability = "TELEPORTER_PROTECT",
        failure_stun = 10,
        failure_drains_first = true,
        success_text = function()
            return ccb.services.translate("You gaze into the strange crystal and the light slowly grows brighter.  As the light spreads and illuminates the surrounding terrain, the air shimmers slightly.  You can see your bedroom, in the place you've been holed up after the end of the world; you can see a city, with buildings made of greenish soapstone and people whose bodies and faces are merely indistinct shadows; you can see the cafe you always used to hang out in, empty and ruined, with the door in back thumping rhythmically as something pounds on it; you can see a point of light, floating in the midst of a starry void, and hear a reedy toneless hum.  You see the paths that link all four of these places and an infinite number of others, glowing paths that you could easy follow in directions you had never previously known existed.  The light in the crystal fades as you set one foot on a path.")
        end,
        failure_text = function()
            return ccb.services.translate("You gaze into the strange crystal and the light slowly grows brighter.  As the light spreads and illuminates the surrounding terrain, the air shimmers slightly.  Images appear, locations and times, all overlapping in a kaleidoscope of color and sound that makes your head throb.  You tear your gaze away from the now-dark crystal but the pounding in your head remains.")
        end,
        after_awakening = function(character)
            local spell = services.types.id("spell", "teleport_blink_monster")
            local cast = services.characters.cast_spell(character, spell, {
                message = ccb.services.translate("Reality suddenly warps around you and you are somewhere else!"),
            })
            if not cast.ok then
                error(cast.error.message)
            end
        end,
        recipes = {
            { "teleport_blink" },
            { "teleport_slow" },
            { "teleport_phase" },
            { "teleport_item_apport" },
            { "teleport_stride" },
            { "teleport_transpose" },
            { "teleport_displacement" },
            { "teleport_reactive_displacement" },
            { "teleport_collapse" },
            { "teleport_loci_establishment" },
            { "teleport_loci_technique" },
            { "teleport_farstep" },
            { "teleport_banish" },
            { "teleport_gateway" },
            { "teleport_relocation" },
            { "teleport_ephemeral_walk" },
            { "teleport_summon", "practice_teleport_breach" },
        },
    },
    {
        name = "vitakinesis",
        trait = "VITAKINETIC",
        ability = "VITAKINETIC_HEALTH",
        failure_stun = 10,
        failure_drains_first = true,
        success_text = function()
            return ccb.services.translate("You gaze into the strange crystal and the light slowly grows brighter.  You become aware of your skin, of every cut and bruise and scrape, of the food sitting in your stomach and the air moving in and out of your lungs.  You can feel the bits of smoke in the air from the all the fires unleashed by the Cataclysm, the bits of dirt and debris in your wounds, of the char in your food.  Not quite knowing how, you reach out and push at it, all the dirt and grime and filth of daily life in the Cataclysm, sealing it away.  You instantly feel better, like a weight you didn't realize you were carrying has been taken off your shoulders, and as the light from the crystal dims and goes dark you stand up straight.  You're going to be alright.")
        end,
        failure_text = function()
            return ccb.services.translate("You gaze into the strange crystal and the light slowly grows brighter.  In the light, you can see yourself, standing there holding a glowing crystal, and then there's a flare of light and you close your eyes against its intensity.  Your head pounds, and when you manage to open your eyes again, the crystal is dark.")
        end,
        effects = {
            { "effect_vita_health", 300 },
        },
        recipes = {
            { "vita_slow_bleeding" },
            { "vita_health_power" },
            { "vita_stop_bleeding" },
            { "vita_concentrated_healing" },
            { "vita_hurt_touch" },
            { "vita_health_power_ally", "practice_vita_healing_touch" },
            { "vita_remove_poison" },
            { "vita_cure_disease" },
            { "vita_sleeping_trance" },
            { "vita_stop_infection" },
            { "vita_increased_hp" },
            { "vita_healing_trance" },
            { "vita_attack_touch" },
            { "vita_blood_purge" },
            { "vita_no_need_for_sleep" },
            { "vita_banish_illness" },
            { "vita_super_heal" },
            { "vita_limb_restore" },
            { "vita_return_from_death" },
        },
        knacks = {
            { "vita_health_power_knack", "vita_health_power" },
            { "vita_concentrated_healing_knack", "vita_concentrated_healing" },
            { "vita_remove_poison_knack", "vita_remove_poison" },
            { "vita_cure_disease_knack", "vita_cure_disease" },
            { "vita_banish_illness_knack", "vita_banish_illness" },
        },
    },
}
