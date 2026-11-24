local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_npc_class {
    id = "NC_BONE_SEER",
    name = ccb.content.text("Bone Seer"),
    job_description = ccb.content.text("I wish to sing the song of the Bones."),
    traits = {
        { trait = "OUTDOORSMAN" },
        { trait = "HEAVYSLEEPER" },
        { trait = "GOODCARDIO" },
        { trait = "LIGHTSTEP" },
        { trait = "ROBUST" },
        { trait = "SKIN_DARK" },
        { trait = "seer_mark" },
        { trait = "hair_mohawk", variant = "black" },
        { trait = "natural_hair_color_black" },
        { trait = "IGNORE_SOUND" },
        { trait = "NO_BASH" },
    },
    common = false,
    perception = { rng = { 0, 2 } },
    strength = { rng = { 0, 2 } },
    intelligence = { rng = { 0, 2 } },
    worn = "BONE_SEER_Brigitte_worn",
    weapon = "BONE_SEER_Brigitte_wield",
    shop_groups = "NC_BONE_SEER_misc",
    skills = {
        {
            skill = "ALL",
            level = {
                mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = -2 }, { one_in = 4 } } } },
            },
        },
        { skill = "survival", bonus = { rng = { 2, 4 } } },
        { skill = "dodge", bonus = { rng = { 4, 8 } } },
        { skill = "melee", bonus = { rng = { 6, 8 } } },
        { skill = "bashing", bonus = { rng = { 3, 6 } } },
        { skill = "cutting", bonus = { rng = { 3, 6 } } },
    },
}

ccb.content.define_mutation {
    id = "seer_mark",
    name = ccb.content.text("Mark of the Seer"),
    points = 1,
    description = ccb.content.text("A strange occult symbol carved into your hand by Brigitte LaCroix."),
    starting_trait = false,
    valid = false,
    purifiable = false,
}

-- A mysterious member of a doomsday cult.
ccb.content.define_npc {
    id = "SEER_Brigitte_LaCroix",
    unique_name = ccb.content.text("Brigitte LaCroix"),
    gender = "female",
    suffix = ccb.content.text("Bone Seer"),
    class = "NC_BONE_SEER",
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_BONE_SEER",
    friend_chat = "TALK_FRIEND_BONE_SEER",
    friend_guard_chat = "TALK_FRIEND_GUARD_BONE_SEER",
    faction = "no_faction",
    missions_offered = "MISSION_SEER_GATHER_BONE",
}

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_seer" } }),
        yes = {
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_song_asked_about_song" } }),
            yes = {
                when = predicates.has_trait("speaker", "seer_mark"),
                yes = {
                    when = predicates.actor_state("speaker", "female"),
                    yes = ccb.content.text("Greetings, sister."),
                    no = ccb.content.text("Greetings, brother."),
                },
                no = ccb.content.gendered_line("Traveler.", { "speaker" }),
            },
            no = ccb.content.gendered_line("You're back.  Have you come to listen to the song?", { "speaker" }),
        },
        no = ccb.content.text("You there.  Quiet down.  Can you hear it?  The song?"),
    },
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "dialogue_first_meeting_talked_to_seer", "yes") },
        },
    },
    replies = {
        {
            text = ccb.content.text("What song?"),
            next_topic = "TALK_BONE_SEER_SONG",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_song_asked_about_song" } })),
        },
        {
            text = ccb.content.text("So about the songs…"),
            next_topic = "TALK_BONE_SEER_SONG2",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_song_asked_about_song" } }),
        },
        {
            text = ccb.content.text("Do others follow this belief as well?"),
            next_topic = "TALK_BONE_SEER_OTHERS",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_song_asked_about_song" } }),
        },
        {
            text = ccb.content.text("Can you tell me more about yourself?"),
            next_topic = "TALK_BONE_SEER_ABOUT",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_song_asked_about_song" } }),
        },
        {
            text = ccb.content.text("You mentioned some cycle before.  What does that mean?"),
            next_topic = "TALK_BONE_SEER_CYCLE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_song_asked_about_song" } }),
        },
        {
            text = ccb.content.text("I've met Cooper."),
            next_topic = "TALK_BONE_SEER_METCOOPER",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_cooper" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_kindred_cooper_knows_cooper" } }) }),
        },
        {
            text = ccb.content.text("Would you like to join me on my travels?"),
            next_topic = "TALK_SUGGEST_FOLLOW_SEER",
            when = predicates.all({ predicates.negate(predicates.actor_state("interlocutor", "following")), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_song_asked_about_song" } }) }),
        },
        {
            text = ccb.content.text("Is there a way I can help you with your song?"),
            next_topic = "TALK_MISSION_LIST_SEER",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_song_asked_about_song" } }),
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_song_asked_about_song" } })),
        },
        {
            text = ccb.content.text("I have to get going.  Take care, Seer."),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_song_asked_about_song" } }),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER_SONG",
    line = ccb.content.text("Listen carefully.  The bones… they hum.  Can you hear it?  The song they weave?  The stories they hold?"),
    replies = {
        {
            text = ccb.content.text("Bones?  What are you talking about?"),
            next_topic = "TALK_BONE_SEER_SONG2",
        },
        {
            text = ccb.content.text("Uh… yeah, sure.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER_SONG2",
    line = ccb.content.text("When it all happened, the Cataclysm, something… changed.  You can see it in all creatures, most of all in their bones.  They break, morph, rise again, over and over - a never-ending cycle.  The dead walk again, horrors rip and tear each other apart.  And within each one… the quiet hum of raw strength.  Only by taking the bones does the cycle end - their story, their song, their strength; they become yours to use."),
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "dialogue_song_asked_about_song", "yes") },
        },
    },
    replies = {
        {
            text = ccb.content.text("What do you actually do with the bones?"),
            next_topic = "TALK_BONE_SEER_BONES",
        },
        {
            text = ccb.content.text("I'm still not sure what you mean."),
            next_topic = "TALK_BONE_SEER_SONG3",
        },
        {
            text = ccb.content.text("Does anyone else, uh, believe this?"),
            next_topic = "TALK_BONE_SEER_OTHERS",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER_SONG3",
    line = ccb.content.text("Only when you crush the bones of a body does it cease to rise.  Only if you examine the bones can you see what was, the story of the bones.  Whatever causes this change is alive, writhing within us all; an inevitable part of this new world.  It holds the power of change.  When we hold the bones, we hold the power.  Thus the strength.  Together… they form a beautiful song."),
    replies = {
        {
            text = ccb.content.text("What do you actually do with the bones?"),
            next_topic = "TALK_BONE_SEER_BONES",
        },
        {
            text = ccb.content.text("Does anyone else share this belief?"),
            next_topic = "TALK_BONE_SEER_OTHERS",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER_OTHERS",
    line = ccb.content.text("There are others who know the power the bones hold, but not all of them are my kin.  Not anymore, at least."),
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "dialogue_kindred_knows_kindred", "yes") },
        },
    },
    replies = {
        {
            text = ccb.content.text("What do you mean 'not anymore'?"),
            next_topic = "TALK_BONE_SEER_COOPER",
        },
        {
            text = ccb.content.text("Why do you gather these bones again?"),
            next_topic = "TALK_BONE_SEER_BONES",
        },
        {
            text = ccb.content.text("Thank you for all the information, but I have to go now."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER_COOPER",
    line = ccb.content.text("Some time ago, a man named Cooper joined me and my kin.  He showed great promise and devotion to our cause, but in his effort to weave songs, he justified increasingly grim actions.  We tried to stop him when we learned of this, but he managed to get away.  If you ever come across him, be sure to thread carefully, and if you can, stop him."),
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "dialogue_kindred_cooper_knows_cooper", "yes") },
        },
    },
    replies = {
        {
            text = ccb.content.text("Wait, Cooper?  Darren Cooper?  I've already met him."),
            next_topic = "TALK_BONE_SEER_METCOOPER2",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_cooper" } }),
        },
        {
            text = ccb.content.text("What exactly did he do?"),
            next_topic = "TALK_BONE_SEER_COOPER2",
        },
        {
            text = ccb.content.text("Sounds like there is another side to this.  Sometimes, what is necessary is not pretty."),
            next_topic = "TALK_BONE_SEER_COOPER3",
            actions = { actions.set_actor_value("speaker", "dialogue_kindred_admires_cooper", "yes") },
        },
        {
            text = ccb.content.text("What cause is that?  What do you do with the bones?"),
            next_topic = "TALK_BONE_SEER_BONES",
        },
        {
            text = ccb.content.text("I see.  <done_conversation_section>"),
            next_topic = "TALK_BONE_SEER",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER_COOPER2",
    line = ccb.content.text("He began killing others to get their bones as fresh as possible.  Later, he… he started carving the bones of the living.  Thought the anguish alone would empower the song.  The goal of the Kindred is to banish the shadow of the Cataclysm, not to cast it.  Such heinous acts will likely twist the song of the world, but I don't think Cooper realizes it.  To him, the end justifies any means."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "dialogue_kindred_cooper_knows_cooper_kill", "yes"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Well… shit.  <done_conversation_section>"),
            next_topic = "TALK_BONE_SEER",
        },
        {
            text = ccb.content.text("What if he is right?  Maybe what you do isn't enough and he's the only one to do what it takes."),
            next_topic = "TALK_BONE_SEER_COOPER3",
            actions = { actions.set_actor_value("speaker", "dialogue_kindred_admires_cooper", "yes") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER_COOPER3",
    line = ccb.content.text("You do not realize the gravity of your claim.  When you understand the Song better, you will understand the danger of his actions."),
    replies = {
        { text = ccb.content.text("I see."), next_topic = "TALK_BONE_SEER" },
        { text = ccb.content.text("We'll see about that."), next_topic = "TALK_BONE_SEER" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER_BONES",
    line = ccb.content.text("The song can be woven in many forms.  Carved bone charms, weapons and armor all hold immense power, and when the time comes, me and my Kindred shall amass enough Song to restore this world as it was before.  Restore it, or end it.  Makes no difference."),
    replies = { { text = ccb.content.text("End the world?  What?"), next_topic = "TALK_BONE_SEER_END" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER_END",
    line = ccb.content.text("The Song holds immeasurable power.  A grand symphony could revert the Cataclysm - or accelerate it to a time beyond all.  But with the world looking as is, both options are preferable."),
    replies = {
        {
            text = ccb.content.text("A strange belief, but maybe there is some truth to it."),
            next_topic = "TALK_BONE_SEER_POSITIVE",
        },
        {
            text = ccb.content.text("Well, at least you're trying to help."),
            next_topic = "TALK_BONE_SEER_POSITIVE",
        },
        { text = ccb.content.text("You're nuts."), next_topic = "TALK_BONE_SEER_INSULT" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER_POSITIVE",
    line = ccb.content.gendered_line("Your mind is open.  More than most.  Perhaps one day, you too will feel the power of the song and become Kindred.  For now, traveler, listen, listen and feel the song.", { "speaker" }),
    replies = { { text = ccb.content.text("I… thank you."), next_topic = "TALK_BONE_SEER" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER_INSULT",
    line = ccb.content.text("Your skepticism does not surprise me.  Perhaps one day, you too will hear the inevitability of the song, feel its power.  But until you do, you will remain just another survivor, path to the Kindred closed."),
    replies = { { text = ccb.content.text("Alright."), next_topic = "TALK_BONE_SEER" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER_ABOUT",
    line = ccb.content.text("I grew up in Louisiana with my grandmother.  Great cook.  Made the best boudin I've ever had.  Each night, she would tell me stories; mostly folklore and myths, like about the rougarou, or the Honey Island Swamp monster but… she sometimes told me about me about the Song, and the bones.  The way she talked about it was… different, serious.  Didn't give it much thought back then; I was just a child, after all.  I moved here a few years back for work, before the Cataclysm, before everything changed.  I do miss home sometimes, but at least the rats here are smaller.  Never could stand the things.  Anyway… thank you for asking.  Been a while since I could simply talk to someone."),
    replies = {
        {
            text = ccb.content.text("Why didn't your parents raise you?"),
            next_topic = "TALK_BONE_SEER_PARENTS",
        },
        { text = ccb.content.text("What's boudin?"), next_topic = "TALK_BONE_SEER_BOUDIN" },
        {
            text = ccb.content.text("What do you mean she talked about the Song 'differently'?"),
            next_topic = "TALK_BONE_SEER_GRANDMA",
        },
        { text = ccb.content.text("What's wrong with rats?"), next_topic = "TALK_BONE_SEER_RATS" },
        {
            text = ccb.content.text("Thank you for sharing.  <done_conversation_section>"),
            next_topic = "TALK_BONE_SEER",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER_PARENTS",
    line = ccb.content.text("They died when I was very young.  Car accident.  I… don't have any memories of them, but my grandmother raised me as her own."),
    replies = { { text = ccb.content.text("She sounds nice."), next_topic = "TALK_BONE_SEER_ABOUT" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER_BOUDIN",
    line = ccb.content.text("Spicy sausage, green onions, rice.  She'd batter and deep fry them, make boudin balls.  A dish to die for."),
    replies = {
        { text = ccb.content.text("Sounds delicious."), next_topic = "TALK_BONE_SEER_ABOUT" },
        { text = ccb.content.text("Not my kind of thing."), next_topic = "TALK_BONE_SEER_ABOUT" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER_GRANDMA",
    line = ccb.content.text("Unlike the other stories, she spoke with determination, reverence even.  I didn't realize it back then but it wasn't just a story; she knew that this wasn't just another tale."),
    replies = { { text = ccb.content.text("I see."), next_topic = "TALK_BONE_SEER_ABOUT" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER_RATS",
    line = ccb.content.text("Ever since a young age, I hated rats.  Can't quite say why; they always struck me as something… foul.  I even have nightmares about them sometimes.  Not too long ago, I had one about a man-sized rat, shambling on it's hind legs.  It chased me up a tall building and then pushed me off, snickering.  Maybe the Song was trying to tell me something, but then again, maybe it was just a bad dream."),
    replies = {
        {
            text = ccb.content.text("Strange dream, but we all have fears, sometimes irrational."),
            next_topic = "TALK_BONE_SEER_ABOUT",
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_SEER_GATHER_BONE",
    name = ccb.content.text("Find 8 bones"),
    description = ccb.content.text("Brigitte LaCroix asked you to collect clean, untainted bones in order to better understand her beliefs.  8 bones should be sufficient."),
    difficulty = 1,
    value = 10000,
    goal = "MGOAL_FIND_ITEM",
    item = "bone",
    item_count = 8,
    origins = { "ORIGIN_SECONDARY" },
    finish = { handler = { "mark_general_mission_NC_SEER_MISSION_1", "become_seer_mark" } },
    dialogue = {
        describe = ccb.content.text("There is always work to be done, song to be woven."),
        offer = ccb.content.text("If you wish to be set on the path to enlightenment, first you must learn to listen and hear the song.  Go out, butcher an untainted creature and feel the power between your fingertips.  Then bring me the bones and I shall carve them for you."),
        accepted = ccb.content.text("Excellent.  Now be on your way."),
        rejected = ccb.content.text("I understand your reluctance.  Feel free to return when you see the way."),
        advice = ccb.content.text("The shambling corpses we see all around move in discord.  Their song can be used, but for an Acolyte, this would be needlessly hard.  Be sure to carve an unspoiled living creature."),
        inquire = ccb.content.text("Have you felt the song in your hands yet?"),
        success = ccb.content.text("And so, another cycle ends.  You have done well.  I will now bestow my mark upon you, so that others may know the path you walk and aid you."),
        success_lie = ccb.content.text("So you say, but the song sings otherwise."),
        failure = ccb.content.text("Then you shall try again, until you hear."),
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_MISSION_LIST_SEER",
    line = {
        when = predicates.available_missions("interlocutor", 0, 0),
        yes = {
            when = predicates.assigned_missions(0, 0),
            yes = ccb.content.text("The song is… quiet for now.  Perhaps with time, more notes will be etched in the bones of this world."),
            no = {
                when = predicates.assigned_missions(2),
                yes = ccb.content.text("An acolyte should not take on too many songs at once."),
                no = ccb.content.text("That is all for now."),
            },
        },
        no = {
            when = predicates.available_missions("interlocutor", 2),
            yes = {
                when = predicates.assigned_missions(0, 0),
                yes = ccb.content.text("There are bones to etch, songs to sing.  Wish to join me?"),
                no = {
                    when = predicates.assigned_missions(2),
                    yes = ccb.content.text("Do you wish to take on more songs?"),
                    no = ccb.content.text("Do you believe you can take on the burden of additional bones?"),
                },
            },
            no = {
                when = predicates.assigned_missions(0, 0),
                yes = ccb.content.text("A song may yet be sung by you, should you wish to."),
                no = {
                    when = predicates.assigned_missions(2),
                    yes = ccb.content.text("There is an additional song you could take on, if you'd like."),
                    no = ccb.content.text("I know of certain bones that could be of use, if you'd like to know more."),
                },
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("I see."),
            next_topic = "TALK_NONE",
            when = predicates.available_missions("interlocutor", 0, 0),
        },
        {
            text = ccb.content.text("I'm listening."),
            next_topic = "TALK_MISSION_OFFER_SEER",
            when = predicates.negate(predicates.available_missions("interlocutor", 0, 0)),
        },
        {
            text = ccb.content.text("Perhaps another time, Seer."),
            next_topic = "TALK_NONE",
            when = predicates.negate(predicates.available_missions("interlocutor", 0, 0)),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_MISSION_OFFER_SEER",
    line = ccb.content.text("If you wish to be set on the path to enlightenment, first you must learn to listen and hear the song.  Go out, butcher an untainted creature and feel the power between your fingertips.  Then bring me the bones and I shall carve them for you."),
    replies = {
        {
            text = ccb.content.text("Well, I guess I oughta see where this goes.  I'm in."),
            next_topic = "TALK_MISSION_ACCEPTED_SEER",
            native_actions = { "assign_mission" },
        },
        { text = ccb.content.text("Not interested."), next_topic = "TALK_MISSION_REJECTED_SEER" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_MISSION_ACCEPTED_SEER",
    line = ccb.content.text("Excellent.  Now be on your way."),
    replies = {
        {
            text = ccb.content.text("Consider it done.  But I also wanted to ask…"),
            next_topic = "TALK_BONE_SEER",
        },
        {
            text = ccb.content.text("Where should I start?"),
            next_topic = "TALK_MISSION_ADVICE_SEER",
        },
        {
            text = ccb.content.text("Can you share some equipment to aid me in this?"),
            next_topic = "TALK_SHARE_EQUIPMENT_SEER",
        },
        { text = ccb.content.text("I'm off then."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_MISSION_ADVICE_SEER",
    line = ccb.content.text("The shambling corpses we see all around move in discord.  Their song can be used, but for an Acolyte, this would be needlessly hard.  Be sure to carve an unspoiled living creature."),
    replies = {
        {
            text = ccb.content.text("So, a creature that isn't a zombie, or a monster.  Got it."),
            next_topic = "TALK_NONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SHARE_EQUIPMENT_SEER",
    line = ccb.content.text("The path to enlightenment is for you to walk.  For me to aid you would ultimately impede your progress and muddle your song."),
    replies = { { text = ccb.content.text("I see.  Very well then."), next_topic = "TALK_NONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SUGGEST_FOLLOW_SEER",
    line = {
        when = predicates.has_trait("speaker", "seer_mark"),
        yes = ccb.content.text("You bear my mark, meaning I believe you have potential to learn to truly listen to the Song.  Yes, I will lend my skills to you, for now."),
        no = ccb.content.text("Only those who bear my mark will prove themselves worthy of my skills."),
    },
    replies = {
        {
            text = ccb.content.text("I see.  Very well then."),
            next_topic = "TALK_NONE",
            when = predicates.negate(predicates.has_trait("speaker", "seer_mark")),
        },
        {
            text = ccb.content.text("I am glad to hear it.  Let's go then."),
            native_actions = { "follow" },
            when = predicates.has_trait("speaker", "seer_mark"),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("That's good, but I need to go at it alone right now.  <end_talking_later>"),
            when = predicates.has_trait("speaker", "seer_mark"),
            next_topic = "TALK_NONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_MISSION_REJECTED_SEER",
    line = ccb.content.text("I understand your reluctance.  Feel free to return when you see the way."),
    replies = {
        {
            text = ccb.content.text("Maybe some other time.  Changing the topic…"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text("Alright, but I have to go now."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER_CYCLE",
    line = ccb.content.text("It's not just walking horrors and monsters that have changed with the Cataclysm.  It started a… cycle, of sorts.  Everything repeats.  We can only see it in others, but it happens to us, even you and I.  How many times have you fallen?  Your flesh rent from your body, devoured.  Or perhaps it was the quiet whimper of succumbing to the elements.  But your bones rose again.  Different flesh, different name, sometimes even different knowledge, but the bones, the same.  We are all trapped in the same cycle.  We just keep forgetting.  That's why we need to amass the Song.  That's why it has to end, even if it means the destruction, not restoration."),
    replies = {
        { text = ccb.content.text("That's… certainly something."), next_topic = "TALK_NONE" },
        { text = ccb.content.text("That's insane."), next_topic = "TALK_BONE_SEER_INSULT" },
        { text = ccb.content.text("Right… I think I'll go now."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER_METCOOPER",
    line = ccb.content.gendered_line("I see.  And you live still.  Does that mean you managed to stop him?", { "speaker" }),
    replies = {
        {
            text = ccb.content.text("I've confronted him.  He ended up attacking me."),
            next_topic = "TALK_BONE_SEER_COOPERFIGHT",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_cooper_fought_cooper" } }),
        },
        {
            text = ccb.content.text("He was reasonable.  We talked, then parted ways peacefully."),
            next_topic = "TALK_BONE_SEER_COOPERPEACE",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_cooper_fought_cooper" } })),
        },
        {
            text = ccb.content.text("I agree with him.  What he does is necessary."),
            next_topic = "TALK_BONE_SEER_COOPERAGREE",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_cooper_fought_cooper" } })), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_cooper_cooper_friendly" } }) }),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER_COOPERFIGHT",
    line = ccb.content.gendered_line("It saddens me to see a talented Kindred lose his way so greatly, but I take solace in the fact that you are unscathed.", { "speaker" }),
    replies = {
        {
            text = ccb.content.text("Best not to dwell on it.  Let's move on."),
            next_topic = "TALK_BONE_SEER",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER_COOPERPEACE",
    line = ccb.content.text("I am glad your meeting ended without conflict.  Perhaps he's understanding the Song more and the harm his actions caused.  If so… there may be hope yet.  Never the less, his action can not go unpunished."),
    replies = {
        {
            text = ccb.content.text("A topic for another time.  Let's move on."),
            next_topic = "TALK_BONE_SEER",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER_METCOOPER2",
    line = ccb.content.text("You have?  A most peculiar coincidence.  How did he act towards you?"),
    replies = {
        {
            text = ccb.content.text("I've confronted him.  He ended up attacking me."),
            next_topic = "TALK_BONE_SEER_COOPERFIGHT",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_cooper_fought_cooper" } }),
        },
        {
            text = ccb.content.text("He was reasonable.  We talked, then parted ways peacefully."),
            next_topic = "TALK_BONE_SEER_COOPERPEACE",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_cooper_fought_cooper" } })),
        },
        {
            text = ccb.content.text("I agree with him.  What he does is necessary."),
            next_topic = "TALK_BONE_SEER_COOPERAGREE",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_cooper_fought_cooper" } })), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_cooper_cooper_friendly" } }) }),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER_COOPERAGREE",
    line = ccb.content.text("Tread carefully.  I can't allow anyone else to go down such a path.  I can't fail again."),
    replies = {
        {
            text = ccb.content.text("I'm sorry.  I'll think about it some more."),
            next_topic = "TALK_BONE_SEER",
        },
        {
            text = ccb.content.text("Just saying he has a point, that's all."),
            next_topic = "TALK_BONE_SEER",
        },
    },
}
