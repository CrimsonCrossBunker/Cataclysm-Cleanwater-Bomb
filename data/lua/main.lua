-- Bundled API v2 smoke test.  Edit this file while the game is running, then
-- press "Reload Lua" in the page; recompiling the game is not required.

local enabled = game.state_get("example.enabled", true)
local show_hud = game.state_get("example.show_hud", true)
-- math.floor also migrates values saved by the API v1 prototype, which stored
-- every Lua number as a floating-point value.
local amount = math.floor(game.state_get("example.amount", 50))
local opacity = game.state_get("example.opacity", 0.75)
local label = game.state_get("example.label", "这条消息来自热加载后的 Lua")
local move_count = game.state_get("example.move_count", 0)

ui.page("lua_ui_example", "Lua UI example", function(ctx)
    local player = game.player_snapshot()
    local clock = game.time_snapshot()
    local weather = game.weather_snapshot()
    local inventory = game.inventory_snapshot(8)
    local effects = game.effects_snapshot(8)
    local skills = game.skills_snapshot(6)
    local equipment = game.equipment_snapshot(16)
    local tile = game.current_tile_snapshot(8)
    local mutations = game.mutations_snapshot(8)
    local bionics = game.bionics_snapshot(8)
    local missions = game.missions_snapshot(8)
    local activity = game.activity_snapshot(8)
    local creatures = game.nearby_creatures_snapshot(12, 8)

    ctx:heading("Lua API v2")
    ctx:text_colored("Lua 热加载成功！", 0.3, 1.0, 0.45, 1.0)
    ctx:text("当前角色：" .. player.name)
    ctx:text("脚本：data/lua/main.lua / API " .. game.api_version)
    ctx:text("修改 Lua 后无需重新编译游戏。")
    ctx:text("时间：" .. clock.display)
    ctx:text("天气：" .. weather.name .. " / " .. weather.temperature_display)
    ctx:text("当前位置：" .. tile.terrain_name ..
             (tile.furniture_name ~= "" and " / " .. tile.furniture_name or ""))
    ctx:text("状态效果：" .. effects.total .. "  装备：" .. equipment.total)
    ctx:text("突变：" .. mutations.total .. "  仿生：" .. bionics.total ..
             "  任务：" .. missions.total)
    ctx:text("当前活动：" .. (activity.active and activity.current.verb or "无") ..
             "  可见生物：" .. creatures.total)
    ctx:text("随身物品：" .. inventory.total .. " 项（本页最多展示 " .. inventory.limit .. " 项）")
    for _, entry in ipairs(inventory.items) do
        ctx:bullet_text(entry.name .. " / " .. entry.category_name)
    end
    for _, entry in ipairs(effects.items) do
        ctx:bullet_text("效果：" .. entry.name .. " ×" .. entry.intensity)
    end
    for _, entry in ipairs(skills.items) do
        ctx:bullet_text("技能：" .. entry.name .. " " .. entry.level)
    end
    ctx:separator()

    enabled = ctx:checkbox("启用功能", enabled)
    show_hud = ctx:checkbox("显示 Lua HUD", show_hud)
    amount = ctx:slider_int("测试数值", amount, 0, 100)
    opacity = ctx:slider_float("界面透明度原型", opacity, 0.0, 1.0)
    label = ctx:input_text("游戏消息", label)
    ctx:progress_bar(amount / 100.0, "测试数值 " .. amount .. "%")
    ctx:bullet_text("本次进程记录的移动事件：" .. move_count)

    if ctx:button("发送游戏消息") then
        game.add_msg("[Lua] " .. label .. " / 数值=" .. amount ..
                     " / 透明度=" .. opacity .. (enabled and " / 已启用" or " / 已关闭"))
    end

    ctx:same_line()
    if ctx:button_id("queue_wait", "排队等待一回合") then
        game.actions.enqueue("wait")
    end

    if activity.active and activity.current.interruptible and
       ctx:button_id("cancel_activity", "取消当前活动") then
        game.actions.enqueue("cancel_activity")
    end

    ctx:same_line()
    if ctx:button("数值 +10") then
        amount = math.min(100, amount + 10)
    end

    game.state_set("example.enabled", enabled)
    game.state_set("example.show_hud", show_hud)
    game.state_set("example.amount", amount)
    game.state_set("example.opacity", opacity)
    game.state_set("example.label", label)
end)

ui.hud("lua_status", {
    title = "Lua hot reload status",
    default_anchor = "top_left",
    default_x = 24,
    default_y = 24,
    default_width = 0.30,
    default_height = 0.24,
    alpha = 0.86,
    interactive = false,
    title_bar = false,
    movable = true,
    scalable = true,
    user_toggleable = true
}, function(ctx)
    if not show_hud then
        return
    end
    local stats = game.player_snapshot()
    local clock = game.time_snapshot()
    local weather = game.weather_snapshot()
    ctx:text_colored("Lua HUD 热更新已生效！", 0.25, 1.0, 0.4, 1.0)
    ctx:text("角色：" .. stats.name)
    ctx:text(clock.season_name .. " 第 " .. clock.day .. " 天 " ..
             string.format("%02d:%02d", clock.hour, clock.minute))
    ctx:text("天气：" .. weather.name .. " / " .. weather.temperature_display)
    ctx:text("耐力 " .. stats.stamina .. "/" .. stats.stamina_max)
    ctx:progress_bar(stats.stamina / math.max(1, stats.stamina_max), "耐力")
    ctx:text("疼痛 " .. stats.pain .. "  专注 " .. stats.focus .. "  速度 " .. stats.speed)
    ctx:disabled_text("移动事件 " .. move_count .. " | API " .. game.api_version)
end)

events.on("avatar_moves", function(event)
    move_count = move_count + 1
    game.state_set("example.move_count", move_count)
end)
