
require 'ffi'

module Allegro extend FFI::Library
    ffi_lib 'allegro_ttf-4.9.18'

    ALLEGRO_TTF_NO_KERNING = 1

    attach_function :al_load_ttf_font, [:string, :int, :int], :pointer
    attach_function :al_load_ttf_font_entry, [:pointer, :string, :int, :int],
                    :pointer
    attach_function :al_init_ttf_addon, [], :bool
    attach_function :al_get_allegro_ttf_version, [], :uint32
end
