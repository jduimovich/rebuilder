FROM registry.access.redhat.com/ubi8/ubi 
WORKDIR /rebuilder 
RUN dnf -y  module install nodejs:18/common  
RUN dnf -y install git  
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
RUN mv kubectl  /usr/local/bin/ && chmod +x /usr/local/bin/kubectl
RUN curl -LO https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/4.12.0/openshift-client-linux.tar.gz    
RUN tar xvf openshift-client-linux.tar.gz 
RUN mv oc  /usr/local/bin/ && chmod +x /usr/local/bin/oc

COPY . /rebuilder
RUN npm install 
CMD [ "bash", "docker-entrypoint.sh" ] 
