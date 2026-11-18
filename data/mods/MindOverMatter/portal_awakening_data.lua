local ccb = require("ccb")

return {
    biokinesis = {
        success_text = function()
            return ccb.services.translate("A roar fills your mind, louder even than the screaming madness of the portal storm.  New strength and vigor suddenly fill you.  You stand up straight and tall, heedless of the wind and the kaleidoscoping sky, and clench your fists.  You feel like you could take on the world, like you could sprint for an hour without stopping, like you could wrestle one of those giant insects to the ground and pin it, like you could dodge bullets.  You unclench your fists and shake your head, but the sense of strength remains.")
        end,
        failure_text = function()
            return ccb.services.translate("A roar fills your mind, louder even than the screaming madness of the portal storm.  Your head pounds in time with the kaleidoscoping sky as your muscles begin cramping uncontrollably.  They suddenly seize up and you collapse to the ground, staring up at the sky, unable to move.")
        end,
        failure_effects = {
            { "effect_biokin_overload", 7200 },
            { "downed", 5 },
            { "motor_seizure", 5 },
        },
    },
    clairsentience = {
        success_text = function()
            return ccb.services.translate("A roar fills your mind, louder even than the screaming madness of the portal storm.  You close your eyes but you can still see--at first just a light against your eyelids, then like a train approaching the end of a tunnel, light expands and reveals your surroundings.  You can see in all directions.  You can see behind and beneath every blade of grass around you, illuminated in the storm's witchlight, for a moment until your awareness snaps back into your body and you reel back with the shock of it.  When you open your eyes again, the colors around you are brighter and the sounds are clearer than before.")
        end,
        failure_text = function()
            return ccb.services.translate("A roar fills your mind, louder even than the screaming madness of the portal storm.  Your head pounds in time with the kaleidoscoping sky as your vision wavers.  The sky grows bright, and then dark.  Sounds fade away before roaring in your ears, and then the entire world suddenly vanishes, leaving you in silent darkness.")
        end,
        failure_effects = {
            { "hallu", 10800 },
            { "blind_clair_overload", 15 },
            { "deaf_clair_overload", 15 },
        },
    },
    electrokinesis = {
        success_text = function()
            return ccb.services.translate("A roar fills your mind, louder even than the screaming madness of the portal storm.  Multi-colored lightning flashes across the sky and then freezes.  The lightning expands in your sight, until you can see individual electrons tracing their paths through the air.  You reach out a hand and some of the electrons change their path, and as the world restarts its motion the lightning crashes into you and through you to the ground.  A few sparks remain, dancing across your hand, and as you flex your fingers lightning crackles between them.")
        end,
        failure_text = function()
            return ccb.services.translate("A roar fills your mind, louder even than the screaming madness of the portal storm.  Multi-colored lightning flashes across the sky, first once and then again, then faster and faster until the thunder comes *before* the lightning.  Bolts crash into the ground around you and suddenly one strikes the ground right next to you, hurling you off your feet.")
        end,
        failure_effects = {
            { "effect_electrokin_overload", 7200 },
        },
        electro_overload = true,
    },
    photokinesis = {
        success_text = function()
            return ccb.services.translate("A roar fills your mind, louder even than the screaming madness of the portal storm.  As you stand there, a sudden warmth envelops your being, far more radiant than the most brilliant of suns.  It begins as a subtle glow deep within, and then it intensifies, growing brighter and brighter, until your entire consciousness is bathed in the incandescent brilliance.  As the light fades, you notice the world is painted in more colors than you ever noticed before, the light seems to respond to your every thought.")
        end,
        failure_text = function()
            return ccb.services.translate("A roar fills your mind, louder even than the screaming madness of the portal storm.  Your head pounds in time with the kaleidoscoping sky as your vision blurs.  Your vision is filled with light, twisting distance and making it impossible to judge your surroundings, and you fall to your knees as you struggle to resist the searing headache and disorientation of the ever-shifting light.")
        end,
        success_effects = {
            { "effect_photokin_arms", 300 },
            { "effect_photokin_invisibility", 300 },
        },
        failure_effects = {
            { "downed", 3 },
            { "effect_photokin_myopia_overload", 600 },
            { "effect_photokin_lumination_overload", 1200 },
        },
    },
    pyrokinesis = {
        success_text = function()
            return ccb.services.translate("A roar fills your mind, louder even than the screaming madness of the portal storm.  You stretch out your hand toward the shattering sky and a glow gathers around it as the air itself begins to shine.  The glow brightens and then flames arise, dancing on the open area above your palm.  You move your hand and the flames move with it, swirling around you, and with a final wave they scatter into the air.  The glow fades, but the sensation of heat remains.")
        end,
        failure_text = function()
            return ccb.services.translate("A roar fills your mind, louder even than the screaming madness of the portal storm.  Your head pounds in time with the kaleidoscoping sky as your skin prickles.  The air grows warm, then hot, and sweat springs from every pore.  The air around you takes on a lambent glow as the heat continues to rise, until your muscles give out and you collapse to your knees.")
        end,
        success_effects = {
            { "effect_pyrokinetic_cloak", 300 },
            { "effect_pyrokinetic_aura", 300 },
        },
        failure_effects = {
            { "effect_pyrokin_fever_burning", 45 },
            { "effect_pyrokin_overload", 7200 },
            { "downed", 1 },
        },
        heat_field = true,
    },
    telekinesis = {
        success_text = function()
            return ccb.services.translate("A roar fills your mind, louder even than the screaming madness of the portal storm.  You look around for shelter, but you're out in the open.  You reach down toward the ground but the ground starts rising--bits of grass and rock and dirt lifting up and swirling around you.  The roar in your head grows louder as you slowly rise off the ground, the debris around you whirling faster and faster, until your mind suddenly stills and you collapse back to the earth with a thump.  The pebbles around start to fall--but one catches your eye, and as you look at it, it stops and hovers in the air for a moment.")
        end,
        failure_text = function()
            return ccb.services.translate("A roar fills your mind, louder even than the screaming madness of the portal storm.  Your head pounds in time with the kaleidoscoping sky as you stagger.  The very air seems to press down on you, its weight growing steadily more oppressive.  Every step takes more effort than a sprint.  You concentrate on putting one foot in front of the other but it takes almost all of your concentration to do so.")
        end,
        success_effects = {
            { "effect_telekinetic_armor", 60 },
        },
        failure_effects = {
            { "effect_telekin_overload", 1800 },
            { "downed", 1 },
        },
    },
    telepathy = {
        success_text = function()
            return ccb.services.translate("A roar fills your mind, louder even than the screaming madness of the portal storm.  A babble of voices, male, female, neither, both, and some not human at all, speaking to you.  The world is rapidly dying.  The dead and the fungus and the plants will fight over what remains and there will be nothing left for humanity.  Stay out here, where realities converge and walk into a better tomorrow.  As the voices blend together, the volume rising, you reach inside your own mind somehow and twist--and are greeted with blessed silence.  Though the portal storm still rages, internally you are calm.")
        end,
        failure_text = function()
            return ccb.services.translate("A roar fills your mind, louder even than the screaming madness of the portal storm.  Your head pounds in time with the kaleidoscoping sky as whispers begin.  First only a murmur, steadily growing louder and louder until they grow into a cacophony of voices.  You hear pleas for mercy, screams of agony, cries of rage and sorrow, all mixed together in an avalanche of sound that drives you to your knees as you clutch your ears to shut them out.  It doesn't help.")
        end,
        success_effects = {
            { "effect_telepathic_mind", 60 },
        },
        failure_effects = {
            { "nightmares", 14400 },
            { "disrupted_sleep", 14400 },
            { "downed", 1 },
        },
    },
    teleportation = {
        success_text = function()
            return ccb.services.translate("A roar fills your mind, louder even than the screaming madness of the portal storm.  Reality grows thin--you can see the ground beneath your hand.  You can see the spaces between molecules, larger by far than the distances at a macro scale.  You see the paths you could take to slip between them, to traverse space in an instant without any obstacles in your path.  As the distances collapse back and reality grows solid once again, that knowledge remains with you.")
        end,
        failure_text = function()
            return ccb.services.translate("A roar fills your mind, louder even than the screaming madness of the portal storm.  Your head pounds in time with the kaleidoscoping sky as your vision wavers.  The world seems to grow far away, then close, and you stumble as your legs can't seem to tell where the ground is.  As you recover and look up, you find yourself somewhere else.")
        end,
        failure_effects = {
            { "effect_portal_storm_teleport", 20 },
            { "effect_teleporter_overload", 7200 },
            { "downed", 1 },
        },
    },
    vitakinesis = {
        success_text = function()
            return ccb.services.translate("A roar fills your mind, louder even than the screaming madness of the portal storm.  For a moment, you can feel the blood flowing in your veins, every blood cell traveling through your body on its way to your cells.  You can feel the oxygen in your lungs cross through into your blood.  The howling of the portal storm pulses in time with your heartbeat for a moment before your awareness fades, but a lingering trace of it remains in the back of your mind.")
        end,
        failure_text = function()
            return ccb.services.translate("A roar fills your mind, louder even than the screaming madness of the portal storm.  Your head pounds in time with the kaleidoscoping sky as the beating of your heart thuds in your ears.  You can feel the blood rushing through your veins, warmth slowly spreading through your body, and a sensation of heat that gets stronger and stronger until it becomes an feverish itching across your entire body, driving you to your knees.")
        end,
        failure_effects = {
            { "flu", 14400 },
            { "effect_vitakin_overload", 7200 },
            { "downed", 3 },
        },
    },
}
