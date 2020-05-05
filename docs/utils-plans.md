
`ict.sh` is a bash script that works as follows:

`ict.sh [-p | --port PORT] [DIR/ | DIR1 DIR2 ..]`

The idea is: (1) port on the host machine is dynamically defined.  (2) You have three ways of getting pyramidal images in place to serve, namely:

- no directory supplied: you on your own drop correctly laid out directories in the container's /pyramids directory.  If you've mounted a directory from the host OS as in the above example, this is feasible and might be handy for fast experiements
- a single directory name with trailing slash: this is directly mounted to /pyramids, so its contents should be namespace-level directories
- one or more directories without trailing slash; these are mounted within /pyramids, so their contents should be group-level directories.

The slash/no-slash syntax kind of mimics rsync.  Example:

`ict.sh imgroot/` and `ict.sh imgroot/*` would be exactly equivalent, but if you had two root directories, you'd also have the option of starting up `ict imgroot1/* imgroot2/*`
