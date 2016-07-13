<img src="https://raw.githubusercontent.com/marceloboeira/bojack/master/docs/bojack.png" width="250" align="right">
# BoJack [![Build Status](https://travis-ci.org/marceloboeira/bojack.svg?branch=master)](https://travis-ci.org/marceloboeira/bojack)
> A non-reliable in-memory key-value store

## Installation

**Requirements**

* The latest version of Crystal (0.18.x).
* LLVM development files.

1. Clone the repo: `git clone https://github.com/marceloboeira/bojack`
2. Switch to repo-directory: `cd bojack`
3. Build: `make install`

## Showtime

1. Run: `bojack-server -p 5000`
2. Run: `telnet 127.0.0.1 5000`

## Usage

|command|description|params|example|return|
|---|---|---|---|---|---|
|set| sets a key with the given name and value  | key, value  | `set foo bar`  | the value of the key "bar"  |
|get| gets the value of the given value  | key | `get foo` | the value stored at the key, "bar" |
|delete| deletes the given key | key | `delete foo` | the value at the deleted key "bar"  |
|size| return the number of stored items | -- | `size` | the value of stored keys in memory |
|ping| checks the server | --  | `ping` | pong if everything is correct |
