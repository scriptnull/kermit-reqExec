$ErrorActionPreference = "Stop"

function install_prereqs() {
  echo "Checking prerequisites"

  $installed_new_package = $false

  $python_package = Get-Package python2 -provider ChocolateyGet -ErrorAction SilentlyContinue
  if (!$python_package) {
    echo "Installing python2"
    choco install -y python2
    $installed_new_package = $true
  }

  $pip_package = Get-Package pip -provider ChocolateyGet -ErrorAction SilentlyContinue
  if (!$pip_package) {
    echo "Installing pip"
    choco install -y pip
    $installed_new_package = $true
  }

  if ($installed_new_package) {
    refreshenv
  }
}

function build_reqExec() {
  echo "Building reqExec binaries"

  pip install pyinstaller==3.3
  pip install -r requirements.txt
  python -m PyInstaller --clean --hidden-import=requests -F main.py
}

install_prereqs
build_reqExec
