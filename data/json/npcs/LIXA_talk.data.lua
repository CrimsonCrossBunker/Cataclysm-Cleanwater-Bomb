local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "LIXA_presentation_computer_main",
    line = ccb.content.text("&This computer is somehow still powered; an alarming buzz emanates from its wall plug.  The desktop is cluttered with dozens of unsorted powerpoint files.  After some investigation, you find one labeled \"LAYMAN BRIEFING\"."),
    replies = {
        { text = ccb.content.text("Open LAYMAN BRIEFING."), next_topic = "LIXA_LAYMAN_BRIEFING" },
        { text = ccb.content.text("Leave."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "LIXA_LAYMAN_BRIEFING",
    line = ccb.content.text("&The screen bears the letters LIXA in big bold font.  Underneath it, in smaller letters, are the words \"Laser Interferometer eXospatial resonance Array\".  The slides are neatly tabulated under grouped headers down the side."),
    replies = {
        { text = ccb.content.text("\"What is LIXA?\""), next_topic = "LIXA_briefing_1" },
        {
            text = ccb.content.text("\"LIGO and spatial compression.\""),
            next_topic = "LIXA_briefing_2",
        },
        {
            text = ccb.content.text("\"What is laser interferometry?\""),
            next_topic = "LIXA_briefing_3a",
        },
        { text = ccb.content.text("\"How does LIXA work?\""), next_topic = "LIXA_briefing_4" },
        {
            text = ccb.content.text("\"But what are we measuring???\""),
            next_topic = "LIXA_briefing_5",
        },
        { text = ccb.content.text("\"LIXA funding.\""), next_topic = "LIXA_briefing_6" },
        { text = ccb.content.text("Close the presentation."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "LIXA_briefing_1",
    line = ccb.content.text("LIXA, or 'Liza' as we like to call her, is the forefront of exospatial research.  It has been confirmed that matter from our local n-space (the 4d coordinates in which we exist) can transit through exodimensions.  But it cannot do it safely!  To understand the behavior of exospace, we must first learn about how it works."),
    replies = {
        { text = ccb.content.text("Title slide."), next_topic = "LIXA_LAYMAN_BRIEFING" },
        {
            text = ccb.content.text("\"LIGO and spatial compression.\""),
            next_topic = "LIXA_briefing_2",
        },
        {
            text = ccb.content.text("\"What is laser interferometry?\""),
            next_topic = "LIXA_briefing_3a",
        },
        { text = ccb.content.text("\"How does LIXA work?\""), next_topic = "LIXA_briefing_4" },
        {
            text = ccb.content.text("\"But what are we measuring???\""),
            next_topic = "LIXA_briefing_5",
        },
        { text = ccb.content.text("\"LIXA funding.\""), next_topic = "LIXA_briefing_6" },
        { text = ccb.content.text("Close the presentation."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "LIXA_briefing_2",
    line = ccb.content.text("LIXA is based off a proposition for a device called LIGO (Laser Interferometer Gravitational wave Observatory).  It was originally designed to confirm the existence of Gravitational Waves, a spreading distortion in spacetime caused by ultramassive events.  The design has been repurposed for the exciting field of exospatial research, where we already know we can find spatial distortions!"),
    replies = {
        { text = ccb.content.text("Title slide."), next_topic = "LIXA_LAYMAN_BRIEFING" },
        { text = ccb.content.text("\"What is LIXA?\""), next_topic = "LIXA_briefing_1" },
        {
            text = ccb.content.text("\"What is laser interferometry?\""),
            next_topic = "LIXA_briefing_3a",
        },
        { text = ccb.content.text("\"How does LIXA work?\""), next_topic = "LIXA_briefing_4" },
        {
            text = ccb.content.text("\"But what are we measuring???\""),
            next_topic = "LIXA_briefing_5",
        },
        { text = ccb.content.text("\"LIXA funding.\""), next_topic = "LIXA_briefing_6" },
        { text = ccb.content.text("Close the presentation."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "LIXA_briefing_3a",
    line = ccb.content.text("&\"Laser interferometry is the technique LIXA uses to measure changes in local exospace.  The principle is simple!  A laser is directed down a long, vacuum-sealed chamber for an exact multiple of its wavelength.  It strikes a mirror and returns down another chamber.  If the spacetime through which the laser moved has not changed, the waveforms will be IN PHASE, and the signal will be at full amplitude!\"  Here there is a diagram of two waves, with peaks at the same places, and a third wave beneath them."),
    replies = {
        {
            text = ccb.content.text("The next slide is titled \"But what if?\""),
            next_topic = "LIXA_briefing_3b",
        },
        { text = ccb.content.text("Title slide."), next_topic = "LIXA_LAYMAN_BRIEFING" },
        { text = ccb.content.text("\"What is LIXA?\""), next_topic = "LIXA_briefing_1" },
        {
            text = ccb.content.text("\"LIGO and spatial compression.\""),
            next_topic = "LIXA_briefing_2",
        },
        { text = ccb.content.text("\"How does LIXA work?\""), next_topic = "LIXA_briefing_4" },
        {
            text = ccb.content.text("\"But what are we measuring???\""),
            next_topic = "LIXA_briefing_5",
        },
        { text = ccb.content.text("\"LIXA funding.\""), next_topic = "LIXA_briefing_6" },
        { text = ccb.content.text("Close the presentation."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "LIXA_briefing_3b",
    line = ccb.content.text("&\"BUT, if the spacetime through which the laser has distorted with effects parallel to the beam, the waveforms will be OUT OF PHASE, and the signal amplitude will be lower than normal!\"  There is a diagram of two waves which do not synch up, and a third wave underneath it that is smaller than either of them."),
    replies = {
        {
            text = ccb.content.text("\"What is laser interferometry?\""),
            next_topic = "LIXA_briefing_3a",
        },
        { text = ccb.content.text("Title slide."), next_topic = "LIXA_LAYMAN_BRIEFING" },
        { text = ccb.content.text("\"What is LIXA?\""), next_topic = "LIXA_briefing_1" },
        {
            text = ccb.content.text("\"LIGO and spatial compression.\""),
            next_topic = "LIXA_briefing_2",
        },
        { text = ccb.content.text("\"How does LIXA work?\""), next_topic = "LIXA_briefing_4" },
        {
            text = ccb.content.text("\"But what are we measuring???\""),
            next_topic = "LIXA_briefing_5",
        },
        { text = ccb.content.text("\"LIXA funding.\""), next_topic = "LIXA_briefing_6" },
        { text = ccb.content.text("Close the presentation."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "LIXA_briefing_4",
    line = ccb.content.text("LIXA works using the principle of LOCAL EXODIMENSIONAL FLUX, the phenomenon in which ambient spacetime around exospatial breaches moves through the 'portal'.  LIXA is equipped with several LOCAL DIMENSIONAL COMPRESSORS.  These devices turn 'portals' on and off hundreds of times a second, which results in the FLUX repeatedly drawing tiny segments of our local n-space into exospace.  This creates a compression effect, 'storing' an enormous amount of 4d-space in those segments in the neighboring exospace."),
    replies = {
        { text = ccb.content.text("Title slide."), next_topic = "LIXA_LAYMAN_BRIEFING" },
        { text = ccb.content.text("\"What is LIXA?\""), next_topic = "LIXA_briefing_1" },
        {
            text = ccb.content.text("\"LIGO and spatial compression.\""),
            next_topic = "LIXA_briefing_2",
        },
        {
            text = ccb.content.text("\"What is laser interferometry?\""),
            next_topic = "LIXA_briefing_3a",
        },
        {
            text = ccb.content.text("\"But what are we measuring???\""),
            next_topic = "LIXA_briefing_5",
        },
        { text = ccb.content.text("\"LIXA funding.\""), next_topic = "LIXA_briefing_6" },
        { text = ccb.content.text("Close the presentation."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "LIXA_briefing_5",
    line = ccb.content.text("The compressed n-space 'stored' in local exospace is in segments too small for any exospace flux, but is still IN exospace.  Through repeated frequency alterations, we can 'rotate' the n-space through the infinite n-planes of exospace, and detect the way in which they shift relative to each other.  This is the first step towards countermeasures, and may one day lead to actual safe transit!!!"),
    replies = {
        { text = ccb.content.text("Title slide."), next_topic = "LIXA_LAYMAN_BRIEFING" },
        { text = ccb.content.text("\"What is LIXA?\""), next_topic = "LIXA_briefing_1" },
        {
            text = ccb.content.text("\"LIGO and spatial compression.\""),
            next_topic = "LIXA_briefing_2",
        },
        {
            text = ccb.content.text("\"What is laser interferometry?\""),
            next_topic = "LIXA_briefing_3a",
        },
        { text = ccb.content.text("\"How does LIXA work?\""), next_topic = "LIXA_briefing_4" },
        { text = ccb.content.text("\"LIXA funding.\""), next_topic = "LIXA_briefing_6" },
        { text = ccb.content.text("Close the presentation."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "LIXA_briefing_6",
    line = ccb.content.text("&This is a series of several slides.  All of them contain financial data so full of references to other projects and definitions that it is basically incomprehensible.  It all adds up to a very large amount of money."),
    replies = {
        { text = ccb.content.text("Title slide."), next_topic = "LIXA_LAYMAN_BRIEFING" },
        { text = ccb.content.text("\"What is LIXA?\""), next_topic = "LIXA_briefing_1" },
        {
            text = ccb.content.text("\"LIGO and spatial compression.\""),
            next_topic = "LIXA_briefing_2",
        },
        {
            text = ccb.content.text("\"What is laser interferometry?\""),
            next_topic = "LIXA_briefing_3a",
        },
        { text = ccb.content.text("\"How does LIXA work?\""), next_topic = "LIXA_briefing_4" },
        {
            text = ccb.content.text("\"But what are we measuring???\""),
            next_topic = "LIXA_briefing_5",
        },
        { text = ccb.content.text("Close the presentation."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "LIXA_personal_computer_main",
    line = ccb.content.text("&This is a personal computer, the frame around the screen decorated with whale stickers.  It has undergone a severe fault, and its file structure is completely scrambled."),
    replies = {
        {
            text = ccb.content.text("Attempt to open a file."),
            trial = { kind = "skill_check", difficulty = 3, skill = "computer" },
            success = { next_topic = "LIXA_personal_success_1" },
            failure = { next_topic = "LIXA_personal_failure" },
        },
        { text = ccb.content.text("Leave."), next_topic = "TALK_DONE" },
    },
}

-- NO_I18N
ccb.content.define_dialogue_topic {
    id = "LIXA_personal_success_1",
    line = ccb.content.text_without_extraction("&<LIXA_personal_snip_1>"),
    replies = {
        {
            text = ccb.content.text("Attempt to open a file."),
            trial = { kind = "skill_check", difficulty = 3, skill = "computer" },
            success = { next_topic = "LIXA_personal_success_2" },
            failure = { next_topic = "LIXA_personal_failure" },
        },
        { text = ccb.content.text("Leave."), next_topic = "TALK_DONE" },
    },
}

-- NO_I18N
ccb.content.define_dialogue_topic {
    id = "LIXA_personal_success_2",
    line = ccb.content.text_without_extraction("&<LIXA_personal_snip_2>"),
    replies = {
        {
            text = ccb.content.text("Attempt to open a file."),
            trial = { kind = "skill_check", difficulty = 3, skill = "computer" },
            success = { next_topic = "LIXA_personal_success_3" },
            failure = { next_topic = "LIXA_personal_failure" },
        },
        { text = ccb.content.text("Leave."), next_topic = "TALK_DONE" },
    },
}

-- NO_I18N
ccb.content.define_dialogue_topic {
    id = "LIXA_personal_success_3",
    line = ccb.content.text_without_extraction("&<LIXA_personal_snip_3>"),
    replies = {
        {
            text = ccb.content.text("Attempt to open a file."),
            trial = { kind = "skill_check", difficulty = 3, skill = "computer" },
            success = { next_topic = "LIXA_personal_success_4" },
            failure = { next_topic = "LIXA_personal_failure" },
        },
        { text = ccb.content.text("Leave."), next_topic = "TALK_DONE" },
    },
}

-- NO_I18N
ccb.content.define_dialogue_topic {
    id = "LIXA_personal_success_4",
    line = ccb.content.text_without_extraction("&<LIXA_personal_snip_4>"),
    replies = {
        {
            text = ccb.content.text("Attempt to open a file."),
            trial = { kind = "skill_check", difficulty = 3, skill = "computer" },
            success = { next_topic = "LIXA_personal_success_1" },
            failure = { next_topic = "LIXA_personal_failure" },
        },
        { text = ccb.content.text("Leave."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "LIXA_personal_failure",
    line = ccb.content.text("&\"ERROR: file path corrupted.  Please contact your sysadmin.\"  The computer then freezes, and reboots."),
    replies = { { text = ccb.content.text("Leave."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "LIXA_experiment_computer_main",
    line = ccb.content.text("WARNING:  multiple system faults detected!  SHUT DOWN IMMEDIATELY."),
    replies = {
        {
            text = ccb.content.text("ERROR: Flux Limiters"),
            next_topic = "LIXA_experiment_flux_limiters",
        },
        { text = ccb.content.text("ERROR: Power Draw"), next_topic = "LIXA_experiment_power_draw" },
        {
            text = ccb.content.text("SYSTEM SHUTDOWN"),
            next_topic = "LIXA_experiment_system_shutdown",
        },
        {
            text = ccb.content.text("Copy research archives to external device."),
            next_topic = "LIXA_experiment_backup_data_need_id",
            when = predicates.all({ predicates.negate(predicates.has_item("speaker", "id_LIXA_najma")), predicates.negate(predicates.has_item("speaker", "id_LIXA_jason")), predicates.negate(predicates.has_item("speaker", "id_LIXA_kai_mei")), predicates.negate(predicates.has_item("speaker", "id_LIXA_rich")) }),
        },
        {
            text = ccb.content.text("Copy research archives to external device."),
            next_topic = "LIXA_experiment_backup_data_no_drive",
            when = predicates.all({ predicates.negate(predicates.has_item("speaker", "usb_drive_nano")), predicates.any({ predicates.has_item("speaker", "id_LIXA_najma"), predicates.has_item("speaker", "id_LIXA_jason"), predicates.has_item("speaker", "id_LIXA_kai_mei"), predicates.has_item("speaker", "id_LIXA_rich") }) }),
        },
        {
            text = ccb.content.text("Copy research archives to external device."),
            next_topic = "LIXA_experiment_backup_data",
            when = predicates.all({ predicates.has_item("speaker", "usb_drive_nano"), predicates.any({ predicates.has_item("speaker", "id_LIXA_najma"), predicates.has_item("speaker", "id_LIXA_jason"), predicates.has_item("speaker", "id_LIXA_kai_mei"), predicates.has_item("speaker", "id_LIXA_rich") }) }),
        },
        { text = ccb.content.text("Leave."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "LIXA_experiment_backup_data_need_id",
    line = ccb.content.text("ERROR:  access denied!  Reason: insufficient clearance level."),
    replies = { { text = ccb.content.text("Leave."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "LIXA_experiment_backup_data_no_drive",
    line = ccb.content.text("ERROR:  no secure USB drive detected!  Please insert an appropriately secured USB drive before attempting to copy files."),
    replies = { { text = ccb.content.text("Leave."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "LIXA_experiment_backup_data",
    line = ccb.content.text("Backup complete!"),
    replies = {
        {
            text = ccb.content.text("Leave."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_5c7b220017bf") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "LIXA_experiment_flux_limiters",
    line = ccb.content.text("Safe exodimensional flux threshold exceeded!  Current flux compression:  ERROR STACK OVERFLOW m/s"),
    replies = {
        { text = ccb.content.text("ERROR: Power Draw"), next_topic = "LIXA_experiment_power_draw" },
        {
            text = ccb.content.text("SYSTEM SHUTDOWN"),
            next_topic = "LIXA_experiment_system_shutdown",
        },
        { text = ccb.content.text("Leave."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "LIXA_experiment_power_draw",
    line = ccb.content.text("Power draw experiencing instability.  Current power input:  negative ERROR STACK OVERFLOW kJ/s."),
    replies = {
        {
            text = ccb.content.text("ERROR: Flux Limiters"),
            next_topic = "LIXA_experiment_flux_limiters",
        },
        {
            text = ccb.content.text("SYSTEM SHUTDOWN"),
            next_topic = "LIXA_experiment_system_shutdown",
        },
        { text = ccb.content.text("Leave."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "LIXA_experiment_system_shutdown",
    line = ccb.content.text("Emergency shutdown halted:  ERROR unsafe power discharge, ERROR active compressors"),
    replies = {
        {
            text = ccb.content.text("ERROR: Flux Limiters"),
            next_topic = "LIXA_experiment_flux_limiters",
        },
        { text = ccb.content.text("ERROR: Power Draw"), next_topic = "LIXA_experiment_power_draw" },
        {
            text = ccb.content.text("SYSTEM SHUTDOWN"),
            next_topic = "LIXA_experiment_system_shutdown",
        },
        { text = ccb.content.text("Leave."), next_topic = "TALK_DONE" },
    },
}
