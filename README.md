<img src="https://raw.githubusercontent.com/marceloboeira/bojack/master/docs/bojack.png" width="250" align="right">
# BoJack [![Travis](https://img.shields.io/travis/marceloboeira/bojack.svg?maxAge=2592000)](https://travis-ci.org/marceloboeira/bojack) [![Stories in Ready](https://img.shields.io/waffle/label/marceloboeira/bojack/ready.svg?maxAge=2592000)](http://waffle.io/marceloboeira/bojack) [![Releases](https://img.shields.io/github/release/marceloboeira/bojack.svg?maxAge=259000)](http://github.com/marceloboeira/bojack/releases)
> A non-reliable in-memory key-value store.

## Installation

**Requirements**

* The latest version of Crystal (0.18.x).
* LLVM development files.

**Steps**

1. Clone the repo: `git clone https://github.com/marceloboeira/bojack`
2. Switch to repo-directory: `cd bojack`
3. Build: `make install` (sudo for linux users)

## Showtime

1. To start the server, run: `bojack server`
2. To connect a client, in another tab, run: `bojack client`

```
$ bojack client
> set foo bar
bar
> get foo
bar
> ping
pong
```

***By default BoJack runs at 127.0.0.1:5000.***

## Usage

### CLI

Currently the command-line interface supports two commands: `server` and `client`.

```
bojack <server/client> <flags>
```

### Server

|flag|description||
|---|---|---|---|
|--hostname|Hostname the server will run|127.0.0.1|
|--port|Port the server will run|5000|
|--log-level|Level of messages logged|DEBUG = 0, INFO = 1 (default), WARN = 2, ERROR = 3, FATAL = 4|

### Client

|flag|description|default|
|---|---|---|---|
|--hostname|Hostname this client will connect|127.0.0.1|
|--port|Port this client will connect|5000|

### Commands

List of available commands for BoJack

|command|description|params|example|return|
|---|---|---|---|---|---|
|set| sets a key with the given name and value  | key, value  | `set foo bar`  | the value of the key "bar"  |
|increment| increments the given key value by 1| key | `increment foo`  | the value of the key "foo" incremented |
|get| gets the value of the given value  | key | `get foo` | the value stored at the key, "bar" |
|delete| deletes the given key | key, * | `delete foo, delete *` | the value at the deleted key "bar" or every key in the database, if "*" is given instead of a key  |
|append| add one or more values to the end of a list | key, value  | `append list foo,bar`  | the list resulted |
|pop| retrieve the last item of the list | key | `pop foo` | the last value stored at the list, "foo" |
|size| return the number of stored items | -- | `size` | the value of stored keys in memory |
|ping| checks the server | --  | `ping` | pong if everything is correct |

### Clients

Want to use BoJack with your language? Currently we support:

- [Crystal](http://github.com/hugoabonizio/bojack.cr) - Thanks to @hugoabonizio
- [Python](https://github.com/mauricioabreu/bojack-py) - Thanks to @mauricioabreu

## Contributing

Found a bug? Have a suggestion? Please [open an issue](https://github.com/marceloboeira/bojack/issues/new).

Want to contribute? Make sure you follow the [guide](CONTRIBUTING.md).
