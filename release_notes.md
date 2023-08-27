= Release Notes

== Version 2.1
New Features

Retrieval of Dynamic Prices from Tibber: Version 2.1 introduces the ability to retrieve dynamic energy prices from Tibber, offering users more options for energy price data providers.

Introducing --help Option to All Scripts: To enhance user experience, the new version includes the "--help" option in all scripts, providing users with quick access to usage instructions and options.

Improvements
README Now More Welcoming to New Users: The README has been updated to provide a more user-friendly and informative introduction for new users. This aims to assist users in quickly getting started with the script.

Introducing Release Notes: To keep users informed about the latest changes and improvements, release notes have been introduced. Users can now easily access information about new features, improvements, and fixes in each version.

Under the Hood
Better Detection of Potential Issues: The script has been enhanced with extra checks and the use of the "-e" flag to immediately stop the script upon encountering uncaught errors. This ensures that potential issues are detected and addressed promptly.

Continuous Testing on Various Platforms: The script is now continuously tested on both Ubuntu and Victron's VenusOS docker image using GitHub actions. This ensures consistent behavior and compatibility across different platforms.

Flexibility via Environment Variables: Users now have increased flexibility with the ability to configure certain aspects of the script's behavior using environment variables.

Extra Hardening of Shell Scripts: The shell scripts have undergone additional hardening based on suggestions from ShellCheck, a tool for analyzing shell scripts. This helps to improve the robustness and reliability of the scripts.
