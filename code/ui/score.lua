-- Score UI element
score = {
  x = 120,  -- Positioned on the right side
  y = 120,  -- Positioned at the bottom
  value = 0,
  col = 7   -- White color by default
}

function update_score()
  -- Update score based on game events
  -- This can be expanded based on scoring mechanics
end

function draw_score()
  -- Draw the score text
  print("score: "..score.value, score.x, score.y, score.col)
end

function add_points(points)
  score.value += points
end

function reset_score()
  score.value = 0
end