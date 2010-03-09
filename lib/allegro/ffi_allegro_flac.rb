
require 'ffi'

module Allegro extend FFI::Library
    ffi_lib 'allegro_flac'

    attach_function :al_init_flac_addon, [], :bool
    attach_function :al_load_flac, [], :bool
#    attach_function :al_load_sample_flac, [:string], :pointer
    attach_function :al_load_flac_audio_stream, [:string,
                    :size_t, :uint], :pointer
#    attach_function :al_get_allegro_flac_version, [], :uint32
end

