-- Environment scripts run on startup.

--Check if current terminal session is being run through SSH.
-- vim.g.SSH_ACTIVE = os.execute("bash /home/kubuntu-main/.config/nvim/ssh_check.sh")
-- vim.g.SSH_ACTIVE = vim.cmd("bash /home/kubuntu-main/.config/nvim/ssh_check.sh")
-- vim.g.SSH_ACTIVE = :echo system(['ls', expand('%:h')])

-- vim.g.SSH_ACTIVE = vim.api.nvim_command("echo system(['ls', expand('%:h')])")
-- vim.api.nvim_command(m[i]) end

-- vim.g.SSH_ACTIVE = vim.fn.getenv('SSH_CLIENT')


-- vim.g.SSH_ACTIVE = vim.api.nvim_call_function('system', 'ls')

-- vim.g.ssh = io.popen("/home/kubuntu-main/.config/nvim/ssh_check.sh")
-- vim.g.ssh_output = vim.g.ssh:read("*all")
-- vim.g.ssh:close()

-- vim.cmd(':silent !./home/kubuntu-main/.config/nvim/ssh_check.sh > /tmp/vim_process')
-- vim.cmd(':.!/home/kubuntu-main/.config/nvim/ssh_check.sh')






---------------------------------------------------------------------------------------------------------------------------------------------
--Global vim settings
require("user.global_options")
--Key bindings (note: key bindings within plugins are contained in their respective files.
require("user.keymap")
--Navigation-related settings.
require("user.navigation")
--Activates lua line.
require("user.visual_settings")


-- TODO: get this working
-- vscode-reascript-extension
-- https://github.com/neoclide/coc.nvim/issues/3023
-- https://samroeca.com/coc-plugin.html
