local vim = vim

local hypr_directions = {
  h = "l",
  j = "d",
  k = "u",
  l = "r",
}

local function get_hypr()
  return os.getenv("HYPRLAND_INSTANCE_SIGNATURE")
end

local function execute(arg, pre)
  local command = string.format("%s hyprctl dispatch %s", pre or "", arg)
  local handle = assert(io.popen(command), string.format("unable to execute: [%s]", command))
  local result = handle:read("*a")
  handle:close()
  return result
end

local M = {
  is_hypr = false,
}

function M.setup()
  M.is_hypr = get_hypr() ~= nil

  if not M.is_hypr then
    return false
  end

  return true
end

function M.change_window(direction)
  execute(string.format("movefocus %s", hypr_directions[direction]))
end

return M

