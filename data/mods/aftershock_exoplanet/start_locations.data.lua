local ccb = require("ccb")

ccb.content.define_start_location {
    id = "sloc_robot_dispatch",
    name = ccb.content.text("Robot Dispatch Center"),
    targets = { "robot_dispatch_second" },
}

ccb.content.define_start_location {
    id = "sloc_afs_augmentation_clinic_n3",
    name = ccb.content.text("Augclinic"),
    targets = { "afs_augmentation_clinic_n3" },
}

ccb.content.define_start_location {
    id = "sloc_afs_glacial_tunnels",
    name = ccb.content.text("Exploring a tunnel"),
    targets = { "afs_tunnel_sinkhole" },
}
