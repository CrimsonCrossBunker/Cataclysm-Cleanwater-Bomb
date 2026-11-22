local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_ROBOFAC_INTERCOM_ANCHOR_PT_1_STARTED", "TALK_ROBOFAC_INTERCOM_ANCHOR_PT_2_STARTED", "TALK_ROBOFAC_INTERCOM_RESONANCE_SUIT_PT_1_STARTED", "TALK_ROBOFAC_INTERCOM_RESONANCE_SUIT_PT_2_STARTED", "TALK_ROBOFAC_INTERCOM_HEW_UPGRADE_STARTED", "TALK_ROBOFAC_INTERCOM_ARMOR_STARTED", "TALK_ROBOFAC_INTERCOM_PROTOTYPE_MENU", "TALK_ROBOFAC_INTERCOM_REPAIR_STARTED_LONG", "TALK_ROBOFAC_INTERCOM_REPAIR_STARTED_SHORT", "TALK_ROBOFAC_INTERCOM_RIFLE_STARTED" },
    line = ccb.content.text("What project would you like to know about?"),
    replies = {
        {
            text = ccb.content.text("Have you decoded the disk?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_ARMOR_BREAKTHROUGH",
            when = predicates.handler("w16b_p_dda_b48c54e1e2a9"),
        },
        {
            text = ccb.content.text("[6 HGC] I'd like to buy the rest of the armor set now."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
            when = predicates.handler("w16b_p_dda_51aa2fb965a7"),
            actions = { actions.handler("w16b_a_dda_64a68bf9b5df"), actions.clear_actor_value("speaker", "dialogue_hub_rnd_u_can_buy_armor") },
        },
        {
            text = ccb.content.text("I'd like to request a Hybrid Weapons Platform."),
            next_topic = "TALK_ROBOFAC_INTERCOM_RIFLE_REQUEST",
            when = predicates.handler("w16b_p_dda_f21d2511f384"),
        },
        {
            text = ccb.content.text("How goes work on the HWP?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_RIFLE_BREAKTHROUGH",
            when = predicates.handler("w16b_p_dda_24d90ed9d882"),
        },
        {
            text = ccb.content.text("I'd like to request a set of armor."),
            next_topic = "TALK_ROBOFAC_INTERCOM_ARMOR_REQUEST",
            when = predicates.handler("w16b_p_dda_f21d2511f384"),
        },
        {
            text = ccb.content.text("How is my ordered armor going?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_ARMOR_FINISHED",
            when = predicates.handler("w16b_p_dda_690ac67f75b5"),
        },
        {
            text = ccb.content.text("I would like you to upgrade my modular defense system."),
            next_topic = "TALK_ROBOFAC_INTERCOM_ANCHOR_PT_2",
            when = predicates.handler("w16b_p_dda_bfd9d51e57e1"),
        },
        {
            text = ccb.content.text("I would like you to make the hazardous materials prototype."),
            next_topic = "TALK_ROBOFAC_INTERCOM_RESONANCE_SUIT_PT_2",
            when = predicates.handler("w16b_p_dda_3c717f06f9ce"),
        },
        {
            text = ccb.content.text("My phase immersion suit has taken a serious beating.  Could someone repair it for me?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_PHASE_REPAIR",
            when = predicates.handler("w16b_p_dda_a6e0a06374ab"),
        },
        {
            text = ccb.content.text("My RM13 combat armor has taken some damage.  Could someone repair it for me?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_RM13_REPAIR",
            when = predicates.handler("w16b_p_dda_be11e37ce5f8"),
        },
        {
            text = ccb.content.text("I salvaged this combat exoskeleton.  Do you think you could repair it?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_EXOSKELETON_REPAIR",
            when = predicates.handler("w16b_p_dda_2db687ba25ae"),
        },
        {
            text = ccb.content.text("My hazardous materials suit has taken a damage.  Could someone repair it for me?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_RESONANCE_SUIT_REPAIR",
            when = predicates.handler("w16b_p_dda_8434301dc662"),
        },
        {
            text = ccb.content.text("How are my armor repairs coming?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_REPAIR",
            when = predicates.any({ predicates.any_equal({ "combat_exoskeleton_light_salvaged", { scope = "speaker", key = "dialogue_hub_rnd_u_current_project" } }), predicates.any_equal({ "phase_immersion_suit", { scope = "speaker", key = "dialogue_hub_rnd_u_current_project" } }), predicates.any_equal({ "rm13_armor", { scope = "speaker", key = "dialogue_hub_rnd_u_current_project" } }), predicates.any_equal({ "resonance_suit", { scope = "speaker", key = "dialogue_hub_rnd_u_current_project" } }) }),
        },
        {
            text = ccb.content.text("I've found this piece of XEDRA tech; it seems to offer some kind of protection.  I'm curious what you all can make of it."),
            next_topic = "TALK_ROBOFAC_INTERCOM_ANCHOR_PT_1",
            when = predicates.handler("w16b_p_dda_4c3b44384355"),
        },
        {
            text = ccb.content.text("Any progress on the anchor?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_ANCHOR_PT_1_COMPLETE",
            when = predicates.any_equal({ "anchor_pt_1", { scope = "speaker", key = "dialogue_hub_rnd_u_current_project" } }),
        },
        {
            text = ccb.content.text("Any progress on the Hub anchor?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_ANCHOR_PT_2_COMPLETE",
            when = predicates.any_equal({ "anchor_pt_2", { scope = "speaker", key = "dialogue_hub_rnd_u_current_project" } }),
        },
        {
            text = ccb.content.text("I've found this odd XEDRA cleansuit.  I'm curious what you all can make of it."),
            next_topic = "TALK_ROBOFAC_INTERCOM_RESONANCE_SUIT_PT_1",
            when = predicates.handler("w16b_p_dda_11f1425194b0"),
        },
        {
            text = ccb.content.text("Any progress on the cleansuit?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_RESONANCE_SUIT_PT_1_COMPLETE",
            when = predicates.any_equal({ "resonance_suit_pt_1", { scope = "speaker", key = "dialogue_hub_rnd_u_current_project" } }),
        },
        {
            text = ccb.content.text("Any progress on the new prototype environment suit?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_RESONANCE_SUIT_PT_2_COMPLETE",
            when = predicates.any_equal({ "resonance_suit_pt_2", { scope = "speaker", key = "dialogue_hub_rnd_u_current_project" } }),
        },
        {
            text = ccb.content.text("You mentioned you could improve my HEW system.  Can you tell me more?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_HEW_UPGRADE",
            when = predicates.handler("w16b_p_dda_c54cbad21301"),
        },
        {
            text = ccb.content.text("Any progress on the HEW-NRE system?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_HEW_UPGRADE_COMPLETE",
            when = predicates.any_equal({ "hew_upgrade", { scope = "speaker", key = "dialogue_hub_rnd_u_current_project" } }),
        },
        {
            text = ccb.content.text("Any progress on that AR headset?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_IVAS_COMPLETE",
            when = predicates.any_equal({ "ivas", { scope = "speaker", key = "dialogue_hub_rnd_u_current_project" } }),
        },
        {
            text = ccb.content.text("I've found a rifle chambered for a caliber I don't recognize.  Do you think you could make an HWP adapter for it?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_HWP_EXODII",
            when = predicates.handler("w16b_p_dda_bb9ae721a5aa"),
        },
        {
            text = ccb.content.text("Have you finished work on that exotic conversion kit?"),
            next_topic = "TALK_ROBOFAC_INTERCOM_HWP_EXODII_COMPLETE",
            when = predicates.any_equal({ "hwp_exodii", { scope = "speaker", key = "dialogue_hub_rnd_u_current_project" } }),
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
        },
    },
}
