
# vendored-node

Eliminate external dependencies.  Install nodejs and npm inside your app's directory, just like
other dependencies.  Ensure that global npm modules are installed in your app's own node sandbox
too. Don't be burned ever again by a global node install on a crufty old server.

## Getting Started

Add `vendored-node` to your project's root directory

    $ cd my-project
    $ git clone https://github.com/fragmentz/vendored-node.git node
    $ make -C ./node NODE_VERSION=4.3.0

Run your app

    $ node/bin/npm install
    $ node/bin/node app.js

You now have a complete node install based at `my-project/node/`.  The executables
are all in `my-project/node/bin`.  NPM is in there too, and global modules
will be installed to `my-project/node/lib/node_modules`.


## Bootstrapping Your App

The setup shown above can be run from any setup script, or builder that does not itself 
require the presence of node.  `Make` is a particularly simple, and ubiquitous way 
to do this.  An example Makefile is included, which you can copy to your project as
a starter.

    $ cp node/Makefile.example ./Makefile
    

You can link to 
node and npm from a more convenient location if you prefer it:

    $ ln -s ../node/bin/node bin/node
    $ ln -s ../node/bin/npm bin/npm

    $ bin/npm install 
    $ bin/node app.js

## Global NPM Modules

Install them like normal, but use the vendored npm.

    $ node/bin/npm install -g mocha

"Global" modules are still contained within your vendored-node "sandbox".

    $ ls -l node/bin/mocha
    lrwxr-xr-x  1 lee  staff  35 Oct 15 23:19 node/bin/mocha -> ../lib/node_modules/mocha/bin/mocha

Most global tools need to be run through the node exe explicitly to ensure that the proper version
of node is used for subsequent invocations.

    $ node/bin/node node/bin/mocha --version
    3.1.2


## A word of advice: Uninstall Node.js, use vendored-node in every project

    $ node --version
    -bash: node: command not found

This is a good thing.  You didn't want to run that nasty global node install anyway.  You have 
no idea where that thing has been.

    $ my-project/bin/node --version
    v4.3.0

... now that's more like it.

The whole point is to ensure that you're always running the version of node (and any
global modules) that the application was built to use.  And that you're not affected
by whatever crap happens to be installed in the global environment of the host machine.
The best way to ensure this is to *completely remove* the global `node` install 
from your workstations and servers.  Each application gets its own `vendored-node`, 
at the proper version, and you never accidentally run the global node.
 

Your application's Makefile installs it, along with any global npm modules 
and other dependencies. All your users have to type is `make`


