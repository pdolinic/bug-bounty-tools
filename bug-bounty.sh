#!/bin/bash

# See README.md on the tools that are used and how to setup and run the script on your system.
# I will try and make as many comments as possible so it is easy to understand the commands that are being ran


# Updates the system
sudo apt-get update && sudo apt-get upgrade -y

# Checks to see if GO is installed and installs if not - required for some of the tools to be installed
if ! command -v go &> /dev/null; then
  # Install Go
  sudo apt-get install golang-go -y
fi

echo "Modifying '.profile' to support GO installations..."
echo -e 'export GOPATH=$(go env GOPATH) \nexport PATH=$PATH:$GOPATH/bin' >> .profile
source ~/.profile
echo "GO successfully installed"

# Installs the tools mentioned in README.md
echo "Installing Nuclei..."
go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest
nuclei
echo "Nuclei installed, installing httpx..."
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
echo "httpx installed, installing Subfinder..."
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
echo "Subfinder installed, installing DNSx..."
go install -v github.com/projectdiscovery/dnsx/cmd/dnsx@latest
echo "DNSx installed, installing Naabu..."
go install -v github.com/projectdiscovery/naabu/v2/cmd/naabu@latest
echo "Naabu installed, installing Nmap"
sudo apt-get install nmap -y
echo "Nmap installed, installing Katana..."
go install github.com/projectdiscovery/katana/cmd/katana@latest
echo "Katana installed, installing Recox..."
git clone https://github.com/samhaxr/recox
cd recox
chmod +x recox.sh
./recox.sh
mv recox.sh /usr/local/bin/recox
echo "Recox successfully installed, please add your VirusTotal and Shodan API keys to /usr/lcoal/bin/recox.sh"
echo "All tools have now been installed."