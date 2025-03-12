--[[

# Link

## Defaults

Cursor        <- CursorIM*

SignColumn    <- FoldColumn         <- CursorLineFold
              <- CursorLineSign

NonText       <- EndOfBuffer*
              <- Whitespace*
              <- LspCodeLens        <- LspCodeLensSeparator
              <- LspInlayHint

NormalFloat   <- FloatBorder
Title         <- FloatTitle         <- FloatFooter
              <- @markup.heading
CurSearch     <- IncSearch*

LineNr        <- LineNrAbove
              <- LineNrBelow

StatusLine    <- MsgSeparator*
              <- StatusLineTerm

StatusLineN   <- StatusLineTermNC
              <- TabLine*            <- TabLineFill*

Pmenu         <- PmenuExtra
              <- PmenuKind
              <- PmenuSbar*

PmenuSel      <- PmenuExtraSel
              <- PmenuKindSel
              <- WildMenu

Search        <- Substitute

Visual        <- VisualNOS
              <- LspReferenceText            <- LspReferenceRead
              <-                             <- LspReferenceTarget
              <-                             <- LspReferenceWrite
              <- LspSignatureActiveParameter
              <- SnippetTabstop 


Normal         <- WinSeparator      <- VertSplit*

## Syntax

Comment                     <- @comment
                            <- DiagnosticUnnecessary
Constant                    <- @constant
                            <- Boolean       <- @boolean
                            <- Character     <- @character
                            <- Number        <- @number          <- Float  <- @number.float
Delimiter                   <- @punctuation
Function                    <- @function
Identifier                  <- @property
Normal                      <- Ignore
Operator                    <- @operator
PreProc                     <- Define*
                            <- Include*
                            <- Macro*        <- @attribute
                            <- PreCondit
Special                     <-               <-                  <- @string.regexp
                            <-               <- @string.special  <- @string.escape
                            <- @attribute.builtin
                            <- @constant.builtin
                            <- @constructor
                            <- @function.builtin
                            <- @markup
                            <- @module.builtin
                            <- @punctuation.special
                            <- @tag.builtin
                            <- @type.builtin
                            <- @variable.builtin
                            <- @variable.parameter.builtin
                            <- Debug*
                            <- SpecialChar*  <- @character.special
                            <- SpecialComment
                            <- Tag*          <- @tag
Statement                   <- Conditional*
                            <- Exception
                            <- Keyword*      <- @keyword
                            <- Label*        <- @label
                            <- Repeat*
String                      <- @string
Todo                        <- @comment.todo
Type                        <- @type
                            <- StorageClass
                            <- Structure*    <- @module
                            <- Typedef
Underlined                  <- @markup.link
                            <- @string.special.url

## Diff

Changed           <- @diff.delta
Removed           <- @diff.minus
Added             <- @diff.plus

## Diagnostic

DiagnosticError <- DiagnosticFloatingError*
                <- DiagnosticSignError*
                <- DiagnosticVirtualLinesError
                <- DiagnosticVirtualTextError
                <- @comment.error
DiagnosticInfo  <- DiagnosticFloatingInfo*
                <- DiagnosticSignInfo*
                <- DiagnosticVirtualLinesInfo
                <- DiagnosticVirtualTextInfo
                <- @comment.note
DiagnosticWarn  <- DiagnosticFloatingWarn*
                <- DiagnosticSignWarn*
                <- DiagnosticVirtualLinesWarn
                <- DiagnosticVirtualTextWarn
                <- @comment.warning
DiagnosticHint  <- DiagnosticFloatingHint*
                <- DiagnosticSignHint*
                <- DiagnosticVirtualLinesHint
                <- DiagnosticVirtualTextHint
DiagnosticOk    <- DiagnosticFloatingOk*
                <- DiagnosticSignOk*
                <- DiagnosticVirtualLinesOk
                <- DiagnosticVirtualTextOk

--]]
--
--[[

# Cleared

ComplMatchIns
MsgArea
NormalNC*
VisualNC

@diff

--]]
--
--[[

# Treesitter (`:h treesitter-highlight-groups`)

@variable                       various variable names
@variable.builtin               built-in variable names (e.g. `this`, `self`)
@variable.parameter             parameters of a function
@variable.parameter.builtin     special parameters (e.g. `_`, `it`)
@variable.member                object and struct fields

@constant               constant identifiers
@constant.builtin       built-in constant values
@constant.macro         constants defined by the preprocessor

@module                 modules or namespaces
@module.builtin         built-in modules or namespaces
@label                  `GOTO` and other labels (e.g. `label:` in C), including heredoc labels

@string                 string literals
@string.documentation   string documenting code (e.g. Python docstrings)
@string.regexp          regular expressions
@string.escape          escape sequences
@string.special         other special strings (e.g. dates)
@string.special.symbol  symbols or atoms
@string.special.path    filenames
@string.special.url     URIs (e.g. hyperlinks)

@character              character literals
@character.special      special characters (e.g. wildcards)

@boolean                boolean literals
@number                 numeric literals
@number.float           floating-point number literals

@type                   type or class definitions and annotations
@type.builtin           built-in types
@type.definition        identifiers in type definitions (e.g. `typedef <type> <identifier>` in C)

@attribute              attribute annotations (e.g. Python decorators, Rust lifetimes)
@attribute.builtin      builtin annotations (e.g. `@property` in Python)
@property               the key in key/value pairs

@function               function definitions
@function.builtin       built-in functions
@function.call          function calls
@function.macro         preprocessor macros

@function.method        method definitions
@function.method.call   method calls

@constructor            constructor calls and definitions
@operator               symbolic operators (e.g. `+`, `*`)

@keyword                keywords not fitting into specific categories
@keyword.coroutine      keywords related to coroutines (e.g. `go` in Go, `async/await` in Python)
@keyword.function       keywords that define a function (e.g. `func` in Go, `def` in Python)
@keyword.operator       operators that are English words (e.g. `and`, `or`)
@keyword.import         keywords for including or exporting modules (e.g. `import`, `from` in Python)
@keyword.type           keywords describing namespaces and composite types (e.g. `struct`, `enum`)
@keyword.modifier       keywords modifying other constructs (e.g. `const`, `static`, `public`)
@keyword.repeat         keywords related to loops (e.g. `for`, `while`)
@keyword.return         keywords like `return` and `yield`
@keyword.debug          keywords related to debugging
@keyword.exception      keywords related to exceptions (e.g. `throw`, `catch`)

@keyword.conditional         keywords related to conditionals (e.g. `if`, `else`)
@keyword.conditional.ternary ternary operator (e.g. `?`, `:`)

@keyword.directive           various preprocessor directives and shebangs
@keyword.directive.define    preprocessor definition directives

@punctuation.delimiter  delimiters (e.g. `;`, `.`, `,`)
@punctuation.bracket    brackets (e.g. `()`, `{}`, `[]`)
@punctuation.special    special symbols (e.g. `{}` in string interpolation)

@comment                line and block comments
@comment.documentation  comments documenting code

@comment.error          error-type comments (e.g. `ERROR`, `FIXME`, `DEPRECATED`)
@comment.warning        warning-type comments (e.g. `WARNING`, `FIX`, `HACK`)
@comment.todo           todo-type comments (e.g. `TODO`, `WIP`)
@comment.note           note-type comments (e.g. `NOTE`, `INFO`, `XXX`)

@markup.strong          bold text
@markup.italic          italic text
@markup.strikethrough   struck-through text
@markup.underline       underlined text (only for literal underline markup!)

@markup.heading         headings, titles (including markers)
@markup.heading.1       top-level heading
@markup.heading.2       section heading
@markup.heading.3       subsection heading
@markup.heading.4       and so on
@markup.heading.5       and so forth
@markup.heading.6       six levels ought to be enough for anybody

@markup.quote           block quotes
@markup.math            math environments (e.g. `$ ... $` in LaTeX)

@markup.link            text references, footnotes, citations, etc.
@markup.link.label      link, reference descriptions
@markup.link.url        URL-style links

@markup.raw             literal or verbatim text (e.g. inline code)
@markup.raw.block       literal or verbatim text as a stand-alone block

@markup.list            list markers
@markup.list.checked    checked todo-style list markers
@markup.list.unchecked  unchecked todo-style list markers

@diff.plus              added text (for diff files)
@diff.minus             deleted text (for diff files)
@diff.delta             changed text (for diff files)

@tag                    XML-style tag names (e.g. in XML, HTML, etc.)
@tag.builtin            builtin tag names (e.g. HTML5 tags)
@tag.attribute          XML-style tag attributes
@tag.delimiter          XML-style tag delimiters


--]]

local P = require("primer.palette")

local H = {}

-- Builtin highlighting groups.
H.ColorColumn = { fg = nil, bg = P.black2, attr = nil, sp = nil }
H.Conceal = { fg = nil, bg = nil, attr = nil, sp = nil }
H.CurSearch = { fg = P.base01, bg = P.base09, attr = nil, sp = nil }
H.Cursor = { fg = P.base00, bg = P.base05, attr = nil, sp = nil }
H.CursorColumn = { fg = nil, bg = P.base01, attr = nil, sp = nil }
H.CursorLine = { fg = nil, bg = P.black2, attr = nil, sp = nil }
H.CursorLineNr = { fg = P.white, bg = nil, attr = nil, sp = nil }
H.Directory = { fg = P.base0D, bg = nil, attr = nil, sp = nil }
H.ErrorMsg = { fg = P.base08, bg = P.base00, attr = nil, sp = nil }
H.Folded = { fg = P.light_grey, bg = P.black2, attr = nil, sp = nil }
H.LineNr = { fg = P.grey, bg = nil, attr = nil, sp = nil }
H.MatchParen = { link = "MatchWord" }
H.ModeMsg = { fg = P.base0B, bg = nil, attr = nil, sp = nil }
H.MoreMsg = { fg = P.base0B, bg = nil, attr = nil, sp = nil }
H.NonText = { fg = P.base03, bg = nil, attr = nil, sp = nil }
H.Normal = { fg = P.base05, bg = P.base00, attr = nil, sp = nil }
H.WinSeparator = { fg = P.line, bg = nil, attr = nil, sp = nil } -- Normal
H.NormalFloat = { fg = nil, bg = P.darker_black, attr = nil, sp = nil }
H.FloatBorder = { fg = P.blue, bg = nil, attr = nil, sp = nil } -- NormalFloat
H.Pmenu = { fg = nil, bg = P.one_bg, attr = nil, sp = nil }
H.PmenuMatch = { fg = P.base05, bg = P.base01, attr = "bold", sp = nil }
H.PmenuMatchSel = { fg = P.base05, bg = P.base01, attr = "bold,       reverse", sp = nil }
H.PmenuSel = { fg = P.black, bg = P.pmenu_bg, attr = nil, sp = nil }
H.WildMenu = { fg = P.base08, bg = P.base0A, attr = nil, sp = nil } -- PmenuSel
H.PmenuThumb = { fg = nil, bg = P.grey, attr = nil, sp = nil }
H.Question = { fg = P.base0D, bg = nil, attr = nil, sp = nil }
H.QuickFixLine = { fg = nil, bg = P.base01, attr = nil, sp = nil }
H.Search = { fg = P.base01, bg = P.base0A, attr = nil, sp = nil }
H.Substitute = { fg = P.base01, bg = P.base0A, attr = nil, sp = nil } -- Search
H.SignColumn = { fg = P.base03, bg = nil, attr = nil, sp = nil }
H.FoldColumn = { fg = nil, bg = nil, attr = nil, sp = nil } -- SignColumn
H.SpecialKey = { fg = P.base03, bg = nil, attr = nil, sp = nil }
H.SpellRare = { fg = nil, bg = nil, attr = "undercurl", sp = P.base0E }
H.SpellLocal = { fg = nil, bg = nil, attr = "undercurl", sp = P.base0C }
H.SpellCap = { fg = nil, bg = nil, attr = "undercurl", sp = P.base0D }
H.SpellBad = { fg = nil, bg = nil, attr = "undercurl", sp = P.base08 }
H.StatusLine = { fg = P.base04, bg = P.base02, attr = nil, sp = nil }
H.StatusLineNC = { fg = P.base03, bg = P.base01, attr = nil, sp = nil }
H.TabLineSel = { fg = P.base0B, bg = P.base01, attr = nil, sp = nil }
H.TermCursor = { fg = nil, bg = nil, attr = "reverse", sp = nil }
H.Title = { fg = P.base0D, bg = nil, attr = nil, sp = nil }
H.FloatTitle = { fg = P.white, bg = P.grey, attr = nil, sp = nil } -- Title
H.Visual = { fg = nil, bg = P.base02, attr = nil, sp = nil }
H.VisualNOS = { fg = P.base08, bg = nil, attr = nil, sp = nil } -- Visual
H.WarningMsg = { fg = P.base08, bg = nil, attr = nil, sp = nil }
H.WinBar = { fg = nil, bg = nil, attr = nil, sp = nil }
H.WinBarNC = { fg = nil, bg = nil, attr = nil, sp = nil }

-- Standard syntax (affects treesitter)
H.Comment = { fg = P.base03, bg = nil, attr = nil, sp = nil } -- was fg=light_grey
H.Constant = { fg = P.base09, bg = nil, attr = nil, sp = nil }
H.Boolean = { fg = P.base09, bg = nil, attr = nil, sp = nil } -- Constant
H.Character = { fg = P.base08, bg = nil, attr = nil, sp = nil } -- Constant
H.Number = { fg = P.base09, bg = nil, attr = nil, sp = nil } -- Constant
H.Float = { fg = P.base09, bg = nil, attr = nil, sp = nil } -- Constant
H.Delimiter = { fg = P.base0F, bg = nil, attr = nil, sp = nil }
H.Error = { fg = P.base00, bg = P.base08, attr = nil, sp = nil }
H.Function = { fg = P.base0D, bg = nil, attr = nil, sp = nil }
H.Identifier = { fg = P.base08, bg = nil, attr = nil, sp = nil }
H.Operator = { fg = P.base05, bg = nil, attr = nil, sp = nil }
H.PreProc = { fg = P.base0A, bg = nil, attr = nil, sp = nil }
H.Define = { fg = P.base0E, bg = nil, attr = nil, sp = nil } -- PreProc
H.Include = { fg = P.base0D, bg = nil, attr = nil, sp = nil } -- PreProc
H.Macro = { fg = P.base08, bg = nil, attr = nil, sp = nil } -- PreProc
H.PreCondit = { fg = P.base0A, bg = nil, attr = nil, sp = nil } -- PreProc
H.Special = { fg = P.base0C, bg = nil, attr = nil, sp = nil }
H.Debug = { fg = P.base08, bg = nil, attr = nil, sp = nil } -- Special
H.SpecialChar = { fg = P.base0F, bg = nil, attr = nil, sp = nil } -- Special
H.SpecialComment = { fg = P.base0C, bg = nil, attr = nil, sp = nil } -- Special
H.Tag = { fg = P.base0A, bg = nil, attr = nil, sp = nil } -- Special
H.Statement = { fg = P.base08, bg = nil, attr = nil, sp = nil }
H.Conditional = { fg = P.base0E, bg = nil, attr = nil, sp = nil } -- Statement
H.Exception = { fg = P.base08, bg = nil, attr = nil, sp = nil } -- Statement
H.Keyword = { fg = P.base0E, bg = nil, attr = nil, sp = nil } -- Statement
H.Label = { fg = P.base0A, bg = nil, attr = nil, sp = nil } -- Statement
H.Repeat = { fg = P.base0A, bg = nil, attr = nil, sp = nil } -- Statement
H.String = { fg = P.base0B, bg = nil, attr = nil, sp = nil }
H.Todo = { fg = P.base0A, bg = P.base01, attr = nil, sp = nil }
H.Type = { fg = P.base0A, bg = nil, attr = nil, sp = nil }
H.StorageClass = { fg = P.base0A, bg = nil, attr = nil, sp = nil } -- Type
H.Structure = { fg = P.base0E, bg = nil, attr = nil, sp = nil } -- Type
H.Typedef = { fg = P.base0A, bg = nil, attr = nil, sp = nil } -- Type
H.Variable = { fg = P.base05, bg = nil, attr = nil, sp = nil }
H.Ignore = { fg = P.base0C, bg = nil, attr = nil, sp = nil }

-- Diff
H.Added = { fg = P.green, bg = nil, attr = nil, sp = nil } -- was fg=base0B
H.Changed = { fg = P.yellow, bg = nil, attr = nil, sp = nil } -- was fg=base0E
H.Removed = { fg = P.red, bg = nil, attr = nil, sp = nil } -- was fg=base08
H.DiffAdd = { fg = P.green, bg = H.blend(P.green, P.black, 90), attr = nil, sp = nil }
H.DiffChange = { fg = P.light_grey, bg = H.blend(P.light_grey, P.black, 90), attr = nil, sp = nil } -- was fg=base0E bg=base01
H.DiffDelete = { fg = P.red, bg = H.blend(P.red, P.black, 90), attr = nil, sp = nil } -- was fg=base08 bg=base01
H.DiffText = { fg = P.white, bg = P.black2, attr = nil, sp = nil } -- was fg=base0D bg=base01

-- Built-in diagnostic
H.DiagnosticError = { fg = P.red, bg = nil, attr = nil, sp = nil } -- was fg=base08
H.DiagnosticHint = { fg = P.purple, bg = nil, attr = nil, sp = nil } -- was fg=base0D
H.DiagnosticInfo = { fg = P.green, bg = nil, attr = nil, sp = nil } -- was fg=base0C
H.DiagnosticOk = { fg = P.green, bg = nil, attr = nil, sp = nil } -- was fg=base0B
H.DiagnosticWarn = { fg = P.yellow, bg = nil, attr = nil, sp = nil } -- was fg=base0E

H.DiagnosticFloatingError = { fg = P.base08, bg = P.black2, attr = nil, sp = nil } -- was fg=base08 bg=base01
H.DiagnosticFloatingHint = { fg = P.base0D, bg = P.black2, attr = nil, sp = nil } -- was fg=base0D bg=base01
H.DiagnosticFloatingInfo = { fg = P.base0C, bg = P.black2, attr = nil, sp = nil } -- was fg=base0C bg=base01
H.DiagnosticFloatingOk = { fg = P.base0B, bg = P.black2, attr = nil, sp = nil } -- was fg=base0B bg=base01
H.DiagnosticFloatingWarn = { fg = P.base0E, bg = P.black2, attr = nil, sp = nil } -- was fg=base0E bg=base01

H.DiagnosticSignError = { link = "DiagnosticFloatingError" }
H.DiagnosticSignHint = { link = "DiagnosticFloatingHint" }
H.DiagnosticSignInfo = { link = "DiagnosticFloatingInfo" }
H.DiagnosticSignOk = { link = "DiagnosticFloatingOk" }
H.DiagnosticSignWarn = { link = "DiagnosticFloatingWarn" }

H.DiagnosticUnderlineError = { fg = nil, bg = nil, attr = "underline", sp = P.base08 }
H.DiagnosticUnderlineHint = { fg = nil, bg = nil, attr = "underline", sp = P.base0D }
H.DiagnosticUnderlineInfo = { fg = nil, bg = nil, attr = "underline", sp = P.base0C }
H.DiagnosticUnderlineOk = { fg = nil, bg = nil, attr = "underline", sp = P.base0B }
H.DiagnosticUnderlineWarn = { fg = nil, bg = nil, attr = "underline", sp = P.base0E }

-- TODO:
--
-- FloatShadow        xxx ctermbg=0 guibg=NvimDarkGrey4 blend=80
-- FloatShadowThrough xxx ctermbg=0 guibg=NvimDarkGrey4 blend=100
--
-- RedrawDebugNormal    xxx cterm=reverse gui=reverse
-- RedrawDebugClear     xxx ctermfg=0 ctermbg=11 guibg=NvimDarkYellow
-- RedrawDebugComposed  xxx ctermfg=0 ctermbg=10 guibg=NvimDarkGreen
-- RedrawDebugRecompose xxx ctermfg=0 ctermbg=9 guibg=NvimDarkRed
--
-- NvimInternalError xxx ctermfg=9 ctermbg=9 guifg=Red guibg=Red
--
-- hi('@variable',       {fg=p.base05, bg=nil, attr=nil, sp=nil})
--
-- hi('@text.strong',    {fg=nil, bg=nil, attr='bold',          sp=nil})
-- hi('@text.emphasis',  {fg=nil, bg=nil, attr='italic',        sp=nil})
-- hi('@text.strike',    {fg=nil, bg=nil, attr='strikethrough', sp=nil})
-- hi('@text.underline', {link='Underlined'})
--
-- -- Semantic tokens
-- if vim.fn.has('nvim-0.9') == 1 then
-- -- Source: `:h lsp-semantic-highlight`
-- -- Included only those differing from default links
-- hi('@lsp.type.variable',      {fg=p.base05, bg=nil, attr=nil, sp=nil})
--
-- hi('@lsp.mod.deprecated',     {fg=p.base08, bg=nil, attr=nil, sp=nil})
-- end
--
-- -- New tree-sitter groups
-- if vim.fn.has('nvim-0.10') == 1 then
-- -- Source: `:h treesitter-highlight-groups`
-- -- Included only those differing from default links
-- hi('@markup.strong',        {link='@text.strong'})
-- hi('@markup.italic',        {link='@text.emphasis'})
-- hi('@markup.strikethrough', {link='@text.strike'})
-- hi('@markup.underline',     {link='@text.underline'})
--
-- hi('@markup.heading.1', {link='markdownH1'})
-- hi('@markup.heading.2', {link='markdownH2'})
-- hi('@markup.heading.3', {link='markdownH3'})
-- hi('@markup.heading.4', {link='markdownH4'})
-- hi('@markup.heading.5', {link='markdownH5'})
-- hi('@markup.heading.6', {link='markdownH6'})
--
-- hi('@string.special.vimdoc',     {link='SpecialChar'})
-- hi('@variable.parameter.vimdoc', {fg=p.base09, bg=nil, attr=nil, sp=nil})
