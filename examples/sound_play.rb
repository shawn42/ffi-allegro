
$:.unshift(File.expand_path(File.join(File.dirname(__FILE__), "..", "lib")))

require 'allegro'

include Allegro

if ARGV.length != 1
    puts "usage: $0 <audio file>"
    exit 1
end
audio_file = ARGV[0]

al_install_system nil

if not al_install_audio ALLEGRO_AUDIO_DRIVER_AUTODETECT
    puts "cannot install audio system: #{al_get_errno}"
    exit 1
end

al_init_ogg_vorbis_addon
al_init_flac_addon

sample = al_load_sample audio_file
if sample.null?
    puts "cannot load sample from file #{audio_file} (#{al_get_errno})"
    exit 1
end

length = al_get_sample_length(sample).to_f / al_get_sample_frequency(sample)

al_reserve_samples 1
al_play_sample sample, 1.0, 0.0, 1.0, ALLEGRO_PLAYMODE_ONCE, nil
sleep length

al_destroy_sample sample

al_uninstall_system
