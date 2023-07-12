#!/usr/bin/env bash

# Get the name of the repository and an action from the command-line arguments.
REPO=$1
ACTION=$2

# If the repository name is not provided...
if [ "$REPO/x" == "/x" ]; then
  # ...and if a .git/config file exists in the current directory...
  if [ -f .git/config ]; then
      # ...print the URL of the current Git repository.
      cat .git/config | grep "url =" | tr 	"\t" 	" " | sed -e "s/url = //" | sed -e "s/ //g"
  else
      # If the .git/config file doesn't exist, print a usage message and exit the script.
      echo "Usage: $0 <repo> <action>"
      exit 1
  fi
exit 1
fi

# If the directory github/${REPO} does not exist, clone the repository from GitHub.
# Here, different mirrors or services for cloning the repository are provided as alternatives.
# Uncomment the line that corresponds to the service you want to use.
if [ ! -d "github/${REPO}" ]; then
git clone https://github.com/$* github/$*
# Switch to this line if you're in China and GitHub is slow.
# git clone https://github.moeyy.xyz/https://github.com/$* github/$*
 #git clone https://github.com.cnpmjs.org/$* github/$*
 #git clone https://hub.fastgit.org/$* github/$*
#git clone https://github.com/$* github/$*
fi

# Define a function that creates a tasks.json file in the .vscode directory of the cloned repository.
# This file is used by Visual Studio Code to define tasks.
# The function takes a command line string as an argument and writes it into the tasks.json file.
function makeBuilder(){
  CLI=$1
  mkdir -p ./github/${REPO}/.vscode >/dev/null
  tee "./github/${REPO}/.vscode/tasks.json" >/dev/null <<EOF
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "build",
      "type": "shell",
      "command": "${CLI}",
      "problemMatcher": [],
      "isBackground": true,
      "presentation": {
        "reveal": "always",
        "panel": "new"
      },
      "runOptions": {
        "runOn": "folderOpen"
      }
    }
  ]
}
EOF
}

# For different types of projects, call the makeBuilder function with a different command line that builds the project.
# If the project is a Python project...
if [ -f "github/${REPO}/requirements.txt" ]; then
makeBuilder "virtualenv --python=python3 venv && source venv/bin/activate && pip3 install -r requirements.txt"
fi

# If the project is a Rust project...
if [ -f "github/${REPO}/"Cargo.toml ]; then
makeBuilder "cargo build --release"
fi

# If the project is a Go project...
if [ -f "github/${REPO}/go.mod" ]; then
  if [ -f "./main.go" ]; then
    makeBuilder "go build"
  fi
fi

# If the project is a Java project...
if [ -f "github/${REPO}/build.gradle" ]; then
makeBuilder "gradle build -x test"
fi

# If the project is a Maven project...
if [ -f "github/${REPO}/pom.xml" ]; then
makeBuilder "mvn install -DskipTests=true"
fi

# If the project is a Node.js project...
if [ -f "github/${REPO}/package.json" ]; then
makeBuilder "pnpm i"
fi

# Finally, open the cloned repository in Visual Studio Code.
code github/$*
