FROM registry.access.redhat.com/ubi8/ubi 
WORKDIR /rebuilder 
RUN dnf -y  module install nodejs:18/common  
RUN dnf -y install git 
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
RUN mv kubectl  /usr/local/bin/ && chmod +x /usr/local/bin/kubectl
COPY . /rebuilder
RUN npm install
# Run the web service on container startup.
CMD [ "node", "app.js" ] 
