<p align="center">
  <img src="https://raw.githubusercontent.com/marceloboeira/bojack/master/docs/bojack.png" width="250">
  <h3 align="center">BoJack</h3>
  <p align="center">The unreliable key-value store<p>
  <p align="center">
    <a href="https://travis-ci.org/marceloboeira/bojack"><img src="https://img.shields.io/travis/marceloboeira/bojack.svg?maxAge=360"></a>
    <a href="http://waffle.io/marceloboeira/bojack"><img src="https://img.shields.io/waffle/label/marceloboeira/bojack/ready.svg?maxAge=360"></a>
    <a href="http://github.com/marceloboeira/bojack/releases"><img src="https://img.shields.io/github/release/marceloboeira/bojack.svg?maxAge=360"></a>
    <a href="https://gitter.im/bo-jack/Lobby?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge"><img src="https://badges.gitter.im/bo-jack/Lobby.svg"></a>
  </p>
</p>

## Status

Originally, from my article "[Why you should build your own NoSQL Database](http://medium.com/@marceloboeira/why-you-should-build-your-own-nosql-database-9bbba42039f5)". BoJack is a bit mature now, yet missing several important features:

 - Cluster-friendliness
 - Security Layer (#34)
 - Unix Socket support (#48)

Feel free to share your thoughts and [contribute](##contributing).

## Installation

**Requirements**

* The latest version of Crystal (0.20.x)
* LLVM development files

**Steps**

1. Clone the repo: `git clone https://github.com/marceloboeira/bojack`
2. Switch to repo-directory: `cd bojack`
3. Build: `make install` (sudo for linux users)

## Showtime

1. Start the server, run: `bojack server`
2. Connect a client, in another tab, run: `bojack client`

```
$ bojack console
> set food 🍣
🍣
> get food
🍣
> ping
pong
```

***By default BoJack runs at 127.0.0.1:5000.***

## Usage

### CLI

Currently the command-line interface supports two commands: `server` and `console`.

```
bojack <server/console> <flags>
```

### Server

|flag|description||
|---|---|---|
|--hostname|Hostname the server will run|127.0.0.1|
|--port|Port the server will run|5000|
|--log|Path for a log file|STDOUT|
|--log-level|Level of messages logged|DEBUG = 0, INFO = 1 (default), WARN = 2, ERROR = 3, FATAL = 4|

### Console

|flag|description|default|
|---|---|---|
|--hostname|Hostname this console will connect|127.0.0.1|
|--port|Port this console will connect|5000|

### Commands

List of available commands for BoJack

|command|description|params|example|return|
|---|---|---|---|---|
|set| sets a key with the given name and value  | key, value  | `set foo bar`  | the value of the key "bar"  |
|increment| increments the given key value by 1| key | `increment foo`  | the value of the key "foo" incremented |
|get| gets the value of the given value  | key | `get foo` | the value stored at the key, "bar" |
|delete| deletes the given key | key, * | `delete foo, delete *` | the value at the deleted key "bar" or every key in the database, if "*" is given instead of a key  |
|append| add one or more values to the end of a list | key, value  | `append list foo,bar`  | the list resulted |
|pop| retrieve the last item of the list | key | `pop foo` | the last value stored at the list, "foo" |
|size| return the number of stored items | -- | `size` | the value of stored keys in memory |
|ping| checks the server | --  | `ping` | pong if everything is correct |

### Clients

Want to use BoJack with your language? Currently, we support:

- [Crystal](http://github.com/hugoabonizio/bojack.cr) - Thanks to @hugoabonizio
- [Python](https://github.com/mauricioabreu/bojack-py) - Thanks to @mauricioabreu
- [Ruby](http://github.com/hugoabonizio/bojack.rb) - Thanks to @hugoabonizio

## Contributing

Found a bug? Have a suggestion? Please [open an issue](https://github.com/marceloboeira/bojack/issues/new).

Want to contribute? Take a look at our [open issues](https://github.com/marceloboeira/bojack/issues) and make sure you follow our [guide](CONTRIBUTING.md).
