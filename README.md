# Entity Modifier

![CI](https://github.com/j8r/minetest-entity_modifier/workflows/CI/badge.svg)
[![ISC](https://img.shields.io/badge/License-ISC-blue.svg?style=flat-square)](https://en.wikipedia.org/wiki/ISC_license)

Modify the model and size of entities, including players.

![screenshot](https://i.postimg.cc/prtm7KCY/screenshot.jpg)

## Usage

This section explains how to use this mod.

Example of what is possible to do:

- disguise into players, blocks, and entities (even dropped items!)

- disguise players and entities (like dropped items) to blocks or other player/entities

- make yourself and other entities tiny or huge

- change others visible names and attributes

Note: Changes are not meant to be permanent. Restarting the server or even reconnections will reset entity models.

### Commands

Each command has a dedicated privilege with the same name, except `clipboard`, which has `clipboard_edit`.

`<object>` can be an entity model (as listed with `/list_entities`) or an [Itemstring](https://wiki.minetest.net/Itemstrings) (e.g. `default:dirt`).
`air` is a valid object, which will make the entity invisible.

#### `/clipboard <object_or_property>`

`/clipboard`: Print the current copied model name.

`/clipboard *`: Activate reset mode, which allows you to reset subsequent selected entities.
Deactivate itself if anything is stored in the clipboard (like selecting a block).

`/clipboard ""`: Empty the clipboard.

`/clipboard <object>`: Copy an object, player or entity to the clipboard

`/clipboard .<property>`: Print a property of the copied model, see https://minetest.gitlab.io/minetest/definition-tables/#object-properties.

`/clipboard .<property>=<value>`: Change a property in the copied model.
Editing requires the `clipboard_edit` privilege. Does not support tables yet.

Example: `/clipboard .nametag="FooBar"`

#### `/disguise <name> [<object>]`

Disguise a `player` into an `object`. Defaults to the clipboard. An empty clipboard resets your disguise.

#### `/disguiseme [<object>]`

Disguise you into an `object`. Defaults to the clipboard. An empty clipboard resets your disguise.

#### `/list_entities [<namespace>]`

List available entity names, with an optional entity namepace (e.g. `mob:`).

#### `/resize <name> [<size>]`

Resize a `player` into `size`, `1` by default.

#### `/resizeme [<size>]`

Resize yourself into `size`, `1` by default.

### Items

`entity_modifier:disguise_wand`:

- **Left click** on (any) a pointed object to copy it into the clipboard (air will make invisible).

- **Left click** on a player/entity to disguise it with the clipboard's model.
If in reset mode, the model will be reset to the default.

- Two consecutive **left clicks** on a same block/air (non-entity) to clear the clipboard.
(no time delay requirement between the two)

- **Right click** to disguise you into the copied model.

Resets your disguise if the clipboard is empty.
- **Right click** with an empty clipboard to copy your model.

- Not craftable, requires the `disguise` privilege.

## Caveats

Blocks can't be disguised, only players/entities (but you can take their appearance).

Some blocks and entities can't be disguised into properly.

Some entities, like dropped items, can't be reset. A workaround is to take it and drop it again.

Partially incompatible with other mods overwriting entity properties (like 3d_armor).
You can of course use both, but funny thing could be seen on using disguise.

## Development

- Lint with [luacheck](https://github.com/mpeterv/luacheck)

`luacheck .`

Docker can be used to run it:
```sh
docker run -it --rm -v $PWD:/dir -w /dir docker.io/alpine sh
apk add -qU luacheck
luacheck .
```

- Use tabs for indent. To check for any spaces in indentation:

`grep -nE '^[[:blank:]]? [[:blank:]]?' *.lua`

## License

Copyright (c) 2021 Julien Reichardt - ISC License
