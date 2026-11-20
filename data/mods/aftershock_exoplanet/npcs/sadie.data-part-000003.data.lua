local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_sadie_heart",
    name = ccb.content.text("Heart for Sadie"),
    description = ccb.content.text("Find a special organ"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 5,
    value = 0,
    item = "flesh_golem_heart",
    item_count = 1,
    start = {
        target = {
            terrain = "forest_thick",
            reveal_radius = 1,
            random = true,
            search_range = 18,
            min_distance = 5,
            z = 0,
        },
        map_updates = {
            {
                layout = {
                    monster_placements = {
                        {
                            id = "mon_flesh_golem_afs",
                            x = 11,
                            y = 11,
                            target = true,
                            name = ccb.content.text("Billy"),
                        },
                    },
                },
            },
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("I want your organ."),
        offer = ccb.content.text("I've been feeling really yummy since the last time Billy came to work on me, and I think it's because my heart is gone.  Like literally gone.  I checked.  Billy did a really good job taking it out, but I want to leave this storage unit with you and if I'm going to do that I need a working heart.  My first idea was to take yours, but you probably need it even more.  You know who has a nice big juicy heart?  Billy does.  And I bet I know where Billy is."),
        accepted = ccb.content.text("Aw, I heart that you're going to help me get that big organ."),
        rejected = ccb.content.text("This makes me sad.  Which makes me happy.  So thanks?  Let me know if you change your mind.  I probably shouldn't go without a heart for too too long but I'm kind of enjoying it.  It's like always being on the edge of something horrible, but in a nice way."),
        advice = ccb.content.text("Please be careful cutting that heart out.  If you ruin it I don't know about another good one nearby.  Maybe practice on some friends and neighbors first, you really want to be sure and get it right.  If you break Billy's heart I can use a heart from another of whatever Billy is, but I can't use regular hearts, and I don't know where to find more Billy types."),
        inquire = ccb.content.text("Do you have my heart?"),
        success = ccb.content.text("Ooh, Billy had a really good heart.  Can you turn away please?  I just need to do some quick open chest surgery here.  Just a quick cut here *ooh* and I need to break this and this *SNAP* *oh!* and just sew some little things together here quickly.  Not as much blood as you'd think.  I should probably look into that later, there should be more blood in there.  Ah, good enough, I can do a better job closing up later.  Kind of tingly, feeling everything moving again in there.  See, heart surgery isn't hard if you have the right attitude.  Well now, you need a good reward for everything you've done for me.  Here, let me inject you with this."),
        success_lie = ccb.content.text("I don't know why, but I feel better.  Also worse.  Maybe I'm good without it."),
        failure = ccb.content.text("Oh no, my heart.  Thank you for trying though, your failure gives me pleasure.  What else are you bad at?"),
    },
    finish = {
        actions = {
            "give_aid",
            ccb.content.dialogue_actions.add_effect("speaker", "sadie_injection", { turns = 200000 }),
            ccb.content.dialogue_actions.set_actor_value("speaker", "general_injection_sadie_injection", "yes"),
        },
    },
}
