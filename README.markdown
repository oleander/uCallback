# µCallback

## What is µCallback?

µCallback makes it possible to call a script or application when a BitTorrent download finishes.

It has support both [Transmission](http://www.transmissionbt.com/) and [µTorrent](http://user.utorrent.com/), even though Transmission already supports it.

## How to use

### Installation

      [sudo] gem install ucallback  
      
### An example - The *synchronous* version

This example listen for µTorrent downloads. When a download finishes, the block is being called with the name of the downloaded item.

So if you downloaded *House.S07E11.HDTV.XviD-LOL.avi* the `item` variable would be set to just that value.
      
      #!/usr/bin/env ruby

      require 'rubygems'
      require 'ucallback'

      Ucallback.listen('uTorrent') do |item|
        # Do something with the information
      end

### A background example - The *asynchronous* version 

The previous example runs as an synchronous script, but what if you what to run it in the background?

The [daemonize](http://daemons.rubyforge.org/) gem fixes this for us. It daemonizes the current thread so we can run it in the background.

Don't forget to install `daemonize` using `[sudo] gem install daemons` 
      
      #!/usr/bin/env ruby

      require 'rubygems'
      require 'ucallback'
      require 'daemons'   
      
      Daemons.daemonize
      
      Ucallback.listen('Transmission') do |item|
        # Do something with the information
      end    

Save the code above to a file, run `chmod +x the_file_you_just_created` on it and you should be able to start it using `the_file_you_just_created`.

## How to help

- Start by copying the project or make your own branch.
- Navigate to the root path of the project and run `bundle`.
- Start by running all tests using rspec, `rspec spec/ucallback_spec.rb`.
- Implement your own code, write some tests, commit and do a pull request.

## Requirements

µCallback is tested on OS X 10.6.6 using Ruby 1.8.7.
With µTorrent [beta 1.1](http://user.utorrent.com/downloads/mac).

**µCallback only works with µTorrent versions that supports [Growl](http://growl.info/) messages.**