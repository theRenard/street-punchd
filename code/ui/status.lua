function update_status()
end

function draw_status()
  local x0 = 4 -- leftmost
  local pw = 15
  local bw = 50
  local bh = 6
  local x1 = x0 + pw + 2 -- middle
  local x3 = 90 -- end

  local y0 = 4

  -- portrait
  rectfill(x0, y0, x0 + pw, y0 + pw, 7)
  rectfill(x0 + 1, y0 + 1, x0 + pw - 1, y0 + pw - 1, 8)
  sspr(x0 + 1, y0 + 1, pw - 2, pw - 2, x0 + 1, y0 + 1, pw - 1, pw - 1)

  -- name
  -- print("jEAN", x1 + 1, y0 + 16, 7)

  -- -- energy
  print("jEAN", x1 + 1, y0 + 3, 7)
  rect(x1, y0 + bh + 3, x1 + bw, y0 + bh * 2 + 3, 7)
  rectfill(x1 + 1, y0 + bh + 4, x1 + bw - 1, y0 + bh * 2 + 2, 8)

  -- energy bar
  local energy = p.energy
  local energy_bar_width = bw * (energy / 100)
  rectfill(x1 + 1, y0 + bh + 4, x1 + energy_bar_width - 1, y0 + bh * 2 + 2, 10)
end
