
require 'ffi'

module Allegro extend FFI::Library
    ffi_lib 'allegro_image'

    ALLEGRO_IIO_LOADER_FUNCTION    = callback([:string], :pointer)
    ALLEGRO_IIO_FS_LOADER_FUNCTION = callback([:pointer], :pointer)
    ALLEGRO_IIO_SAVER_FUNCTION     = callback([:string, :pointer], :bool)
    ALLEGRO_IIO_FS_SAVER_FUNCTION  = callback([:pointer, :pointer], :bool)

    attach_function :al_init_image_addon, [], :bool
    attach_function :al_shutdown_image_addon, [], :void
    attach_function :al_register_bitmap_loader, [:string,
                    ALLEGRO_IIO_LOADER_FUNCTION], :bool
    attach_function :al_register_bitmap_saver, [:string,
                    ALLEGRO_IIO_SAVER_FUNCTION], :bool
#    attach_function :al_register_bitmap_loader_stream, [:string,
#                    ALLEGRO_IIO_FS_LOADER_FUNCTION], :bool
#    attach_function :al_register_bitmap_saver_stream, [:string,
#                    ALLEGRO_IIO_FS_SAVER_FUNCTION], :bool
    attach_function :al_load_bitmap, [:string], :pointer
#    attach_function :al_load_bitmap_stream, [:pointer, :string], :pointer
    attach_function :al_save_bitmap, [:string, :pointer], :bool
#    attach_function :al_save_bitmap_stream, [:pointer, :string, :pointer],
                    :bool
    attach_function :al_get_allegro_image_version, [], :uint32
    attach_function :al_load_pcx, [:string], :pointer
    attach_function :al_load_bmp, [:string], :pointer
    attach_function :al_load_tga, [:string], :pointer
    attach_function :al_load_png, [:string], :pointer
    attach_function :al_load_jpg, [:string], :pointer
#    attach_function :al_load_pcx_stream, [:pointer], :pointer
#    attach_function :al_load_bmp_stream, [:pointer], :pointer
#    attach_function :al_load_tga_stream, [:pointer], :pointer
#    attach_function :al_load_png_stream, [:pointer], :pointer
#    attach_function :al_load_jpg_stream, [:pointer], :pointer
    attach_function :al_save_pcx, [:string, :pointer], :bool
    attach_function :al_save_bmp, [:string, :pointer], :bool
    attach_function :al_save_tga, [:string, :pointer], :bool
    attach_function :al_save_png, [:string, :pointer], :bool
    attach_function :al_save_jpg, [:string, :pointer], :bool
#    attach_function :al_save_pcx_stream, [:pointer, :pointer], :bool
#    attach_function :al_save_bmp_stream, [:pointer, :pointer], :bool
#    attach_function :al_save_tga_stream, [:pointer, :pointer], :bool
#    attach_function :al_save_png_stream, [:pointer, :pointer], :bool
#    attach_function :al_save_jpg_stream, [:pointer, :pointer], :bool
end
