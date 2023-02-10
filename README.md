# Description

Simple autocompletion plugin for Vim using ins-complete in automatic way.

## User functions used for key mapping

None. Popup menu is triggered on events InsertCharPre and InsertEnter.
Use normal keys to navigate the popup menu.

## Variables for configuration

- `g:insautocomplete_omni_pattern` or `b:insautocomplete_omni_pattern` can be used to override default omni completion triggers
- `g:insautocomplete_user_pattern` or `b:insautocomplete_user_pattern` can be used to override default user completion triggers
