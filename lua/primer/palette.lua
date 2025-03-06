local P = {}

local H = require('primer.helpers')

local function alpha(color, bg, a)
  vim.validate({
    color = { color, H.is_valid_hex, 'valid rbg hex `#rrggbb`' },
    bg = { bg, H.is_valid_hex, 'valid rbg hex `#rrggbb`' },
    alpha = {
      a,
      function(arg) return type(arg) == 'number' and arg >= 0 and arg <= 1 end,
      'valid number between 0 and 1',
    },
  })

  return H.blend(color, bg, 1 - a)
end

P.light = {
  base = {
    color = {
      black = {
        value = function() return '#1f2328' end,
      },
      inset = {
        value = function() return P.light.base.color.neutral['0'] end,
      },
      transparent = {
        value = function(bg) return alpha('#ffffff', bg, 0) end,
      },
      white = {
        value = function() return '#ffffff' end,
      },
      neutral = {
        ['0'] = {
          value = function() return P.light.base.color.white end,
        },
        ['1'] = {
          value = function() return '#F6F8FA' end,
        },
        ['2'] = {
          value = function() return '#EFF2F5' end,
        },
        ['3'] = {
          value = function() return '#E6EAEF' end,
        },
        ['4'] = {
          value = function() return '#E0E6EB' end,
        },
        ['5'] = {
          value = function() return '#DAE0E7' end,
        },
        ['6'] = {
          value = function() return '#D1D9E0' end,
        },
        ['7'] = {
          value = function() return '#C8D1DA' end,
        },
        ['8'] = {
          value = function() return '#818B98' end,
        },
        ['9'] = {
          value = function() return '#59636E' end,
        },
        ['10'] = {
          value = function() return '#454C54' end,
        },
        ['11'] = {
          value = function() return '#393F46' end,
        },
        ['12'] = {
          value = function() return '#25292E' end,
        },
        ['13'] = {
          value = function() return P.light.base.color.black end,
        },
      },
      blue = {
        ['0'] = {
          value = function() return '#ddf4ff' end,
        },
        ['1'] = {
          value = function() return '#b6e3ff' end,
        },
        ['2'] = {
          value = function() return '#80ccff' end,
        },
        ['3'] = {
          value = function() return '#54aeff' end,
        },
        ['4'] = {
          value = function() return '#218bff' end,
        },
        ['5'] = {
          value = function() return '#0969da' end,
        },
        ['6'] = {
          value = function() return '#0550ae' end,
        },
        ['7'] = {
          value = function() return '#033d8b' end,
        },
        ['8'] = {
          value = function() return '#0a3069' end,
        },
        ['9'] = {
          value = function() return '#002155' end,
        },
      },
      green = {
        ['0'] = {
          value = function() return '#dafbe1' end,
        },
        ['1'] = {
          value = function() return '#aceebb' end,
        },
        ['2'] = {
          value = function() return '#6fdd8b' end,
        },
        ['3'] = {
          value = function() return '#4ac26b' end,
        },
        ['4'] = {
          value = function() return '#2da44e' end,
        },
        ['5'] = {
          value = function() return '#1a7f37' end,
        },
        ['6'] = {
          value = function() return '#116329' end,
        },
        ['7'] = {
          value = function() return '#044f1e' end,
        },
        ['8'] = {
          value = function() return '#003d16' end,
        },
        ['9'] = {
          value = function() return '#002d11' end,
        },
      },
      yellow = {
        ['0'] = {
          value = function() return '#fff8c5' end,
        },
        ['1'] = {
          value = function() return '#fae17d' end,
        },
        ['2'] = {
          value = function() return '#eac54f' end,
        },
        ['3'] = {
          value = function() return '#d4a72c' end,
        },
        ['4'] = {
          value = function() return '#bf8700' end,
        },
        ['5'] = {
          value = function() return '#9a6700' end,
        },
        ['6'] = {
          value = function() return '#7d4e00' end,
        },
        ['7'] = {
          value = function() return '#633c01' end,
        },
        ['8'] = {
          value = function() return '#4d2d00' end,
        },
        ['9'] = {
          value = function() return '#3b2300' end,
        },
      },
      orange = {
        ['0'] = {
          value = function() return '#fff1e5' end,
        },
        ['1'] = {
          value = function() return '#ffd8b5' end,
        },
        ['2'] = {
          value = function() return '#ffb77c' end,
        },
        ['3'] = {
          value = function() return '#fb8f44' end,
        },
        ['4'] = {
          value = function() return '#e16f24' end,
        },
        ['5'] = {
          value = function() return '#bc4c00' end,
        },
        ['6'] = {
          value = function() return '#953800' end,
        },
        ['7'] = {
          value = function() return '#762c00' end,
        },
        ['8'] = {
          value = function() return '#5c2200' end,
        },
        ['9'] = {
          value = function() return '#471700' end,
        },
      },
      red = {
        ['0'] = {
          value = function() return '#ffebe9' end,
        },
        ['1'] = {
          value = function() return '#ffcecb' end,
        },
        ['2'] = {
          value = function() return '#ffaba8' end,
        },
        ['3'] = {
          value = function() return '#ff8182' end,
        },
        ['4'] = {
          value = function() return '#fa4549' end,
        },
        ['5'] = {
          value = function() return '#cf222e' end,
        },
        ['6'] = {
          value = function() return '#a40e26' end,
        },
        ['7'] = {
          value = function() return '#82071e' end,
        },
        ['8'] = {
          value = function() return '#660018' end,
        },
        ['9'] = {
          value = function() return '#4c0014' end,
        },
      },
      purple = {
        ['0'] = {
          value = function() return '#fbefff' end,
        },
        ['1'] = {
          value = function() return '#ecd8ff' end,
        },
        ['2'] = {
          value = function() return '#d8b9ff' end,
        },
        ['3'] = {
          value = function() return '#c297ff' end,
        },
        ['4'] = {
          value = function() return '#a475f9' end,
        },
        ['5'] = {
          value = function() return '#8250df' end,
        },
        ['6'] = {
          value = function() return '#6639ba' end,
        },
        ['7'] = {
          value = function() return '#512a97' end,
        },
        ['8'] = {
          value = function() return '#3e1f79' end,
        },
        ['9'] = {
          value = function() return '#2e1461' end,
        },
      },
      pink = {
        ['0'] = {
          value = function() return '#ffeff7' end,
        },
        ['1'] = {
          value = function() return '#ffd3eb' end,
        },
        ['2'] = {
          value = function() return '#ffadda' end,
        },
        ['3'] = {
          value = function() return '#ff80c8' end,
        },
        ['4'] = {
          value = function() return '#e85aad' end,
        },
        ['5'] = {
          value = function() return '#bf3989' end,
        },
        ['6'] = {
          value = function() return '#99286e' end,
        },
        ['7'] = {
          value = function() return '#772057' end,
        },
        ['8'] = {
          value = function() return '#611347' end,
        },
        ['9'] = {
          value = function() return '#4d0336' end,
        },
      },
      coral = {
        ['0'] = {
          value = function() return '#fff0eb' end,
        },
        ['1'] = {
          value = function() return '#ffd6cc' end,
        },
        ['2'] = {
          value = function() return '#ffb4a1' end,
        },
        ['3'] = {
          value = function() return '#fd8c73' end,
        },
        ['4'] = {
          value = function() return '#ec6547' end,
        },
        ['5'] = {
          value = function() return '#c4432b' end,
        },
        ['6'] = {
          value = function() return '#9e2f1c' end,
        },
        ['7'] = {
          value = function() return '#801f0f' end,
        },
        ['8'] = {
          value = function() return '#691105' end,
        },
        ['9'] = {
          value = function() return '#510901' end,
        },
      },
    },
  },
  fgColor = {
    default = {
      value = function() return P.light.base.color.neutral['13'] end,
    },
    muted = {
      value = function() return P.light.base.color.neutral['9'] end,
    },
    onEmphasis = {
      value = function() return P.light.base.color.neutral['0'] end,
    },
    onInverse = {
      value = function() return P.light.base.color.neutral['0'] end,
    },
    white = {
      value = function() return P.light.base.color.neutral['0'] end,
    },
    black = {
      value = function() return P.light.base.color.neutral['13'] end,
    },
    disabled = {
      value = function() return P.light.base.color.neutral['8'] end,
    },
    link = {
      value = function() return P.light.fgColor.accent end,
    },
    neutral = {
      value = function() return P.light.base.color.neutral['9'] end,
    },
    accent = {
      value = function() return P.light.base.color.blue['5'] end,
    },
    success = {
      value = function() return P.light.base.color.green['5'] end,
    },
    open = {
      value = function() return P.light.fgColor.success end,
    },
    attention = {
      value = function() return P.light.base.color.yellow['5'] end,
    },
    severe = {
      value = function() return P.light.base.color.orange['5'] end,
    },
    danger = {
      value = function() return '#d1242f' end,
    },
    closed = {
      value = function() return P.light.fgColor.danger end,
    },
    done = {
      value = function() return P.light.base.color.purple['5'] end,
    },
    upsell = {
      value = function() return P.light.fgColor.done end,
    },
    sponsors = {
      value = function() return P.light.base.color.pink['5'] end,
    },
  },
  bgColor = {
    default = {
      value = function() return P.light.base.color.neutral['0'] end,
    },
    muted = {
      value = function() return P.light.base.color.neutral['1'] end,
    },
    inset = {
      value = function() return P.light.bgColor.muted end,
    },
    emphasis = {
      value = function() return P.light.base.color.neutral['12'] end,
    },
    inverse = {
      value = function() return P.light.base.color.neutral['12'] end,
    },
    white = {
      value = function() return P.light.base.color.neutral['0'] end,
    },
    black = {
      value = function() return P.light.base.color.neutral['13'] end,
    },
    disabled = {
      value = function() return P.light.base.color.neutral['2'] end,
    },
    transparent = {
      value = function() return P.light.base.color.transparent end,
    },
    neutral = {
      muted = {
        value = function() return P.light.base.color.neutral['8'] end,
      },
      emphasis = {
        value = function() return P.light.base.color.neutral['9'] end,
      },
    },
    accent = {
      muted = {
        value = function() return P.light.base.color.blue['0'] end,
      },
      emphasis = {
        value = function() return P.light.base.color.blue['5'] end,
      },
    },
    success = {
      muted = {
        value = function() return P.light.base.color.green['0'] end,
      },
      emphasis = {
        value = function() return '#1f883d' end,
      },
    },
    open = {
      muted = {
        value = function() return P.light.bgColor.success.muted end,
      },
      emphasis = {
        value = function() return P.light.bgColor.success.emphasis end,
      },
    },
    attention = {
      muted = {
        value = function() return P.light.base.color.yellow['0'] end,
      },
      emphasis = {
        value = function() return P.light.base.color.yellow['5'] end,
      },
    },
    severe = {
      muted = {
        value = function() return P.light.base.color.orange['0'] end,
      },
      emphasis = {
        value = function() return P.light.base.color.orange['5'] end,
      },
    },
    danger = {
      muted = {
        value = function() return P.light.base.color.red['0'] end,
      },
      emphasis = {
        value = function() return P.light.base.color.red['5'] end,
      },
    },
    closed = {
      muted = {
        value = function() return P.light.bgColor.danger.muted end,
      },
      emphasis = {
        value = function() return P.light.bgColor.danger.emphasis end,
      },
    },
    done = {
      muted = {
        value = function() return P.light.base.color.purple['0'] end,
      },
      emphasis = {
        value = function() return P.light.base.color.purple['5'] end,
      },
    },
    upsell = {
      muted = {
        value = function() return P.light.bgColor.done.muted end,
      },
      emphasis = {
        value = function() return P.light.bgColor.done.emphasis end,
      },
    },
    sponsors = {
      muted = {
        value = function() return P.light.base.color.pink['0'] end,
      },
      emphasis = {
        value = function() return P.light.base.color.pink['5'] end,
      },
    },
  },
  color = {
    ansi = {
      black = {
        value = function() return P.light.base.color.neutral['13'] end,
      },
      ['black-bright'] = {
        value = function() return P.light.base.color.neutral['11'] end,
      },
      white = {
        value = function() return P.light.base.color.neutral['9'] end,
      },
      ['white-bright'] = {
        value = function() return P.light.base.color.neutral['8'] end,
      },
      gray = {
        value = function() return P.light.base.color.neutral['9'] end,
      },
      red = {
        value = function() return P.light.base.color.red['5'] end,
      },
      ['red-bright'] = {
        value = function() return P.light.base.color.red['6'] end,
      },
      green = {
        value = function() return P.light.base.color.green['6'] end,
      },
      ['green-bright'] = {
        value = function() return P.light.base.color.green['5'] end,
      },
      yellow = {
        value = function() return P.light.base.color.yellow['8'] end,
      },
      ['yellow-bright'] = {
        value = function() return P.light.base.color.yellow['7'] end,
      },
      blue = {
        value = function() return P.light.base.color.blue['5'] end,
      },
      ['blue-bright'] = {
        value = function() return P.light.base.color.blue['4'] end,
      },
      magenta = {
        value = function() return P.light.base.color.purple['5'] end,
      },
      ['magenta-bright'] = {
        value = function() return P.light.base.color.purple['4'] end,
      },
      cyan = {
        value = function() return '#1b7c83' end,
      },
      ['cyan-bright'] = {
        value = function() return '#3192aa' end,
      },
    },
    prettylights = {
      syntax = {
        comment = {
          value = function() return P.light.base.color.neutral['9'] end,
        },
        constant = {
          value = function() return P.light.base.color.blue['6'] end,
        },
        ['constant-other-reference-link'] = {
          value = function() return P.light.base.color.blue['8'] end,
        },
        entity = {
          value = function() return P.light.base.color.purple['6'] end,
        },
        storage = {
          modifier = {
            import = {
              value = function() return P.light.base.color.neutral['13'] end,
            },
          },
        },
        ['entity-tag'] = {
          value = function() return P.light.base.color.blue['6'] end,
        },
        keyword = {
          value = function() return P.light.base.color.red['5'] end,
        },
        string = {
          value = function() return P.light.base.color.blue['8'] end,
        },
        variable = {
          value = function() return P.light.base.color.orange['6'] end,
        },
        brackethighlighter = {
          unmatched = {
            value = function() return P.light.base.color.red['7'] end,
          },
          angle = {
            value = function() return P.light.base.color.neutral['9'] end,
          },
        },
        invalid = {
          illegal = {
            text = {
              value = function() return P.light.base.color.neutral['1'] end,
            },
            bg = {
              value = function() return P.light.base.color.red['7'] end,
            },
          },
        },
        carriage = {
          ['return'] = {
            text = {
              value = function() return P.light.base.color.neutral['1'] end,
            },
            bg = {
              value = function() return P.light.base.color.red['5'] end,
            },
          },
        },
        ['string-regexp'] = {
          value = function() return P.light.base.color.green['6'] end,
        },
        markup = {
          list = {
            value = function() return P.light.base.color.yellow['9'] end,
          },
          heading = {
            value = function() return P.light.base.color.blue['6'] end,
          },
          italic = {
            value = function() return P.light.base.color.neutral['13'] end,
          },
          bold = {
            value = function() return P.light.base.color.neutral['13'] end,
          },
          deleted = {
            text = {
              value = function() return P.light.base.color.red['7'] end,
            },
            bg = {
              value = function() return P.light.base.color.red['0'] end,
            },
          },
          inserted = {
            text = {
              value = function() return P.light.base.color.green['6'] end,
            },
            bg = {
              value = function() return P.light.base.color.green['0'] end,
            },
          },
          changed = {
            text = {
              value = function() return P.light.base.color.orange['6'] end,
            },
            bg = {
              value = function() return P.light.base.color.orange['1'] end,
            },
          },
          ignored = {
            text = {
              value = function() return P.light.base.color.neutral['6'] end,
            },
            bg = {
              value = function() return P.light.base.color.blue['6'] end,
            },
          },
        },
        meta = {
          diff = {
            range = {
              value = function() return P.light.base.color.purple['5'] end,
            },
          },
        },
        sublimelinter = {
          gutter = {
            mark = {
              value = function() return P.light.base.color.neutral['8'] end,
            },
          },
        },
      },
    },
  },
  borderColor = {
    default = {
      value = function() return P.light.base.color.neutral['6'] end,
    },
    muted = {
      value = function(bg) return alpha(P.light.borderColor.default, bg, 0.7) end,
    },
    emphasis = {
      value = function() return P.light.base.color.neutral['8'] end,
    },
    disabled = {
      value = function(bg) return alpha(P.light.base.color.neutral['8'], bg, 0.1) end,
    },
    transparent = {
      value = function() return P.light.base.color.transparent end,
    },
    translucent = {
      value = function(bg) return alpha(P.light.base.color.neutral['13'], 0.15) end,
    },
    neutral = {
      muted = {
        value = function() return P.light.borderColor.muted end,
      },
      emphasis = {
        value = function() return P.light.base.color.neutral['9'] end,
      },
    },
    accent = {
      muted = {
        value = function(bg) return alpha(P.light.base.color.blue['3'], 0.4) end,
      },
      emphasis = {
        value = function() return P.light.base.color.blue['5'] end,
      },
    },
    success = {
      muted = {
        value = function(bg) return alpha(P.light.base.color.green['3'], 0.4) end,
      },
      emphasis = {
        value = function() return P.light.base.color.green['5'] end,
      },
    },
    open = {
      muted = {
        value = function() return P.light.borderColor.success.muted end,
      },
      emphasis = {
        value = function() return P.light.borderColor.success.emphasis end,
      },
    },
    attention = {
      muted = {
        value = function(bg) return alpha(P.light.base.color.yellow['3'], 0.4) end,
      },
      emphasis = {
        value = function() return P.light.base.color.yellow['5'] end,
      },
    },
    severe = {
      muted = {
        value = function(bg) return alpha(P.light.base.color.orange['3'], 0.4) end,
      },
      emphasis = {
        value = function() return P.light.base.color.orange['5'] end,
      },
    },
    danger = {
      muted = {
        value = function(bg) return alpha(P.light.base.color.red['3'], 0.4) end,
      },
      emphasis = {
        value = function() return P.light.base.color.red['5'] end,
      },
    },
    closed = {
      muted = {
        value = function() return P.light.borderColor.danger.muted end,
      },
      emphasis = {
        value = function() return P.light.borderColor.danger.emphasis end,
      },
    },
    done = {
      muted = {
        value = function(bg) return alpha(P.light.base.color.purple['3'], 0.4) end,
      },
      emphasis = {
        value = function() return P.light.base.color.purple['5'] end,
      },
    },
    upsell = {
      muted = {
        value = function() return P.light.borderColor.done.muted end,
      },
      emphasis = {
        value = function() return P.light.borderColor.done.emphasis end,
      },
    },
    sponsors = {
      muted = {
        value = function(bg) return alpha(P.light.base.color.pink['3'], 0.4) end,
      },
      emphasis = {
        value = function() return P.light.base.color.pink['5'] end,
      },
    },
  },
  focus = { outlineColor = {
    value = function() return P.light.borderColor.accent.emphasis end,
  } },
  selection = {
    bgColor = {
      value = function(bg) return alpha(P.light.bgColor.accent.emphasis, 0.2) end,
    },
  },
}

P.dark = {
  base = {
    color = {
      black = {
        value = function() return '#010409' end,
      },
      inset = {
        value = function() return P.dark.base.color.black end,
      },
      white = {
        value = function() return '#ffffff' end,
      },
      transparent = {
        value = function() return '#000000' end,
        alpha = 0,
      },
      neutral = {
        ['0'] = {
          value = function() return P.dark.base.color.black end,
        },
        ['1'] = {
          value = function() return '#0D1117' end,
        },
        ['2'] = {
          value = function() return '#151B23' end,
        },
        ['3'] = {
          value = function() return '#212830' end,
        },
        ['4'] = {
          value = function() return '#262C36' end,
        },
        ['5'] = {
          value = function() return '#2A313C' end,
        },
        ['6'] = {
          value = function() return '#2F3742' end,
        },
        ['7'] = {
          value = function() return '#3D444D' end,
        },
        ['8'] = {
          value = function() return '#656C76' end,
        },
        ['9'] = {
          value = function() return '#9198A1' end,
        },
        ['10'] = {
          value = function() return '#B7BDC8' end,
        },
        ['11'] = {
          value = function() return '#D1D7E0' end,
        },
        ['12'] = {
          value = function() return '#F0F6FC' end,
        },
        ['13'] = {
          value = function() return P.dark.base.color.white end,
        },
      },
      blue = {
        ['0'] = {
          value = function() return '#cae8ff' end,
        },
        ['1'] = {
          value = function() return '#a5d6ff' end,
        },
        ['2'] = {
          value = function() return '#79c0ff' end,
        },
        ['3'] = {
          value = function() return '#58a6ff' end,
        },
        ['4'] = {
          value = function() return '#388bfd' end,
        },
        ['5'] = {
          value = function() return '#1f6feb' end,
        },
        ['6'] = {
          value = function() return '#1158c7' end,
        },
        ['7'] = {
          value = function() return '#0d419d' end,
        },
        ['8'] = {
          value = function() return '#0c2d6b' end,
        },
        ['9'] = {
          value = function() return '#051d4d' end,
        },
      },
      green = {
        ['0'] = {
          value = function() return '#aff5b4' end,
        },
        ['1'] = {
          value = function() return '#7ee787' end,
        },
        ['2'] = {
          value = function() return '#56d364' end,
        },
        ['3'] = {
          value = function() return '#3fb950' end,
        },
        ['4'] = {
          value = function() return '#2ea043' end,
        },
        ['5'] = {
          value = function() return '#238636' end,
        },
        ['6'] = {
          value = function() return '#196c2e' end,
        },
        ['7'] = {
          value = function() return '#0f5323' end,
        },
        ['8'] = {
          value = function() return '#033a16' end,
        },
        ['9'] = {
          value = function() return '#04260f' end,
        },
      },
      yellow = {
        ['0'] = {
          value = function() return '#f8e3a1' end,
        },
        ['1'] = {
          value = function() return '#f2cc60' end,
        },
        ['2'] = {
          value = function() return '#e3b341' end,
        },
        ['3'] = {
          value = function() return '#d29922' end,
        },
        ['4'] = {
          value = function() return '#bb8009' end,
        },
        ['5'] = {
          value = function() return '#9e6a03' end,
        },
        ['6'] = {
          value = function() return '#845306' end,
        },
        ['7'] = {
          value = function() return '#693e00' end,
        },
        ['8'] = {
          value = function() return '#4b2900' end,
        },
        ['9'] = {
          value = function() return '#341a00' end,
        },
      },
      orange = {
        ['0'] = {
          value = function() return '#ffdfb6' end,
        },
        ['1'] = {
          value = function() return '#ffc680' end,
        },
        ['2'] = {
          value = function() return '#ffa657' end,
        },
        ['3'] = {
          value = function() return '#f0883e' end,
        },
        ['4'] = {
          value = function() return '#db6d28' end,
        },
        ['5'] = {
          value = function() return '#bd561d' end,
        },
        ['6'] = {
          value = function() return '#9b4215' end,
        },
        ['7'] = {
          value = function() return '#762d0a' end,
        },
        ['8'] = {
          value = function() return '#5a1e02' end,
        },
        ['9'] = {
          value = function() return '#3d1300' end,
        },
      },
      red = {
        ['0'] = {
          value = function() return '#ffdcd7' end,
        },
        ['1'] = {
          value = function() return '#ffc1ba' end,
        },
        ['2'] = {
          value = function() return '#ffa198' end,
        },
        ['3'] = {
          value = function() return '#ff7b72' end,
        },
        ['4'] = {
          value = function() return '#f85149' end,
        },
        ['5'] = {
          value = function() return '#da3633' end,
        },
        ['6'] = {
          value = function() return '#b62324' end,
        },
        ['7'] = {
          value = function() return '#8e1519' end,
        },
        ['8'] = {
          value = function() return '#67060c' end,
        },
        ['9'] = {
          value = function() return '#490202' end,
        },
      },
      purple = {
        ['0'] = {
          value = function() return '#eddeff' end,
        },
        ['1'] = {
          value = function() return '#e2c5ff' end,
        },
        ['2'] = {
          value = function() return '#d2a8ff' end,
        },
        ['3'] = {
          value = function() return '#BE8FFF' end,
        },
        ['4'] = {
          value = function() return '#AB7DF8' end,
        },
        ['5'] = {
          value = function() return '#8957e5' end,
        },
        ['6'] = {
          value = function() return '#6e40c9' end,
        },
        ['7'] = {
          value = function() return '#553098' end,
        },
        ['8'] = {
          value = function() return '#3c1e70' end,
        },
        ['9'] = {
          value = function() return '#271052' end,
        },
      },
      pink = {
        ['0'] = {
          value = function() return '#ffdaec' end,
        },
        ['1'] = {
          value = function() return '#ffbedd' end,
        },
        ['2'] = {
          value = function() return '#ff9bce' end,
        },
        ['3'] = {
          value = function() return '#f778ba' end,
        },
        ['4'] = {
          value = function() return '#db61a2' end,
        },
        ['5'] = {
          value = function() return '#bf4b8a' end,
        },
        ['6'] = {
          value = function() return '#9e3670' end,
        },
        ['7'] = {
          value = function() return '#7d2457' end,
        },
        ['8'] = {
          value = function() return '#5e103e' end,
        },
        ['9'] = {
          value = function() return '#42062a' end,
        },
      },
      coral = {
        ['0'] = {
          value = function() return '#ffddd2' end,
        },
        ['1'] = {
          value = function() return '#ffc2b2' end,
        },
        ['2'] = {
          value = function() return '#ffa28b' end,
        },
        ['3'] = {
          value = function() return '#f78166' end,
        },
        ['4'] = {
          value = function() return '#ea6045' end,
        },
        ['5'] = {
          value = function() return '#cf462d' end,
        },
        ['6'] = {
          value = function() return '#ac3220' end,
        },
        ['7'] = {
          value = function() return '#872012' end,
        },
        ['8'] = {
          value = function() return '#640d04' end,
        },
        ['9'] = {
          value = function() return '#460701' end,
        },
      },
    },
  },
  fgColor = {
    default = {
      value = function() return P.dark.base.color.neutral['12'] end,
    },
    muted = {
      value = function() return P.dark.base.color.neutral['9'] end,
    },
    onEmphasis = {
      value = function() return P.dark.base.color.neutral['13'] end,
    },
    onInverse = {
      value = function() return P.dark.base.color.neutral['0'] end,
    },
    white = {
      value = function() return P.dark.base.color.neutral['13'] end,
    },
    black = {
      value = function() return P.dark.base.color.neutral['0'] end,
    },
    disabled = {
      value = function() return P.dark.base.color.neutral['8'] end,
      alpha = 0.6,
    },
    link = {
      value = function() return P.dark.fgColor.accent end,
    },
    neutral = {
      value = function() return P.dark.base.color.neutral['9'] end,
    },
    accent = {
      value = function() return '#4493F8' end,
    },
    success = {
      value = function() return P.dark.base.color.green['3'] end,
    },
    open = {
      value = function() return P.dark.fgColor.success end,
    },
    attention = {
      value = function() return P.dark.base.color.yellow['3'] end,
    },
    severe = {
      value = function() return P.dark.base.color.orange['4'] end,
    },
    danger = {
      value = function() return P.dark.base.color.red['4'] end,
    },
    closed = {
      value = function() return P.dark.fgColor.danger end,
    },
    done = {
      value = function() return P.dark.base.color.purple['4'] end,
    },
    upsell = {
      value = function() return P.dark.fgColor.done end,
    },
    sponsors = {
      value = function() return P.dark.base.color.pink['4'] end,
    },
  },
  bgColor = {
    default = {
      value = function() return P.dark.base.color.neutral['1'] end,
    },
    muted = {
      value = function() return P.dark.base.color.neutral['2'] end,
    },
    inset = {
      value = function() return P.dark.base.color.neutral['0'] end,
    },
    emphasis = {
      value = function() return P.dark.base.color.neutral['7'] end,
    },
    inverse = {
      value = function() return P.dark.base.color.neutral['13'] end,
    },
    white = {
      value = function() return P.dark.base.color.neutral['13'] end,
    },
    black = {
      value = function() return P.dark.base.color.neutral['0'] end,
    },
    disabled = {
      value = function() return P.dark.base.color.neutral['3'] end,
    },
    transparent = {
      value = function() return P.dark.base.color.transparent end,
    },
    neutral = {
      muted = {
        value = function() return P.dark.base.color.neutral['8'] end,
        alpha = 0.2,
      },
      emphasis = {
        value = function() return P.dark.base.color.neutral['8'] end,
      },
    },
    accent = {
      muted = {
        value = function() return P.dark.base.color.blue['4'] end,
        alpha = 0.1,
      },
      emphasis = {
        value = function() return P.dark.base.color.blue['5'] end,
      },
    },
    success = {
      muted = {
        value = function() return P.dark.base.color.green['4'] end,
        alpha = 0.15,
      },
      emphasis = {
        value = function() return P.dark.base.color.green['5'] end,
      },
    },
    open = {
      muted = {
        value = function() return P.dark.bgColor.success.muted end,
      },
      emphasis = {
        value = function() return P.dark.bgColor.success.emphasis end,
      },
    },
    attention = {
      muted = {
        value = function() return P.dark.base.color.yellow['4'] end,
        alpha = 0.15,
      },
      emphasis = {
        value = function() return P.dark.base.color.yellow['5'] end,
      },
    },
    severe = {
      muted = {
        value = function() return P.dark.base.color.orange['4'] end,
        alpha = 0.1,
      },
      emphasis = {
        value = function() return P.dark.base.color.orange['5'] end,
      },
    },
    danger = {
      muted = {
        value = function() return P.dark.base.color.red['4'] end,
        alpha = 0.1,
      },
      emphasis = {
        value = function() return P.dark.base.color.red['5'] end,
      },
    },
    closed = {
      muted = {
        value = function() return P.dark.bgColor.danger.muted end,
      },
      emphasis = {
        value = function() return P.dark.bgColor.danger.emphasis end,
      },
    },
    done = {
      muted = {
        value = function() return P.dark.base.color.purple['4'] end,
        alpha = 0.15,
      },
      emphasis = {
        value = function() return P.dark.base.color.purple['5'] end,
      },
    },
    upsell = {
      muted = {
        value = function() return P.dark.bgColor.done.muted end,
      },
      emphasis = {
        value = function() return P.dark.bgColor.done.emphasis end,
      },
    },
    sponsors = {
      muted = {
        value = function() return P.dark.base.color.pink['4'] end,
        alpha = 0.1,
      },
      emphasis = {
        value = function() return P.dark.base.color.pink['5'] end,
      },
    },
  },
  color = {
    ansi = {
      black = {
        value = function() return P.dark.base.color.neutral['6'] end,
      },
      ['black-bright'] = {
        value = function() return P.dark.base.color.neutral['8'] end,
      },
      white = {
        value = function() return P.dark.base.color.neutral['12'] end,
      },
      ['white-bright'] = {
        value = function() return P.dark.base.color.neutral['13'] end,
      },
      gray = {
        value = function() return P.dark.base.color.neutral['8'] end,
      },
      red = {
        value = function() return P.dark.base.color.red['3'] end,
      },
      ['red-bright'] = {
        value = function() return P.dark.base.color.red['2'] end,
      },
      green = {
        value = function() return P.dark.base.color.green['3'] end,
      },
      ['green-bright'] = {
        value = function() return P.dark.base.color.green['2'] end,
      },
      yellow = {
        value = function() return P.dark.base.color.yellow['3'] end,
      },
      ['yellow-bright'] = {
        value = function() return P.dark.base.color.yellow['2'] end,
      },
      blue = {
        value = function() return P.dark.base.color.blue['3'] end,
      },
      ['blue-bright'] = {
        value = function() return P.dark.base.color.blue['2'] end,
      },
      magenta = {
        value = function() return P.dark.base.color.purple['3'] end,
      },
      ['magenta-bright'] = {
        value = function() return P.dark.base.color.purple['2'] end,
      },
      cyan = {
        value = function() return '#39c5cf' end,
      },
      ['cyan-bright'] = {
        value = function() return '#56d4dd' end,
      },
    },
    prettylights = {
      syntax = {
        comment = {
          value = function() return P.dark.base.color.neutral['9'] end,
        },
        constant = {
          value = function() return P.dark.base.color.blue['2'] end,
        },
        ['constant-other-reference-link'] = {
          value = function() return P.dark.base.color.blue['1'] end,
        },
        entity = {
          value = function() return P.dark.base.color.purple['2'] end,
        },
        storage = {
          modifier = {
            import = {
              value = function() return P.dark.base.color.neutral['12'] end,
            },
          },
        },
        ['entity-tag'] = {
          value = function() return P.dark.base.color.green['1'] end,
        },
        keyword = {
          value = function() return P.dark.base.color.red['3'] end,
        },
        string = {
          value = function() return P.dark.base.color.blue['1'] end,
        },
        variable = {
          value = function() return P.dark.base.color.orange['2'] end,
        },
        brackethighlighter = {
          unmatched = {
            value = function() return P.dark.base.color.red['4'] end,
          },
          angle = {
            value = function() return P.dark.base.color.neutral['9'] end,
          },
        },
        invalid = {
          illegal = {
            text = {
              value = function() return P.dark.base.color.neutral['12'] end,
            },
            bg = {
              value = function() return P.dark.base.color.red['7'] end,
            },
          },
        },
        carriage = {
          ['return'] = {
            text = {
              value = function() return P.dark.base.color.neutral['12'] end,
            },
            bg = {
              value = function() return P.dark.base.color.red['6'] end,
            },
          },
        },
        ['string-regexp'] = {
          value = function() return P.dark.base.color.green['1'] end,
        },
        markup = {
          list = {
            value = function() return P.dark.base.color.yellow['1'] end,
          },
          heading = {
            value = function() return P.dark.base.color.blue['5'] end,
          },
          italic = {
            value = function() return P.dark.base.color.neutral['12'] end,
          },
          bold = {
            value = function() return P.dark.base.color.neutral['12'] end,
          },
          deleted = {
            text = {
              value = function() return P.dark.base.color.red['0'] end,
            },
            bg = {
              value = function() return P.dark.base.color.red['8'] end,
            },
          },
          inserted = {
            text = {
              value = function() return P.dark.base.color.green['0'] end,
            },
            bg = {
              value = function() return P.dark.base.color.green['8'] end,
            },
          },
          changed = {
            text = {
              value = function() return P.dark.base.color.orange['0'] end,
            },
            bg = {
              value = function() return P.dark.base.color.orange['8'] end,
            },
          },
          ignored = {
            text = {
              value = function() return P.dark.base.color.neutral['12'] end,
            },
            bg = {
              value = function() return P.dark.base.color.blue['6'] end,
            },
          },
        },
        meta = {
          diff = { range = {
            value = function() return P.dark.base.color.purple['2'] end,
          } },
        },
        sublimelinter = {
          gutter = {
            mark = {
              value = function() return P.dark.base.color.neutral['7'] end,
            },
          },
        },
      },
    },
  },
  borderColor = {
    default = {
      value = function() return P.dark.base.color.neutral['7'] end,
    },
    muted = {
      value = function() return P.dark.borderColor.default end,
      alpha = 0.7,
    },
    emphasis = {
      value = function() return P.dark.base.color.neutral['8'] end,
    },
    disabled = {
      value = function() return P.dark.base.color.neutral['8'] end,
      alpha = 0.1,
    },
    transparent = {
      value = function() return P.dark.base.color.transparent end,
    },
    translucent = {
      value = function() return P.dark.base.color.neutral['13'] end,
      alpha = 0.15,
    },
    neutral = {
      muted = {
        value = function() return P.dark.borderColor.muted end,
      },
      emphasis = {
        value = function() return P.dark.borderColor.emphasis end,
      },
    },
    accent = {
      muted = {
        value = function() return P.dark.base.color.blue['4'] end,
        alpha = 0.4,
      },
      emphasis = {
        value = function() return P.dark.base.color.blue['5'] end,
      },
    },
    success = {
      muted = {
        value = function() return P.dark.base.color.green['4'] end,
        alpha = 0.4,
      },
      emphasis = {
        value = function() return P.dark.base.color.green['5'] end,
      },
    },
    open = {
      muted = {
        value = function() return P.dark.borderColor.success.muted end,
      },
      emphasis = {
        value = function() return P.dark.borderColor.success.emphasis end,
      },
    },
    attention = {
      muted = {
        value = function() return P.dark.base.color.yellow['4'] end,
        alpha = 0.4,
      },
      emphasis = {
        value = function() return P.dark.base.color.yellow['5'] end,
      },
    },
    severe = {
      muted = {
        value = function() return P.dark.base.color.orange['4'] end,
        alpha = 0.4,
      },
      emphasis = {
        value = function() return P.dark.base.color.orange['5'] end,
      },
    },
    danger = {
      muted = {
        value = function() return P.dark.base.color.red['4'] end,
        alpha = 0.4,
      },
      emphasis = {
        value = function() return P.dark.base.color.red['5'] end,
      },
    },
    closed = {
      muted = {
        value = function() return P.dark.borderColor.danger.muted end,
      },
      emphasis = {
        value = function() return P.dark.borderColor.danger.emphasis end,
      },
    },
    done = {
      muted = {
        value = function() return P.dark.base.color.purple['4'] end,
        alpha = 0.4,
      },
      emphasis = {
        value = function() return P.dark.base.color.purple['5'] end,
      },
    },
    upsell = {
      muted = {
        value = function() return P.dark.borderColor.done.muted end,
      },
      emphasis = {
        value = function() return P.dark.borderColor.done.emphasis end,
      },
    },
    sponsors = {
      muted = {
        value = function() return P.dark.base.color.pink['4'] end,
        alpha = 0.4,
      },
      emphasis = {
        value = function() return P.dark.base.color.pink['5'] end,
      },
    },
  },
  focus = { outlineColor = {
    value = function() return P.dark.borderColor.accent.emphasis end,
  } },
  selection = {
    bgColor = {
      value = function() return P.dark.bgColor.accent.emphasis end,
      alpha = 0.7,
    },
  },
}

P.darkDimmed = {
  base = {
    color = {
      black = {
        value = function() return '#1c2128' end,
      },
      inset = {
        value = function() return P.darkDimmed.base.color.black end,
      },
      white = {
        value = function() return '#cdd9e5' end,
      },
      transparent = {
        value = function() return '#000000' end,
        alpha = 0,
      },
      neutral = {
        ['0'] = {
          value = function() return P.darkDimmed.base.color.black end,
        },
        ['1'] = {
          value = function() return '#0D1117' end,
        },
        ['2'] = {
          value = function() return '#151B23' end,
        },
        ['3'] = {
          value = function() return '#212830' end,
        },
        ['4'] = {
          value = function() return '#262C36' end,
        },
        ['5'] = {
          value = function() return '#2A313C' end,
        },
        ['6'] = {
          value = function() return '#2F3742' end,
        },
        ['7'] = {
          value = function() return '#3D444D' end,
        },
        ['8'] = {
          value = function() return '#656C76' end,
        },
        ['9'] = {
          value = function() return '#9198A1' end,
        },
        ['10'] = {
          value = function() return '#B7BDC8' end,
        },
        ['11'] = {
          value = function() return '#D1D7E0' end,
        },
        ['12'] = {
          value = function() return '#F0F6FC' end,
        },
        ['13'] = {
          value = function() return P.darkDimmed.base.color.white end,
        },
      },
      blue = {
        ['0'] = {
          value = function() return '#c6e6ff' end,
        },
        ['1'] = {
          value = function() return '#96d0ff' end,
        },
        ['2'] = {
          value = function() return '#6cb6ff' end,
        },
        ['3'] = {
          value = function() return '#539bf5' end,
        },
        ['4'] = {
          value = function() return '#4184e4' end,
        },
        ['5'] = {
          value = function() return '#316dca' end,
        },
        ['6'] = {
          value = function() return '#255ab2' end,
        },
        ['7'] = {
          value = function() return '#1b4b91' end,
        },
        ['8'] = {
          value = function() return '#143d79' end,
        },
        ['9'] = {
          value = function() return '#0f2d5c' end,
        },
      },
      green = {
        ['0'] = {
          value = function() return '#b4f1b4' end,
        },
        ['1'] = {
          value = function() return '#8ddb8c' end,
        },
        ['2'] = {
          value = function() return '#6bc46d' end,
        },
        ['3'] = {
          value = function() return '#57ab5a' end,
        },
        ['4'] = {
          value = function() return '#46954a' end,
        },
        ['5'] = {
          value = function() return '#347d39' end,
        },
        ['6'] = {
          value = function() return '#2b6a30' end,
        },
        ['7'] = {
          value = function() return '#245829' end,
        },
        ['8'] = {
          value = function() return '#1b4721' end,
        },
        ['9'] = {
          value = function() return '#113417' end,
        },
      },
      yellow = {
        ['0'] = {
          value = function() return '#fbe090' end,
        },
        ['1'] = {
          value = function() return '#eac55f' end,
        },
        ['2'] = {
          value = function() return '#daaa3f' end,
        },
        ['3'] = {
          value = function() return '#c69026' end,
        },
        ['4'] = {
          value = function() return '#ae7c14' end,
        },
        ['5'] = {
          value = function() return '#966600' end,
        },
        ['6'] = {
          value = function() return '#805400' end,
        },
        ['7'] = {
          value = function() return '#6c4400' end,
        },
        ['8'] = {
          value = function() return '#593600' end,
        },
        ['9'] = {
          value = function() return '#452700' end,
        },
      },
      orange = {
        ['0'] = {
          value = function() return '#ffddb0' end,
        },
        ['1'] = {
          value = function() return '#ffbc6f' end,
        },
        ['2'] = {
          value = function() return '#f69d50' end,
        },
        ['3'] = {
          value = function() return '#e0823d' end,
        },
        ['4'] = {
          value = function() return '#cc6b2c' end,
        },
        ['5'] = {
          value = function() return '#ae5622' end,
        },
        ['6'] = {
          value = function() return '#94471b' end,
        },
        ['7'] = {
          value = function() return '#7f3913' end,
        },
        ['8'] = {
          value = function() return '#682d0f' end,
        },
        ['9'] = {
          value = function() return '#4d210c' end,
        },
      },
      red = {
        ['0'] = {
          value = function() return '#ffd8d3' end,
        },
        ['1'] = {
          value = function() return '#ffb8b0' end,
        },
        ['2'] = {
          value = function() return '#ff938a' end,
        },
        ['3'] = {
          value = function() return '#f47067' end,
        },
        ['4'] = {
          value = function() return '#e5534b' end,
        },
        ['5'] = {
          value = function() return '#c93c37' end,
        },
        ['6'] = {
          value = function() return '#ad2e2c' end,
        },
        ['7'] = {
          value = function() return '#922323' end,
        },
        ['8'] = {
          value = function() return '#78191b' end,
        },
        ['9'] = {
          value = function() return '#5d0f12' end,
        },
      },
      purple = {
        ['0'] = {
          value = function() return '#eedcff' end,
        },
        ['1'] = {
          value = function() return '#dcbdfb' end,
        },
        ['2'] = {
          value = function() return '#dcbdfb' end,
        },
        ['3'] = {
          value = function() return '#b083f0' end,
        },
        ['4'] = {
          value = function() return '#986ee2' end,
        },
        ['5'] = {
          value = function() return '#8256d0' end,
        },
        ['6'] = {
          value = function() return '#6b44bc' end,
        },
        ['7'] = {
          value = function() return '#5936a2' end,
        },
        ['8'] = {
          value = function() return '#472c82' end,
        },
        ['9'] = {
          value = function() return '#352160' end,
        },
      },
      pink = {
        ['0'] = {
          value = function() return '#ffd7eb' end,
        },
        ['1'] = {
          value = function() return '#ffb3d8' end,
        },
        ['2'] = {
          value = function() return '#fc8dc7' end,
        },
        ['3'] = {
          value = function() return '#e275ad' end,
        },
        ['4'] = {
          value = function() return '#c96198' end,
        },
        ['5'] = {
          value = function() return '#ae4c82' end,
        },
        ['6'] = {
          value = function() return '#983b6e' end,
        },
        ['7'] = {
          value = function() return '#7e325a' end,
        },
        ['8'] = {
          value = function() return '#69264a' end,
        },
        ['9'] = {
          value = function() return '#551639' end,
        },
      },
      coral = {
        ['0'] = {
          value = function() return '#ffdacf' end,
        },
        ['1'] = {
          value = function() return '#ffb9a5' end,
        },
        ['2'] = {
          value = function() return '#f79981' end,
        },
        ['3'] = {
          value = function() return '#ec775c' end,
        },
        ['4'] = {
          value = function() return '#de5b41' end,
        },
        ['5'] = {
          value = function() return '#c2442d' end,
        },
        ['6'] = {
          value = function() return '#a93524' end,
        },
        ['7'] = {
          value = function() return '#8d291b' end,
        },
        ['8'] = {
          value = function() return '#771d13' end,
        },
        ['9'] = {
          value = function() return '#5d1008' end,
        },
      },
    },
  },
  fgColor = {
    default = {
      value = function() return P.darkDimmed.base.color.neutral['11'] end,
    },
    muted = {
      value = function() return P.darkDimmed.base.color.neutral['9'] end,
    },
    onEmphasis = {
      value = function() return P.darkDimmed.base.color.neutral['12'] end,
    },
    onInverse = {
      value = function() return P.darkDimmed.base.color.neutral['0'] end,
    },
    white = {
      value = function() return P.darkDimmed.base.color.neutral['0'] end,
    },
    black = {
      value = function() return P.darkDimmed.base.color.neutral['13'] end,
    },
    disabled = {
      value = function() return P.darkDimmed.base.color.neutral['8'] end,
    },
    link = {
      value = function() return P.darkDimmed.fgColor.accent end,
    },
    neutral = {
      value = function() return P.darkDimmed.base.color.neutral['9'] end,
    },
    accent = {
      value = function() return '#478be6' end,
    },
    success = {
      value = function() return P.darkDimmed.base.color.green['5'] end,
    },
    open = {
      value = function() return P.darkDimmed.fgColor.success end,
    },
    attention = {
      value = function() return P.darkDimmed.base.color.yellow['5'] end,
    },
    severe = {
      value = function() return P.darkDimmed.base.color.orange['5'] end,
    },
    danger = {
      value = function() return '#d1242f' end,
    },
    closed = {
      value = function() return P.darkDimmed.fgColor.danger end,
    },
    done = {
      value = function() return P.darkDimmed.base.color.purple['5'] end,
    },
    upsell = {
      value = function() return P.darkDimmed.fgColor.done end,
    },
    sponsors = {
      value = function() return P.darkDimmed.base.color.pink['5'] end,
    },
  },
  bgColor = {
    default = {
      value = function() return P.darkDimmed.base.color.neutral['3'] end,
    },
    muted = {
      value = function() return P.darkDimmed.base.color.neutral['4'] end,
    },
    inset = {
      value = function() return P.darkDimmed.base.color.neutral['2'] end,
    },
    emphasis = {
      value = function() return P.darkDimmed.base.color.neutral['12'] end,
    },
    inverse = {
      value = function() return P.darkDimmed.base.color.neutral['12'] end,
    },
    white = {
      value = function() return P.darkDimmed.base.color.neutral['0'] end,
    },
    black = {
      value = function() return P.darkDimmed.base.color.neutral['13'] end,
    },
    disabled = {
      value = function() return P.darkDimmed.base.color.neutral['5'] end,
    },
    transparent = {
      value = function() return P.darkDimmed.base.color.transparent end,
    },
    neutral = {
      muted = {
        value = function() return P.darkDimmed.base.color.neutral['8'] end,
      },
      emphasis = {
        value = function() return P.darkDimmed.base.color.neutral['8'] end,
      },
    },
    accent = {
      muted = {
        value = function() return P.darkDimmed.base.color.blue['0'] end,
      },
      emphasis = {
        value = function() return P.darkDimmed.base.color.blue['5'] end,
      },
    },
    success = {
      muted = {
        value = function() return P.darkDimmed.base.color.green['0'] end,
      },
      emphasis = {
        value = function() return '#1f883d' end,
      },
    },
    open = {
      muted = {
        value = function() return P.darkDimmed.bgColor.success.muted end,
      },
      emphasis = {
        value = function() return P.darkDimmed.bgColor.success.emphasis end,
      },
    },
    attention = {
      muted = {
        value = function() return P.darkDimmed.base.color.yellow['0'] end,
      },
      emphasis = {
        value = function() return P.darkDimmed.base.color.yellow['5'] end,
      },
    },
    severe = {
      muted = {
        value = function() return P.darkDimmed.base.color.orange['0'] end,
      },
      emphasis = {
        value = function() return P.darkDimmed.base.color.orange['5'] end,
      },
    },
    danger = {
      muted = {
        value = function() return P.darkDimmed.base.color.red['0'] end,
      },
      emphasis = {
        value = function() return P.darkDimmed.base.color.red['5'] end,
      },
    },
    closed = {
      muted = {
        value = function() return P.darkDimmed.bgColor.danger.muted end,
      },
      emphasis = {
        value = function() return P.darkDimmed.bgColor.danger.emphasis end,
      },
    },
    done = {
      muted = {
        value = function() return P.darkDimmed.base.color.purple['0'] end,
      },
      emphasis = {
        value = function() return P.darkDimmed.base.color.purple['5'] end,
      },
    },
    upsell = {
      muted = {
        value = function() return P.darkDimmed.bgColor.done.muted end,
      },
      emphasis = {
        value = function() return P.darkDimmed.bgColor.done.emphasis end,
      },
    },
    sponsors = {
      muted = {
        value = function() return P.darkDimmed.base.color.pink['0'] end,
      },
      emphasis = {
        value = function() return P.darkDimmed.base.color.pink['5'] end,
      },
    },
  },
  color = {
    ansi = {
      black = {
        value = function() return P.darkDimmed.base.color.neutral['13'] end,
      },
      ['black-bright'] = {
        value = function() return P.darkDimmed.base.color.neutral['11'] end,
      },
      white = {
        value = function() return P.darkDimmed.base.color.neutral['9'] end,
      },
      ['white-bright'] = {
        value = function() return P.darkDimmed.base.color.neutral['8'] end,
      },
      gray = {
        value = function() return P.darkDimmed.base.color.neutral['9'] end,
      },
      red = {
        value = function() return P.darkDimmed.base.color.red['5'] end,
      },
      ['red-bright'] = {
        value = function() return P.darkDimmed.base.color.red['6'] end,
      },
      green = {
        value = function() return P.darkDimmed.base.color.green['6'] end,
      },
      ['green-bright'] = {
        value = function() return P.darkDimmed.base.color.green['5'] end,
      },
      yellow = {
        value = function() return P.darkDimmed.base.color.yellow['8'] end,
      },
      ['yellow-bright'] = {
        value = function() return P.darkDimmed.base.color.yellow['7'] end,
      },
      blue = {
        value = function() return P.darkDimmed.base.color.blue['5'] end,
      },
      ['blue-bright'] = {
        value = function() return P.darkDimmed.base.color.blue['4'] end,
      },
      magenta = {
        value = function() return P.darkDimmed.base.color.purple['5'] end,
      },
      ['magenta-bright'] = {
        value = function() return P.darkDimmed.base.color.purple['4'] end,
      },
      cyan = {
        value = function() return '#1b7c83' end,
      },
      ['cyan-bright'] = {
        value = function() return '#3192aa' end,
      },
    },
    prettylights = {
      syntax = {
        comment = {
          value = function() return P.darkDimmed.base.color.neutral['9'] end,
        },
        constant = {
          value = function() return P.darkDimmed.base.color.blue['6'] end,
        },
        ['constant-other-reference-link'] = {
          value = function() return P.darkDimmed.base.color.blue['8'] end,
        },
        entity = {
          value = function() return P.darkDimmed.base.color.purple['6'] end,
        },
        storage = {
          modifier = {
            import = {
              value = function() return P.darkDimmed.base.color.neutral['13'] end,
            },
          },
        },
        ['entity-tag'] = {
          value = function() return P.darkDimmed.base.color.blue['6'] end,
        },
        keyword = {
          value = function() return P.darkDimmed.base.color.red['5'] end,
        },
        string = {
          value = function() return P.darkDimmed.base.color.blue['8'] end,
        },
        variable = {
          value = function() return P.darkDimmed.base.color.orange['6'] end,
        },
        brackethighlighter = {
          unmatched = {
            value = function() return P.darkDimmed.base.color.red['7'] end,
          },
          angle = {
            value = function() return P.darkDimmed.base.color.neutral['9'] end,
          },
        },
        invalid = {
          illegal = {
            text = {
              value = function() return P.darkDimmed.base.color.neutral['1'] end,
            },
            bg = {
              value = function() return P.darkDimmed.base.color.red['7'] end,
            },
          },
        },
        carriage = {
          ['return'] = {
            text = {
              value = function() return P.darkDimmed.base.color.neutral['1'] end,
            },
            bg = {
              value = function() return P.darkDimmed.base.color.red['5'] end,
            },
          },
        },
        ['string-regexp'] = {
          value = function() return P.darkDimmed.base.color.green['6'] end,
        },
        markup = {
          list = {
            value = function() return P.darkDimmed.base.color.yellow['9'] end,
          },
          heading = {
            value = function() return P.darkDimmed.base.color.blue['6'] end,
          },
          italic = {
            value = function() return P.darkDimmed.base.color.neutral['13'] end,
          },
          bold = {
            value = function() return P.darkDimmed.base.color.neutral['13'] end,
          },
          deleted = {
            text = {
              value = function() return P.darkDimmed.base.color.red['7'] end,
            },
            bg = {
              value = function() return P.darkDimmed.base.color.red['0'] end,
            },
          },
          inserted = {
            text = {
              value = function() return P.darkDimmed.base.color.green['6'] end,
            },
            bg = {
              value = function() return P.darkDimmed.base.color.green['0'] end,
            },
          },
          changed = {
            text = {
              value = function() return P.darkDimmed.base.color.orange['6'] end,
            },
            bg = {
              value = function() return P.darkDimmed.base.color.orange['1'] end,
            },
          },
          ignored = {
            text = {
              value = function() return P.darkDimmed.base.color.neutral['6'] end,
            },
            bg = {
              value = function() return P.darkDimmed.base.color.blue['6'] end,
            },
          },
        },
        meta = {
          diff = {
            range = {
              value = function() return P.darkDimmed.base.color.purple['5'] end,
            },
          },
        },
        sublimelinter = {
          gutter = {
            mark = {
              value = function() return P.darkDimmed.base.color.neutral['8'] end,
            },
          },
        },
      },
    },
  },
  borderColor = {
    default = {
      value = function() return P.darkDimmed.base.color.neutral['7'] end,
    },
    muted = {
      value = function() return P.darkDimmed.base.color.neutral['7'] end,
      alpha = 0.7,
    },
    emphasis = {
      value = function() return P.darkDimmed.base.color.neutral['8'] end,
    },
    disabled = {
      value = function() return P.darkDimmed.base.color.neutral['8'] end,
      alpha = 0.1,
    },
    transparent = {
      value = function() return P.darkDimmed.base.color.transparent end,
    },
    translucent = {
      value = function() return P.darkDimmed.base.color.neutral['13'] end,
      alpha = 0.15,
    },
    neutral = {
      muted = {
        value = function() return P.darkDimmed.base.color.neutral['7'] end,
        alpha = 0.7,
      },
      emphasis = {
        value = function() return P.darkDimmed.base.color.neutral['9'] end,
      },
    },
    accent = {
      muted = {
        value = function() return P.darkDimmed.base.color.blue['3'] end,
        alpha = 0.4,
      },
      emphasis = {
        value = function() return P.darkDimmed.base.color.blue['5'] end,
      },
    },
    success = {
      muted = {
        value = function() return P.darkDimmed.base.color.green['3'] end,
        alpha = 0.4,
      },
      emphasis = {
        value = function() return P.darkDimmed.base.color.green['5'] end,
      },
    },
    open = {
      muted = {
        value = function() return P.darkDimmed.borderColor.success.muted end,
      },
      emphasis = {
        value = function() return P.darkDimmed.borderColor.success.emphasis end,
      },
    },
    attention = {
      muted = {
        value = function() return P.darkDimmed.base.color.yellow['3'] end,
        alpha = 0.4,
      },
      emphasis = {
        value = function() return P.darkDimmed.base.color.yellow['5'] end,
      },
    },
    severe = {
      muted = {
        value = function() return P.darkDimmed.base.color.orange['3'] end,
        alpha = 0.4,
      },
      emphasis = {
        value = function() return P.darkDimmed.base.color.orange['5'] end,
      },
    },
    danger = {
      muted = {
        value = function() return P.darkDimmed.base.color.red['3'] end,
        alpha = 0.4,
      },
      emphasis = {
        value = function() return P.darkDimmed.base.color.red['5'] end,
      },
    },
    closed = {
      muted = {
        value = function() return P.darkDimmed.borderColor.danger.muted end,
      },
      emphasis = {
        value = function() return P.darkDimmed.borderColor.danger.emphasis end,
      },
    },
    done = {
      muted = {
        value = function() return P.darkDimmed.base.color.purple['3'] end,
        alpha = 0.4,
      },
      emphasis = {
        value = function() return P.darkDimmed.base.color.purple['5'] end,
      },
    },
    upsell = {
      muted = {
        value = function() return P.darkDimmed.borderColor.done.muted end,
      },
      emphasis = {
        value = function() return P.darkDimmed.borderColor.done.emphasis end,
      },
    },
    sponsors = {
      muted = {
        value = function() return P.darkDimmed.base.color.pink['3'] end,
        alpha = 0.4,
      },
      emphasis = {
        value = function() return P.darkDimmed.base.color.pink['5'] end,
      },
    },
  },
  focus = { outlineColor = {
    value = function() return P.darkDimmed.borderColor.accent.emphasis end,
  } },
  selection = {
    bgColor = {
      value = function() return P.darkDimmed.bgColor.accent.emphasis end,
      alpha = 0.2,
    },
  },
}

return P
