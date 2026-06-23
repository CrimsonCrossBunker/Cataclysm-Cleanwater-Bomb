// Headless platform backend.
//
// Phase 0 of the simulate/present decoupling (see plan
// sim-render-decoupling-plan.md). This file is the curses-free analogue of
// ncurses_def.cpp / wincurse.cpp: it provides the catacurses interface, the
// platform entry points, the input_manager hooks, the nc_color helpers, and
// the ImTui ncurses-platform shims -- but touches no terminal at all.
//
// The design is "headless == the IMTUI build minus real terminal I/O":
//   * Dear ImGui (cata_imgui.cpp) is an unconditional dependency and is reused
//     as-is.
//   * imtui-impl-text.cpp rasterises ImGui draw data into an in-memory
//     ImTui::TScreen cell buffer with zero curses calls; it is reused as-is.
//   * Only the terminal-touching layers are swapped out here: the catacurses
//     window backend (real ncurses ::WINDOW forwarding) and the ImTui ncurses
//     platform layer (ImTui_ImplNcurses_*).
//
// The in-memory TScreen left behind by imtui-impl-text captures only the Dear
// ImGui-rendered widgets. It is NOT a complete frame buffer: the ASCII map
// (game::draw_ter -> mvwputch) and the catacurses-drawn sidebar text go through
// the catacurses primitives, which are no-ops here (and even in the real IMTUI
// build flow to a parallel ncurses channel, never into the TScreen). So the
// Phase 0.5 deterministic-replay harness should assert on simulation state
// directly, not treat this TScreen as a faithful render of the whole screen.

#if defined(HEADLESS)

#include <cstdint>
#include <memory>
#include <stdexcept>
#include <string>

#include "cached_options.h"
#include "cata_imgui.h"
#include "color.h"
#include "cursesdef.h"
#include "game_ui.h"
#include "input.h"
#include "output.h"
#include "point.h"
#include "ui_manager.h"

// ImTui platform-layer shims. We reuse imtui-impl-text.cpp (the in-memory
// renderer) but NOT imtui-impl-ncurses.cpp (the terminal driver); the latter
// is excluded from the imtui build under HEADLESS, so the symbols it would
// normally export are provided here instead.
#include "imtui/imtui.h"
#include "imtui/imtui-impl-ncurses.h"
#include "imgui/imgui.h"

// The catacurses client (Dear ImGui wrapper) lives in ui_manager.h as a global.
std::unique_ptr<cataimgui::client> imclient;

// ---------------------------------------------------------------------------
// catacurses window backing store
//
// Under TUI builds cata_cursesport::WINDOW is unavailable (it is gated behind
// !TUI), and the real ncurses ::WINDOW does not exist here, so we keep a tiny
// dimensions-only struct. The game only reads geometry back through the
// catacurses getmax*/getbeg*/getcur* accessors, so this is sufficient.
// ---------------------------------------------------------------------------
namespace
{
struct headless_window {
    point pos;
    int width = 0;
    int height = 0;
    point cursor;
};

headless_window *as_hw( const catacurses::window &win )
{
    return win.get<headless_window>();
}
} // namespace

int get_window_width()
{
    return TERMX;
}

int get_window_height()
{
    return TERMY;
}

catacurses::window catacurses::newwin( const int nlines, const int ncols, const point &begin )
{
    headless_window *const w = new headless_window();
    w->pos = begin;
    w->width = ncols;
    w->height = nlines;
    return catacurses::window( std::shared_ptr<void>( w, []( void *const p ) {
        delete static_cast<headless_window *>( p );
    } ) );
}

void catacurses::wnoutrefresh( const window & ) { }
void catacurses::wrefresh( const window & ) { }
void catacurses::werase( const window & ) { }

int catacurses::getmaxx( const window &win )
{
    const headless_window *const w = as_hw( win );
    return w ? w->width : 0;
}

int catacurses::getmaxy( const window &win )
{
    const headless_window *const w = as_hw( win );
    return w ? w->height : 0;
}

int catacurses::getbegx( const window &win )
{
    const headless_window *const w = as_hw( win );
    return w ? w->pos.x : 0;
}

int catacurses::getbegy( const window &win )
{
    const headless_window *const w = as_hw( win );
    return w ? w->pos.y : 0;
}

int catacurses::getcurx( const window &win )
{
    const headless_window *const w = as_hw( win );
    return w ? w->cursor.x : 0;
}

int catacurses::getcury( const window &win )
{
    const headless_window *const w = as_hw( win );
    return w ? w->cursor.y : 0;
}

void catacurses::wattroff( const window &, const nc_color ) { }
void catacurses::wattron( const window &, const nc_color & ) { }

void catacurses::wmove( const window &win, const point &p )
{
    if( headless_window *const w = as_hw( win ) ) {
        w->cursor = p;
    }
}

void catacurses::mvwprintw( const window &, const point &, const std::string & ) { }
void catacurses::wprintw( const window &, const std::string & ) { }
void catacurses::refresh() { }

void refresh_display() { }
void drain_renderer_recovery() { }
void refresh_mouse_config() { }

void catacurses::doupdate() { }
void catacurses::clear() { }
void catacurses::erase() { }

void catacurses::endwin()
{
    ui_manager::reset();
}

void catacurses::wborder( const window &, const chtype, const chtype, const chtype, const chtype,
                          const chtype, const chtype, const chtype, const chtype ) { }
void catacurses::mvwhline( const window &, const point &, const chtype, const int ) { }
void catacurses::mvwvline( const window &, const point &, const chtype, const int ) { }
void catacurses::mvwaddch( const window &, const point &, const chtype ) { }
void catacurses::waddch( const window &, const chtype ) { }
void catacurses::wredrawln( const window &, const int, const int ) { }
void catacurses::wclear( const window & ) { }
void catacurses::curs_set( const int ) { }

void catacurses::init_pair( const short pair, const base_color f, const base_color b )
{
    if( imclient ) {
        imclient->upload_color_pair( pair, static_cast<int>( f ), static_cast<int>( b ) );
    }
}

catacurses::window catacurses::stdscr;
catacurses::window catacurses::newscr;

void catacurses::resizeterm()
{
    // KNOWN LIMITATION (Phase 0): this does not resize stdscr's backing
    // headless_window, and game_ui::init_ui() reads TERMX/TERMY back from
    // stdscr, so the viewport is effectively frozen at its init_interface
    // size. Fine for tests/replay (fixed viewport); a server/replay path that
    // wants a configurable or per-client viewport must recreate stdscr here
    // (mirroring sdltiles.cpp's newwin-on-resize) before this is useful.
    game_ui::init_ui();
    ui_manager::screen_resized();
}

void catacurses::init_interface()
{
    // No terminal: pick a sane default viewport unless one was already set.
    if( TERMX <= 0 ) {
        TERMX = EVEN_MINIMUM_TERM_WIDTH;
    }
    if( TERMY <= 0 ) {
        TERMY = EVEN_MINIMUM_TERM_HEIGHT;
    }
    stdscr = newwin( TERMY, TERMX, point::zero );
    imclient = std::make_unique<cataimgui::client>();
    init_colors();
}

bool catacurses::supports_256_colors()
{
    return true;
}

// ---------------------------------------------------------------------------
// input_manager
//
// There is no input device in headless mode. Tests run with test_mode == true
// and never call get_input_event (callers skip it); we mirror ncurses_def by
// throwing if it is reached under test_mode, and returning an error event
// otherwise so a non-test headless process degrades instead of blocking.
//
// KNOWN LIMITATION (Phase 0): the non-test path returns immediately where the
// ncurses backend would block in getch(). input_context::handle_input() loops
// on get_input_event() and does not break on an error event, so a future
// *interactive* headless path (timeout <= 0, context without ANY_INPUT
// registered) would busy-spin at 100% CPU. Not reachable today (test_mode
// throws; --jsonverify never calls handle_input). When a non-test interactive
// headless path is added, give error events here a small sleep or have callers
// treat error as a terminating condition.
// ---------------------------------------------------------------------------
void input_manager::pump_events()
{
    previously_pressed_key = 0;
}

input_event input_manager::get_input_event( const keyboard_mode /*preferred_keyboard_mode*/ )
{
    if( test_mode ) {
        // input should be skipped in caller's code
        throw std::runtime_error( "input_manager::get_input_event called in test mode" );
    }
    previously_pressed_key = 0;
    input_event rval;
    rval.type = input_timeout > 0 ? input_event_t::timeout : input_event_t::error;
    return rval;
}

void input_manager::set_timeout( const int delay )
{
    input_timeout = delay;
}

// ---------------------------------------------------------------------------
// nc_color helpers (curses-free bit layout).
//
// This is a byte-for-byte copy of the software implementation in
// cursesport.cpp:525-557 (the SDL-tiles / wincon path). It is NOT the same as
// ncurses_def.cpp's version, which uses real ncurses COLOR_PAIR()/A_BOLD macros
// and the 2-arg nc_color ctor. The three backends partition by #if guard so
// only one nc_color definition ever links.
//
// TODO(phase1): the two software copies (here + cursesport.cpp) could share one
// backend-neutral TU, but the guard union that selects them (TUI / HEADLESS /
// WIN32-curses) is intricate and most failure modes only surface in configs not
// built on this machine -- out of scope for Phase 0 (pure-additive, no edits to
// upstream-hot cursesport.cpp). Deferred deliberately, not forgotten.
// ---------------------------------------------------------------------------
static constexpr int A_BLINK = 0x00000800;
static constexpr int A_BOLD  = 0x00002000;
static constexpr int A_COLOR = 0x03fe0000;

nc_color nc_color::from_color_pair_index( const int index )
{
    return nc_color( index << 17 & A_COLOR );
}

int nc_color::to_color_pair_index() const
{
    return ( attribute_value & A_COLOR ) >> 17;
}

nc_color nc_color::bold() const
{
    return nc_color( attribute_value | A_BOLD );
}

bool nc_color::is_bold() const
{
    return attribute_value & A_BOLD;
}

nc_color nc_color::blink() const
{
    return nc_color( attribute_value | A_BLINK );
}

bool nc_color::is_blink() const
{
    return attribute_value & A_BLINK;
}

// ---------------------------------------------------------------------------
// Startup-time terminal helpers used by game::init_ui (game.cpp).
// Headless has no minimum-size constraint and a guaranteed-UTF-8 environment.
// ---------------------------------------------------------------------------
void ensure_term_size(); // NOLINT(cata-static-declarations,misc-use-internal-linkage)
void check_encoding(); // NOLINT(cata-static-declarations,misc-use-internal-linkage)

void ensure_term_size() { }
void check_encoding() { }

// NOLINTNEXTLINE(cata-use-string_view): signature mirrors sdltiles/wincurse impls
void set_title( const std::string & ) { }

// ---------------------------------------------------------------------------
// ImTui ncurses-platform shims.
//
// cata_imgui.cpp's TUI path calls these unconditionally. The real
// implementations (imtui-impl-ncurses.cpp) drive a terminal; here we keep only
// the parts the in-memory text renderer depends on:
//   * Init must allocate the platform user-data (ImTui::ImplImtui_Data), which
//     owns the TScreen that imtui-impl-text.cpp renders into and that
//     imtui-impl-text.cpp's Shutdown frees.
//   * NewFrame must keep ImGui's DisplaySize in sync with the viewport, or
//     ImGui::NewFrame asserts.
// Everything else (drawing to a terminal, color pairs, input polling) is inert.
// ---------------------------------------------------------------------------
void ImTui_ImplNcurses_Init( float /*fps_active*/, float /*fps_idle*/ )
{
    if( ImGui::GetIO().BackendPlatformUserData == nullptr ) {
        ImGui::GetIO().BackendPlatformUserData = new ImTui::ImplImtui_Data();
    }
    ImGui::GetIO().DisplaySize = ImVec2( get_window_width(), get_window_height() );
}

void ImTui_ImplNcurses_Shutdown() { }

bool ImTui_ImplNcurses_NewFrame( std::vector<std::pair<int, ImTui::mouse_event>> /*key_events*/ )
{
    ImGui::GetIO().DisplaySize = ImVec2( get_window_width(), get_window_height() );
    return false;
}

void ImTui_ImplNcurses_DrawScreen( bool /*active*/ ) { }
void ImTui_ImplNcurses_UploadColorPair( short /*p*/, short /*f*/, short /*b*/ ) { }
void ImTui_ImplNcurses_SetAllocedPairCount( short /*p*/ ) { }

bool ImTui_ImplNcurses_ProcessEvent()
{
    return false;
}

#endif // HEADLESS
