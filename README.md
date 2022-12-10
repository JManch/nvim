![image](https://user-images.githubusercontent.com/61563764/206861957-36e5bfc6-51bc-4214-a748-c828e3264dfd.png)
![image](https://user-images.githubusercontent.com/61563764/206861926-93e03936-a7ff-4b8c-8c7e-af21c378b8c9.png)

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
