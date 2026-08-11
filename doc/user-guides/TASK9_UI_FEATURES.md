# Task9 UI Features (2026-08)

Three small UI changes adopted from community proposals (QQ #101/#183/#193).

## 1. Crafted liquids can be consumed directly

**Proposal**: QQ#101 — 制作液体加「食用」选项.

When crafting produces a liquid (e.g. clean water, soup), the liquid-handling
menu that appears now offers "Consume it" (`e`) in addition to pouring into a
container / vehicle / ground. Previously the option was only shown for liquids
with a vehicle or map source; freshly crafted liquids had no consume option.

This matches Cataclysm-BN behaviour. Liquids obtained from monsters remain
excluded.

Affected code: `src/handle_liquid.cpp` (relaxed the consume-option condition).

## 2. Inventory screen direct wield/wear keys

**Proposal**: QQ#193 — i 物品栏界面集成 g 界面按键（w 手持 / W 穿戴直按）.

While browsing the inventory (`i`), the currently highlighted item can be
wielded or worn directly by pressing `w` / `W`, without opening the item action
menu and without leaving the inventory screen:

- `w` — wield the highlighted item (immediately; consumes the usual move cost).
  The list refreshes and the selection moves to the next item.
- `W` — wear the highlighted item (immediately). Interactive prompts (body
  part / layer choices) behave as in the game's normal wear flow.
- If the item cannot be wielded/worn, a specific reason is shown and the
  inventory screen stays open.

The key hints (`w`/`W`) are shown in the inventory screen header.

Affected code: `src/inventory_ui.h/.cpp`, `src/game_inventory.cpp`.

## 3. Auto travel paces to the slowest follower

**Proposal**: QQ#183 — 自动旅行速度同步队伍最慢 NPC.

While the avatar is auto-moving (auto travel mode or destination travel), if a
following NPC that is slower than the avatar falls behind beyond its follow
radius, the avatar spends the rest of the turn waiting ("You slow down to let
X catch up.") so the party stays together. Followers that keep up (same or
higher speed) never trigger the wait.

Affected code: `src/handle_action.cpp` (auto-move step).

## Testing

Manual test steps are tracked in the CCB task archive
(`ccb-archive/task9-ui-memo.md`, section 6). All three changes were verified
in-game by the responsible human on 2026-08-11.
