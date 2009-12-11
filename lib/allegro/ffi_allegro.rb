
require 'ffi'

module Allegro extend FFI::Library
    ffi_lib 'allegro-4.9.16'

    #{{{1 Base
    ALLEGRO_VERSION = 4
    ALLEGRO_SUB_VERSION = 9
    ALLEGRO_WIP_VERSION = 16
    ALLEGRO_RELEASE_NUMBER = 1

    ALLEGRO_VERSION_STR = "4.9.16 (WIP)"
    ALLEGRO_VERSION_INT = ((4 << 24) | (9 << 16) | (16 << 8) | 1)

    ALLEGRO_DATE_STR = "2009"
    ALLEGRO_DATE = 20091129

    attach_function :al_get_allegro_version, [], :uint32

    ALLEGRO_PI = 3.14159265358979323846
    #}}}

    #{{{1 Errors
    attach_function :al_get_errno, [], :int
    attach_function :al_set_errno, [:int], :void
    #}}}

    #{{{1 System
    attach_function :al_install_system,
                    [callback([callback([], :void)], :int)], :bool
    attach_function :al_uninstall_system, [], :void
    attach_function :al_get_system_driver, [], :pointer
    attach_function :al_get_system_config, [], :pointer

    ALLEGRO_PROGRAM_PATH =         0
    ALLEGRO_TEMP_PATH =            1
    ALLEGRO_SYSTEM_DATA_PATH =     2
    ALLEGRO_USER_DATA_PATH =       3
    ALLEGRO_USER_HOME_PATH =       4
    ALLEGRO_USER_SETTINGS_PATH =   5
    ALLEGRO_SYSTEM_SETTINGS_PATH = 6
    ALLEGRO_EXENAME_PATH =         7
    ALLEGRO_LAST_PATH =            8

    attach_function :al_get_standard_path, [:int], :pointer
    attach_function :al_set_orgname, [:string], :void
    attach_function :al_set_appname, [:string], :void
    attach_function :al_get_orgname, [], :string
    attach_function :al_get_appname, [], :string

    attach_function :al_inhibit_screensaver, [:bool], :bool
    #}}}

    #{{{1 Paths
    attach_function :al_create_path, [:string], :pointer
    attach_function :al_create_path_for_directory, [:string], :pointer
    attach_function :al_clone_path, [:pointer], :pointer
    attach_function :al_get_path_num_components, [:pointer], :int
    attach_function :al_get_path_component, [:pointer, :int], :string
    attach_function :al_replace_path_component, [:pointer, :int, :string],
                    :void
    attach_function :al_remove_path_component, [:pointer, :int], :void
    attach_function :al_insert_path_component, [:pointer, :int, :string],
                    :void
    attach_function :al_get_path_tail, [:pointer], :string
    attach_function :al_drop_path_tail, [:pointer], :void
    attach_function :al_append_path_component, [:pointer, :string], :void
    attach_function :al_join_paths, [:pointer, :pointer], :bool
    attach_function :al_path_cstr, [:pointer, :char], :string
    attach_function :al_free_path, [:pointer], :void
    attach_function :al_set_path_drive, [:pointer, :string], :void
    attach_function :al_get_path_drive, [:pointer], :string
    attach_function :al_set_path_filename, [:pointer, :string], :void
    attach_function :al_get_path_filename, [:pointer], :string
    attach_function :al_get_path_extension, [:pointer], :string
    attach_function :al_set_path_extension, [:pointer, :string], :bool
    attach_function :al_get_path_basename, [:pointer], :string
    attach_function :al_make_path_absolute, [:pointer], :bool
    attach_function :al_make_path_canonical, [:pointer], :bool
    attach_function :al_is_path_present, [:pointer], :bool
    #}}}

    #{{{1 Timeouts
    class ALLEGRO_TIMEOUT < FFI::Struct
        layout :__pad1__, :uint32,
               :__pad2__, :uint32
    end

    attach_function :al_current_time, [], :double
    attach_function :al_rest, [:double], :void
    attach_function :al_init_timeout, [:pointer, :double], :void
    #}}}

    #{{{1 Events
    ALLEGRO_EVENT_JOYSTICK_AXIS =         1
    ALLEGRO_EVENT_JOYSTICK_BUTTON_DOWN =  2
    ALLEGRO_EVENT_JOYSTICK_BUTTON_UP =    3
    ALLEGRO_EVENT_KEY_DOWN =             10
    ALLEGRO_EVENT_KEY_REPEAT =           11
    ALLEGRO_EVENT_KEY_UP =               12
    ALLEGRO_EVENT_MOUSE_AXES =           20
    ALLEGRO_EVENT_MOUSE_BUTTON_DOWN =    21
    ALLEGRO_EVENT_MOUSE_BUTTON_UP =      22
    ALLEGRO_EVENT_MOUSE_ENTER_DISPLAY =  23
    ALLEGRO_EVENT_MOUSE_LEAVE_DISPLAY =  24
    ALLEGRO_EVENT_MOUSE_WARPED =         25
    ALLEGRO_EVENT_TIMER =                30
    ALLEGRO_EVENT_DISPLAY_EXPOSE =       40
    ALLEGRO_EVENT_DISPLAY_RESIZE =       41
    ALLEGRO_EVENT_DISPLAY_CLOSE =        42
    ALLEGRO_EVENT_DISPLAY_LOST =         43
    ALLEGRO_EVENT_DISPLAY_FOUND =        44
    ALLEGRO_EVENT_DISPLAY_SWITCH_IN =    45
    ALLEGRO_EVENT_DISPLAY_SWITCH_OUT =   46

    class AnyEvent < FFI::Struct
        layout :type, :int,
               :source, :pointer,
               :timestamp, :double
    end

    class DisplayEvent < FFI::Struct
        layout :type, :int,
               :source, :pointer,
               :timestamp, :double,
               :x, :int,
               :y, :int,
               :width, :int,
               :height, :int
    end

    class JoystickEvent < FFI::Struct
        layout :type, :int,
               :source, :pointer,
               :timestamp, :double,
               :stick, :int,
               :axis, :int,
               :pos, :float,
               :button, :int
    end

    class KeyboardEvent < FFI::Struct
        layout :type, :int,
               :source, :pointer,
               :timestamp, :double,
               :display, :pointer,
               :keycode, :int,
               :unichar, :uint,
               :modifiers, :uint
    end

    class MouseEvent < FFI::Struct
        layout :type, :int,
               :source, :pointer,
               :timestamp, :double,
               :display, :pointer,
               :x, :int,
               :y, :int,
               :z, :int,
               :w, :int,
               :dx, :int,
               :dy, :int,
               :dz, :int,
               :dw, :int,
               :button, :uint
    end

    class TimerEvent < FFI::Struct
        layout :type, :int,
               :source, :pointer,
               :timestamp, :double,
               :count, :long,
               :error, :double
    end

    class UserEvent < FFI::Struct
        layout :type, :int,
               :source, :pointer,
               :timestamp, :double,
               :__internal__descr, :pointer,
               :data1, :__intptr_t,
               :data2, :__intptr_t,
               :data3, :__intptr_t,
               :data4, :__intptr_t
    end

    class Event < FFI::Union
        layout :type, :int,
               :any, AnyEvent,
               :display, DisplayEvent,
               :joystick, JoystickEvent,
               :keyboard, KeyboardEvent,
               :mouse, MouseEvent,
               :timer, TimerEvent,
               :user, UserEvent
    end

    attach_function :al_init_user_event_source, [:pointer], :void
    attach_function :al_destroy_user_event_source, [:pointer], :void
    attach_function :al_emit_user_event, [:pointer, :pointer,
                    callback([:pointer], :void)], :bool
    attach_function :al_unref_user_event, [:pointer], :void
    attach_function :al_create_event_queue, [], :pointer
    attach_function :al_destroy_event_queue, [:pointer], :void
    attach_function :al_register_event_source, [:pointer, :pointer], :void
    attach_function :al_unregister_event_source, [:pointer, :pointer], :void
    attach_function :al_set_event_source_data, [:pointer, :__intptr_t], :void
    attach_function :al_get_event_source_data, [:pointer], :__intptr_t
    attach_function :al_event_queue_is_empty, [:pointer], :bool
    attach_function :al_get_next_event, [:pointer, :pointer], :bool
    attach_function :al_peek_next_event, [:pointer, :pointer], :bool
    attach_function :al_drop_next_event, [:pointer], :bool
    attach_function :al_flush_event_queue, [:pointer], :void
    attach_function :al_wait_for_event, [:pointer, :pointer], :void
    attach_function :al_wait_for_event_timed, [:pointer, :pointer, :float],
                    :bool
    attach_function :al_wait_for_event_until, [:pointer, :pointer, :pointer],
                    :bool
    #}}}

    #{{{1 Mouse
    ALLEGRO_MOUSE_MAX_EXTRA_AXES = 4

    class ALLEGRO_MOUSE_STATE < FFI::Struct
        layout :x, :int,
               :y, :int,
               :z, :int,
               :w, :int,
               :more_axes, [:int, 4],
               :buttons, :int,
               :display, :pointer
    end

    ALLEGRO_SYSTEM_MOUSE_CURSOR_NONE        =  0
    ALLEGRO_SYSTEM_MOUSE_CURSOR_DEFAULT     =  1
    ALLEGRO_SYSTEM_MOUSE_CURSOR_ARROW       =  2
    ALLEGRO_SYSTEM_MOUSE_CURSOR_BUSY        =  3
    ALLEGRO_SYSTEM_MOUSE_CURSOR_QUESTION    =  4
    ALLEGRO_SYSTEM_MOUSE_CURSOR_EDIT        =  5
    ALLEGRO_SYSTEM_MOUSE_CURSOR_MOVE        =  6
    ALLEGRO_SYSTEM_MOUSE_CURSOR_RESIZE_N    =  7
    ALLEGRO_SYSTEM_MOUSE_CURSOR_RESIZE_W    =  8
    ALLEGRO_SYSTEM_MOUSE_CURSOR_RESIZE_S    =  9
    ALLEGRO_SYSTEM_MOUSE_CURSOR_RESIZE_E    = 10
    ALLEGRO_SYSTEM_MOUSE_CURSOR_RESIZE_NW   = 11
    ALLEGRO_SYSTEM_MOUSE_CURSOR_RESIZE_SW   = 12
    ALLEGRO_SYSTEM_MOUSE_CURSOR_RESIZE_SE   = 13
    ALLEGRO_SYSTEM_MOUSE_CURSOR_RESIZE_NE   = 14
    ALLEGRO_SYSTEM_MOUSE_CURSOR_PROGRESS    = 15
    ALLEGRO_SYSTEM_MOUSE_CURSOR_PRECISION   = 16
    ALLEGRO_SYSTEM_MOUSE_CURSOR_LINK        = 17
    ALLEGRO_SYSTEM_MOUSE_CURSOR_ALT_SELECT  = 18
    ALLEGRO_SYSTEM_MOUSE_CURSOR_UNAVAILABLE = 19
    ALLEGRO_NUM_SYSTEM_MOUSE_CURSORS        = 20

    attach_function :al_is_mouse_installed, [], :bool
    attach_function :al_install_mouse, [], :bool
    attach_function :al_uninstall_mouse, [], :void
    attach_function :al_get_mouse_num_buttons, [], :uint
    attach_function :al_get_mouse_num_axes, [], :uint
    attach_function :al_set_mouse_xy, [:int, :int], :bool
    attach_function :al_set_mouse_z, [:int], :bool
    attach_function :al_set_mouse_w, [:int], :bool
    attach_function :al_set_mouse_axis, [:int, :int], :bool
    attach_function :al_set_mouse_range, [:int, :int, :int, :int], :bool
    attach_function :al_get_mouse_state, [:pointer], :void
    attach_function :al_mouse_button_down, [:pointer, :int], :bool
    attach_function :al_get_mouse_state_axis, [:pointer, :int], :int
    attach_function :al_get_mouse_event_source, [], :pointer
    attach_function :al_create_mouse_cursor, [:pointer, :int, :int], :pointer
    attach_function :al_destroy_mouse_cursor, [:pointer], :void
    attach_function :al_set_mouse_cursor, [:pointer], :bool
    attach_function :al_set_system_mouse_cursor, [:int], :bool
    attach_function :al_show_mouse_cursor, [], :bool
    attach_function :al_hide_mouse_cursor, [], :bool
    attach_function :al_get_mouse_cursor_position, [:pointer, :pointer],
                    :bool
    #}}}

    #{{{1 Keyboard
    ALLEGRO_KEY_A             =   1
    ALLEGRO_KEY_B             =   2
    ALLEGRO_KEY_C             =   3
    ALLEGRO_KEY_D             =   4
    ALLEGRO_KEY_E             =   5
    ALLEGRO_KEY_F             =   6
    ALLEGRO_KEY_G             =   7
    ALLEGRO_KEY_H             =   8
    ALLEGRO_KEY_I             =   9
    ALLEGRO_KEY_J             =  10
    ALLEGRO_KEY_K             =  11
    ALLEGRO_KEY_L             =  12
    ALLEGRO_KEY_M             =  13
    ALLEGRO_KEY_N             =  14
    ALLEGRO_KEY_O             =  15
    ALLEGRO_KEY_P             =  16
    ALLEGRO_KEY_Q             =  17
    ALLEGRO_KEY_R             =  18
    ALLEGRO_KEY_S             =  19
    ALLEGRO_KEY_T             =  20
    ALLEGRO_KEY_U             =  21
    ALLEGRO_KEY_V             =  22
    ALLEGRO_KEY_W             =  23
    ALLEGRO_KEY_X             =  24
    ALLEGRO_KEY_Y             =  25
    ALLEGRO_KEY_Z             =  26

    ALLEGRO_KEY_0             =  27
    ALLEGRO_KEY_1             =  28
    ALLEGRO_KEY_2             =  29
    ALLEGRO_KEY_3             =  30
    ALLEGRO_KEY_4             =  31
    ALLEGRO_KEY_5             =  32
    ALLEGRO_KEY_6             =  33
    ALLEGRO_KEY_7             =  34
    ALLEGRO_KEY_8             =  35
    ALLEGRO_KEY_9             =  36

    ALLEGRO_KEY_PAD_0         =  37
    ALLEGRO_KEY_PAD_1         =  38
    ALLEGRO_KEY_PAD_2         =  39
    ALLEGRO_KEY_PAD_3         =  40
    ALLEGRO_KEY_PAD_4         =  41
    ALLEGRO_KEY_PAD_5         =  42
    ALLEGRO_KEY_PAD_6         =  43
    ALLEGRO_KEY_PAD_7         =  44
    ALLEGRO_KEY_PAD_8         =  45
    ALLEGRO_KEY_PAD_9         =  46

    ALLEGRO_KEY_F1            =  47
    ALLEGRO_KEY_F2            =  48
    ALLEGRO_KEY_F3            =  49
    ALLEGRO_KEY_F4            =  50
    ALLEGRO_KEY_F5            =  51
    ALLEGRO_KEY_F6            =  52
    ALLEGRO_KEY_F7            =  53
    ALLEGRO_KEY_F8            =  54
    ALLEGRO_KEY_F9            =  55
    ALLEGRO_KEY_F10           =  56
    ALLEGRO_KEY_F11           =  57
    ALLEGRO_KEY_F12           =  58

    ALLEGRO_KEY_ESCAPE        =  59
    ALLEGRO_KEY_TILDE         =  60
    ALLEGRO_KEY_MINUS         =  61
    ALLEGRO_KEY_EQUALS        =  62
    ALLEGRO_KEY_BACKSPACE     =  63
    ALLEGRO_KEY_TAB           =  64
    ALLEGRO_KEY_OPENBRACE     =  65
    ALLEGRO_KEY_CLOSEBRACE    =  66
    ALLEGRO_KEY_ENTER         =  67
    ALLEGRO_KEY_SEMICOLON     =  68
    ALLEGRO_KEY_QUOTE         =  69
    ALLEGRO_KEY_BACKSLASH     =  70
    ALLEGRO_KEY_BACKSLASH2    =  71
    ALLEGRO_KEY_COMMA         =  72
    ALLEGRO_KEY_FULLSTOP      =  73
    ALLEGRO_KEY_SLASH         =  74
    ALLEGRO_KEY_SPACE         =  75

    ALLEGRO_KEY_INSERT        =  76
    ALLEGRO_KEY_DELETE        =  77
    ALLEGRO_KEY_HOME          =  78
    ALLEGRO_KEY_END           =  79
    ALLEGRO_KEY_PGUP          =  80
    ALLEGRO_KEY_PGDN          =  81
    ALLEGRO_KEY_LEFT          =  82
    ALLEGRO_KEY_RIGHT         =  83
    ALLEGRO_KEY_UP            =  84
    ALLEGRO_KEY_DOWN          =  85

    ALLEGRO_KEY_PAD_SLASH     =  86
    ALLEGRO_KEY_PAD_ASTERISK  =  87
    ALLEGRO_KEY_PAD_MINUS     =  88
    ALLEGRO_KEY_PAD_PLUS      =  89
    ALLEGRO_KEY_PAD_DELETE    =  90
    ALLEGRO_KEY_PAD_ENTER     =  91

    ALLEGRO_KEY_PRINTSCREEN   =  92
    ALLEGRO_KEY_PAUSE         =  93

    ALLEGRO_KEY_ABNT_C1       =  94
    ALLEGRO_KEY_YEN           =  95
    ALLEGRO_KEY_KANA          =  96
    ALLEGRO_KEY_CONVERT       =  97
    ALLEGRO_KEY_NOCONVERT     =  98
    ALLEGRO_KEY_AT            =  99
    ALLEGRO_KEY_CIRCUMFLEX    = 100
    ALLEGRO_KEY_COLON2        = 101
    ALLEGRO_KEY_KANJI         = 102

    ALLEGRO_KEY_EQUALS_PAD    = 103
    ALLEGRO_KEY_BACKQUOTE     = 104
    ALLEGRO_KEY_SEMICOLON2    = 105
    ALLEGRO_KEY_COMMAND       = 106
    ALLEGRO_KEY_UNKNOWN       = 107

    ALLEGRO_KEY_MODIFIERS     = 215

    ALLEGRO_KEY_LSHIFT        = 215
    ALLEGRO_KEY_RSHIFT        = 216
    ALLEGRO_KEY_LCTRL         = 217
    ALLEGRO_KEY_RCTRL         = 218
    ALLEGRO_KEY_ALT           = 219
    ALLEGRO_KEY_ALTGR         = 220
    ALLEGRO_KEY_LWIN          = 221
    ALLEGRO_KEY_RWIN          = 222
    ALLEGRO_KEY_MENU          = 223
    ALLEGRO_KEY_SCROLLLOCK    = 224
    ALLEGRO_KEY_NUMLOCK       = 225
    ALLEGRO_KEY_CAPSLOCK      = 226

    ALLEGRO_KEY_MAX = 227

    ALLEGRO_KEYMOD_SHIFT      = 0x00001
    ALLEGRO_KEYMOD_CTRL       = 0x00002
    ALLEGRO_KEYMOD_ALT        = 0x00004
    ALLEGRO_KEYMOD_LWIN       = 0x00008
    ALLEGRO_KEYMOD_RWIN       = 0x00010
    ALLEGRO_KEYMOD_MENU       = 0x00020
    ALLEGRO_KEYMOD_ALTGR      = 0x00040
    ALLEGRO_KEYMOD_COMMAND    = 0x00080
    ALLEGRO_KEYMOD_SCROLLLOCK = 0x00100
    ALLEGRO_KEYMOD_NUMLOCK    = 0x00200
    ALLEGRO_KEYMOD_CAPSLOCK   = 0x00400
    ALLEGRO_KEYMOD_INALTSEQ   = 0x00800
    ALLEGRO_KEYMOD_ACCENT1    = 0x01000
    ALLEGRO_KEYMOD_ACCENT2    = 0x02000
    ALLEGRO_KEYMOD_ACCENT3    = 0x04000
    ALLEGRO_KEYMOD_ACCENT4    = 0x08000

    class ALLEGRO_KEYBOARD_STATE < FFI::Struct
        layout :display, :pointer,
               :__key_down__internal__, [:uint, (ALLEGRO_KEY_MAX + 31) / 32]
    end

    attach_function :al_is_keyboard_installed, [], :bool
    attach_function :al_install_keyboard, [], :bool
    attach_function :al_uninstall_keyboard, [], :void
    attach_function :al_set_keyboard_leds, [:int], :bool
    attach_function :al_keycode_to_name, [:int], :string
    attach_function :al_get_keyboard_state, [:pointer], :void
    attach_function :al_key_down, [:pointer, :int], :bool
    attach_function :al_get_keyboard_event_source, [], :pointer
    #}}}

    #{{{1 Joystick
    AL_MAX_JOYSTICK_AXES =     3
    AL_MAX_JOYSTICK_STICKS =   8
    AL_MAX_JOYSTICK_BUTTONS = 32

    class ALLEGRO_JOYSTICK_STICK_STATE < FFI::Struct
        layout :axis, [:float, AL_MAX_JOYSTICK_AXES]
    end

    class ALLEGRO_JOYSTICK_STATE < FFI::Struct
        layout :stick, [ALLEGRO_JOYSTICK_STICK_STATE,
                        AL_MAX_JOYSTICK_STICKS],
               :button, [:int, AL_MAX_JOYSTICK_BUTTONS]
    end

    ALLEGRO_JOYFLAG_DIGITAL =  0x01
    ALLEGRO_JOYFLAG_ANALOGUE = 0x02

    attach_function :al_install_joystick, [], :bool
    attach_function :al_uninstall_joystick, [], :void
    attach_function :al_get_num_joysticks, [], :int
    attach_function :al_get_joystick, [:int], :pointer
    attach_function :al_release_joystick, [:pointer], :void
    attach_function :al_get_joystick_name, [:pointer], :string
    attach_function :al_get_joystick_number, [:pointer], :int
    attach_function :al_get_joystick_num_sticks, [:pointer], :int
    attach_function :al_get_joystick_stick_flags, [:pointer, :int], :int
    attach_function :al_get_joystick_stick_name, [:pointer, :int],
                    :string
    attach_function :al_get_joystick_num_axes, [:pointer, :int], :int
    attach_function :al_get_joystick_axis_name, [:pointer, :int, :int],
                    :string
    attach_function :al_get_joystick_num_buttons, [:pointer], :int
    attach_function :al_get_joystick_button_name, [:pointer, :int],
                    :string
    attach_function :al_get_joystick_state, [:pointer, :pointer], :void
    attach_function :al_get_joystick_event_source, [:pointer], :pointer
    #}}}

    #{{{1 Colors
    class ALLEGRO_COLOR < FFI::Struct
        layout :r, :float,
               :g, :float,
               :b, :float,
               :a, :float
    end

    attach_function :al_map_rgb, [:uchar, :uchar, :uchar], ALLEGRO_COLOR
    attach_function :al_map_rgba, [:uchar, :uchar, :uchar, :uchar],
                    ALLEGRO_COLOR
    attach_function :al_map_rgb_f, [:float, :float, :float], ALLEGRO_COLOR
    attach_function :al_map_rgba_f, [:float, :float, :float, :float],
                    ALLEGRO_COLOR
    attach_function :al_unmap_rgb, [ALLEGRO_COLOR, :pointer, :pointer,
                    :pointer], :void
    attach_function :al_unmap_rgba, [ALLEGRO_COLOR, :pointer, :pointer,
                    :pointer, :pointer], :void
    attach_function :al_unmap_rgb_f, [ALLEGRO_COLOR, :pointer, :pointer,
                    :pointer], :void
    attach_function :al_unmap_rgba_f, [ALLEGRO_COLOR, :pointer, :pointer,
                    :pointer, :pointer], :void
    #}}}

    #{{{1 Display
    ALLEGRO_WINDOWED =                 1
    ALLEGRO_FULLSCREEN =               2
    ALLEGRO_RESIZABLE =               16
    ALLEGRO_NOFRAME =                 64
    ALLEGRO_GENERATE_EXPOSE_EVENTS = 128

    ALLEGRO_RED_SIZE =               0
    ALLEGRO_GREEN_SIZE =             1
    ALLEGRO_BLUE_SIZE =              2
    ALLEGRO_ALPHA_SIZE =             3
    ALLEGRO_RED_SHIFT =              4
    ALLEGRO_GREEN_SHIFT =            5
    ALLEGRO_BLUE_SHIFT =             6
    ALLEGRO_ALPHA_SHIFT =            7
    ALLEGRO_ACC_RED_SIZE =           8
    ALLEGRO_ACC_GREEN_SIZE =         9
    ALLEGRO_ACC_BLUE_SIZE =         10
    ALLEGRO_ACC_ALPHA_SIZE =        11
    ALLEGRO_STEREO =                12
    ALLEGRO_AUX_BUFFERS =           13
    ALLEGRO_COLOR_SIZE =            14
    ALLEGRO_DEPTH_SIZE =            15
    ALLEGRO_STENCIL_SIZE =          16
    ALLEGRO_SAMPLE_BUFFERS =        17
    ALLEGRO_SAMPLES =               18
    ALLEGRO_RENDER_METHOD =         19
    ALLEGRO_FLOAT_COLOR =           20
    ALLEGRO_FLOAT_DEPTH =           21
    ALLEGRO_SINGLE_BUFFER =         22
    ALLEGRO_SWAP_METHOD =           23
    ALLEGRO_COMPATIBLE_DISPLAY =    24
    ALLEGRO_UPDATE_DISPLAY_REGION = 25
    ALLEGRO_VSYNC =                 26
    ALLEGRO_DISPLAY_OPTIONS_COUNT = 27

    ALLEGRO_DONTCARE = 0
    ALLEGRO_REQUIRE =  1
    ALLEGRO_SUGGEST =  2

    class ALLEGRO_DISPLAY_MODE < FFI::Struct
        layout :width, :int,
               :height, :int,
               :format, :int,
               :refresh_rate, :int
    end

    class ALLEGRO_MONITOR_INFO < FFI::Struct
        layout :x1, :int,
               :y1, :int,
               :x2, :int,
               :y2, :int
    end

    attach_function :al_set_new_display_refresh_rate, [:int], :void
    attach_function :al_set_new_display_flags, [:int], :void
    attach_function :al_get_new_display_refresh_rate, [], :int
    attach_function :al_get_new_display_flags, [], :int
    attach_function :al_get_display_width, [], :int
    attach_function :al_get_display_height, [], :int
    attach_function :al_get_display_format, [], :int
    attach_function :al_get_display_refresh_rate, [], :int
    attach_function :al_get_display_flags, [], :int
    attach_function :al_create_display, [:int, :int], :pointer
    attach_function :al_destroy_display, [:pointer], :void
    attach_function :al_set_current_display, [:pointer], :bool
    attach_function :al_get_current_display, [], :pointer
    attach_function :al_set_target_bitmap, [:pointer], :void
    attach_function :al_get_backbuffer, [], :pointer
    attach_function :al_get_frontbuffer, [], :pointer
    attach_function :al_get_target_bitmap, [], :pointer
    attach_function :al_acknowledge_resize, [:pointer], :bool
    attach_function :al_resize_display, [:int, :int], :bool
    attach_function :al_flip_display, [], :void
    attach_function :al_update_display_region, [:int, :int, :int, :int], :void
    attach_function :al_is_compatible_bitmap, [:pointer], :bool
    attach_function :al_get_num_display_modes, [], :int
    attach_function :al_get_display_mode, [:int, :pointer], :pointer
    attach_function :al_wait_for_vsync, [], :bool
    attach_function :al_get_display_event_source, [:pointer], :pointer
    attach_function :al_clear_to_color, [ALLEGRO_COLOR], :void
    attach_function :al_draw_pixel, [:float, :float, ALLEGRO_COLOR], :void
    attach_function :al_set_display_icon, [:pointer], :void
    attach_function :al_get_num_video_adapters, [], :int
    attach_function :al_get_monitor_info, [:int, :pointer], :void
    attach_function :al_get_current_video_adapter, [], :int
    attach_function :al_set_current_video_adapter, [:int], :void
    attach_function :al_set_new_window_position, [:int, :int], :void
    attach_function :al_get_new_window_position, [:pointer, :pointer], :void
    attach_function :al_set_window_position, [:pointer, :int, :int], :void
    attach_function :al_get_window_position, [:pointer, :pointer, :pointer],
                    :void
    attach_function :al_toggle_window_frame, [:pointer, :bool], :void
    attach_function :al_set_window_title, [:string], :void
    attach_function :al_set_new_display_option, [:int, :int, :int], :void
    attach_function :al_get_new_display_option, [:int, :pointer], :int
    attach_function :al_reset_new_display_options, [], :void
    attach_function :al_get_display_option, [:int], :int
    attach_function :al_get_num_display_formats, [], :int
    attach_function :al_get_display_format_option, [:int, :int], :int
    attach_function :al_set_new_display_format, [:int], :void
    attach_function :al_hold_bitmap_drawing, [:bool], :void
    attach_function :al_is_bitmap_drawing_held, [], :bool
    #}}}

    #{{{1 Transformations
    # The ffi gem doesn't support multi-dimentionnal arrays yet, so a
    # work-around was proposed by the author:
    # http://groups.google.com/group/ruby-ffi/browse_thread/thread/378467705717660e
    #
    # An issue has been filled on:
    # http://github.com/ffi/ffi/issues/#issue/18

    class ALLEGRO_TRANSFORM < FFI::Struct
        layout :m0, [:float, 4],
               :m1, [:float, 4],
               :m2, [:float, 4],
               :m3, [:float, 4]
    end 

    attach_function :al_use_transform, [:pointer], :void
    attach_function :al_copy_transform, [:pointer, :pointer], :void
    attach_function :al_identity_transform, [:pointer], :void
    attach_function :al_build_transform, [:pointer, :float, :float,
                    :float, :float, :float], :void
    attach_function :al_translate_transform, [:pointer, :float, :float],
                    :void
    attach_function :al_rotate_transform, [:pointer, :float], :void
    attach_function :al_scale_transform, [:pointer, :float, :float],
                    :void
    attach_function :al_transform_coordinates, [:pointer, :pointer,
                    :pointer], :void
    attach_function :al_transform_transform, [:pointer, :pointer], :void
    attach_function :al_get_current_transform, [], :pointer
    attach_function :al_invert_transform, [:pointer], :void
    attach_function :al_check_inverse, [:pointer, :float], :int
    #}}}

    #{{{1 Bitmaps
    ALLEGRO_PIXEL_FORMAT_ANY               =  0
    ALLEGRO_PIXEL_FORMAT_ANY_NO_ALPHA      =  1
    ALLEGRO_PIXEL_FORMAT_ANY_WITH_ALPHA    =  2
    ALLEGRO_PIXEL_FORMAT_ANY_15_NO_ALPHA   =  3
    ALLEGRO_PIXEL_FORMAT_ANY_16_NO_ALPHA   =  4
    ALLEGRO_PIXEL_FORMAT_ANY_16_WITH_ALPHA =  5
    ALLEGRO_PIXEL_FORMAT_ANY_24_NO_ALPHA   =  6
    ALLEGRO_PIXEL_FORMAT_ANY_32_NO_ALPHA   =  7
    ALLEGRO_PIXEL_FORMAT_ANY_32_WITH_ALPHA =  8
    ALLEGRO_PIXEL_FORMAT_ARGB_8888         =  9
    ALLEGRO_PIXEL_FORMAT_RGBA_8888         = 10
    ALLEGRO_PIXEL_FORMAT_ARGB_4444         = 11
    ALLEGRO_PIXEL_FORMAT_RGB_888           = 12
    ALLEGRO_PIXEL_FORMAT_RGB_565           = 13
    ALLEGRO_PIXEL_FORMAT_RGB_555           = 14
    ALLEGRO_PIXEL_FORMAT_RGBA_5551         = 15
    ALLEGRO_PIXEL_FORMAT_ARGB_1555         = 16
    ALLEGRO_PIXEL_FORMAT_ABGR_8888         = 17
    ALLEGRO_PIXEL_FORMAT_XBGR_8888         = 18
    ALLEGRO_PIXEL_FORMAT_BGR_888           = 19
    ALLEGRO_PIXEL_FORMAT_BGR_565           = 20
    ALLEGRO_PIXEL_FORMAT_BGR_555           = 21
    ALLEGRO_PIXEL_FORMAT_RGBX_8888         = 22
    ALLEGRO_PIXEL_FORMAT_XRGB_8888         = 23
    ALLEGRO_PIXEL_FORMAT_ABGR_F32          = 24
    ALLEGRO_PIXEL_FORMAT_ABGR_8888_LE      = 25
    ALLEGRO_PIXEL_FORMAT_RGBA_4444         = 26
    ALLEGRO_NUM_PIXEL_FORMATS              = 27

    ALLEGRO_VIDEO_BITMAP                   = 0x0000
    ALLEGRO_MEMORY_BITMAP                  = 0x0001
    ALLEGRO_KEEP_BITMAP_FORMAT             = 0x0002
    ALLEGRO_FORCE_LOCKING                  = 0x0004
    ALLEGRO_NO_PRESERVE_TEXTURE            = 0x0008
    ALLEGRO_ALPHA_TEST                     = 0x0010

    ALLEGRO_FLIP_HORIZONTAL                = 0x00001
    ALLEGRO_FLIP_VERTICAL                  = 0x00002

    ALLEGRO_LOCK_READWRITE                 = 0
    ALLEGRO_LOCK_READONLY                  = 1
    ALLEGRO_LOCK_WRITEONLY                 = 2

    ALLEGRO_ZERO                           = 0
    ALLEGRO_ONE                            = 1
    ALLEGRO_ALPHA                          = 2
    ALLEGRO_INVERSE_ALPHA                  = 3

    class ALLEGRO_LOCKED_REGION < FFI::Struct
        layout :data, :pointer,
               :format, :int,
               :pitch, :int
    end

    attach_function :al_set_new_bitmap_format, [:int], :void
    attach_function :al_set_new_bitmap_flags, [:int], :void
    attach_function :al_get_new_bitmap_format, [], :int
    attach_function :al_get_new_bitmap_flags, [], :int
    attach_function :al_get_bitmap_width, [:pointer], :int
    attach_function :al_get_bitmap_height, [:pointer], :int
    attach_function :al_get_bitmap_format, [:pointer], :int
    attach_function :al_get_bitmap_flags, [:pointer], :int
    attach_function :al_create_bitmap, [:int, :int], :pointer
    attach_function :al_destroy_bitmap, [:pointer], :void
    attach_function :al_draw_bitmap, [:pointer, :float, :float, :int],
                    :void
    attach_function :al_draw_bitmap_region, [:pointer, :float, :float,
                    :float, :float, :float, :float, :int], :void
    attach_function :al_draw_scaled_bitmap, [:pointer, :float, :float,
                    :float, :float, :float, :float, :float, :float, :int],
                    :void
    attach_function :al_draw_rotated_bitmap, [:pointer, :float, :float,
                    :float, :float, :float, :int], :void
    attach_function :al_draw_rotated_scaled_bitmap, [:pointer, :float,
                    :float, :float, :float, :float, :float, :float, :int],
                    :void
    attach_function :al_lock_bitmap, [:pointer, :int, :int], :pointer
    attach_function :al_lock_bitmap_region, [:pointer, :int, :int, :int,
                    :int, :int, :int], :pointer
    attach_function :al_unlock_bitmap, [:pointer], :void
    attach_function :al_put_pixel, [:int, :int, ALLEGRO_COLOR], :void
    attach_function :al_get_pixel, [:pointer, :int, :int], ALLEGRO_COLOR
    attach_function :al_get_pixel_size, [:int], :int
    attach_function :al_get_pixel_format_bits, [:int], :int
    attach_function :al_convert_mask_to_alpha, [:pointer, ALLEGRO_COLOR],
                    :void
    attach_function :al_set_clipping_rectangle, [:int, :int, :int, :int],
                    :void
    attach_function :al_get_clipping_rectangle, [:pointer, :pointer,
                    :pointer, :pointer], :void
    attach_function :al_create_sub_bitmap, [:pointer, :int, :int, :int,
                    :int], :pointer
    attach_function :al_is_sub_bitmap, [:pointer], :bool
    attach_function :al_clone_bitmap, [:pointer], :pointer
    attach_function :al_is_bitmap_locked, [:pointer], :bool
    attach_function :al_set_blender, [:int, :int, ALLEGRO_COLOR], :void
    attach_function :al_get_blender, [:pointer, :pointer, :pointer], :void
    attach_function :al_set_separate_blender, [:int, :int, :int, :int,
                    ALLEGRO_COLOR], :void
    attach_function :al_get_separate_blender, [:pointer, :pointer, :pointer,
                    :pointer, :pointer], :void
    attach_function :_al_get_blend_color, [], :pointer
    attach_function :_al_put_pixel, [:pointer, :int, :int, ALLEGRO_COLOR],
                    :void
    #}}}
end
