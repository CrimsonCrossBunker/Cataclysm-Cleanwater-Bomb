package com.crimsoncrossbunker.cataclysmcb;

import android.view.View;
import android.widget.PopupMenu;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Shared action-choice presentation for interactive HUD elements.
 *
 * The model owns configured action IDs, the active scene owns the available
 * action catalog, and the overlay remains the only component allowed to
 * dispatch an action.  This class only intersects both lists and presents a
 * consistent menu; it never executes game actions itself.
 */
final class AndroidHudActionMenu {
    interface SelectionListener {
        void onSelected(String actionId);
    }

    private AndroidHudActionMenu() {
    }

    static ArrayList<String> availableActions(AndroidHudModel.Element element,
            Map<String, AndroidHudModel.ActionDescriptor> catalog) {
        ArrayList<String> result = new ArrayList<>();
        if (!AndroidHudModel.supportsActionBinding(element) || catalog == null) {
            return result;
        }
        for (String actionId : element.actionIds) {
            if (catalog.containsKey(actionId)) {
                result.add(actionId);
            }
        }
        return result;
    }

    static void show(View anchor, List<String> actionIds,
            Map<String, AndroidHudModel.ActionDescriptor> catalog,
            String checkedActionId, SelectionListener listener) {
        if (anchor == null || actionIds == null || actionIds.isEmpty() ||
                catalog == null || listener == null) {
            return;
        }
        PopupMenu menu = new PopupMenu(anchor.getContext(), anchor);
        for (int index = 0; index < actionIds.size(); ++index) {
            String actionId = actionIds.get(index);
            AndroidHudModel.ActionDescriptor action = catalog.get(actionId);
            String label = action == null || action.label.isEmpty() ?
                actionId : action.label;
            if (action != null && !AndroidHudModel.RISK_SAFE.equals(action.risk)) {
                label = "⚠ " + label;
            }
            if (actionId.equals(checkedActionId)) {
                label = "✓ " + label;
            }
            menu.getMenu().add(0, index, index, label);
        }
        menu.setOnMenuItemClickListener(item -> {
            int index = item.getItemId();
            if (index < 0 || index >= actionIds.size()) {
                return false;
            }
            listener.onSelected(actionIds.get(index));
            return true;
        });
        menu.show();
    }
}
