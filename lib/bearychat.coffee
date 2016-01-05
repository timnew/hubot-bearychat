# Hubot dependencies
{Robot, Adapter, TextMessage, Response, User} = require 'hubot'
url = require('url')

class BearyChat extends Adapter
  run: ->
    @configChatOutgoing()
    @configChatIncomming()

    @robot.logger.info "#{@robot.name} is online."
    @send {}, "#{@robot.name} is online."

    @emit 'connected'

  configChatOutgoing: ->
    parsedUrl = url.parse(process.env.BEARY_CHAT_OUTGOING || '/bearychat/outgoing')

    if parsedUrl.protocol? and parsedUrl.protocol != 'https:'
      ex = new Error('Chat Outgoing must be https')
      @robot.logger.error(ex)
      throw ex

    @bearyChatOutgoing = parsedUrl.path

    @robot.router.post @bearyChatOutgoing, @outgoingRoute

    @robot.logger.info('Register Bearychat Outgoing route: %s', @bearyChatOutgoing)

  outgoingRoute: (req, res) =>
    @robot.logger.info req.body
    ###
    {
      token: "robot's token"
      ts: 1355517523
      text: "!baike 中国"
      trigger_word: "!baike"
      subdomain: 'your_domain'
      channel_name: 'your_channel'
      user_name: 'your_name'
    }
    ###
    incomingMessage = req.body
    user = new User(req.body.user_name)
    @receive new TextMessage(user, incomingMessage.text)
    res.status(200).end()

  configChatIncomming: ->
    @bearyChatIncoming = process.env.BEARY_CHAT_INCOMING

    unless @bearyChatIncoming?
      ex = new Error('bearyChatIncoming is not set')
      @robot.logger.error(ex)
      throw ex

    @robot.logger.info('Register Bearychat Incomming route: %s', @bearyChatIncoming)

  send: (user, strings...) ->
    @robot.logger.info 'Send message', strings...

    message = JSON.stringify
      text: strings.join('\n')

    @robot.http(@bearyChatIncoming)
          .header('Content-Type', 'application/json')
          .post(message) (err, res, body) =>
            @robot.logger.info body

  reply: (user, strings...) ->
    @send user, strings...

exports.use = (robot) ->
  new BearyChat robot
