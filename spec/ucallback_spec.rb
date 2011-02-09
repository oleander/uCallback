require 'spec_helper'   
def write(application = 'uTorrent')
  system "echo '2011-02-09 01.56.09 GrowlHelperApp[533] #{application}: Download complete (House.S07E11.HDTV.XviD-LOL.avi) - Priority 0' >> /tmp/temp_system/system.log"
end

describe Ucallback do
  before(:all) do
    @log_file = File.expand_path(File.dirname(__FILE__) + "/data/system.log")
    @bin      = File.expand_path(File.dirname(__FILE__) + "../../bin/ucallback")
  end
  
  before(:each) do
    random        = Digest::MD5.hexdigest(Time.now.to_s)
    @folder       = "/tmp/#{random}"
    @file         = "#{@folder}/#{random}"
    @tmp_log_file = "#{@folder}/system.log"
    
    %x{mkdir -p /tmp/temp_system && rm -r /tmp/temp_system && mkdir -p /tmp/temp_system && mkdir -p #{@folder} && cp #{@log_file} /tmp/temp_system}
    
    @loop = 0
  end                            

  it "should not see a message if the same already exists" do
    system "sleep 3 && #{@bin} #{@file} uTorrent &" 
    write; sleep 6; write    
    loop do
      sleep 0.2
      @loop += 1
      break if system "test -e #{@file}" or @loop == 10 # Breaks if the file exists
    end
    
    system("test -e #{@file}").should be_false
  end
  
  it "should know when a message is being passed" do
    system "sleep 3 && #{@bin} #{@file} uTorrent &" 
    sleep 6; write

    loop do
      sleep 0.2
      @loop += 1
      break if system "test -e #{@file}" or @loop == 10 # Breaks if the file exists
    end
    
    File.read(@file).should match(/House\.S07E11\.HDTV\.XviD-LOL\.avi/)       
  end
  
  it "should know when a message is being passed, using Transmission" do
    system "sleep 3 && #{@bin} #{@file} Transmission &" 
    sleep 6; write("Transmission")

    loop do
      sleep 0.2
      @loop += 1
      break if system "test -e #{@file}" or @loop == 10 # Breaks if the file exists
    end
    
    File.read(@file).should match(/House\.S07E11\.HDTV\.XviD-LOL\.avi/)       
  end
end 