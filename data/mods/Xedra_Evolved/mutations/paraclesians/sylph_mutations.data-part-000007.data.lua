local ccb = require("ccb")

ccb.content.define_mutation {
    id = "SYLPH_CLOUD_FORM",
    name = ccb.content.text("Body of Cloud"),
    points = 11,
    description = ccb.content.text("The Sylph may transform into misty cloud.  They will be insubstantial and unable to interact with the environment, but also able to move incredibly quickly and attacks will simply pass through them.  Each second in the cloud form will cost 10 mana."),
    prerequisites = { "SYLPH_FLY_AT_WILL" },
    categories = { "SYLPH" },
    purifiable = false,
    threshold_requirements = { "THRESH_SYLPH" },
    active = true,
    activation_setup_only = true,
    on_activate = "sylph_enter_cloud_form",
    on_deactivate = "sylph_leave_cloud_form",
    on_process = "sylph_maintain_cloud_form",
}
