#!/bin/bash
set -e

echo "🟢 System Update"
sudo apt update -y
sudo apt upgrade -y

echo "🐳 Installing Docker..."
curl -fsSL https://get.docker.com | sudo bash
sudo systemctl start docker
sudo systemctl enable docker

echo "🟢 Installing Git, curl, and yarn..."
sudo apt install -y git curl
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update -y
sudo apt install -y yarn

echo "🟢 Cloning Aztec Protocol repo..."
if [ ! -d "aztec-packages" ]; then
  git clone https://github.com/AztecProtocol/aztec-packages.git
fi
cd aztec-packages

echo "📦 Installing packages (may take time)..."
yarn install

echo "✅ Setup complete! You can now run the node."
