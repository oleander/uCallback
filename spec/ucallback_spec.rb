require 'spec_helper'   
def write
  system "echo '2011-02-09 01.56.09 GrowlHelperApp[533] uTorrent: Download complete (House.S07E11.HDTV.XviD-LOL.avi) - Priority 0' >> /tmp/temp_system/system.log"
end

describe Ucallback do
  before(:all) do
    @log_file = File.expand_path(File.dirname(__FILE__) + "/data/system.log")
  end
  
  before(:each) do
    random        = Digest::MD5.hexdigest(Time.now.to_s)
    @folder       = "/tmp/#{random}"
    @file         = "#{@folder}/#{random}"
    @tmp_log_file = "#{@folder}/system.log"
    
    %x{mkdir -p /tmp/temp_system && rm -r /tmp/temp_system && mkdir -p /tmp/temp_system && mkdir -p #{@folder} && cp #{@log_file} /tmp/temp_system}
        
    @bin = File.expand_path(File.dirname(__FILE__) + "../../bin/ucallback") 
    system "sleep 3 && #{@bin} #{@file} &"
    @loop = 0
  end                            

  it "should not see a message if the same already exists" do
    write; sleep 6; write    
    loop do
      sleep 0.2
      @loop += 1
      break if system "test -e #{@file}" or @loop == 10 # Breaks if the file exists
    end
    
    system("test -e #{@file}").should be_false
  end
  
  it "should know when a message is being passed" do
    sleep 6; write

    loop do
      sleep 0.2
      @loop += 1
      break if system "test -e #{@file}" or @loop == 10 # Breaks if the file exists
    end
    
    File.read(@file).should match(/House\.S07E11\.HDTV\.XviD-LOL\.avi/)       
  end
end