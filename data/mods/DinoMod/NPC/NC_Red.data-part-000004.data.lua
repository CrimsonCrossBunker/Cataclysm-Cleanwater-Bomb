local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_OLD_GUARD_DINO_3",
    name = ccb.content.text("Protect the cattle"),
    description = ccb.content.text("Someone or something in the swamps is stealing cattle.  Stop it."),
    goal = "MGOAL_KILL_MONSTER",
    difficulty = 9,
    value = 100000,
    start = {
        target = { terrain = "forest_water", reveal_radius = 5, random = true, search_range = 50 },
        map_updates = {
            {
                layout = {
                    monster_placements = { { group = "GROUP_DINOSAUR_ZOMBIE", x = 12, y = 12, target = true } },
                },
            },
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_OLD_GUARD_DINO_4",
    -- Native mission phases did not apply the giver opinion (trust +1, value +1).
    finish = {
        actions = {
            ccb.content.dialogue_actions.purchase_pet("mon_zachycephalosaurus_chain", { count = 1, name = ccb.content.text("Betty") }),
            { item = "meth" },
        },
    },
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("This is probably a waste of time, but a nearby farmer has been complaining that someone or something has been stealing a lot of their cattle.  We don't normally bother with little things like this, but our food supplies are getting low and the farmers are threatening to cut us off if we won't help.  I've marked on your map where the farmers think the cattle are going."),
        accepted = ccb.content.text("Thanks, keeping the people safe is what we try and do."),
        rejected = ccb.content.text("Come back when you get a chance, we really need to start reclaiming the region."),
        advice = ccb.content.text("Maybe bring a rope to bring the cattle back or something for them to eat.  They can be ornery cusses if you don't know how to treat them."),
        inquire = ccb.content.text("How is the search going?"),
        success = ccb.content.text("Oh.  Oh no.  We didn't think the dinosaurs could raise and we've killed so many of them.  We might be in trouble here.  Here's one now, I'll rip it apart!  Wait, I can see in its dead eyes that it loves us and wants to help us.  I'll just end up killing it, I'm barely holding it together here.  You'd better take it."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_OLD_GUARD_DINO_4",
    name = ccb.content.text("Kill 50 dinos"),
    description = ccb.content.text("Kill 50 dinos"),
    goal = "MGOAL_KILL_MONSTER_SPEC",
    monster_species = "DINOSAUR",
    monster_kill_goal = 50,
    difficulty = 9,
    value = 100000,
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_OLD_GUARD_DINO_5",
    -- Native mission phases did not apply the giver opinion (trust +1, value +1).
    finish = {
        actions = {
            ccb.content.dialogue_actions.purchase_pet("mon_zachycephalosaurus_chain", { count = 1, name = ccb.content.text("Stromer") }),
            { item = "meth" },
        },
    },
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("While we were out on a hunting party a couple of those big ugly ones came back and ate a whole mob of the dead I wanted to take out.  We lost a lot of soldiers too while we were out too, good ones, and they died bad.  Slow.  I made sure of it, the traitors.  These dinosaurs have gone too far.  They're making us crazy.  We need to rack up some serious numbers to catch up.  We need some serious risk taking, I'm talking explosives and fire and drugs and rock and roll here.  I don't care if it's living dinos or dead, they all need to be taken down."),
        accepted = ccb.content.text("Kill all dinos."),
        rejected = ccb.content.text("I'm right on the edge soldier.  Whose side are you on here?"),
        advice = ccb.content.text("You can kill a lot of dinos without taking a lot of pills, but I don't see how."),
        inquire = ccb.content.text("You hit your numbers yet?"),
        success = ccb.content.text("That's what I like to hear.  We got our numbers too, and we chained down a couple too.  I had to take out a few more soldiers who didn't make their numbers, so this is good.  We're doing good."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_OLD_GUARD_DINO_5",
    name = ccb.content.text("Kill me a T Rex"),
    description = ccb.content.text("Kill me a T Rex"),
    goal = "MGOAL_KILL_MONSTER",
    difficulty = 9,
    value = 100000,
    start = {
        target = { terrain = "field", reveal_radius = 5, random = true, search_range = 60 },
        map_updates = {
            {
                layout = {
                    monster_placements = { { id = "mon_tyrannosaurus", x = 12, y = 12, target = true } },
                },
            },
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    -- Native mission phases did not apply the giver opinion (trust +1, value +1).
    finish = {
        actions = {
            "npc_die",
            ccb.content.dialogue_actions.purchase_pet("mon_zyrannosaurus_chain", { count = 1, name = ccb.content.text("Wilma") }),
            { item = "meth" },
        },
    },
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("I have a special mission I need to complete before these dinos finish killing me off, and I need you to bring me something special.  Go kill me a T Rex.  We're going to be gods.  It's all going to be worth it."),
        accepted = ccb.content.text("MY LIFE FOR YOU."),
        rejected = ccb.content.text("I'm right on the edge soldier.  Whose side are you on here?"),
        advice = ccb.content.text("You're a dino killing machine like me.  You know what to do."),
        inquire = ccb.content.text("You got my body yet?"),
        success = ccb.content.text("All right, we've got the body here.  Watch this, I'm going to climb into its dead mouth and when you see me again I'll be a god.  *SWALLOW*"),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
}
