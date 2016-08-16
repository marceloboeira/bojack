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

1. Run: `bojack server -p 5000`
2. Run: `bojack client -p 5000`

```
$ bojack client -p 5000
> set foo bar
bar
> get foo
bar
> ping
pong
```

## Usage

|command|description|params|example|return|
|---|---|---|---|---|---|
|set| sets a key with the given name and value  | key, value  | `set foo bar`  | the value of the key "bar"  |
|get| gets the value of the given value  | key | `get foo` | the value stored at the key, "bar" |
|delete| deletes the given key | key, * | `delete foo, delete *` | the value at the deleted key "bar" or every key in the database, if "*" is given instead of a key  |
|append| add one or more values to the end of a list | key, value  | `append list foo,bar`  | the list resulted |
|pop| retrieve the last item of the list | key | `pop foo` | the last value stored at the list, "foo" |
|size| return the number of stored items | -- | `size` | the value of stored keys in memory |
|ping| checks the server | --  | `ping` | pong if everything is correct |

## Contributing

Found a bug? Have a suggestion? Please [open an issue](https://github.com/marceloboeira/bojack/issues/new).

Want to contribute? Make sure you follow the [guide](CONTRIBUTING.md).
