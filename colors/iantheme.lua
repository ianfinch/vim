--
-- Define colours for my theme
--
-- Create them all as data structures, then process them all in one go at the end
--

local vim_ui = {
    ColorColumn = { bg = "#800000" },
    Conceal = { bg = "#6c6c6c", fg = "#c0c0c0" },
    Cursor = { bg = "#ffffff", fg = "#000000" },
    CursorColumn = { bg = "#6c6c6c" },
    CursorLine = { bg = "#272727" },
    CursorLineNr = { bg = "#474747" },
    Ignore = { fg = "#000000" },
    IncSearch = { bg = "#000000", fg = "#ffffff" },
    LineNr = { bg = "#405060", fg = "#ffffff" },
    MatchParen = { bg = "#0000d7" },
    ModeMsg = { fg = "#ffffff" },
    MoreMsg = { fg = "#00ff00" },
    NonText = { fg = "#808080" },
    Pmenu = { bg = "#0000d7", fg = "#ffffff" },
    PmenuSbar = { bg = "#a8a8a8" },
    PmenuSel = { bg = "#8787ff", fg = "#ffffff" },
    PmenuThumb = { bg = "#ffffff" },
    Search = { bg = "#262626" },
    SignColumn = { link = "LineNr" },
    SpecialKey = { fg = "#808080" },
    Title = { },
    ToolbarButton = { bg = "#c0c0c0", fg = "#000000" },
    ToolbarLine = { bg = "#6c6c6c" },
    Underlined = { fg = "#5fd7ff" },
    VertSplit = { fg = "#ffffff" },
    Visual = { bg = "#626262" },
    VisualNOS = { bg = "#262626" },
    Directory = { link = "Identifier" },
    EndOfBuffer = { link = "NonText" },
    Question = { link = "MoreMsg" },
    QuickFixLine = { link = "Search" }
}

local general_syntax = {
    Comment = { fg = "#ff5fff" }
}

local constants = {
    Constant = { fg = "#008787" },
    Boolean = { link = "Constant" },
    Character = { link = "Constant" },
    Number = { link = "Constant" },
    Float = { link = "Number" },
    String = { link = "Constant" },
    Regexp = { link = "Constant" }
}

local diffs = {
    DiffAdd = { bg = "#ccff99", fg = "#000000" },
    DiffChange = { link = "DiffAdd" },
    DiffDelete = { bg = "#ffcccc", fg = "#000000" },
    DiffText = { fg = "#ff0000" },
    diffAdded = { link = "String" },
    diffLine = { link = "PreProc" },
    diffRemoved = { link = "Statement" },
    diffSubname = { link = "Comment" }
}

local git = {
    GitSignsAddInline = { fg = "#009900" },
    GitSignsChangeInline = { link = "GitSignsAddInline" },
    GitSignsDeleteInline = { fg = "#ff0000" },
    GitSignsAdd = { link = "DiffAdd" },
    GitSignsChange = { link = "DiffChange" },
    GitSignsDelete = { link = "DiffDelete" }
}

local folding = {
    Folded = { bg = "#000087", fg = "#d7ffff" },
    FoldColumn = { link = "Folded" }
}

local identifiers = {
    Identifier = { fg = "#ffd700" },
    Function = { link = "Identifier" }
}

local text_colours = {
    ErrorMsg = { bg = "#800000" },
    Error = { bg = "#800000", fg = "#ffffff" },
    Normal = { bg = "#000000", fg = "#dadada" },
    NormalNC = { bg = "#000000", fg = "#dadada" },
    NormalFloat = { bg = "#073642", fg = "#dadada" },
    FloatTitle = { link = "NormalFloat" },
    Todo = { bg = "#ffff00", fg = "#000000" },
    WarningMsg = { fg = "#ff0000" }
}

local pre_processors = {
    PreProc = { fg = "#87ffff" },
    Include = { link = "PreProc" },
    Define = { link = "PreProc" },
    Macro = { link = "PreProc" },
    PreCondit = { link = "PreProc" }
}

local special_characters = {
    Special = { fg = "#00d700" },
    Tag = { link = "Special" },
    SpecialChar = { link = "Special" },
    Delimiter = { link = "Special" },
    SpecialComment = { link = "Special" },
    Debug = { link = "Special" }
}

local spellcheck = {
    SpellBad = { bg = "#800000" },
    SpellCap = { bg = "#000080" },
    SpellLocal = { bg = "#008080" },
    SpellRare = { bg = "#800080" }
}

local statements = {
    Statement = { fg = "#ff8700" },
    Conditional = { link = "Statement" },
    Repeat = { link = "Statement" },
    Label = { link = "Statement" },
    Operator = { link = "Statement" },
    Keyword = { link = "Statement" },
    Exception = { link = "Statement" }
}

local status_line = {
    StatusLineNC = { bg = "#a8a8a8", fg = "#000000" },
    StatusLineTermNC = { bg = "#87ffaf", fg = "#000000" },
    StatusLineTerm = { bg = "#87ffaf", fg = "#000000" },
    StatusLine = { bg = "#5f005f", fg = "#ffffff" }
}

local tab_bar = {
    TabLineFill = { bg = "#5f005f", fg = "#ffffff" },
    TabLineSel = { bg = "#5f00af", fg = "#ffffff" },
    TabLine = { fg = "#ffffff" }
}

local types = {
    Type = { fg = "#d7d787" },
    StorageClass = { link = "Type" },
    Structure = { link = "Type" },
    Typedef = { link = "Type" }
}

-- Gather all the colour sets together, ready for processing
local colours = {
    colours = colours,
    constants = constants,
    diffs = diffs,
    folding = folding,
    general_syntax = general_syntax,
    git = git,
    identifiers = identifiers,
    pre_processors = pre_processors,
    special_characters = special_characters,
    spellcheck = spellcheck,
    statements = statements,
    status_line = status_line,
    tab_bar = tab_bar,
    text_colours = text_colours,
    types = types,
    vim_ui = vim_ui
}

-- Go through all our highlight groups, processing their tables
for group, highlights in pairs(colours) do

    -- Get each name and definition and call the vim highlight function
    for name, val in pairs(highlights) do

        vim.api.nvim_set_hl(0, name, val)
--        vim.api.nvim_set_hl(0, name, { fg = "#999999", bg = "#000000" })
    end
end

-- Set the name of our colour scheme
vim.g.colors_name = "iantheme"
