# Description:
#   send all of the messages on Slack in #timeline
#
# Configuration:
#   create #timeline channel on your Slack team
#
# Notes:
#   None
#
# Author:
#   vexus2

request = require 'request'
module.exports = (robot) ->
  robot.hear /.*?/i, (msg) ->
    channel = msg.envelope.room
    room_name = robot.adapter.client.rtm.dataStore.getChannelGroupOrDMById(channel).name
    message = msg.message.text
    username = msg.message.user.name
    user_id = msg.message.user.id
    reloadUserImages(robot, user_id)
    user_image = robot.brain.data.userImages[user_id]
    if message.length > 0
      message = encodeURIComponent(message)
      link_names = if process.env.SLACK_LINK_NAMES then process.env.SLACK_LINK_NAMES else 0
      timeline_channel = if process.env.SLACK_TIMELINE_CHANNEL then process.env.SLACK_TIMELINE_CHANNEL else 'timeline'
      request = msg.http("https://slack.com/api/chat.postMessage?token=#{process.env.SLACK_API_TOKEN}&channel=%23#{timeline_channel}&text=#{message}%20(at%20%23#{room_name}%20)&username=#{username}&link_names=#{link_names}&pretty=1&icon_url=#{user_image}").get()
      request (err, res, body) ->

  reloadUserImages = (robot, user_id) ->
    robot.brain.data.userImages = {} if !robot.brain.data.userImages
    robot.brain.data.userImages[user_id] = "" if !robot.brain.data.userImages[user_id]?

    return if robot.brain.data.userImages[user_id] != ""
    options =
      url: "https://slack.com/api/users.list?token=#{process.env.SLACK_API_TOKEN}&pretty=1"
      timeout: 2000
      headers: {}

    request options, (error, response, body) ->
      json = JSON.parse body
      i = 0
      len = json.members.length

      while i < len
        image = json.members[i].profile.image_48
        robot.brain.data.userImages[json.members[i].id] = image
        ++i
