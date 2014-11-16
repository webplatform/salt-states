# src: https://github.com/solarkennedy/etcd-packages
NAME=etcd
VERSION=0.4.6
TARBALL=$(NAME)-v$(VERSION)-Linux-amd64.tar.gz
TARDIR=$(NAME)-v$(VERSION)-linux-amd64
DOWNLOAD=https://github.com/coreos/etcd/releases/download/v$(VERSION)/$(TARBALL)
DESCRIPTION=A highly-available key value store for shared configuration and service discovery

.PHONY: default
default: deb
package: deb

$(TARBALL):
        wget -c -O $(TARBALL) $(DOWNLOAD)

$(TARDIR): $(TARBALL)
        tar xzf $(TARBALL)

etcd_$(VERSION)_amd64.deb: $(TARDIR)
        cd $(TARDIR)/ && \
        fpm -s dir -t deb -v $(VERSION) -n $(NAME) -a amd64 \
        --prefix=/usr/bin/ \
        --url "https://github.com/coreos/etcd" \
        --description "$(DESCRIPTION)" \
        --deb-user root --deb-group root \
        etcd etcdctl && \
        mv *.deb ..

etcd_$(VERSION)_amd64.rpm: $(TARDIR)
        cd $(TARDIR)/ && \
        fpm -s dir -t rpm -v $(VERSION) -n $(NAME) -a amd64 \
        --prefix=/usr/bin \
        --description "$(DESCRIPTION)" \
        --url "https://github.com/coreos/etcd" \
        etcd etcdctl && \
        mv *.rpm ..

.PHONY: clean
clean:
        rm -rf etcd*

.PHONY: deb
deb: $(NAME)_$(VERSION)_amd64.deb
