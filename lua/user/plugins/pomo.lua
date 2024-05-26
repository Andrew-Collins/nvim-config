local BellNotifier = {}

BellNotifier.new = function(timer, opts)
  local self = setmetatable({}, { __index = BellNotifier })
  self.timer = timer
  self.notification = nil
  self.opts = opts and opts or {}
  self.title_icon = "󱎫"
  self.text_icon = "󰄉"
  self.sticky = false
  self._last_text = nil
  return self
end

BellNotifier._update = function(self, text, level, timeout)
  local repetitions_str = ""
  if self.timer.max_repetitions ~= nil and self.timer.max_repetitions > 0 then
    repetitions_str = string.format(" [%d/%d]", self.timer.repetitions + 1, self.timer.max_repetitions)
  end

  local title
  if self.timer.name ~= nil then
    title = string.format(
      "Timer #%d, %s, %s%s",
      self.timer.id,
      self.timer.name,
      require("pomo").util.format_time(self.timer.time_limit),
      repetitions_str
    )
  else
    title = string.format("Timer #%d, %s%s", self.timer.id, require("pomo").util.format_time(self.timer.time_limit),
      repetitions_str)
  end

  if text ~= nil then
    self._last_text = text
  elseif not self._last_text then
    return
  else
    text = self._last_text
  end

  assert(text)

  local ok, notify = pcall(require, "notify")
  if not ok then
    notify = vim.notify
  end

  local notification = notify(text, level, {
    icon = self.title_icon,
    title = title,
    timeout = timeout,
    replace = self.notification,
    hide_from_history = true,
  })

  if self.sticky then
    self.notification = notification
  end
end

BellNotifier.tick = function(self, time_left)
  if self.sticky then
    self:_update(
      string.format(
        " %s  %s left...%s",
        self.text_icon,
        require("pomo").util.format_time(time_left),
        self.timer.paused and " (paused)" or ""
      ),
      vim.log.levels.INFO,
      false
    )
  end
end

BellNotifier.start = function(self)
  ---@type integer|boolean
  local timeout = false
  if not self.sticky then
    timeout = 1000
  end
  self:_update(string.format(" %s  starting...", self.text_icon), vim.log.levels.INFO, timeout)
end

BellNotifier.done = function(self)
  self:_update(string.format(" %s  timer done!", self.text_icon), vim.log.levels.WARN, 3000)
  os.execute('tput bel')
end

BellNotifier.stop = function(self)
  self:_update(string.format(" %s  stopping...", self.text_icon), vim.log.levels.INFO, 1000)
end

BellNotifier.hide = function(self)
  self:_update(nil, vim.log.levels.INFO, 100)
  self.sticky = false
end

BellNotifier.show = function(self)
  self.sticky = true
  local time_left = self.timer:time_remaining()
  if time_left ~= nil and time_left > 0 then
    self:tick(time_left)
  end
end

return { {
  "epwalsh/pomo.nvim",
  version = "*", -- Recommended, use latest release instead of latest commit
  lazy = true,
  cmd = { "TimerStart", "TimerRepeat" },
  dependencies = {
    -- Optional, but highly recommended if you want to use the "Default" timer
    "rcarriga/nvim-notify",
  },
  opts = {
    update_interval = 1000,
    notifiers = {
      -- {
      --   name = "Default",
      --   opts = {
      --     sticky = false,
      --     title_icon = "󱎫",
      --     text_icon = "󰄉",
      --     -- title_icon = "⏳",
      --     -- text_icon = "⏱️",
      --   },
      -- },
      -- TODO: write terminal bell function
      { init = BellNotifier.new, opts = {} },
    },
    -- Override the notifiers for specific timer names.
    --   timers = {
    --     -- For example, use only the "System" notifier when you create a timer called "Break",
    --     -- e.g. ':TimerStart 2m Break'.
    --     Break = {
    --       { name = "System" },
    --     },
    --   },
  }
} }
