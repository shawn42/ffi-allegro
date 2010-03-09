
require 'ffi'

module Allegro extend FFI::Library
    ffi_lib 'allegro_vorbis-4.9.18'

    attach_function :al_init_ogg_vorbis_addon, [], :bool
#    attach_function :al_load_sample_ogg_vorbis, [:string], :pointer
    attach_function :al_load_ogg_vorbis, [], :bool
    attach_function :al_load_ogg_vorbis_audio_stream, [:string,
                    :size_t, :uint], :pointer
#    attach_function :al_get_allegro_ogg_vorbis_version, [], :uint32
end
