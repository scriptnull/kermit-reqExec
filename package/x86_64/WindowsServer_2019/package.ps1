$ErrorActionPreference = "Stop"

function install_prereqs() {
  echo "Checking prerequisites"

  $python_package = Get-Package python2 -provider ChocolateyGet -ErrorAction SilentlyContinue
  if (!$python_package) {
    echo "Installing python2"
    choco install -y python2
  }

  $pip_package = Get-Package pip -provider ChocolateyGet -ErrorAction SilentlyContinue
  if (!$pip_package) {
    echo "Installing pip"
    choco install -y pip
  }
}

function buildReqExec() {
  echo "building reqExec binaries"
  pip install pyinstaller==3.3
  pip install -r requirements.txt
  python -m PyInstaller --clean --hidden-import=requests -F main.py
}

install_prereqs
buildReqExec
