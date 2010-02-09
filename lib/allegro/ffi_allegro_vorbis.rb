
require 'ffi'

module Allegro extend FFI::Library
    ffi_lib 'allegro_vorbis-4.9.16'

    attach_function :al_init_ogg_vorbis_addon, [], :bool
    attach_function :al_load_sample_ogg_vorbis, [:string], :pointer
    attach_function :al_load_audio_stream_ogg_vorbis, [:string,
                    :size_t, :uint], :pointer
    attach_function :al_get_allegro_ogg_vorbis_version, [], :uint32
end
