FROM ubuntu
MAINTAINER Leon Lei <leonlei1983@gmail.com>

WORKDIR /root
ENV HOME /root
ENV JENKINS_HOME /root/jenkins

# installation required utilities
RUN apt-get update && \
	apt-get install -y curl git ssh vim wget screen python2.7 openjdk-7-jdk && \
	rm -rf /var/lib/apt/lists/* && apt-get clean -yq

RUN cd ~ && git clone https://github.com/leonlei1983/linux_config && \
	mv ~/linux_config/.vim ~/.vim && mv ~/.vim/vimrc ~/.vimrc && \
	rm -rf ~/linux_config && \
	mkdir ~/apps && cd ~/apps && wget http://download.java.net/glassfish/4.1/release/glassfish-4.1.zip && \
	unzip glassfish-4.1.zip && \
	cd ~/apps/glassfish4/glassfish/domains/domain1/autodeploy && \
	wget http://mirrors.jenkins-ci.org/war/latest/jenkins.war

CMD ["~/apps/glassfish4/bin/asadmin", "start-domain"]
