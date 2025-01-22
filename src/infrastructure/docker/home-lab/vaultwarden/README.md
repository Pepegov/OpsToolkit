### Settings

- DOMAIN -Specifies the domain associated with your Vaultwarden instance.
- LOGIN_RATELIMIT_MAX_BURST -Defines the maximum number of login or two-factor authentication requests allowed in a short period, while maintaining the average interval set by LOGIN_RATELIMIT_SECONDS.
- LOGIN_RATELIMIT_SECONDS - Specifies the average time in seconds between login requests from the same IP address before Vaultwarden begins to limit the request rate.
- ADMIN_RATELIMIT_MAX_BURST - Similar to the previous setting but applies to the admin panel.
ADMIN_RATELIMIT_SECONDS - Defines the average time interval for requests to the admin panel, similar to LOGIN_RATELIMIT_SECONDS.
- ADMIN_TOKEN - The secret key for accessing the Vaultwarden admin panel. For security, it’s recommended to use a long random string of characters. The admin panel will be disabled if this value is not set.
- SENDS_ALLOWED - Allows users to create Bitwarden Sends, a tool for securely sharing credentials.
- EMERGENCY_ACCESS_ALLOWED - Enables users to allow emergency access to their accounts, which can be useful in cases like granting a spouse access to credentials in an emergency. Possible values: true/false.
- WEB_VAULT_ENABLED - Determines whether the web vault interface is accessible. Disabling this option may be useful to prevent unauthorized access after configuring accounts. Possible values: true/false.
- SIGNUPS_ALLOWED -This setting controls whether or not new users can register for accounts without an invitation. Possible values: true / false.