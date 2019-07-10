#!/bin/sh
# Description rsync from adapter01 to adapter02
rsync -avz --delete /opt/WEB/tomcat8083/ adapter02.zootaplus:/opt/WEB/tomcat8083/
rsync -avz --delete /opt/WEB/tomcat8084/ adapter02.zootaplus:/opt/WEB/tomcat8084/
rsync -avz --delete /opt/WEB/tomcat8085/ adapter02.zootaplus:/opt/WEB/tomcat8085/
rsync -avz --delete /opt/WEB/tomcatPortal/ adapter02.zootaplus:/opt/WEB/tomcatPortal/
rsync -avz --delete /opt/WEB/tomcatWorker/ adapter02.zootaplus:/opt/WEB/tomcatWorker/
rsync -avz --delete /opt/WEB/tomcatAdapter/ adapter02.zootaplus:/opt/WEB/tomcatAdapter/