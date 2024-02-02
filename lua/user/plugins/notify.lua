return {
  "rcarriga/nvim-notify",
  version = "*", -- Recommended, use latest release instead of latest commit
  lazy = true,
  -- config = function()
  --   require('nvim-notify').setup(
  opts =
  {
    background_colour = "NotifyBackground",
    fps = 30,
    icons = {
      DEBUG = "",
      ERROR = "",
      INFO = "",
      TRACE = "✎",
      WARN = ""
    },
    level = 2,
    minimum_width = 50,
    render = "compact",
    stages = "fade_in_slide_out",
    time_formats = {
      notification = "%T",
      notification_history = "%FT%T"
    },
    timeout = 5000,
    top_down = true
  }
  --   )
  -- end
}
