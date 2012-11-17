require 'rubygems'
require 'sinatra/base'
require 'eventmachine'
require 'logger'

$logger = Logger.new(File.join(File.dirname(__FILE__), "development.log"))

module TestEM
  def self.start
    if defined?(PhusionPassenger)
      $logger.debug "TestEM: PhusionPassenger *is* defined"
      PhusionPassenger.on_event(:starting_worker_process) do |forked|
        EM.stop if (forked && EM.reactor_running?)        

        $logger.debug "TestEM: Starting EM ... "
        Thread.new { EM.run }
        die_gracefully_on_signal
      end
    end
  end

  def self.die_gracefully_on_signal
    Signal.trap("INT")  { EM.stop }
    Signal.trap("TERM") { EM.stop }
  end
end

TestEM.start

class TestServer < Sinatra::Application

  get '/em_enabled' do    
    EM.next_tick {
      $logger.debug "TestServer: Sleeping on em_enabled"
      sleep 10.0
    }

    "EM enabled!"
  end
  
  get '/em_disabled' do
    
    $logger.debug "TestServer: Sleeping on em_disabled"
    sleep 10.0
    
    "EM disabled!"
  end
end

# [vincentc@local flowb_em_test]$ ab -n 1000 -c 10 http://testhost.com:8080/em_enabled
# Connection Times (ms)
#               min  mean[+/-sd] median   max
# Connect:        0    0   0.2      0       2
# Processing:     1    4   1.3      3      13
# Waiting:        1    4   1.3      3      12
# Total:          2    4   1.3      4      13
# 
# Percentage of the requests served within a certain time (ms)
#   50%      4
#   66%      4
#   75%      4
#   80%      5
#   90%      5
#   95%      6
#   98%      8
#   99%      9
#  100%     13 (longest request)