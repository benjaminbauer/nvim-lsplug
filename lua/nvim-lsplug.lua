local lsp_installer = require("nvim-lsp-installer")
local lsp_installer_servers = require "nvim-lsp-installer.servers"

local M = {}
local configured_servers = {}
local explicit_setup_options = {}

function M.add(servername, setup_options)
  local ok, _ = lsp_installer.get_server(servername)

  if not ok then
    error(servername .. " is not supported by lsp-installer")
  end

  table.insert(configured_servers, servername)

  if setup_options then
    explicit_setup_options[servername] = setup_options
  end
end

function M.install()
  local all_installed = true
  for _, name in pairs(configured_servers) do
    local _, server = lsp_installer.get_server(name)

    if not server:is_installed() then
      all_installed = false
      server:install()
    end
  end

  if not all_installed then
    lsp_installer.info_window.open()
  else
    print("all configured servers already installed")
  end
end

local function diffServers()
  local installed_servers = lsp_installer_servers.get_installed_server_names()
  local dirty_servers = {}

  -- if an item is in installed_servers but no in configured_servers, then remove it
  for _, iserver in pairs(installed_servers) do
    local iserver_configured = false

    for _, cserver in pairs(configured_servers) do
      if iserver == cserver then
        iserver_configured = true
      end
    end

    if not iserver_configured then
      table.insert(dirty_servers, iserver)
    end
  end

  return dirty_servers
end

local function uninstall_servers(servernames)
  for _, server in pairs(servernames) do
    lsp_installer.uninstall(server)
  end
end

function M.clean()
  local dirty_servers = diffServers()

  if not next(dirty_servers) then
    print("Already clean")
    return
  end

  local dservers = table.concat(dirty_servers,", ")

  local choice = vim.fn.confirm(
      string.format("This will uninstall all servers installed but not configured: %s. Continue?", dservers),
      "&Yes\n&No",
      2
    )

  if choice == 1 then
    uninstall_servers(dirty_servers)
  else
    print("aborted")
  end
end

function M.finish()
  -- Register a handler that will be called for all installed servers.
  -- Alternatively, you may also register handlers on specific server instances instead (see example below).
  lsp_installer.on_server_ready(function(server)
      local opts = {}

      if explicit_setup_options[server.name] then
        opts = explicit_setup_options[server.name]
      end

      server:setup(opts)
    end)
end

function M.init()
  vim.cmd("command! -bang -nargs=0 LsplugInstall :lua require('nvim-lsplug').install()")
  vim.cmd("command! -bang -nargs=0 LsplugClean :lua require('nvim-lsplug').clean()")
end

return M
