return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      dashboard = {
        example = "github",
          sections = {
            { section = "header" },
            {
              pane = 2,
              section = "terminal",
              cmd = "colorscript -e square",
              height = 5,
              padding = 1,
            },
            { section = "keys", gap = 1, padding = 1 },
            {
              pane = 2,
              icon = " ",
              desc = "Browse Repo",
              padding = 1,
              key = "b",
              action = function()
                Snacks.gitbrowse()
              end,
            },
            function()
              local in_git = Snacks.git.get_root() ~= nil
              local cmds = {
                {
                  title = "Notifications",
                  cmd = "gh notify -s -a -n5",
                  action = function()
                    vim.ui.open("https://github.com/notifications")
                  end,
                  key = "n",
                  icon = " ",
                  height = 5,
                  enabled = true,
                },
                {
                  icon = " ",
                  title = "Open PRs",
                  cmd = "gh pr list -L 5",
                  key = "p",
                  action = function()
                    vim.fn.jobstart("gh pr list --web", { detach = true })
                  end,
                  height = 12,
                },
                {
                  icon = " ",
                  title = "Git Status",
                  cmd = "hub --no-pager diff --stat -B -M -C",
                  height = 10,
                },
              }
              return vim.tbl_map(function(cmd)
                return vim.tbl_extend("force", {
                  pane = 2,
                  section = "terminal",
                  enabled = in_git,
                  padding = 1,
                  ttl = 5 * 60,
                  indent = 3,
                }, cmd)
              end, cmds)
            end,
            { section = "startup" },
          },
      }
    },
  }
}