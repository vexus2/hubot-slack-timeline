[![npm version](https://badge.fury.io/js/hubot-slack-timeline.svg)](http://badge.fury.io/js/hubot-slack-timeline)

# Hubot Slack Timeline

## Description

It will send all of the messages on Slack in #timeline.
However, a private group messages does not include

## Installation and Setup

Add the following code in your external-scripts.json file.
["hubot-slack-timeline"]

**Note**: The default hubot configuration will use a redis based brain that assumes the redis server is already running.  Either start your local redis server (usually with `redis-start &`) or remove the `redis-brain.coffee` script from the default `hubot-scripts.json` file.

### Create #timeline channel in Slack

type `/open` and create #timeline channel in your Slack


### Configuring the variables on Heroku

    % heroku config:add SLACK_API_TOKEN="YOUR_SLACK_API_TOKEN"

### Configuring the variables on UNIX

    % export SLACK_API_TOKEN="YOUR_SLACK_API_TOKEN"

### Optional
#### change timeline's channel name (default: timeline)
    % export SLACK_TIMELINE_CHANNEL=timeline

#### link name, channels into #timeline (default: 0)

    % export SLACK_LINK_NAMES=1


**Note**: You can generate Slack API token here [https://api.slack.com/](https://api.slack.com/)

