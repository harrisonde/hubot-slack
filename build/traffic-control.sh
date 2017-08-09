#!/usr/bin/env ash
set -eou pipefail
IFS=$'\n\t'

source $(pwd)/build/.env
source $(pwd)/build/radar.sh


#/ USAGE:
#/      traffic-control [options]
#/
#/ DESCRIPTION:
#/      Setup Hubot in a new environment with as little hassle as possible.
#/
#/      You may pass the Slack token at runtime using a long form command argument. Please
#/      see the options for details on "--token" argument. This token may be provided by
#/      Slack via the Custom Bot creation page and take the form of "xoxb-... ." A alternative
#/      and preferred method will be to use an environment variable; several options exist and
#/      you may use the best option for your use case.
#/
#/ OPTIONS:
#/      --help: Display this help message
usage() { grep '^#/' "$0" | cut -c4- ; exit 0 ; }
expr "$*" : ".*--help" > /dev/null && usage

##
# Given any command line arguments, parse, and display
#/      --token: A Slack bot token
assign() {
    TOKEN=
    for arg in "$@"; do
        case $arg in
            --token=*|-token=*)
            TOKEN="${arg#*=}"
            echo $(expr "$@" : "^--token=\(.*\)")
           ;;

           *)
            warning "$(basename "$0") Unknown argument(s) will be ignored"
            ;;
        esac
    done
}

##
# A bot requires basic configuration by the user; validate and response accordingly.
configure() {
    info "Awesome! Let's get that Hubot rock'n!"
    sleep 1

    info "Checking your bot configuration"
    sleep 1

    if [ "$@" ]; then
        debug "Commandline arguments supersede; using $@"
        export HUBOT_SLACK_TOKEN=$@

    elif [ ! -z "${HUBOT_SLACK_TOKEN+x}" ]; then
        debug "Using slack token from env file: xoxb-2151xxxxx-xxxxxxxxxxxxx"

    else
        warning "Visit the Custom Bot creation page at https://my.slack.com/apps/A0F7YS25R-bots to register your bot with your Slack team and to retrieve a new bot token."
        fatal "A valid Slack token was not provided."
    fi
}

##
# Add project dependencies
dependencies() {
    npm install yo generator-hubot
}

##
# Set an environment variable. Mark each name to be passed to child processes in the environment.
exports() {
    export HUBOT_SLACK_TOKEN
    export HUBOT_OWNER
    export HUBOT_OWNER_EMAIL
    export HUBOT_DESCRIPTION
    export HUBOT_NAME
    export HUBOT_ADAPTER

    debug "Exporting environment: $(printenv | grep BOT_ | tr '\n' ' ')"

}


##
# Backup unique Hubot files.
backup() {
    debug "Storing Hubot project files."
    local tmpDir="./build/tmp"
    mkdir $tmpDir
    mv README.md $tmpDir
    mv .gitignore $tmpDir
    mv *.json $tmpDir
    unset tempDir
}

##
# Restore unique Hubot files.
restore() {
    debug "Restoring Hubot project files."
    local tmpDir="./build/tmp"
    mv -f $tmpDir/README.md ./
    mv -f $tmpDir/.gitignore ./
    mv -f $tmpDir/*.json ./
    rm -r $tmpDir
    unset tempDir
}
##
# Launch Hubot
start() {
     exec bin/hubot
}

##
# Use underlying Yeoman scaffolding to generate a new Hubot
generate() {
    info "Install Hubot the Yeoman generator; this may take a bit..."
    yo hubot \
        --owner="${HUBOT_OWNER} <${HUBOT_OWNER_EMAIL}>" \
        --name="${HUBOT_NAME}" \
        --description="${HUBOT_DESCRIPTION}" \
        --adapter="${HUBOT_ADAPTER}" \
        --defaults
}
##
# Create or start a Hubot.
init() {
    exports
    export PATH="node_modules/.bin:node_modules/hubot/node_modules/.bin:$PATH"

    if [ -e bin/hubot ]; then
        info "Hubot is installed, execute binary."
        start
    else
        dependencies

        backup

        generate

        restore

        start

    fi

}

##
# Handle all script events
main() {
    debug "$(basename "$0") Running main"

    configure $(assign $@)

    init

}

##
# Handle all script cleanup events
cleanup() {
    # ...
    $(info "Clean up in-progress. ")
    unset TOKEN
}


main $@

#/
#/ EXAMPLES:
#/      Leverage command argument; long form:
#/      $ traffic-control.sh --token="xoxb-123456-abcef-ghij-7890"
#/      $ Awesome! Let's get that Hubot rock'n
#/      $ Commandline arguments supersede; using xoxb-123456-abcef-ghij-7890
#/
#/      Environment variable (preferred):
#/      $ traffic-control.sh
#/      $ Awesome! Let's get that Hubot rock'n
#/      $ Using slack token from env file: xoxb-123456-abcef-ghij-7890