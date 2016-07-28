local Constants = {}

Constants.SCREEN_WIDTH = love.graphics.getWidth()
Constants.SCREEN_HEIGHT = love.graphics.getHeight()

Constants.BOARD_WIDTH = Constants.SCREEN_HEIGHT
Constants.BOARD_HEIGHT = Constants.SCREEN_HEIGHT

Constants.CELL_WIDTH = 126
Constants.CELL_HEIGHT = 126
Constants.BORDER_SIZE = 8

Constants.BOARD_ORIGIN_X = ((Constants.SCREEN_WIDTH - Constants.BOARD_WIDTH) * 0.5) + Constants.BORDER_SIZE
Constants.BOARD_ORIGIN_Y = ((Constants.SCREEN_HEIGHT - Constants.BOARD_HEIGHT) * 0.5) + Constants.BORDER_SIZE

Constants.NUM_ROWS = 8
Constants.NUM_COLUMNS = 8

return Constants