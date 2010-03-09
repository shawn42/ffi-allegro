
require 'allegro'

include Allegro

if ARGV.length != 1
  puts "usage: $0 <font file>"
  exit 1
end

def run(argc, argv)
  font_file = ARGV[0]

  al_install_system nil
  al_init_font_addon
  al_init_ttf_addon

  dpy = al_create_display 800, 600
  al_install_keyboard
  al_install_mouse

  al_set_window_title "ffi-allegro example: text display"

  evqueue = al_create_event_queue()
  al_register_event_source evqueue, al_get_display_event_source(dpy)
  al_register_event_source evqueue, al_get_keyboard_event_source
  al_register_event_source evqueue, al_get_mouse_event_source

  font = al_load_ttf_font font_file, 16, 0
  if font.null?
    puts "cannot load font from file #{font_file} (#{al_get_errno})"
    exit 1
  end

  bgcolor = al_map_rgb 20, 20, 255
  fgcolor = al_map_rgb 40, 80, 160

  stop = false
  while !stop do
    al_clear_to_color bgcolor
    # why does this line cause it to draw in black?
    #al_set_blender ALLEGRO_ALPHA, ALLEGRO_INVERSE_ALPHA, fgcolor

    al_draw_text font, 400, 300, ALLEGRO_ALIGN_CENTRE, "Hello!"

    al_flip_display

    ev = Event.new
    al_wait_for_event evqueue, ev

    case ev[:type]
    when ALLEGRO_EVENT_KEY_UP
      if ev[:keyboard][:keycode] == ALLEGRO_KEY_ESCAPE
        stop = true
      end

    when ALLEGRO_EVENT_DISPLAY_CLOSE
      stop = true
    end
  end

  al_destroy_font font

  al_destroy_event_queue evqueue
  al_destroy_display dpy

  al_uninstall_system
end
args = ARGV.dup
args.unshift $0
strptrs = []

args.each do |arg|
  strptrs << FFI::MemoryPointer.from_string(arg)
end

# Now load all the pointers into a native memory block
argv = FFI::MemoryPointer.new(:pointer, strptrs.length)
strptrs.each_with_index do |p, i|
  argv[i].put_pointer(0,  p)
end


al_run_main ARGV.size, argv, &method(:run)
