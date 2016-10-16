NODE_VERSION := latest
cwd = $(shell pwd)

all: bin/node

bin/node: n/bin/n
	PATH=$(cwd)/bin:$(PATH)    \
			 N_PREFIX=$(cwd)       \
			 n/bin/n $(NODE_VERSION)
	mv bin/node bin/_node
	mv bin/npm bin/_npm
	cp vendored-node/bin/* bin/

n/bin/n:
	git clone https://github.com/tj/n.git n

clean:
	find . -mindepth 1 -maxdepth 1          \
		-type d                               \
		! -name ".*"                          \
		! -name vendored-node                 \
		-exec rm -rf "{}" \;

