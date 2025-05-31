background = {}

function init_background()
  background.x = 0
  background.y = 0
end

function draw_background()
  -- draw a background
  -- starting from position x = 1, y = 1
  -- ending at position x = 128, y = 64
  -- draw pixels every 2 pixels
  rectfill(0, 0, 128, 64, 1)
  fillp(0X33)
  rectfill(0, 0, 20, 64, 145)
  rectfill(21, 4, 40, 64, 145)
  rectfill(41, 8, 60, 64, 145)
  rectfill(61, 12, 80, 64, 145)
  rectfill(81, 16, 100, 64, 145)
  rectfill(101, 20, 120, 64, 145)
  rectfill(121, 24, 128, 64, 145)
  fillp(0)
end