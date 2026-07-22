package org.libsdl.app;

import android.content.Context;
import android.view.KeyEvent;
import android.view.inputmethod.EditorInfo;
import android.view.inputmethod.InputConnection;

/**
 * SDL text editor with deletion support for Android keyboards that use newer
 * InputConnection APIs or send KEYCODE_DEL directly.
 *
 * SDLInputConnection only specializes deleteSurroundingText().  Some vendor
 * keyboards instead call deleteSurroundingTextInCodePoints(), while others
 * deliver KEYCODE_DEL through sendKeyEvent().  Normalize all three paths to
 * SDL's synthetic backspace event so native text widgets receive the same
 * input regardless of the selected keyboard.
 */
public final class CleanwaterDummyEdit extends SDLDummyEdit {
    public CleanwaterDummyEdit(Context context) {
        super(context);
    }

    @Override
    public InputConnection onCreateInputConnection(EditorInfo outAttrs) {
        ic = new CleanwaterInputConnection(this, true);
        outAttrs.inputType = input_type;
        outAttrs.imeOptions = EditorInfo.IME_FLAG_NO_EXTRACT_UI |
                              EditorInfo.IME_FLAG_NO_FULLSCREEN;
        return ic;
    }
}

final class CleanwaterInputConnection extends SDLInputConnection {
    CleanwaterInputConnection(CleanwaterDummyEdit targetView, boolean fullEditor) {
        super(targetView, fullEditor);
    }

    @Override
    public boolean sendKeyEvent(KeyEvent event) {
        if (event.getKeyCode() == KeyEvent.KEYCODE_DEL) {
            if (event.getAction() == KeyEvent.ACTION_DOWN) {
                nativeGenerateScancodeForUnichar('\b');
            }
            return true;
        }
        return super.sendKeyEvent(event);
    }

    @Override
    public boolean deleteSurroundingTextInCodePoints(int beforeLength, int afterLength) {
        if (beforeLength > 0 && afterLength == 0) {
            while (beforeLength-- > 0) {
                nativeGenerateScancodeForUnichar('\b');
            }
            return true;
        }
        if (!super.deleteSurroundingTextInCodePoints(beforeLength, afterLength)) {
            return false;
        }
        updateText();
        return true;
    }
}
