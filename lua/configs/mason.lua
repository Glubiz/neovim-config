
return {
    ui = { border = "rounded" },
    ensure_installed = {
        { import = "mason.daps" },
        { import = "mason.formatters" },
        { import = "mason.linters" },
        { import = "mason.lsps" },
    },
}
