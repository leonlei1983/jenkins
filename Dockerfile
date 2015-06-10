FROM ubuntu
MAINTAINER Leon Lei <leonlei1983@gmail.com>

ENV HOME		/home/jenkins
ENV JENKINS_HOME	/var/jenkins
ENV GLASSFISH_HOME	/var/glassfish4
ENV JAVA_HOME		/usr/lib/jvm/java-7-openjdk-amd64
ENV PATH		$PATH:$JAVA_HOME/bin:$GLASSFISH_HOME/glassfish4/bin

RUN apt-get update && \
	apt-get install -y curl git ssh vim wget screen python2.7 openjdk-7-jdk zip unzip && \
	rm -rf /var/lib/apt/lists/* && apt-get clean -yq

RUN useradd -d $HOME -u 1000 -m -s /bin/bash jenkins && \
	mkdir -p $GLASSFISH_HOME $JENKINS_HOME && \
	chown jenkins -R $JENKINS_HOME $GLASSFISH_HOME

USER jenkins
WORKDIR $HOME

RUN cd $GLASSFISH_HOME && \
	wget -q http://download.java.net/glassfish/4.1/release/glassfish-4.1.zip && \
	unzip glassfish-4.1.zip && rm glassfish-4.1.zip && \
	cd glassfish4/glassfish/domains/domain1/autodeploy && \
	wget -q http://mirrors.jenkins-ci.org/war/latest/jenkins.war && \
	cd ~ && git clone https://github.com/leonlei1983/linux_config && \
	mv ~/linux_config/.vim ~/.vim && mv ~/.vim/vimrc ~/.vimrc && \
	mv ~/linux_config/.screenrc ~/.screenrc && \
	rm -rf ~/linux_config

EXPOSE 4848 8080 8181 50000

CMD	asadmin start-domain
