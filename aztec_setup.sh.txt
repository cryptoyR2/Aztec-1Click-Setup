#!binbash

echo 🟢 System Update & Dependencies...
sudo apt update && sudo apt upgrade -y
sudo apt install -y curl git build-essential unzip tmux

echo 🐳 Installing Docker...
curl -fsSL httpsget.docker.com -o get-docker.sh && sh get-docker.sh
sudo systemctl start docker
sudo systemctl enable docker

echo 🟢 Installing Node.js v18 & Yarn...
curl -fsSL httpsdeb.nodesource.comsetup_18.x  sudo -E bash -
sudo apt install -y nodejs
npm install --global yarn

echo 📦 Cloning Aztec Protocol...
git clone httpsgithub.comAztecProtocolaztec-packages.git
cd aztec-packages
git checkout master

echo 📦 Installing packages (may take time)...
yarn

echo 🚀 Starting Aztec Sequencer in tmux session...
cd yarn-projectend-to-end
tmux new-session -d -s aztec 'yarn start sequencer'

echo ✅ Aztec Sequencer is running in background inside 'tmux' session named 'aztec'
echo 👉 Run this to check logs tmux attach -t aztec
