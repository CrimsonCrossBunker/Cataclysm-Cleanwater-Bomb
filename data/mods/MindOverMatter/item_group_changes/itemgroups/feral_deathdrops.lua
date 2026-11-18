local content = require("ccb").content

do
    local group = content.ItemGroup { id = "mon_feral_survivalist_death_drops", kind = "collection" }
    group:group("concentrated_matrix_elixirs", 5)
    group:group("concentrated_matrix_elixirs", 1)
    content.extend_item_group(group)
end
