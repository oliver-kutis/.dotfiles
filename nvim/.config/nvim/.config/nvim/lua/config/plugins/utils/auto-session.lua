return {
  'rmagatti/auto-session',
  lazy = false,

  ---enables autocomplete for opts
  ---@module "auto-session"
  ---@type AutoSession.Config
  opts = {
    enabled = true,
    suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
    root_dir = '~/code/.dotfiles/nvim/.sessions/',
    -- log_level = 'debug',
  },
}
