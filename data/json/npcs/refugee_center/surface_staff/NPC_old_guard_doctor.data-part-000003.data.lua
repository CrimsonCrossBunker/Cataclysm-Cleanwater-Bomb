local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_SCIENCE_REP_2",
    name = ccb.content.text("Download Workstation Data"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 5,
    value = 50000,
    item = "software_lab_data",
    start = {
        target = {
            terrain = "microlab_generic_surface",
            special = "4x4_microlab_surface",
            reveal_radius = 3,
            cant_see = true,
        },
        map_updates = {
            {
                terrain = "microlab_generic_surface_connector",
                layout = {
                    computer_placements = {
                        {
                            name = ccb.content.text("Laboratory Archives"),
                            chat_topics = { "mission_science_rep_2_computer_main" },
                            x = 21,
                            y = 14,
                            dialogue_on_access = true,
                        },
                    },
                    tile_edits = { { shape = "point", operation = "remove_items", x = 21, y = 14 } },
                },
            },
        },
        actions = { { group = "mission_science_rep_secure_usb_blank" } },
    },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_SCIENCE_REP_3",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("The medical software didn't just analyze the blood, it triggered a government alert.  Medical staff was under orders to immediately drive any matching samples to the nearest laboratory.  That must mean the government knew!  We have the destination address.  Go there, get in, and bring back any records you can download off a computer.  Like last time, I can compensate you, and the Old Guard saw enough promise in this assignment to spare a larger sum of 60 merch.  I'm sure you're also free to lay claim to any valuables you might find at the target location."),
        accepted = ccb.content.text("Great!  I've mapped out a route to the address.  Bring back anything you find on this secure USB drive."),
        rejected = ccb.content.text("Can't blame you, but come back if you change your mind."),
        advice = ccb.content.text("If the laboratory is locked, maybe you can find an id card from employees who died in the evacuation.  Don't forget the secure USB drive."),
        inquire = ccb.content.text("Have you completed your mission?"),
        success = ccb.content.text("Thanks!  This data looks damaged, but maybe I can make something out of it."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    finish = { actions = { { item = "FMCNote", count = 60 } } },
}

ccb.content.define_mission {
    id = "MISSION_SCIENCE_REP_3",
    name = ccb.content.text("Download Encryption Codes"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 5,
    value = 50000,
    item = "software_encryption_codes",
    start = {
        target = {
            terrain = "lab_subway_vent_shaft_surface",
            special = "microlab_mutable",
            reveal_radius = 3,
            cant_see = true,
        },
        map_updates = {
            {
                terrain = "microlab_portal_dressroom",
                layout = {
                    computer_placements = {
                        {
                            name = ccb.content.text("Security Console"),
                            chat_topics = { "mission_science_rep_3_computer_main" },
                            x = 9,
                            y = 18,
                            dialogue_on_access = true,
                        },
                    },
                    tile_edits = { { shape = "point", operation = "remove_items", x = 9, y = 18 } },
                },
            },
        },
        actions = { { group = "mission_science_rep_secure_usb_blank" } },
    },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_SCIENCE_REP_4",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("Unfortunately the data you got was incomplete and mostly encrypted.  There may be a way to get encryption codes, though.  I found a complaint by the infosec team that they were unable to deliver critical security updates to one research site.  It was some kind of more restricted secondary site, they weren't allowed in.  That means it should have unsecured computers we can get the codes from.  I couldn't secure any funding for this due to a lack of obvious results, but if you believe in this enough, maybe we can convince them otherwise?"),
        accepted = ccb.content.text("Great!  I've mapped out a route to the address.  Use this secure USB drive as usual."),
        rejected = ccb.content.text("Can't blame you, but come back if you change your mind."),
        advice = ccb.content.text("Expect the lab to be locked as usual.  Don't forget the secure USB drive."),
        inquire = ccb.content.text("Have you completed your mission?"),
        success = ccb.content.text("Wonderful!  Now I just need to get an undamaged, complete archive, and we can really figure out what happened."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_SCIENCE_REP_4",
    name = ccb.content.text("Download Research Archives"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 5,
    value = 50000,
    item = "software_archived_data",
    start = {
        target = {
            terrain = "lab_subway_vent_shaft_surface",
            special = "microlab_mutable",
            reveal_radius = 3,
            cant_see = true,
        },
        map_updates = {
            {
                terrain = "microlab_portal_MSU14",
                layout = {
                    computer_placements = {
                        {
                            name = ccb.content.text("Laboratory Archives"),
                            chat_topics = { "mission_science_rep_4_computer_main" },
                            x = 13,
                            y = 5,
                            dialogue_on_access = true,
                        },
                    },
                    tile_edits = { { shape = "point", operation = "remove_items", x = 21, y = 14 } },
                },
            },
        },
        actions = { { group = "mission_science_rep_secure_usb_blank" } },
    },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_SCIENCE_REP_5",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("So there looks to be months, maybe years of experiments, and that data set must be huge.  That data will have to be backed up somewhere secure and remote.  I heard of a lab that has data servers hidden in a high security vault on lower floors.  I bet the archives inside that lab are still working.  The Old Guard didn't seem very convinced, but still ended up providing 100 merch for this."),
        accepted = ccb.content.text("Excellent!  I've mapped out a route to the address.  Bring back anything you find on this secure USB drive."),
        rejected = ccb.content.text("Can't blame you, but come back if you change your mind."),
        advice = ccb.content.text("That lab is going to be protected by various security systems.  You may need special access cards or a way to cut your way in.  Don't forget the secure USB drive."),
        inquire = ccb.content.text("Have you completed your mission?"),
        success = ccb.content.text("Thanks!  This is a lot of data to go through."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    finish = { actions = { { item = "FMCNote", count = 100 } } },
}
