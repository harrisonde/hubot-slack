#!/usr/bin/env bash
set -eou pipefail

readonly LOCAL_LOG_FILE_PATH=${BASE_PATH:="./"}${LOG_FILE:="$(basename "$0").log"}
readonly LOCAL_LOG_LEVEL=${LOG_LEVEL:=production}

if [ "$LOCAL_LOG_LEVEL" == "debug" ]; then
    echo "Running in debug mode ie extremely verbose. As a best practice, disable in production. " ;
fi
#/ Usage: radar [options]
#/ Description: Take in a log request and log it to a log file. Each request may define a log level that describes the severity of the logging message.
#/ Usage:
#/  Command Line:
#/      $sh log.sh --debug="Boom goes the dynamite!"
#/
#/  Import:
#/      source log.sh
#/      debug "Boom goes dynamite!"
#/
#/  Options:

##
#   Describes the files usage options when the help argument is set.
#/   --help: Display this help message
usage() {
    grep '^#/' "$0" | cut -c4- ; exit 0 ;
}
expr "$*" : ".*--help" > /dev/null && usage

##
#   Display a table with logging messages and severities.
#/   --levels: Display the logging messages and seventies.
levels() {
    echo '| Level   | Severity | Description |'
    echo '|---------|----------|-------------|'
    echo '| Fatal   | High     | A severe error causing the application to fail.'
    echo '| Error   | ...      | A error impacting application performance.'
    echo '| Warning | ...      | Harmful state; application functions with minimal impact.'
    echo '| Notice  | ...      | High-level notification message. '
    echo '| Info    | ...      | High-level information message. '
    echo '| Debug   | Low      | Detailed message used to identify events within the application.'
}
expr "$*" : ".*--levels" > /dev/null && levels

##
# Output the current date and time wherein echo is used to replace return as
# Bash return expects only integers as a return value.
timestamp() {
    echo $(date +%F.%T)
}

##
#   A method to log out debug messages in the log.
#/   --debug: Log a debug message to the logs.
debug() {
    if [ "$LOCAL_LOG_LEVEL" == "debug" ]; then
      echo "[DEBUG $(timestamp)] $@" | tee -a "$LOCAL_LOG_FILE_PATH" >&2 ;
    fi
}

##
#   A method to log out informational messages in the log.
#/   --info: Log an informational message to the logs.
info() {
    echo "[INFO $(timestamp)] $@"  | tee -a "$LOCAL_LOG_FILE_PATH" >&2 ;
}

##
# #   A method to log out notice messages in the log.
#/   --notice: Log a notice to the logs.
notice() {
    echo "[NOTICE $(timestamp)] $@" | tee -a "$LOCAL_LOG_FILE_PATH" >&2 ;
}

##
#   A method to log out warning messages in the log.
#/   --warning: Log an warning message to the logs.
warning() {
    echo "[WARNING $(timestamp)] $@"  | tee -a "$LOCAL_LOG_FILE_PATH" >&2 ;
}

##
#   A method to log out error messages in the log.
#/   --error: Log an error message to the logs.
error() {
    echo "[ERROR $(timestamp)] $@" | tee -a "$LOCAL_LOG_FILE_PATH" >&2 ;
}

##
#   A method to log out fatal messages in the log and exit the process.
#/   --fatal: Log an fatal message to the logs and exit.
fatal() {
    echo "[FATAL $(timestamp)] $@" | tee -a "$LOCAL_LOG_FILE_PATH" >&2 ; exit 1 ;
}

##
# Allow for calling via source or command line and preform checks accordingly; by
# string to string match of the caller.
if [[ "$0" == "log.sh"  ]] ; then
   expr "$*" : ".*--debug" > /dev/null && debug `expr "$@" : "^--debug=\(.*\)"`
   expr "$*" : ".*--info" > /dev/null && info `expr "$@" : "^--info=\(.*\)"`
   expr "$*" : ".*--notice" > /dev/null && notice `expr "$@" : "^--notice=\(.*\)"`
   expr "$*" : ".*--warning" > /dev/null && warning `expr "$@" : "^--warning=\(.*\)"`
   expr "$*" : ".*--error" > /dev/null && error `expr "$@" : "^--error=\(.*\)"`
   expr "$*" : ".*--fatal" > /dev/null && fatal `expr "$@" : "^--fatal=\(.*\)"`
fi
