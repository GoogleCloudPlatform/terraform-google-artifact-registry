# Upgrading to v0.3.0

The v0.3.0 release of **terraform-google-artifact-registry** is a backwards
incompatible release.

### Defaults for Public Repositories

Previously, this module provided defaults that pointed at well-known public
repositories. Previously, for example, you could specify remote repository
configuration for Docker Hub like so:

```
remote_repository_config = {
  docker_repository = {}
}
```

And you would get a remote repository configuration that would point to Docker
Hub. Now, you have to explicitly specify that you want Docker Hub like so:

```
remote_repository_config = {
  docker_repository = {
    public_repository = "DOCKER_HUB"
  }
}
```

This change was made because the previous behavior of defaulting these to
well-known values turned out to be incompatible with specifying custom
repository options via the `custom_repository` argument.
