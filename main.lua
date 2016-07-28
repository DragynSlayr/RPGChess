Constants = require("utils.constants")
Sprite = require("utils.sprite")
Driver = require("utils.driver")

debugging = true

-- Register mouse events
love.mousepressed = Driver.mousePressed

--Register key events
love.keypressed = Driver.keyPressed

-- Register love events
love.load = Driver.load
love.update = Driver.update
love.draw = Driver.draw

--Change background color
love.graphics.setBackgroundColor(200, 188, 146)