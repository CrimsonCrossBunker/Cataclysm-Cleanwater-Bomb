local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_npc_class {
    id = "NC_AUGUSTMOON_GENETECH_TRADER",
    name = ccb.content.text("Mercurial augmentation tech."),
    job_description = ccb.content.text("Outfitter Clerk"),
    common = false,
    traits = {
        { group = "BG_survival_story_POLICE" },
        { trait = "RETURN_TO_START_POS" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
    },
    strength = { rng = { 0, 1 } },
    dexterity = { rng = { 0, 2 } },
    intelligence = { rng = { -2, 0 } },
    perception = { rng = { 0, 2 } },
    worn = "NC_AUGUSTMOON_TOOL_TRADER_worn",
    carry = "EMPTY_GROUP",
    weapon = "EMPTY_GROUP",
    skills = { { skill = "ALL", level = { sum = { { dice = { 3, 2 } }, { constant = -3 } } } } },
    shop_groups = { { id = "afs_augustmoon_genetech_trader", rigid = true } },
    price_rules = { { group = "afs_augustmoon_genetech_trader", markup = 1.1 } },
}

ccb.content.define_npc {
    id = "augustmoon_mercurial_clerk",
    suffix = ccb.content.text("Mercurial augmentation tech."),
    class = "NC_AUGUSTMOON_GENETECH_TRADER",
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_AUGUSTMOON_GENETECH_TRADER",
    faction = "mercurial",
}

ccb.content.define_dialogue_topic {
    id = { "TALK_AUGUSTMOON_GENETECH_TRADER", "TALK_AUGUSTMOON_GENETECH_WORKS" },
    line = ccb.content.text("&The Mercurial store is attended by a massive clerk, sleek scales adorn their massive forearms and slightly pointed ears.  They greet you with a voice that is both deep and melodious, \"Welcome to Mercurial Genetech, where we can help you unlock your potential.\""),
    replies = {
        {
            text = ccb.content.text("I'm looking into augments."),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.has_any_trait("speaker", { "ESPER_ADVANCEMENT_OKAY", "ESPER_STARTER_ADVANCEMENT_OKAY" })),
            actions = { "start_trade" },
        },
        {
            text = ccb.content.text("I'm looking into augments.  I know the risks."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_aftershock_exoplanet_718eecbe9628"),
            actions = { "start_trade" },
        },
        {
            text = ccb.content.text("I'm looking into augments."),
            next_topic = "TALK_AUGUSTMOON_GENETECH_ESPER_WARNING",
            when = predicates.handler("dlg_p_aftershock_exoplanet_1cc1c1d49db6"),
        },
        {
            text = ccb.content.text("How does this Genetech stuff works?"),
            next_topic = "TALK_AUGUSTMOON_GENETECH_WORKS",
        },
        {
            text = ccb.content.text("Maybe later."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_AUGUSTMOON_GENETECH_WORKS" },
    line = ccb.content.text("&The clerk smiles, \"Our Genetech is a marvel of modern science, capable of rewriting your very DNA.  We offer a wide range of treatments, from the mundanely medical to the exotic.  You need only select one of our templates and visit one of our editing machines in both ends of this store.  If you ever have doubts, remember that all our treatments are reversible.\""),
}

ccb.content.define_dialogue_topic {
    id = { "TALK_AUGUSTMOON_GENETECH_ESPER_WARNING" },
    line = ccb.content.text("&The clerk picks up a small device, \"Alright, I just need to do a preliminary scan.  If you please.\"  They gesture to your arm and you allow them to place the device against your skin.  There is a moment while the clerk watches the screen and then their eyebrows shoot up.  \"Whoa, esper heritage?  They told me to keep an eye out but I've never seen that before.  Where did I put that disclaimer they gave me…\"  The clerk turns and consults their console for a short while before they begin reciting, \"While we can guarantee that all Mercurial Genetch products have been tested in a wide variety of conditions and on a wide variety of subjects, Hyperspace Era noetic treatments are notoriously prone to degradation when further genetic modifications are applied.  Mercurial is not responsible for any reduction of esper potential or capability that may or may not occur as a result of our Genetech treatments.  If you have any concerns about your esper potential, we urge you to consult a licensed physician with a specialty in esper families.\"  They pause.  \"And no, before you ask, there isn't one in the system.  It's up to you if you think it's worth the risk.\""),
    replies = {
        {
            text = ccb.content.text("Huh.  Well, I better give it some thought."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_aftershock_exoplanet_e2d20d8f059a") },
        },
    },
}
