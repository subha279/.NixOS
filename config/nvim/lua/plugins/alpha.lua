return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    -- Header (Centered)
    dashboard.section.header.val = { "NVIM" }

    -- Remove menu (empty buttons section)
    dashboard.section.buttons.val = {}

    -- Footer (Centered)
    dashboard.section.footer.val = {
      "",
      "The more lower you go,",
      "The more amusing it gets...",
      "Just kidding.",
      "You only go insane 󰈸",
    }
    dashboard.section.footer.opts.hl = "String"

    -- Adjust layout to center header and footer
    dashboard.config.layout = {
      { type = "padding", val = 10 }, -- Push header down (adjust this)
      dashboard.section.header,
      { type = "padding", val = 6 }, -- Space between header and footer
      dashboard.section.footer,
    }

    -- Apply the configuration
    alpha.setup(dashboard.opts)
  end,
}
