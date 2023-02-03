# Description

Simple autocompletion plugin for Vim using ins-complete in automatic way.

## User functions used for key mapping

- `insautocomplete#manual_or_next(<key>)`: Key triggers autocompletion based on the text before cursor or selects next candidate if pop up menu is visible
- `insautocomplete#next(<key>)`: Key selects next candidate if pop up menu is visible
- `insautocomplete#previous(<key>)`: Key selects previous candidate if pop up menu is visible
- `insautocomplete#confirm(<key>)`: Key chooses selected candidate if pop up menu is visible
- `insautocomplete#abort(<key>)`: Key aborts current completion

## Variables for configuration

- `g:insautocomplete_omni_pattern` can be used to override default omni completion triggers
- `g:insautocomplete_user_pattern` can be used to override default user completion triggers
- `g:insautocomplete_direction` can be used to override default selection direction (default: "\<C-N>")
