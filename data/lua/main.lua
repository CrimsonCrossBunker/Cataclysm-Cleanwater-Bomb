-- Built-in gameplay HUD.  The script only reads immutable snapshots; layout
-- overrides belong to the renderer and survive Lua hot reloads.

local function percentage(value, maximum)
    if maximum == nil or maximum <= 0 then
        return 0
    end
    return math.max(0, math.min(100, math.floor(value * 100 / maximum + 0.5)))
end

local function append_alert(alerts, active, label, value)
    if active then
        table.insert(alerts, label .. " " .. value)
    end
end

local action_groups = {
    {
        id = "movement",
        default = "reset_move",
        actions = {
            { id = "toggle_prone", label = "俯卧" },
            { id = "toggle_crouch", label = "蹲伏" },
            { id = "reset_move", label = "行走" },
            { id = "toggle_run", label = "奔跑" }
        }
    },
    {
        id = "observe",
        default = "look",
        actions = {
            { id = "look", label = "观察" },
            { id = "peek", label = "窥视" }
        }
    },
    {
        id = "combat",
        default = "autoattack",
        actions = {
            { id = "autoattack", label = "攻击" },
            { id = "fire", label = "射击" }
        }
    },
    {
        id = "character",
        default = "player_data",
        actions = {
            { id = "player_data", label = "个人信息" },
            { id = "bodystatus", label = "身体信息" },
            { id = "medical", label = "医疗" }
        }
    },
    {
        id = "safe_mode",
        default = "safemode",
        actions = {
            { id = "safemode", label = "安全模式" }
        }
    },
    {
        id = "hauling",
        default = "haul",
        actions = {
            { id = "haul", label = "搬运" },
            { id = "grab", label = "抓住" }
        }
    },
    {
        id = "interaction",
        default = "interact",
        actions = {
            { id = "interact", label = "互动" },
            { id = "open", label = "开门" },
            { id = "close", label = "关门" }
        }
    },
    {
        id = "work",
        default = "craft",
        actions = {
            { id = "craft", label = "制作" },
            { id = "construct", label = "建造" },
            { id = "disassemble", label = "拆解" }
        }
    },
    {
        id = "inventory",
        default = "inventory",
        actions = {
            { id = "inventory", label = "物品栏" },
            { id = "insert", label = "放入" },
            { id = "unload", label = "清空" },
            { id = "compare", label = "比较" },
            { id = "advinv", label = "高级物品管理" }
        }
    },
    {
        id = "ground_items",
        default = "pickup",
        actions = {
            { id = "pickup", label = "拾取" },
            { id = "drop_adj", label = "丢旁边" },
            { id = "drop", label = "丢脚下" }
        }
    },
    {
        id = "held_item",
        default = "wield",
        actions = {
            { id = "wield", label = "手持" },
            { id = "throw", label = "投掷" }
        }
    },
    {
        id = "clothing",
        default = "wear",
        actions = {
            { id = "wear", label = "穿上" },
            { id = "take_off", label = "脱下" }
        }
    },
    {
        id = "other",
        default = "map",
        actions = {
            { id = "factions", label = "阵营" },
            { id = "sleep", label = "睡觉" },
            { id = "item_action_menu", label = "物品使用菜单" },
            { id = "bionics", label = "生化插件" },
            { id = "missions", label = "任务" },
            { id = "morale", label = "士气" },
            { id = "messages", label = "日志" },
            { id = "chat", label = "叫喊" },
            { id = "diary", label = "日记" },
            { id = "map", label = "地图" }
        }
    }
}

local function draw_action_groups(ctx, first, last)
    local input = game.actions.context_snapshot()
    for index = first, last do
        local group = action_groups[index]
        local options = {}
        for _, action in ipairs(group.actions) do
            if input.available[action.id] then
                table.insert(options, action)
            end
        end
        local state_key = "hud.action_slot." .. group.id
        local selected = game.state_get(state_key, group.default)
        local current = ctx:action_slot_id(
            group.id, selected, input.revision, options)
        if current ~= "" and current ~= selected then
            game.state_set(state_key, current)
        end
    end
end

ui.hud("ccb_player_status", {
    title = "角色状态",
    default_anchor = "top_left",
    default_x = 16,
    default_y = 16,
    default_width = 0.27,
    default_height = 0.27,
    alpha = 0.84,
    interactive = false,
    background = false,
    title_bar = false,
    movable = true,
    scalable = true,
    user_toggleable = true
}, function(ctx)
    local player = game.player_snapshot()
    local equipment = game.equipment_snapshot(1)
    local stamina_percent = percentage(player.stamina, player.stamina_max)

    ctx:text(player.name)
    ctx:progress_bar(stamina_percent / 100.0, "耐力 " .. stamina_percent .. "%")

    local core_status = "疼痛 " .. player.pain ..
                        "  专注 " .. player.focus ..
                        "  速度 " .. player.speed
    if player.pain > 0 then
        ctx:text_colored(core_status, 1.0, 0.45, 0.38, 1.0)
    else
        ctx:disabled_text(core_status)
    end

    local alerts = {}
    append_alert(alerts, player.hunger >= 100, "饥饿", player.hunger)
    append_alert(alerts, player.thirst >= 80, "口渴", player.thirst)
    append_alert(alerts, player.sleepiness >= 192, "疲劳", player.sleepiness)
    append_alert(alerts, player.radiation > 0, "辐射", player.radiation)
    if #alerts > 0 then
        ctx:text_colored(table.concat(alerts, "  "), 1.0, 0.72, 0.25, 1.0)
    end

    if equipment.has_weapon and equipment.weapon ~= nil then
        ctx:text("武器：" .. equipment.weapon.name)
    else
        ctx:disabled_text("武器：空手")
    end
end)

ui.hud("ccb_quick_actions", {
    title = "常用动作",
    contexts = { "DEFAULTMODE" },
    default_anchor = "top_right",
    default_x = 16,
    default_y = 16,
    default_width = 0.18,
    default_height = 0.78,
    alpha = 0.92,
    interactive = true,
    background = false,
    title_bar = false,
    movable = true,
    scalable = true,
    user_toggleable = true
}, function(ctx)
    draw_action_groups(ctx, 1, 7)
end)

ui.hud("ccb_more_actions", {
    title = "更多动作",
    contexts = { "DEFAULTMODE" },
    default_anchor = "top_right",
    default_x = 190,
    default_y = 16,
    default_width = 0.18,
    default_height = 0.70,
    alpha = 0.92,
    interactive = true,
    background = false,
    title_bar = false,
    movable = true,
    scalable = true,
    user_toggleable = true
}, function(ctx)
    draw_action_groups(ctx, 8, #action_groups)
end)

ui.hud("ccb_world_status", {
    title = "环境信息",
    default_anchor = "top_right",
    default_x = 88,
    default_y = 16,
    default_width = 0.30,
    default_height = 0.18,
    alpha = 0.80,
    interactive = false,
    background = false,
    title_bar = false,
    movable = true,
    scalable = true,
    user_toggleable = true
}, function(ctx)
    local clock = game.time_snapshot()
    local weather = game.weather_snapshot()
    local tile = game.current_tile_snapshot(8)

    ctx:text(clock.season_name .. " 第 " .. clock.day .. " 天  " ..
             string.format("%02d:%02d", clock.hour, clock.minute))

    local weather_text = weather.name .. "  " .. weather.temperature_display
    if weather.dangerous then
        ctx:text_colored(weather_text, 1.0, 0.48, 0.35, 1.0)
    else
        ctx:text(weather_text)
    end

    local location = tile.terrain_name
    if tile.furniture_name ~= "" then
        location = location .. " / " .. tile.furniture_name
    end
    ctx:text(location)

    if tile.dangerous_field or tile.trap_dangerous then
        ctx:text_colored("当前位置存在危险", 1.0, 0.35, 0.30, 1.0)
    elseif tile.item_count > 0 then
        ctx:disabled_text("地面物品 " .. tile.item_count)
    end
end)
