package com.crimsoncrossbunker.cataclysmcb;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.Gravity;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.EditText;
import android.widget.FrameLayout;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.TextView;

import java.util.ArrayList;
import java.util.Collection;
import java.util.LinkedHashSet;
import java.util.List;

/**
 * Reusable searchable catalog dialog for HUD information sources and actions.
 *
 * Multi-choice selection is stored independently from the filtered ListView,
 * so narrowing or clearing a query never loses choices that are off screen.
 */
final class AndroidHudSearchDialog {
    static final class Item<T> {
        final T value;
        final String id;
        final String label;
        private final String[] searchFields;

        Item(T value, String id, String label, String... searchFields) {
            this.value = value;
            this.id = id;
            this.label = label;
            this.searchFields = new String[(searchFields == null ? 0 : searchFields.length) + 2];
            this.searchFields[0] = label;
            this.searchFields[1] = id;
            if (searchFields != null) {
                System.arraycopy(searchFields, 0, this.searchFields, 2, searchFields.length);
            }
        }

        boolean matches(String query) {
            return AndroidHudModel.matchesSearch(query, searchFields);
        }
    }

    interface SingleChoiceListener<T> {
        void selected(T value);
    }

    interface MultipleChoiceListener {
        /**
         * @return true to close the dialog, false to keep it open.
         */
        boolean confirmed(LinkedHashSet<String> selectedIds);
    }

    private AndroidHudSearchDialog() {
    }

    static <T> void showSingle(Context context, String title, String searchHint,
            List<Item<T>> items, SingleChoiceListener<T> listener) {
        CatalogView<T> catalog = new CatalogView<>(context, searchHint, items, null);
        AlertDialog dialog = new AlertDialog.Builder(context)
            .setTitle(title)
            .setView(catalog.root)
            .setNegativeButton("取消", null)
            .create();
        catalog.list.setOnItemClickListener((parent, view, position, id) -> {
            listener.selected(catalog.visible.get(position).value);
            dialog.dismiss();
        });
        dialog.show();
    }

    static <T> void showMultiple(Context context, String title, String searchHint,
            List<Item<T>> items, Collection<String> initiallySelected,
            String confirmLabel, MultipleChoiceListener listener) {
        LinkedHashSet<String> selected = new LinkedHashSet<>();
        if (initiallySelected != null) {
            selected.addAll(initiallySelected);
        }
        CatalogView<T> catalog = new CatalogView<>(context, searchHint, items, selected);
        AlertDialog dialog = new AlertDialog.Builder(context)
            .setTitle(title)
            .setView(catalog.root)
            .setPositiveButton(confirmLabel, null)
            .setNegativeButton("取消", null)
            .create();
        catalog.list.setOnItemClickListener((parent, view, position, id) -> {
            String itemId = catalog.visible.get(position).id;
            if (catalog.list.isItemChecked(position)) {
                selected.add(itemId);
            } else {
                selected.remove(itemId);
            }
        });
        dialog.setOnShowListener(ignored -> dialog.getButton(
            DialogInterface.BUTTON_POSITIVE).setOnClickListener(view -> {
                if (listener.confirmed(new LinkedHashSet<>(selected))) {
                    dialog.dismiss();
                }
            }));
        dialog.show();
    }

    private static final class CatalogView<T> {
        final LinearLayout root;
        final ListView list;
        final ArrayList<Item<T>> visible = new ArrayList<>();

        private final List<Item<T>> all;
        private final ArrayAdapter<String> adapter;
        private final LinkedHashSet<String> selected;

        CatalogView(Context context, String searchHint, List<Item<T>> items,
                LinkedHashSet<String> selected) {
            all = items;
            this.selected = selected;

            root = new LinearLayout(context);
            root.setOrientation(LinearLayout.VERTICAL);
            int padding = dp(context, 18);
            root.setPadding(padding, dp(context, 4), padding, dp(context, 8));

            EditText search = new EditText(context);
            search.setHint(searchHint);
            search.setSingleLine(true);
            search.setContentDescription(searchHint);
            root.addView(search, new LinearLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT));

            FrameLayout results = new FrameLayout(context);
            int maximumHeight = dp(context, 420);
            int availableHeight = Math.round(
                context.getResources().getDisplayMetrics().heightPixels * .55f);
            root.addView(results, new LinearLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT, Math.min(maximumHeight, availableHeight)));

            list = new ListView(context);
            list.setChoiceMode(selected == null ?
                ListView.CHOICE_MODE_SINGLE : ListView.CHOICE_MODE_MULTIPLE);
            adapter = new ArrayAdapter<>(context,
                selected == null ? android.R.layout.simple_list_item_1 :
                    android.R.layout.simple_list_item_multiple_choice,
                new ArrayList<>());
            adapter.setNotifyOnChange(false);
            list.setAdapter(adapter);
            results.addView(list, new FrameLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT));

            TextView empty = new TextView(context);
            empty.setText("没有匹配项");
            empty.setGravity(Gravity.CENTER);
            results.addView(empty, new FrameLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT));
            list.setEmptyView(empty);

            search.addTextChangedListener(new TextWatcher() {
                @Override public void beforeTextChanged(CharSequence text, int start,
                        int count, int after) {
                }

                @Override public void onTextChanged(CharSequence text, int start,
                        int before, int count) {
                }

                @Override public void afterTextChanged(Editable text) {
                    filter(text == null ? "" : text.toString());
                }
            });
            filter("");
        }

        private void filter(String query) {
            visible.clear();
            adapter.clear();
            for (Item<T> item : all) {
                if (item.matches(query)) {
                    visible.add(item);
                    adapter.add(item.label);
                }
            }
            adapter.notifyDataSetChanged();
            if (selected != null) {
                list.clearChoices();
                for (int i = 0; i < visible.size(); ++i) {
                    list.setItemChecked(i, selected.contains(visible.get(i).id));
                }
            }
        }
    }

    private static int dp(Context context, int value) {
        return Math.round(value * context.getResources().getDisplayMetrics().density);
    }
}
