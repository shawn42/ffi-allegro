
require 'allegro'

include Allegro

if ARGV.length != 1
    puts "usage: $0 <image file>"
    exit 1
end

def run(argc, argv)
  img_file = ARGV[0]

  al_install_system nil
  al_init_image_addon

  dpy = al_create_display 800, 600
  al_install_keyboard
  al_install_mouse

  al_set_window_title "ffi-allegro example: image display"

  evqueue = al_create_event_queue()
  al_register_event_source evqueue, al_get_display_event_source(dpy)
  al_register_event_source evqueue, al_get_keyboard_event_source
  al_register_event_source evqueue, al_get_mouse_event_source

  img = al_load_bitmap img_file
  if img.null?
      puts "cannot load image from file #{img_file} (#{al_get_errno})"
      exit 1
  end

  al_resize_display al_get_bitmap_width(img), al_get_bitmap_height(img)

  bgcolor = al_map_rgb 20, 20, 20

  stop = false
  while !stop do
      al_clear_to_color bgcolor

      al_draw_bitmap img, 0, 0, 0

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

  al_destroy_bitmap img

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
