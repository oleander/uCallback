require 'rubygems'
require 'fsevent'

class Ucallback < FSEvent
  def self.listen(application ='uTorrent', &block)
    this = self.new(application, block)
    this.latency = 0.0
    this.watch_directories this.log_dir
    this.start
  end
  
  def initialize(application, block)
    @block       = block
    @application = application
    @last_line   = get_last_line
  end
  
  def on_change(directories)
    last_line = get_last_line
    # If the last line is equal to this one
    # Is means that the file that was changes isn't system.log
    return if @last_line == last_line or last_line.empty? ; @last_line = last_line

    @block.call($1) if last_line =~ /#{self.matcher}/i
  end
  
  def log_dir
    "/private/var/log/"
    # "/tmp/temp_system" # Only for tests
  end
  
  def log_file
    "#{self.log_dir}/system.log"
  end
  
  def get_last_line
    %x{tail -n 1 #{log_file}}
  end
  
  def matcher 
    "#{@application}: Download complete \((.*?)\) - Priority"
  end
end                                  