require 'rubygems'
require 'fsevent'

class Ucallback < FSEvent
  def self.listen(&block)
    this = self.new(block)
    this.latency = 0.0
    this.watch_directories self.log_dir
    this.start
  end
  
  
  def initialize(block)
    @block = block
    @last_line = get_last_line
  end
  
  def on_change(directories)
    last_line = get_last_line
    # If the last line is equal to this one
    # Is means that the file that was changes isn't system.log
    return if @last_line == last_line or last_line.empty? ; @last_line = last_line

    @block.call($1) if last_line =~ /#{self.matcher}/i
  end
  
  def self.log_dir
    # "/private/var/log/"
    "/tmp/temp_system"
  end
  
  def log_file
    "#{Ucallback.log_dir}/system.log"
  end
  
  def get_last_line
    %x{tail -n 1 #{log_file}}
  end
  
  def matcher
    "uTorrent: Download complete \((.*?)\) - Priority"
  end
end