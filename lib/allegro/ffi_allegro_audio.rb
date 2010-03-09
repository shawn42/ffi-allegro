
require 'ffi'

module Allegro extend FFI::Library
    ffi_lib 'allegro_audio-4.9.18'

    ALLEGRO_EVENT_AUDIO_STREAM_FRAGMENT = 513
    ALLEGRO_EVENT_AUDIO_STREAM_FINISHED = 514

    ALLEGRO_AUDIO_DEPTH_INT8        = 0x00
    ALLEGRO_AUDIO_DEPTH_INT16       = 0x01
    ALLEGRO_AUDIO_DEPTH_INT24       = 0x02
    ALLEGRO_AUDIO_DEPTH_FLOAT32     = 0x03
    ALLEGRO_AUDIO_DEPTH_UNSIGNED    = 0x08
    ALLEGRO_AUDIO_DEPTH_UINT16      = ALLEGRO_AUDIO_DEPTH_INT16 \
                                    | ALLEGRO_AUDIO_DEPTH_UNSIGNED
    ALLEGRO_AUDIO_DEPTH_UINT24      = ALLEGRO_AUDIO_DEPTH_INT24 \
                                    | ALLEGRO_AUDIO_DEPTH_UNSIGNED
    ALLEGRO_AUDIO_DEPTH_UINT8       = ALLEGRO_AUDIO_DEPTH_INT8 \
                                    | ALLEGRO_AUDIO_DEPTH_UNSIGNED

    ALLEGRO_CHANNEL_CONF_1          = 0x10
    ALLEGRO_CHANNEL_CONF_2          = 0x20
    ALLEGRO_CHANNEL_CONF_3          = 0x30
    ALLEGRO_CHANNEL_CONF_4          = 0x40
    ALLEGRO_CHANNEL_CONF_5_1        = 0x51
    ALLEGRO_CHANNEL_CONF_6_1        = 0x61
    ALLEGRO_CHANNEL_CONF_7_1        = 0x71

    ALLEGRO_MAX_CHANNELS            = 8
    ALLEGRO_PLAYMODE_ONCE           = 0x100
    ALLEGRO_PLAYMODE_LOOP           = 0x101
    ALLEGRO_PLAYMODE_BIDIR          = 0x102

    ALLEGRO_MIXER_QUALITY_POINT     = 0x110
    ALLEGRO_MIXER_QUALITY_LINEAR    = 0x111

    ALLEGRO_AUDIO_DRIVER_AUTODETECT = 0x20000
    ALLEGRO_AUDIO_DRIVER_OPENAL     = 0x20001
    ALLEGRO_AUDIO_DRIVER_ALSA       = 0x20002
    ALLEGRO_AUDIO_DRIVER_DSOUND     = 0x20003
    ALLEGRO_AUDIO_DRIVER_OSS        = 0x20004
    ALLEGRO_AUDIO_DRIVER_AQUEUE     = 0x20005
    ALLEGRO_AUDIO_DRIVER_PULSEAUDIO = 0x20006

    ALLEGRO_AUDIO_PAN_NONE          = -1000.0

    class ALLEGRO_SAMPLE_ID < FFI::Struct
        layout :_index, :int,
               :_id, :int
    end

    attach_function :al_create_sample, [:pointer, :ulong, :ulong, :int,
                    :int, :bool], :pointer
    attach_function :al_destroy_sample, [:pointer], :void
    attach_function :al_create_sample_instance, [:pointer], :pointer
    attach_function :al_destroy_sample_instance, [:pointer], :void
    attach_function :al_get_sample_frequency, [:pointer], :uint
    attach_function :al_get_sample_length, [:pointer], :ulong
    attach_function :al_get_sample_depth, [:pointer], :int
    attach_function :al_get_sample_channels, [:pointer], :int
    attach_function :al_get_sample_data, [:pointer], :pointer
    attach_function :al_get_sample_instance_frequency, [:pointer], :uint
    attach_function :al_get_sample_instance_length, [:pointer], :ulong
    attach_function :al_get_sample_instance_position, [:pointer], :ulong
    attach_function :al_get_sample_instance_speed, [:pointer], :float
    attach_function :al_get_sample_instance_gain, [:pointer], :float
    attach_function :al_get_sample_instance_pan, [:pointer], :float
    attach_function :al_get_sample_instance_time, [:pointer], :float
    attach_function :al_get_sample_instance_depth, [:pointer], :int
    attach_function :al_get_sample_instance_channels, [:pointer], :int
    attach_function :al_get_sample_instance_playmode, [:pointer], :int
    attach_function :al_get_sample_instance_playing, [:pointer], :bool
    attach_function :al_get_sample_instance_attached, [:pointer], :bool
    attach_function :al_set_sample_instance_position, [:pointer, :ulong],
                    :bool
    attach_function :al_set_sample_instance_length, [:pointer, :ulong], :bool
    attach_function :al_set_sample_instance_speed, [:pointer, :float], :bool
    attach_function :al_set_sample_instance_gain, [:pointer, :float], :bool
    attach_function :al_set_sample_instance_pan, [:pointer, :float], :bool
    attach_function :al_set_sample_instance_playmode, [:pointer, :int], :bool
    attach_function :al_set_sample_instance_playing, [:pointer, :bool], :bool
    attach_function :al_detach_sample_instance, [:pointer], :bool
    attach_function :al_set_sample, [:pointer, :pointer], :bool
    attach_function :al_get_sample, [:pointer], :pointer
    attach_function :al_play_sample_instance, [:pointer], :bool
    attach_function :al_stop_sample_instance, [:pointer], :bool
    attach_function :al_create_audio_stream, [:size_t, :ulong, :ulong, :int,
                    :int], :pointer
    attach_function :al_destroy_audio_stream, [:pointer], :void
    attach_function :al_drain_audio_stream, [:pointer], :void
    attach_function :al_get_audio_stream_frequency, [:pointer], :uint
    attach_function :al_get_audio_stream_length, [:pointer], :ulong
    attach_function :al_get_audio_stream_fragments, [:pointer], :uint
    attach_function :al_get_available_audio_stream_fragments, [:pointer],
                    :uint
    attach_function :al_get_audio_stream_speed, [:pointer], :float
    attach_function :al_get_audio_stream_gain, [:pointer], :float
    attach_function :al_get_audio_stream_pan, [:pointer], :float
    attach_function :al_get_audio_stream_channels, [:pointer], :int
    attach_function :al_get_audio_stream_depth, [:pointer], :int
    attach_function :al_get_audio_stream_playmode, [:pointer], :int
    attach_function :al_get_audio_stream_playing, [:pointer], :bool
    attach_function :al_get_audio_stream_attached, [:pointer], :bool
    attach_function :al_get_audio_stream_fragment, [:pointer], :pointer
    attach_function :al_set_audio_stream_speed, [:pointer, :float], :bool
    attach_function :al_set_audio_stream_gain, [:pointer, :float], :bool
    attach_function :al_set_audio_stream_pan, [:pointer, :float], :bool
    attach_function :al_set_audio_stream_playmode, [:pointer, :int], :bool
    attach_function :al_set_audio_stream_playing, [:pointer, :bool], :bool
    attach_function :al_detach_audio_stream, [:pointer], :bool
    attach_function :al_set_audio_stream_fragment, [:pointer, :pointer], :bool
    attach_function :al_rewind_audio_stream, [:pointer], :bool
    attach_function :al_seek_audio_stream_secs, [:pointer, :double], :bool
    attach_function :al_get_audio_stream_position_secs, [:pointer], :double
    attach_function :al_get_audio_stream_length_secs, [:pointer], :double
    attach_function :al_set_audio_stream_loop_secs, [:pointer, :double,
                    :double], :bool
    attach_function :al_get_audio_stream_event_source, [:pointer], :pointer
    attach_function :al_create_mixer, [:ulong, :int, :int], :pointer
    attach_function :al_destroy_mixer, [:pointer], :void
    attach_function :al_attach_sample_to_mixer, [:pointer, :pointer], :bool
    attach_function :al_attach_audio_stream_to_mixer, [:pointer, :pointer],
                    :bool
    attach_function :al_attach_mixer_to_mixer, [:pointer, :pointer], :bool
    attach_function :al_set_mixer_postprocess_callback, [:pointer,
                    callback([:pointer, :ulong, :pointer], :void),
                    :pointer], :bool
    attach_function :al_get_mixer_frequency, [:pointer], :uint
    attach_function :al_get_mixer_channels, [:pointer], :int
    attach_function :al_get_mixer_depth, [:pointer], :int
    attach_function :al_get_mixer_quality, [:pointer], :int
    attach_function :al_get_mixer_playing, [:pointer], :bool
    attach_function :al_get_mixer_attached, [:pointer], :bool
    attach_function :al_set_mixer_frequency, [:pointer, :ulong], :bool
    attach_function :al_set_mixer_quality, [:pointer, :int], :bool
    attach_function :al_set_mixer_playing, [:pointer, :bool], :bool
    attach_function :al_detach_mixer, [:pointer], :bool
    attach_function :al_create_voice, [:ulong, :int, :int], :pointer
    attach_function :al_destroy_voice, [:pointer], :void
    attach_function :al_attach_sample_to_voice, [:pointer, :pointer], :bool
    attach_function :al_attach_audio_stream_to_voice, [:pointer, :pointer],
                    :bool
    attach_function :al_attach_mixer_to_voice, [:pointer, :pointer], :bool
    attach_function :al_detach_voice, [:pointer], :void
    attach_function :al_get_voice_frequency, [:pointer], :uint
    attach_function :al_get_voice_position, [:pointer], :ulong
    attach_function :al_get_voice_channels, [:pointer], :int
    attach_function :al_get_voice_depth, [:pointer], :int
    attach_function :al_get_voice_playing, [:pointer], :bool
    attach_function :al_set_voice_position, [:pointer, :ulong], :bool
    attach_function :al_set_voice_playing, [:pointer, :bool], :bool
    attach_function :al_install_audio, [:int], :bool
    attach_function :al_uninstall_audio, [], :void
    attach_function :al_get_allegro_audio_version, [], :uint32
    attach_function :al_get_channel_count, [:int], :size_t
    attach_function :al_get_depth_size, [:int], :size_t
    attach_function :al_reserve_samples, [:int], :bool
    attach_function :al_get_default_mixer, [], :pointer
    attach_function :al_set_default_mixer, [:pointer], :bool
    attach_function :al_restore_default_mixer, [], :bool
    attach_function :al_play_sample, [:pointer, :float, :float, :float,
                    :int, :pointer], :bool
    attach_function :al_stop_sample, [:pointer], :void
    attach_function :al_stop_samples, [], :void
    attach_function :al_register_sample_loader, [:string, callback([:string],
                    :pointer)], :pointer
    attach_function :al_register_sample_saver, [:string, callback([:string,
                    :pointer], :bool)], :bool
    attach_function :al_register_audio_stream_loader, [:string,
                    callback([:string, :size_t, :uint], :pointer)], :pointer
    attach_function :al_load_sample, [:string], :pointer
    attach_function :al_save_sample, [:string, :pointer], :bool
    attach_function :al_load_audio_stream, [:string, :size_t, :uint], :pointer
#    attach_function :al_load_sample_wav, [:string], :pointer
#    attach_function :al_save_sample_wav, [:string, :pointer], :bool
#    attach_function :al_save_sample_wav_pf, [:pointer, :pointer], :bool
#    attach_function :al_load_audio_stream_wav, [:string, :size_t, :uint],
#                    :pointer
end

