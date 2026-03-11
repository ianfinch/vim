--
-- Health check my custom components
--
local M = {}

-- Test whether a dependency is present
local function check_dependency(name, module)

    if pcall(require, module) then
        vim.health.ok(name .. " module is present")
    else
        vim.health.error(name .. " module is missing")
    end
end

-- Test whether an external command is available
local function check_external(cmd)

    if vim.fn.executable(cmd) == 1 then
        vim.health.ok(cmd .. " command is available")
    else
        vim.health.error(cmd .. " command is not installed")
    end
end

-- Need to return a check() function for this to be detected
M.check = function()

    vim.health.start("Checking dependencies")
    check_dependency("Icon", "nvim-web-devicons")
    check_dependency("Popup", "plenary.popup")
    check_dependency("Ian's utils", "custom.utils")
    check_external("rg")
end

return M
