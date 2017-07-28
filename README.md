# Hubot
## A Hubot for Slack
 
### Description 
It may go with out saying but "Hubot is your friendly robot sidekick. Install him in your company to dramatically improve employee efficiency." The core of the application is all thanks to the talented folks at GitHub. Out of the box, Hubot is all about having fun by posting jokes and images in Slack. We have expanded that functionality by adding our own Hubot scripts.  
 
### Usage
The package ships with a utility to get Hubot online with as little work as possible. This may be the preferred method if you are getting started for the first time and want to stay out of the weeds. For more advanced users, feel free to jump past our utility and utilize the underling Docker container.       

#### Environment
The underlying Docker container needs to know a few things about your bot. This information will get delivered to yeoman generator without interactively prompting. Please update the env file with your specific bot configuration:
```bash
readonly HUBOT_SLACK_TOKEN="xoxb-xxxx-xxxx"
readonly HUBOT_OWNER="Name"
readonly HUBOT_OWNER_EMAIL="Email"
readonly HUBOT_DESCRIPTION="Delightfully aware robutt"
readonly HUBOT_NAME="Hubot"
```

Move into the scripts directory and run the start up command:

```bash
$ cd Hubot/scripts         # start from the scripts directory
$ sh start.sh --help       # read the documentation
$ sh start.sh
``````