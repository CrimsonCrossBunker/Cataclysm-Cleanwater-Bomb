local ccb = require("ccb")
local content = ccb.content

-- Native weighted fault groups
do
local definition = content.FaultGroup {
    id = "carbide_armor",
}
definition:fault("fault_armor_carbide", 100)
definition:fault("fault_armor_carbide_bad", 5)
content.add(definition)
end
do
local definition = content.FaultGroup {
    id = "afs_steel_armor",
}
definition:fault("afs_fault_armor_steel", 100)
definition:fault("afs_fault_armor_steel_bad", 5)
content.add(definition)
end
do
local definition = content.FaultGroup {
    id = "electronic_general",
}
definition:fault("fault_emp_reboot", 100)
content.replace(definition)
end
