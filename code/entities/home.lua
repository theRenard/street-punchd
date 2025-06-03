homes = {}
home_width = 42
home_height = 57
home_spacing = 10
last_index = 0

function init_home()
  for i = 1, 4 do
    homes[i] = {
      x = i * (home_width + home_spacing),
      y = 7,
      draw = randint(0, 4),
      color = randint(0, 1),
    }
    last_index = i
  end
end

function update_home()
  for i = 1, #homes do
    homes[i].x -= scroll_speed * 1.5
    if homes[i].x < -(home_width + home_spacing) then
      -- move home to the end of the collection
      homes[i].x = homes[last_index].x + home_width + home_spacing
      homes[i].draw = randint(0, 4)
      homes[i].color = randint(0, 1)
      last_index = i
    end
  end
end

function draw_home()
  for i = 1, #homes do
    local flrx = flr(homes[i].x)
    palt(12, true)
    palt(0, false)
    pal(8, 10)
    if homes[i].draw >= 1 then
      if homes[i].color == 0 then
        pal(6, 14)
        pal(2, 4)
        pal(13, 15)
      end
      sspr(50, 70, home_width, home_height, flrx, homes[i].y)
      pal(6, 6)
      pal(2, 2)
      pal(13, 15)
    end
    pal(8, 8)
    palt(0, true)
    palt(12, false)
  end
end

