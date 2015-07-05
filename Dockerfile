FROM zuazo/chef-local:debian-7

COPY . /tmp/opendkim
RUN berks vendor -b /tmp/opendkim/Berksfile $COOKBOOK_PATH
RUN chef-client -r "recipe[apt],recipe[opendkim]"

EXPOSE 8891

CMD ["/usr/sbin/opendkim", "-f", "-x", "/etc/opendkim.conf", "-u", "opendkim", "-P", "/var/run/opendkim/opendkim.pid"]
