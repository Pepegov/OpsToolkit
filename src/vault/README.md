
## dev_in_memory

This runs a completely in-memory Vault server, which is useful for development but should not be used in production.

When running in development mode, two additional options can be set via environment variables:

    VAULT_DEV_ROOT_TOKEN_ID: This sets the ID of the initial generated root token to the given value
    VAULT_DEV_LISTEN_ADDRESS: This sets the IP:port of the development server listener (defaults to 0.0.0.0:8200)