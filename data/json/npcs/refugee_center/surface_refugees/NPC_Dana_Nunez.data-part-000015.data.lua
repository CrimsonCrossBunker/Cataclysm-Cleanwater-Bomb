local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_REFUGEE_Dana_Sourdough",
    name = ccb.content.text("Find Dana's family sourdough culture"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    value = 1000,
    item = "landough_calrisean",
    start = {
        target = { terrain = "bakery", reveal_radius = 1, random = true, search_range = 800 },
        map_updates = { { layout = { item_placements = { { id = "landough_calrisean", x = 5, y = 16 } } } } },
        actions = {
            ccb.content.dialogue_actions.set_actor_value("speaker", "mission_flag_Dana_Sourdough", "in_progress"),
        },
    },
    finish = {
        actions = {
            ccb.content.dialogue_actions.set_actor_value("speaker", "mission_flag_Dana_Sourdough", "yes"),
            ccb.content.dialogue_actions.add_effect("interlocutor", "dana_sourdough_revival", { turns = 604800 }),
        },
        handler = "advance_counter_refugee_center_refugee_happiness_by_2",
    },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("I could get my real sourdough starter…"),
        offer = ccb.content.text("If you really like this second-rate bread, you could risk your life for something actually worth it.  I left my actual sourdough starter back in the bakery where I worked.  That baby is a hundred years old, and has been in my family for generations… if you can bring him to me, I'll bake you the finest bread you've ever had."),
        accepted = ccb.content.text("Take care of yourself out there.  And listen, when you bring my sourdough back, I don't want to see a scratch on him, you understand?"),
        rejected = ccb.content.text("I can understand why you think you wouldn't want to risk your life for a bread starter.  You haven't tried that bread."),
        advice = ccb.content.text("He'll be in the right-hand fridge, in a jar with a picture of the Millennium Falcon on it."),
        inquire = ccb.content.text("So, you seen my sourdough starter?"),
        success = ccb.content.text("Oh, you will not regret this.  He may not look like much, but he's got it where it counts, kid.  It's gonna take me a few days to revive him after being abandoned so long, but he'll be operational soon and then you can come back for some real bread."),
        success_lie = ccb.content.text("This ain't it."),
        failure = ccb.content.text("I am not sure if I'm gonna make it through the Cataclysm without my special jar of goop."),
    },
}
