
function fatal()
{
  local MSG=$*
  printf "\033[0;31m $MSG \033[0m\n\n"
  exit 1
}


