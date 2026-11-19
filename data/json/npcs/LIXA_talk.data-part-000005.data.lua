local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

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
