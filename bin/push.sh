#!/bin/bash

function ColorText()
{
  if [ $# -ne 4 ]
  then
    echo "Usage:"
    echo "    4 parameters are needed!"
    echo "    ForeColor, BackgroundClor, Style and Text!"
    exit 255
  else
    Fg="3""$1"
    Bg="4""$2"
    SetColor="\E[""$Fg;$Bg""m"
    Style="\033[""$3""m"
    Text="$4"
    EndStyle="\033[0m"
    echo -e "$SetColor""$Style""$Text""$EndStyle"
  fi
}

function usage()
{
  ColorText 1 8 2 "Usage:"
  ColorText 1 8 2 "  $0 <branch_name> <commit_message> "
  ColorText 1 8 2 "  eg: $0 master 'new update message' "
}

if [ "$#" != "2" ]; then
  usage
  exit 255
fi

export REMOTE_PATH=git@github.com:Linylyy/RuHuo.git
export COMMIT_MESSAGE=$2
export BRANCH_NAME=$1


ColorText 2 8 2 "  REMOTE_PATH:          $REMOTE_PATH"
ColorText 2 8 2 "  COMMIT_MESSAGE:       $COMMIT_MESSAGE"
ColorText 2 8 2 "  BRANCH_NAME:          $BRANCH_NAME"

while [ 'test' = 'test' ]
do
  read -n 1 -p "Do you sure all the above are correct [Y/N]?"
  case $REPLY in
    Y | y) echo ; ColorText 2 8 2 "The program is running!"; break;;
    N | n) echo ; ColorText 1 8 1 "You have canceled! The program has exited!"; exit 0;;
    * ) echo ; ColorText 1 8 2 "Wrong selection! Please give a correct answer!";;
  esac
done

################################################

git add -A
git commit -m "$COMMIT_MESSAGE"

git remote rm $USER
git remote add $USER git@github.com:Linylyy/RuHuo.git
git push $USER HEAD:$BRANCH_NAME
