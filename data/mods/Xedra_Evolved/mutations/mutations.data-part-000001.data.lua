local ccb = require("ccb")

ccb.content.define_mutation {
    id = "DHAMPIR_FANGS",
    name = ccb.content.text("Dhampir Fangs"),
    points = 1,
    description = ccb.content.text("You have a set of small fangs, not as long as a true vampire's, but on the other hand, you can retract them to more easily conceal them.  Activate to extend your fangs."),
    types = { "TEETH" },
    active = true,
    activation_setup_only = true,
    activation_message = ccb.content.text("Your fangs lengthen."),
    enchantments = { "INLINE_ENCH_DHAMPIR_FANGS_0" },
    on_activate = "enable_dhampir_fangs",
    on_deactivate = "disable_dhampir_fangs",
}
