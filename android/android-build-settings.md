# What is this for

- Auto-generated version number for release builds
- No need to include keystore / password in repository
- The code should still build with no extra configuration

# How it works

- Version code / number are generated from the commit itself
- Version / sign settings are injected as environment variables
- When these settings are not present, failback to default ones silently