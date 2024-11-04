import dracula.draw

c.completion.shrink = True
c.fonts.default_family = "FiraCode Nerd Font Mono"

config.load_autoconfig()

dracula.draw.blood(c, {
    'spacing': {
        'vertical': 6,
        'horizontal': 8
    }
})
