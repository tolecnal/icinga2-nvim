" Vim syntax file
" Language: Icinga2 Configuration
" Maintainer: Generated for Neovim
" Latest Revision: 2025

if exists("b:current_syntax")
  finish
endif

" Comments
syn keyword icinga2Todo contained TODO FIXME XXX NOTE
syn match icinga2Comment "//.*$" contains=icinga2Todo
syn match icinga2Comment "#.*$" contains=icinga2Todo
syn region icinga2Comment start="/\*" end="\*/" contains=icinga2Todo

" Keywords
syn keyword icinga2Keyword object template apply import include include_recursive include_zones
syn keyword icinga2Keyword const var function return
syn keyword icinga2Keyword if else for while break continue
syn keyword icinga2Keyword assign ignore where
syn keyword icinga2Keyword use namespace
syn keyword icinga2Keyword library

" Boolean and Null
syn keyword icinga2Boolean true false
syn keyword icinga2Null null

" Object Types
syn keyword icinga2Type ApiListener ApiUser
syn keyword icinga2Type CheckCommand NotificationCommand EventCommand
syn keyword icinga2Type Dependency
syn keyword icinga2Type Endpoint
syn keyword icinga2Type Host HostGroup
syn keyword icinga2Type IcingaApplication
syn keyword icinga2Type IdoMySqlConnection IdoPgsqlConnection
syn keyword icinga2Type Notification NotificationComponent
syn keyword icinga2Type PerfdataWriter
syn keyword icinga2Type ScheduledDowntime
syn keyword icinga2Type Service ServiceGroup
syn keyword icinga2Type TimePeriod
syn keyword icinga2Type User UserGroup
syn keyword icinga2Type Zone

" Built-in Functions
syn keyword icinga2Function regex match cidr_match
syn keyword icinga2Function len union intersection
syn keyword icinga2Function keys values
syn keyword icinga2Function string number bool
syn keyword icinga2Function random
syn keyword icinga2Function log typeof
syn keyword icinga2Function range
syn keyword icinga2Function exit
syn keyword icinga2Function sleep
syn keyword icinga2Function dirname basename
syn keyword icinga2Function path_exists
syn keyword icinga2Function glob glob_recursive
syn keyword icinga2Function escape_shell_arg escape_shell_cmd
syn keyword icinga2Function escape_create_process_arg
syn keyword icinga2Function parse_performance_data
syn keyword icinga2Function getenv

" Fixed operator syntax to properly escape special characters
" Operators - using separate matches for each to avoid regex issues
syn match icinga2Operator "+"
syn match icinga2Operator "-"
syn match icinga2Operator "\*"
syn match icinga2Operator "/"
syn match icinga2Operator "%"
syn match icinga2Operator "="
syn match icinga2Operator "=="
syn match icinga2Operator "!="
syn match icinga2Operator "<"
syn match icinga2Operator ">"
syn match icinga2Operator "<="
syn match icinga2Operator ">="
syn match icinga2Operator "&&"
syn match icinga2Operator "||"
syn match icinga2Operator "!"
syn match icinga2Operator "&"
syn match icinga2Operator "|"
syn match icinga2Operator "\~" " Regex match operator
syn keyword icinga2Operator in

" Numbers
syn match icinga2Number "\<\d\+\>"
syn match icinga2Number "\<\d\+\.\d\+\>"
syn match icinga2Number "\<0x\x\+\>"

" Duration Literals
" Replaced broken pattern with proper Vim regex syntax
syn match   icinga2Duration "\<\d\+\(\.\d\+\)\?\(ms\|[smhd]\)\>"

" Runtime Macros
syn match icinga2RuntimeMacro "\$[a-zA-Z_][a-zA-Z0-9_\.]*\$" contained

" Strings
syn region icinga2String start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=icinga2Escape,icinga2RuntimeMacro
syn region icinga2String start=+'+ skip=+\\\\\|\\'+ end=+'+ contains=icinga2Escape,icinga2RuntimeMacro

" Multi-line strings
syn region icinga2MultiString start=+{{{+ end=+}}}+ contains=icinga2RuntimeMacro

" Escape sequences in strings
syn match icinga2Escape contained "\\[tnr\\\"']"
syn match icinga2Escape contained "\\x\x\{2}"
syn match icinga2Escape contained "\\u\x\{4}"

" Identifiers (attributes and variables)
syn match icinga2Identifier "\<[a-zA-Z_][a-zA-Z0-9_]*\>"

" Special attributes
syn keyword icinga2Special name import vars

" Highlighting Links
hi def link icinga2Comment Comment
hi def link icinga2Todo Todo
hi def link icinga2Keyword Keyword
hi def link icinga2Type Type
hi def link icinga2Function Function
hi def link icinga2Operator Operator
hi def link icinga2Boolean Boolean
hi def link icinga2Null Constant
hi def link icinga2Number Number
hi def link icinga2Duration Number
hi def link icinga2String String
hi def link icinga2MultiString String
hi def link icinga2Escape SpecialChar
hi def link icinga2RuntimeMacro Identifier
hi def link icinga2Identifier Identifier
hi def link icinga2Special Special

let b:current_syntax = "icinga2"

