= Release Notes

== Version "20230826"

 * New features
 - Retrieval of dynamic prices from [Tibber](https://tibber.com/)
 - Introducing --help option to all scripts 

 * Improvements
 - README now more welcoming to new users
 - Introducing release notes

 * Under the hood
 - Better detection of things that could go wrong.
   . Extra checks and set of -e flag to stop script upon uncaught errors
   . Continuously testing with GitHub on Ubuntu and Victron's VenusOS [docker image](https://github.com/victronenergy/venus-docker)
 - Some flexibility via environment variables
 - Extra hardening of shell scripts along suggestions by [shellcheck](https://www.shellcheck.net/)
 - 
