sudo wget -qO /usr/local/bin/stern https://github.com/wercker/stern/releases/download/1.7.0/stern_linux_amd64 && \
       sudo chmod +x /usr/local/bin/stern

sudo apt-get update
sudo apt-get install -y unzip

# kubectx/kubens
wget -q https://github.com/ahmetb/kubectx/archive/v0.5.0.zip && \
	unzip v0.5.0.zip && \
	sudo cp kubectx-0.5.0/completion/*bash /usr/share/bash-completion/ && \
	sudo chmod +x kubectx-0.5.0/kube* && \
	sudo cp kubectx-0.5.0/kube* /usr/local/bin/ && \
	rm -fr v0.5.0.zip kubectx-0.5.0/
