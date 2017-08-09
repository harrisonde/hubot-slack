# Hubot-Slack - A Hubot ready for Slack

![Github Hubot](https://raw.githubusercontent.com/harrisonde/harrisonde.github.io/master/hubot/hubot-slack.jpg)

### Description 
According to Github, Inc (2017), "Hubot is your friendly robot sidekick. Install him in your company to dramatically improve employee efficiency." The core of the application was created by the talented folks at GitHub utilizing CoffeeScript and Node.js. Hubot ships with scripts providing fun features such as posting images and time checking. The aim of the Hubot for Slack project is establishing a runway from development to production that may remove some of the common development roadblocks encountered while building a Hubot for Slack.     
 
### Usage
The project ships with Traffic Control, a helper-utility to get Hubot online with minimal effort. Use it to quickly bypass Hubot's upfront wiring and start coding your own custom Hubot scripts. Already know Hubot's schematics by heart? Bypass Traffic Control and utilize the underling Docker container(s).       

#### Traffic Control
Traffic Control may be used to get Hubot online with minimal effort. Complete the following steps and start chatting in less then five minutes. 

```bash
    $ vim ./build/.env                          # Add your Hubot's specific configuration.
    $ sh ./build/traffic-control.sh --help      # Read the documentation!
    $ sh ./build/traffic-control.sh             # Activate your Hubot!
```

##### Environment
Traffic Control needs to know a few things about your Hubot. This information is delivered to the underlying Yeoman generator. Please update the ```./build/.env``` file with your specific Hubot configuration. You may cut, paste, and update the following code snippet:

```bash
readonly HUBOT_SLACK_TOKEN="xoxb-xxxx-xxxx" # Visit https://my.slack.com/services/new/bot for a token.
readonly HUBOT_OWNER="Name"                 # Who is responsible for this Hubot?
readonly HUBOT_OWNER_EMAIL="Email"          # What is their email?
readonly HUBOT_DESCRIPTION="My fun Hubot"   # Tell the world about your Hubot.
readonly HUBOT_NAME="Hubot"                 # What is your Hubot's name?
readonly HUBOT_ADAPTER="slack"              # The adapter for Slack
```

### References
* "Getting Started - Hubot Documentation." Github, July 2017, https://hubot.github.com