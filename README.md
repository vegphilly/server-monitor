server-monitor
==============

Monitor a server for signs of vitality. Email an admin if tests don't pass.

setup
=====

1. Create a cabal sandbox with `cabal sandbox init`
2. Build the app with `cabal build`
3. Copy the `example-config` file and fill in these values.
4. Run the app with `<path_to_executable> <path_to_config>`
5. If there is output, your server has failed, expect an email to be sent.
6. Run this in a cronjob.


