
require 'ffi'

module Allegro extend FFI::Library
    ffi_lib 'allegro_font'

    ALLEGRO_ALIGN_LEFT   = 0
    ALLEGRO_ALIGN_CENTRE = 1
    ALLEGRO_ALIGN_RIGHT  = 2

    attach_function :al_register_font_loader, [:string,
                    callback([:string, :int, :int], :pointer)], :pointer
    attach_function :al_load_bitmap_font, [:string], :pointer
    attach_function :al_load_font, [:string, :int, :int], :pointer
    attach_function :al_grab_font_from_bitmap, [:pointer, :int, :pointer],
                    :pointer
    attach_function :al_draw_ustr, [:pointer, :float, :float, :int,
                    :pointer], :void
    attach_function :al_draw_text, [:pointer, :float, :float, :int, :string],
                    :void
    attach_function :al_draw_justified_text, [:pointer, :float, :float,
                    :float, :float, :int, :string], :void
    attach_function :al_draw_justified_ustr, [:pointer, :float, :float,
                    :float, :float, :int, :pointer], :void
    attach_function :al_draw_textf, [:pointer, :float, :float, :int, :string,
                    :varargs], :void
    attach_function :al_draw_justified_textf, [:pointer, :float, :float,
                    :float, :float, :int, :string, :varargs], :void
    attach_function :al_get_text_width, [:pointer, :string], :int
    attach_function :al_get_ustr_width, [:pointer, :pointer], :int
    attach_function :al_get_font_line_height, [:pointer], :int
    attach_function :al_destroy_font, [:pointer], :void
    attach_function :al_get_ustr_dimensions, [:pointer, :pointer, :pointer,
                    :pointer, :pointer, :pointer, :pointer, :pointer], :void
    attach_function :al_get_text_dimensions, [:pointer, :string, :pointer,
                    :pointer, :pointer, :pointer, :pointer, :pointer], :void
    attach_function :al_init_font_addon, [], :void
    attach_function :al_shutdown_font_addon, [], :void
    attach_function :al_get_allegro_font_version, [], :uint32
end
