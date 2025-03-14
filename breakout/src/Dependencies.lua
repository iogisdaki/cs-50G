push = require 'libraries/push'
Class = require 'libraries/class'
require 'src/Constants'

-- a basic StateMachine class which will allow us to transition to and from
-- game states smoothly and avoid monolithic code in one file
require 'src/StateMachine'
require 'src/LevelMaker'

require 'src/Util'
require 'src/Paddle'
require 'src/Ball'
require 'src/Brick'

require 'src/states/BaseState'
require 'src/states/StartState'
require 'src/states/PlayState'
require 'src/states/ServeState'