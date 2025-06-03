function update_top_bars()
end

function draw_top_bars()
  local margin = 4 -- leftmost
  local portrait_width = 16
  local bar_width = 40
  local bar_height = 4
  local x1 = margin + portrait_width + 2 -- middle
  local x3 = 90 -- end

  local y0 = margin

  -- portrait
  rectfill(margin, margin, margin + portrait_width, margin + portrait_width, 7)
  rectfill(margin + 1, margin + 1, margin + portrait_width - 1, margin + portrait_width - 1, 8)
  sspr(margin + 1, margin + 1, portrait_width - 2, portrait_width - 2, margin + 1, margin + 1, portrait_width - 1, portrait_width - 1)

  -- name
  -- print("jEAN", x1 + 1, y0 + 16, 7)

  -- -- energy
  print("jEAN", x1 + 1, y0 + 3, 7)
  rect(x1, y0 + bar_height + 5, x1 + bar_width, y0 + bar_height * 2 + 5, 7)
  rectfill(x1 + 1, y0 + bar_height + 6, x1 + bar_width - 1, y0 + bar_height * 2 + 4, 8)

  -- energy bar
  local energy = player.energy
  local energy_bar_width = ceil(bar_width * (energy / 100))
  energy_bar_width = mid(0, energy_bar_width, bar_width - 2)
  rectfill(x1 + 1, y0 + bar_height + 6, x1 + 1 + energy_bar_width, y0 + bar_height * 2 + 4, 10)
end
