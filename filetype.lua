vim.filetype.add({
    extension ={
        h = function(path)
            local stem = vim.fn.fnamemodify(path, ":r")
            if
                vim.uv.fs_stat(string.format("%s.cc", stem))
                or vim.uv.fs_stat(string.format("%s.cpp", stem))
            then
                return "cpp"
            end

            if
                vim.fn.search(
                    string.format(
                        [[\C\%%(%s\)]],
                        table.concat({
                            [[^#include <[^>.]\+>$]],
                            [[\<constexpr\>]],
                            [[\<consteval\>]],
                            [[\<extern "C"\>]],
                            [[^class\> [A-Z]],
                            [[^\s*using\>]],
                            [[\<template\>\s*<]],
                            [[\<std::]],
                        }, "\\|")
                    ),
                    "nw"
                ) ~= 0
            then
                return "cpp"
            end

            return "c"
        end,
        plist = "xml",
    },
})
