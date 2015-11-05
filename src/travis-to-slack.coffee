# Description
#   Travis CI webhook
#
# Author:
#   h.matsuo

module.exports = (robot) ->
  robot.router.post "/travisci/webhooks", (req, res) ->
    { payload } = req.body
    { status_message, build_url, message, number, repository } = JSON.parse payload

    envelope =
      room: repository.name

    status = if status_message is 'Pending' then 'started.' else "finished. (#{status_message})"

    robot.send envelope, """
      Build ##{number} of #{repository.owner_name}/#{repository.name} #{status}
      > #{message}
      #{build_url}
    """
    res.end "OK"


  robot.respond /hello/, (msg) ->
    msg.reply "hello!"

  robot.hear /orly/, ->
    msg.send "yarly"
