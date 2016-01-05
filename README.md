hubot-bearychat [![NPM version][npm-image]][npm-url] [![Dependency Status][depstat-image]][depstat-url]
================

> `hubot-bearychat` is an [BearyChat] adapter for Hubot

## Install

Install using [npm][npm-url].

    $ npm install hubot-bearychat --save

And start hubot with adapter `bearychat`

    $ bin/hubot -a bearychat

## Configuration

Due to lack of built-in support from [BearyChat], so this adapter simulate the full conversation capability with a pair of `Incoming` and `Outgoing` Robots.

### Incoming Robot
1. Add a Incoming Robot(Purple one) to your BearyChat
2. Copy the `Hook Address` url in the `Robot Settings`, it looks like `https://hook.bearychat.com/<xxxx>/incoming/<xxxxxxx>`
3. Set the url to environment variable `BEARY_CHAT_INCOMING`

### Outgoing Robot
1. Add a Outgoing Robot(Black one) to your BearyChat
2. Set the `trigger word` to your robot's name or robot's alias (Be careful this is case-sensitive)
3. Set `https://<your robot host>/bearychat/outgoing` to the `POST Request Address` in your `Robot Settings`

**Hint: ** Adapter by default register the web hook url at `/bearychat/outgoing`, but this can be override with `BEARY_CHAT_OUTGOING` environment variable.

### Test

Once you set it up, and have your robot deployed.
If everything goes right, you will see Robot posts `<your robot name> is online.` message to your chatroom.

And if you says `<robot name> adapter`, it will responds `bearychat`.

**PITFALL: ** It robot doesn't responds, check your Outgoing Robot's `trigger word`, it must be aligned to your you robot's name or alias. Or Your robot cannot parse it properly. And if you are using English, you need to aware the trigger word is case-sensitive.

## License
MIT

[![NPM downloads][npm-downloads]][npm-url]

[homepage]: https://github.com/timnew/hubot-bearychat

[npm-url]: https://npmjs.org/package/hubot-bearychat
[npm-image]: http://img.shields.io/npm/v/hubot-bearychat.svg?style=flat
[npm-downloads]: http://img.shields.io/npm/dm/hubot-bearychat.svg?style=flat

[depstat-url]: https://gemnasium.com/timnew/hubot-bearychat
[depstat-image]: http://img.shields.io/gemnasium/timnew/hubot-bearychat.svg?style=flat

[BearyChat]: https://bearychat.com/
