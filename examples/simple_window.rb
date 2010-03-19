
require 'allegro'

include Allegro


def run(argc, argv)
#  puts "WOW"
#  $t = Thread.new do
#    f = File.open("/Users/shawn42/tmp/wow.txt","w+")
#    f.write "ack"
#    f.flush
    GC.start
#    f.write "HERE"
#    f.flush
    al_install_system ALLEGRO_VERSION_INT, nil

#    f.write "SYS UP"
#    f.flush
    dpy = al_create_display 800, 600
#    f.write "DISPLAY UP"
#    f.flush
    al_install_keyboard
    al_install_mouse

    al_set_window_title "ffi-allegro example: simple window"

    evqueue = al_create_event_queue()
    al_register_event_source evqueue, al_get_display_event_source(dpy)
    al_register_event_source evqueue, al_get_keyboard_event_source
    al_register_event_source evqueue, al_get_mouse_event_source

    stop = false
    while !stop do
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


    al_destroy_event_queue evqueue
    al_destroy_display dpy
    al_uninstall_system
#    exit 0
#  end
#
#  p $t.methods.sort-nil.methods
#  p $t.wakeup
#  p $t.run
  0
end

$args = ARGV.dup
$args.unshift $0
$strptrs = []

$args.each do |arg|
  $strptrs << FFI::MemoryPointer.from_string(arg)
end

# Now load all the pointers into a native memory block
$argv = FFI::MemoryPointer.new(:pointer, $strptrs.length)
$strptrs.each_with_index do |p, i|
  $argv[i].put_pointer(0,  p)
end


al_run_main $argv.size, $argv, &method(:run)
