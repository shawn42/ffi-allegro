
require 'ffi'

module Allegro extend FFI::Library
    ffi_lib 'allegro_color'

    attach_function :al_get_allegro_color_version, [], :uint32
    attach_function :al_color_hsv_to_rgb, [:float, :float, :float, :pointer,
                    :pointer, :pointer], :void
    attach_function :al_color_rgb_to_hsl, [:float, :float, :float, :pointer,
                    :pointer, :pointer], :void
    attach_function :al_color_rgb_to_hsv, [:float, :float, :float, :pointer,
                    :pointer, :pointer], :void
    attach_function :al_color_hsl_to_rgb, [:float, :float, :float, :pointer,
                    :pointer, :pointer], :void
    attach_function :al_color_name_to_rgb, [:string, :pointer, :pointer,
                    :pointer], :int
    attach_function :al_color_rgb_to_name, [:float, :float, :float], :string
    attach_function :al_color_cmyk_to_rgb, [:float, :float, :float, :float,
                    :pointer, :pointer, :pointer], :void
    attach_function :al_color_rgb_to_cmyk, [:float, :float, :float, :pointer,
                    :pointer, :pointer, :pointer], :void
    attach_function :al_color_yuv_to_rgb, [:float, :float, :float, :pointer,
                    :pointer, :pointer], :void
    attach_function :al_color_rgb_to_yuv, [:float, :float, :float, :pointer,
                    :pointer, :pointer], :void
    attach_function :al_color_rgb_to_html, [:float, :float, :float, :string],
                    :void
    attach_function :al_color_html_to_rgb, [:string, :pointer, :pointer,
                    :pointer], :void
    attach_function :al_color_yuv, [:float, :float, :float],
                    ALLEGRO_COLOR.by_value
    attach_function :al_color_cmyk, [:float, :float, :float, :float],
                    ALLEGRO_COLOR.by_value
    attach_function :al_color_hsl, [:float, :float, :float],
                    ALLEGRO_COLOR.by_value
    attach_function :al_color_hsv, [:float, :float, :float],
                    ALLEGRO_COLOR.by_value
    attach_function :al_color_name, [:string], ALLEGRO_COLOR.by_value
    attach_function :al_color_html, [:string], ALLEGRO_COLOR.by_value
end

