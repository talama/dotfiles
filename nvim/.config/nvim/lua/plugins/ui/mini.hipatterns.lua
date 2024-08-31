return {
	"echasnovski/mini.hipatterns",
	desc = "Highlight colors in your code",
	event = "BufReadPre",
	config = function()
		local hi = require("mini.hipatterns")

		-- Returns hex color group for matching hsl() color.
		---@param match string
		---@return string
		local hsl_color = function(_, match)
			local style = "bg" -- 'fg' or 'bg'
			local hue, saturation, lightness = match:match("hsl%((%d+) ?(%d+)%% ?(%d+)%%%)")

			-- Converts HSL to RGB.
			-- https://www.w3.org/TR/css-color-3/#hsl-color
			---@param h string The hue value in degrees.
			---@param s string The saturation value in percent.
			---@param l string The lightness value in percent.
			---@return integer, integer, integer
			local function hsl_to_rgb(h, s, l)
				h, s, l = h % 360, s / 100, l / 100
				if h < 0 then
					h = h + 360
				end
				local function f(n)
					local k = (n + h / 30) % 12
					local a = s * math.min(l, 1 - l)
					return l - a * math.max(-1, math.min(k - 3, 9 - k, 1))
				end
				return f(0) * 255, f(8) * 255, f(4) * 255
			end

			local red, green, blue = hsl_to_rgb(hue, saturation, lightness)
			local hex = string.format("#%02x%02x%02x", red, green, blue)
			return hi.compute_hex_color_group(hex, style)
		end

		hi.setup({
			highlighters = {
				hex_color = hi.gen_highlighter.hex_color({ priority = 2000 }),
				hsl_color = {
					pattern = "hsl%(%d+ ?%d+%% ?%d+%%%)",
					group = hsl_color,
				},
			},
		})
	end,
}
