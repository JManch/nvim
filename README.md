![image](https://user-images.githubusercontent.com/61563764/208174663-fd7529e8-efe2-4650-a46b-7d1cf10cb1da.png)
My (somewhat) minimal Neovim config that I use with [Neovide](https://github.com/neovide/neovide).

# Config structure

```
lua
├── core
└── plugins
    ├── init.lua
    └── configs
```

The structure takes inspiration from [NvChad](https://github.com/NvChad/NvChad)

- The `core` folder contains config files for vanilla Neovim with no plugin-specific config
- The `configs` folder contains isolated plugin-specific configs
- Plugins only create keymaps, autocmds etc... in their own config files
