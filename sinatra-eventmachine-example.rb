require 'sinatra/base'
require 'eventmachine'

class SinatraEventmachineExample < Sinatra::Application
  get '/with_em' do    
    EM.next_tick {
      logger.debug "TestServer: Sleeping on em_enabled"
      sleep 5.0
    }
    "EM enabled!"
  end
  get '/without_em' do
    logger.debug "TestServer: Sleeping on em_disabled"
    sleep 5.0
    "EM disabled!"
  end
end