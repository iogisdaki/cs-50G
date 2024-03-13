BaseState = Class{}

-- this class defines empty methods so you can inherite and choose which methods you want to implement without having errors
function BaseState:init() end
function BaseState:enter() end
function BaseState:exit() end
function BaseState:update(dt) end
function BaseState:render() end