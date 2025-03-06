require('mini.base16').setup({
  palette = {
    base00 = '#212830', -- Default bg
    base01 = '#2a313c', -- Lighter bg (status bar, line number, folding mks)
    base02 = '#3d444d', -- Selection bg
    base03 = '#656c76', -- Comments, invisibles, line hl
    base04 = '#9198a1', -- Dark fg (status bars)

    base05 = '#b7bdc8', -- Default fg (caret, delimiters, Operators)
    base06 = '#d1d7e0', -- Light fg (not often used)
    base07 = '#f0f6fc', -- Light bg (not often used)

    base08 = '#b083f0', -- Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
    base09 = '#ffbc6f', -- Integers, Boolean, Constants, XML Attributes, Markup Link Url
    base0A = '#eac55f', -- Classes, Markup Bold, Search Text Background
    base0B = '#96d0ff', -- Strings, Inherited Class, Markup Code, Diff Inserted
    base0C = '#6cb6ff', -- Support, regex, escape chars
    base0D = '#539bf5', -- Function, methods, headings
    base0E = '#ff938a', -- Keywords
    base0F = '#8ddb8c', -- Deprecated, open/close embedded tags

    -- base00 = '#24292E', -- Default bg
    -- base01 = '#33383d', -- Lighter bg (status bar, line number, folding mks)
    -- base02 = '#383d42', -- Selection bg
    -- base03 = '#6a6f74', -- Comments, invisibles, line hl
    -- base04 = '#969da4', -- Dark fg (status bars)
    -- base05 = '#c9d1d9', -- Default fg (caret, delimiters, Operators)
    -- base06 = '#d3dbe3', -- Light fg (not often used)
    -- base07 = '#dde5ed', -- Light bg (not often used)
    -- base08 = '#B392E9', -- Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
    -- base09 = '#ffab70', -- Integers, Boolean, Constants, XML Attributes, Markup Link Url
    -- base0A = '#ffdf5d', -- Classes, Markup Bold, Search Text Background
    -- base0B = '#a5d6ff', -- Strings, Inherited Class, Markup Code, Diff Inserted
    -- base0C = '#83caff', -- Support, regex, escape chars
    -- base0D = '#6AB1F0', -- Function, methods, headings
    -- base0E = '#ff7f8d', -- Keywords
    -- base0F = '#85e89d', -- Deprecated, open/close embedded tags
  },
})

vim.g.colors_name = 'github'
