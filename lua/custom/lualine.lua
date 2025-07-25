local colours = {
    white = "#ffffff",
    grey = {
        light = "#a0a0a0",
        mid = "#5f5f5f",
        dark = "#121212"
    },
    purple = {
        dark = "#5f00af",
        light = "#875fd7",
        bright = "#800080"
    },
    blue = {
        dark = "#005fff",
        light = "#00afff",
        bright = "#0000ff"
    },
    orange = {
        dark = "#ff5f00",
        light = "#ffaf00",
        bright = "#875f00"
    },
    red = {
        dark = "#ff0000",
        light = "#ff5f5f",
        bright = "#870000"
    },
    yellow = {
        dark = "#ffff33",
        light = "#ffff66",
        bright = "#ffff99"
    }
}

local iantheme = {
    normal = {
        a = { bg = colours.purple.dark, fg = colours.white, gui = "bold" },
        b = { bg = colours.purple.light, fg = colours.white },
        c = { bg = colours.purple.bright, fg = colours.white }
    },
    insert = {
        a = { bg = colours.blue.dark, fg = colours.white, gui = "bold" },
        b = { bg = colours.blue.light, fg = colours.white },
        c = { bg = colours.blue.bright, fg = colours.white }
    },
    visual = {
        a = { bg = colours.orange.dark, fg = colours.grey.dark, gui = "bold" },
        b = { bg = colours.orange.light, fg = colours.grey.dark },
        c = { bg = colours.orange.bright, fg = colours.white }
    },
    replace = {
        a = { bg = colours.red.dark, fg = colours.white, gui = "bold" },
        b = { bg = colours.red.light, fg = colours.white },
        c = { bg = colours.red.bright, fg = colours.white }
    },
    command = {
        a = { bg = colours.yellow.dark, fg = colours.grey.dark, gui = "bold" },
        b = { bg = colours.yellow.light, fg = colours.grey.dark },
        c = { bg = colours.yellow.bright, fg = colours.grey.dark }
    },
    inactive = {
        a = { bg = colours.grey.mid, fg = colours.grey.light, gui = "bold" },
        b = { bg = colours.grey.mid, fg = colours.grey.light },
        c = { bg = colours.grey.mid, fg = colours.grey.light }
    }
}

require("lualine").setup({
    options = {
        theme = iantheme
    }
})
