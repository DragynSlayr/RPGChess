StringHelper = require("utils.stringHelper")
FileHandler = require("utils.fileHandler")
MathHelper = require("utils.mathHelper")
Constants = require("utils.constants")
Renderer = require("utils.renderer")
Sprite = require("utils.sprite")
Driver = require("utils.driver")

debugging = false

-- Register mouse events
love.mousepressed = Driver.mousePressed

--Register key events
love.keypressed = Driver.keyPressed

-- Register love events
love.load = Driver.load
love.update = Driver.update
love.draw = Driver.draw

--Change background color
love.graphics.setBackgroundColor(200, 200, 200, 255)