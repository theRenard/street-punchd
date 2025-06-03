-- this entity is used to create a background building,
-- it is just a black rectangle with diagonal lines as windows
-- it is used to create a street scene

buildings = {}

function init_buildings()
  -- create background of buildings
  local building_pos = 0
  for i = 1, 20 do
    local building_width = randint(6, 16)
    -- a building height is between 40 and 50,
    -- the width is between 6 and 10
    -- the y position is always 70
    buildings[i] = {
      x = building_pos,
      y = 64,
      w = building_width,
      h = randint(30, 50),
      windows = randint(0, 5),
      window_color = 1,
      window_width = randint(1, 2),
      window_height = randint(2, 6),
      window_spacing = randint(3, 5)
    }
    building_pos = building_pos + building_width
  end
end

function update_buildings()
  -- move buildings to the left
  for i = 1, #buildings do
    buildings[i].x -= scroll_speed * 0.3
    if buildings[i].x < -20 then
      buildings[i].x = 148 + buildings[i].x
    end
  end
end

function draw_buildings()
  -- draw buildings
  for i = 1, #buildings do
    local building = buildings[i]

    local flrx = flr(building.x)
    rectfill(flrx, building.y, building.x + building.w, building.y - building.h, building.color)

    -- Draw vertical windows
    -- The windows are drawn in a column
    -- starting from the top of the building
    -- the windows are spaced out by the window_spacing
    -- the windows are centered vertically
    for i = 1, building.windows do
      local spacing = (building.window_spacing + building.window_height) * i
      local x0 = flrx + (building.w / 2) - building.window_width / 2
      local y0 = building.y - building.h + spacing
      local x1 = x0 + building.window_width
      local y1 = y0 - building.window_height
      rectfill(x0, y0, x1, y1, building.window_color)
    end
    -- print(w, x, y - h, 4)
  end
end