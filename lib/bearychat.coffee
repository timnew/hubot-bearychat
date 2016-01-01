# Hubot dependencies
{Robot, Adapter, TextMessage, Response, User} = require 'hubot'

class BearyChat extends Adapter
  run: ->
    @bearyChatOutgoing = process.env.BEARY_CHAT_OUTGOING
    @bearyChatIncomming = process.env.BEARY_CHAT_INCOMMING

    @robot.router.post @bearyChatOutgoing, (req, res) =>
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

    @robot.logger.info "#{@robot.name} is online."
    @send {}, "#{@robot.name} is online."

    @emit 'connected'

  send: (user, strings...) ->
    @robot.logger.info 'Send message', strings...

    message = JSON.stringify
      text: strings.join('\n')

    @robot.http(@breaChatIncomming)
          .header('Content-Type', 'application/json')
          .post(message) (err, res, body) =>
            @robot.logger.info body

  reply: (user, strings...) ->
    @send user, strings...

exports.use = (robot) ->
  new BearyChat robot
