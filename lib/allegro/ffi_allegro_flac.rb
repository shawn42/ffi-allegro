
require 'ffi'

module Allegro extend FFI::Library
    ffi_lib 'allegro_flac-4.9.16'

    attach_function :al_init_flac_addon, [], :bool
    attach_function :al_load_sample_flac, [:string], :pointer
    attach_function :al_load_audio_stream_flac, [:string,
                    :size_t, :uint], :pointer
    attach_function :al_get_allegro_flac_version, [], :uint32
end

