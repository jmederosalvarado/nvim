local H = {}

-- Validation

H.is_valid_hex = function(x, x_name)
  return type(x) == 'string' and x:len() == 7 and x:sub(1, 1) == '#' and (tonumber(x:sub(2), 16) ~= nil)
end

-- Color manipulation ---------------------------------------------------------

-- Blends two colors with a given percentage.
-- @param first The primary hex color.
-- @param second The hex color to which you want to blend the first color.
-- @param strength Percentage indicating how much to blend.
--                 This needs to be a number between 0 - 1.
-- @return The mixed color as a hex value
H.blend = function(first, second, strength)
  local s = strength or 0.5

  local first_rgb = H.hex2rgb(first)
  local second_rgb = H.hex2rgb(second)

  local r1, g1, b1 = first_rgb.r, first_rgb.g, first_rgb.b
  local r2, g2, b2 = second_rgb.r, second_rgb.g, second_rgb.b

  if r1 == nil or r2 == nil then return first end

  if s == 0 then
    return first
  elseif s == 1 then
    return second
  end

  local r3 = r1 * (1 - s) + r2 * s
  local g3 = g1 * (1 - s) + g2 * s
  local b3 = b1 * (1 - s) + b2 * s

  return H.rgb2hex({ r = r3, g = g3, b = b3 })
end

-- Color conversion -----------------------------------------------------------
-- Source: https://www.easyrgb.com/en/math.php
-- Accuracy is usually around 2-3 decimal digits, which should be fine

-- HEX <-> CIELCh(uv)
H.hex2lch = function(hex)
  local res = hex
  for _, f in pairs({ H.hex2rgb, H.rgb2xyz, H.xyz2luv, H.luv2lch }) do
    res = f(res)
  end
  return res
end

H.lch2hex = function(lch)
  local res = lch
  for _, f in pairs({ H.lch2luv, H.luv2xyz, H.xyz2rgb, H.rgb2hex }) do
    res = f(res)
  end
  return res
end

-- HEX <-> RGB
H.hex2rgb = function(hex)
  local dec = tonumber(hex:sub(2), 16)

  local b = math.fmod(dec, 256)
  local g = math.fmod((dec - b) / 256, 256)
  local r = math.floor(dec / 65536)

  return { r = r, g = g, b = b }
end

H.rgb2hex = function(rgb)
  -- Round and trim values
  local t = vim.tbl_map(function(x)
    x = math.min(math.max(x, 0), 255)
    return math.floor(x + 0.5)
  end, rgb)

  return '#' .. string.format('%02x', t.r) .. string.format('%02x', t.g) .. string.format('%02x', t.b)
end

-- RGB <-> XYZ
H.rgb2xyz = function(rgb)
  local t = vim.tbl_map(function(c)
    c = c / 255
    if c > 0.04045 then
      c = ((c + 0.055) / 1.055) ^ 2.4
    else
      c = c / 12.92
    end
    return 100 * c
  end, rgb)

  -- Source of better matrix: http://brucelindbloom.com/index.html?Eqn_RGB_XYZ_Matrix.html
  local x = 0.41246 * t.r + 0.35757 * t.g + 0.18043 * t.b
  local y = 0.21267 * t.r + 0.71515 * t.g + 0.07217 * t.b
  local z = 0.01933 * t.r + 0.11919 * t.g + 0.95030 * t.b
  return { x = x, y = y, z = z }
end

H.xyz2rgb = function(xyz)
  -- Source of better matrix: http://brucelindbloom.com/index.html?Eqn_RGB_XYZ_Matrix.html
  -- stylua: ignore start
  local r =  3.24045 * xyz.x - 1.53713 * xyz.y - 0.49853 * xyz.z
  local g = -0.96927 * xyz.x + 1.87601 * xyz.y + 0.04155 * xyz.z
  local b =  0.05564 * xyz.x - 0.20403 * xyz.y + 1.05722 * xyz.z
  -- stylua: ignore end

  return vim.tbl_map(function(c)
    c = c / 100
    if c > 0.0031308 then
      c = 1.055 * (c ^ (1 / 2.4)) - 0.055
    else
      c = 12.92 * c
    end
    return 255 * c
  end, {
    r = r,
    g = g,
    b = b,
  })
end

-- XYZ <-> CIELuv
-- Using white reference for D65 and 2 degrees
H.ref_u = (4 * 95.047) / (95.047 + (15 * 100) + (3 * 108.883))
H.ref_v = (9 * 100) / (95.047 + (15 * 100) + (3 * 108.883))

H.xyz2luv = function(xyz)
  local x, y, z = xyz.x, xyz.y, xyz.z
  if x + y + z == 0 then return { l = 0, u = 0, v = 0 } end

  local var_u = 4 * x / (x + 15 * y + 3 * z)
  local var_v = 9 * y / (x + 15 * y + 3 * z)
  local var_y = y / 100
  if var_y > 0.008856 then
    var_y = var_y ^ (1 / 3)
  else
    var_y = (7.787 * var_y) + (16 / 116)
  end

  local l = (116 * var_y) - 16
  local u = 13 * l * (var_u - H.ref_u)
  local v = 13 * l * (var_v - H.ref_v)
  return { l = l, u = u, v = v }
end

H.luv2xyz = function(luv)
  if luv.l == 0 then return { x = 0, y = 0, z = 0 } end

  local var_y = (luv.l + 16) / 116
  if var_y ^ 3 > 0.008856 then
    var_y = var_y ^ 3
  else
    var_y = (var_y - 16 / 116) / 7.787
  end

  local var_u = luv.u / (13 * luv.l) + H.ref_u
  local var_v = luv.v / (13 * luv.l) + H.ref_v

  local y = var_y * 100
  local x = -(9 * y * var_u) / ((var_u - 4) * var_v - var_u * var_v)
  local z = (9 * y - 15 * var_v * y - var_v * x) / (3 * var_v)
  return { x = x, y = y, z = z }
end

-- CIELuv <-> CIELCh(uv)
H.tau = 2 * math.pi

H.luv2lch = function(luv)
  local c = math.sqrt(luv.u ^ 2 + luv.v ^ 2)
  local h
  if c == 0 then
    h = 0
  else
    -- Convert [-pi, pi] radians to [0, 360] degrees
    h = (math.atan2(luv.v, luv.u) % H.tau) * 360 / H.tau
  end
  return { l = luv.l, c = c, h = h }
end

H.lch2luv = function(lch)
  local angle = lch.h * H.tau / 360
  local u = lch.c * math.cos(angle)
  local v = lch.c * math.sin(angle)
  return { l = lch.l, u = u, v = v }
end

-- Distances ------------------------------------------------------------------
H.dist_circle = function(x, y)
  local d = math.abs(x - y) % 360
  return d > 180 and (360 - d) or d
end

H.dist_circle_set = function(set1, set2)
  -- Minimum distance between all pairs
  local dist = math.huge
  local d
  for _, x in pairs(set1) do
    for _, y in pairs(set2) do
      d = H.dist_circle(x, y)
      if dist > d then dist = d end
    end
  end
  return dist
end

H.nearest_rgb_id = function(rgb_target, rgb_palette)
  local best_dist = math.huge
  local best_id, dist
  for id, rgb in pairs(rgb_palette) do
    dist = math.abs(rgb_target.r - rgb.r) + math.abs(rgb_target.g - rgb.g) + math.abs(rgb_target.b - rgb.b)
    if dist < best_dist then
      best_id, best_dist = id, dist
    end
  end

  return best_id
end

-- Utilities ------------------------------------------------------------------
H.error = function(msg) error('(mini.base16) ' .. msg, 0) end

H.check_type = function(name, val, ref, allow_nil)
  if type(val) == ref or (ref == 'callable' and vim.is_callable(val)) or (allow_nil and val == nil) then return end
  H.error(string.format('`%s` should be %s, not %s', name, ref, type(val)))
end

return H
