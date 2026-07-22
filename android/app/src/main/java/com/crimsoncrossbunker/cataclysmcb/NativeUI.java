package com.crimsoncrossbunker.cataclysmcb;

import java.util.concurrent.Semaphore;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.text.InputFilter;
import android.text.InputType;
import android.view.WindowManager;
import android.view.inputmethod.InputMethodManager;
import android.widget.EditText;
import android.widget.LinearLayout;

public class NativeUI {
    enum YesNoDialogResponse {
        YES,
        NO
    }

    private CataclysmDDA activity;

    NativeUI(CataclysmDDA activity) {
        this.activity = activity;
    }

    private class Popup {
        private Semaphore semaphore = new Semaphore(0, true);

        public void popup(final String message) {
            activity.runOnUiThread(new Runnable() {
                public void run() {
                    AlertDialog dialog = new AlertDialog.Builder(activity, R.style.AlertDialogTheme)
                            .setTitle("")
                            .setCancelable(false)
                            .setMessage(message)
                            .setNeutralButton(R.string.ok, new DialogInterface.OnClickListener() {
                                public void onClick(DialogInterface dialog, int id) {
                                    semaphore.release();
                                }
                            }).create();
                    dialog.show();
                }
            });

            try {
                semaphore.acquire();
            } catch (InterruptedException ex) {
                // No-op
            }
        }
    }

    private class QueryYN {
        private Semaphore semaphore = new Semaphore(0, true);

        private YesNoDialogResponse response;

        public boolean queryYN(final String message) {
            activity.runOnUiThread(new Runnable() {
                public void run() {
                    AlertDialog dialog = new AlertDialog.Builder(activity, R.style.AlertDialogTheme)
                            .setTitle("")
                            .setCancelable(false)
                            .setMessage(message)
                            .setPositiveButton(R.string.yes, new DialogInterface.OnClickListener() {
                                public void onClick(DialogInterface dialog, int id) {
                                    response = YesNoDialogResponse.YES;
                                    semaphore.release();
                                }
                            })
                            .setNegativeButton(R.string.no, new DialogInterface.OnClickListener() {
                                public void onClick(DialogInterface dialog, int id) {
                                    response = YesNoDialogResponse.NO;
                                    semaphore.release();
                                }
                            }).create();
                    dialog.show();
                }
            });

            try {
                semaphore.acquire();
            } catch (InterruptedException ex) {
                // No-op
            }

            return response == YesNoDialogResponse.YES;
        }
    }

    private class SingleChoiceList {
        private Semaphore semaphore = new Semaphore(0, true);

        private int singleChoiceResponse;

        private final int cancel = -1;
        private final int init = -2;

        private String[] mixOptionsText(final String[] options, final boolean[] enabled) {
            String[] result = new String[options.length];
            for (int i = 0; i < options.length; i++) {
                if (enabled[i]) {
                    result[i] = options[i];
                } else {
                    result[i] = String.format("%s [%s]", options[i], activity.getString(R.string.unavailable));
                }
            }
            return result;
        }

        public int singleChoiceList(final String text, final String[] options, final boolean[] enabled) {
            singleChoiceResponse = init;

            final String[] choices = mixOptionsText(options, enabled);

            while (singleChoiceResponse == init
                    || (singleChoiceResponse != cancel && enabled[singleChoiceResponse] == false)) {
                activity.runOnUiThread(new Runnable() {
                    public void run() {
                        AlertDialog dialog = new AlertDialog.Builder(activity, R.style.AlertDialogTheme)
                                .setTitle(text)
                                .setItems(choices, new DialogInterface.OnClickListener() {
                                    public void onClick(DialogInterface dialog, int which) {
                                        singleChoiceResponse = which;
                                        semaphore.release();
                                    }
                                })
                                .setOnCancelListener(new DialogInterface.OnCancelListener() {
                                    public void onCancel(DialogInterface dialog) {
                                        singleChoiceResponse = cancel;
                                        semaphore.release();
                                    }
                                })
                                .create();
                        dialog.show();
                    }
                });

                try {
                    semaphore.acquire();
                } catch (InterruptedException ex) {
                    // No-op
                }

                if (singleChoiceResponse != cancel && enabled[singleChoiceResponse] == false) {
                    new Popup().popup(activity.getString(R.string.unavailableOption));
                }
            }

            return singleChoiceResponse;
        }
    }

    private class TextInput {
        private final Semaphore semaphore = new Semaphore(0, true);
        private String response;

        public String textInput(final String title, final String initialValue,
                final int maxLength) {
            response = null;
            activity.runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    final EditText input = new EditText(activity);
                    input.setSingleLine(true);
                    input.setInputType(InputType.TYPE_CLASS_TEXT
                        | InputType.TYPE_TEXT_FLAG_CAP_WORDS);
                    input.setText(initialValue);
                    if (maxLength > 0) {
                        input.setFilters(new InputFilter[] {
                            new InputFilter.LengthFilter(maxLength)
                        });
                    }

                    int padding = Math.round(20f
                        * activity.getResources().getDisplayMetrics().density);
                    LinearLayout container = new LinearLayout(activity);
                    container.setPadding(padding, 0, padding, 0);
                    container.addView(input, new LinearLayout.LayoutParams(
                        LinearLayout.LayoutParams.MATCH_PARENT,
                        LinearLayout.LayoutParams.WRAP_CONTENT));

                    final AlertDialog dialog = new AlertDialog.Builder(
                            activity, R.style.AlertDialogTheme)
                        .setTitle(title)
                        .setView(container)
                        .setPositiveButton(R.string.ok, new DialogInterface.OnClickListener() {
                            @Override
                            public void onClick(DialogInterface ignored, int which) {
                                response = input.getText().toString();
                                semaphore.release();
                            }
                        })
                        .setNegativeButton(R.string.cancel, new DialogInterface.OnClickListener() {
                            @Override
                            public void onClick(DialogInterface ignored, int which) {
                                response = null;
                                semaphore.release();
                            }
                        })
                        .setOnCancelListener(new DialogInterface.OnCancelListener() {
                            @Override
                            public void onCancel(DialogInterface ignored) {
                                response = null;
                                semaphore.release();
                            }
                        })
                        .create();
                    dialog.setOnShowListener(new DialogInterface.OnShowListener() {
                        @Override
                        public void onShow(DialogInterface ignored) {
                            input.requestFocus();
                            input.selectAll();
                            if (dialog.getWindow() != null) {
                                dialog.getWindow().setSoftInputMode(
                                    WindowManager.LayoutParams.SOFT_INPUT_STATE_ALWAYS_VISIBLE
                                    | WindowManager.LayoutParams.SOFT_INPUT_ADJUST_RESIZE);
                            }
                            InputMethodManager keyboard = (InputMethodManager)
                                activity.getSystemService(Context.INPUT_METHOD_SERVICE);
                            if (keyboard != null) {
                                keyboard.showSoftInput(input, InputMethodManager.SHOW_IMPLICIT);
                            }
                        }
                    });
                    dialog.show();
                }
            });

            try {
                semaphore.acquire();
            } catch (InterruptedException ex) {
                Thread.currentThread().interrupt();
                return null;
            }
            return response;
        }
    }

    public void popup(final String message) {
        final Popup popup = new Popup();
        popup.popup(message);
    }

    public boolean queryYN(final String message) {
        final QueryYN queryYN = new QueryYN();
        return queryYN.queryYN(message);
    }

    public int singleChoiceList(final String text, final String[] options, final boolean[] enabled) {
        final SingleChoiceList singleChoiceList = new SingleChoiceList();
        return singleChoiceList.singleChoiceList(text, options, enabled);
    }

    public String textInput(final String title, final String initialValue, final int maxLength) {
        return new TextInput().textInput(title, initialValue, maxLength);
    }
}
