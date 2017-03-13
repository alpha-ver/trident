class Daemon

  def sig(attr={})
    signals = [
      "EXIT",
      "HUP",
      "INT",
      "QUIT",
      "TRAP",
      "ABRT",
      "IOT",
      "SYS",
      "PIPE",
      "ALRM",
      "TERM",
      "URG",
      "TSTP",
      "CONT",
      "CHLD",
      "CLD",
      "TTIN",
      "TTOU",
      "IO",
      "XCPU",
      "XFSZ",
      "PROF",
      "WINCH",
      "USR1",
      "USR2",
      "PWR",
      "POLL"]
    signals.each do |signal,i|
      Signal.trap(signal) do
        case signal
        when "INT", "TERM", "TSTP"
          print "\nSignal - #{signal}\n".colorize(:black).on_white
          Process.kill 9, Process.pid
        else
          puts "Signal - #{signal} - Ignoring".colorize(:black).on_white

        end
      end
    end
  end

  def state

  end

end
