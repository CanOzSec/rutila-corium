# RutilaCorium

## Description

I started this project to create a portable environment that met my expectations for a penetration testing environment. <br>
I had three main problems with the leading penetration testing environments: outdated packages, malfunctioning tools, and isolation. <br>
To address these issues, I developed scripts that retrieve and install tools directly from their sources, using Docker as an isolation layer. <br>

## Installation

You need to install [Docker](https://docs.docker.com/get-docker/) before proceeding. <br>
You can build this container utilizing the build script in the following manner:

```
chmod +x ./build_container.sh && sudo ./build_container.sh
chmod +x ./make_symlinks.sh && sudo ./make_symlinks.sh
```

Optionally you can download the data files which are wordlists and tools you can deploy on the target. <br>
Keep in mind that these tools are precompiled and you should not trust them blindly.

```
chmod +x ./download_data.sh && ./download_data.sh
```

## Usage

You can add `/opt/symlinks` to your path and tools will be ready to use:
```
export PATH=$PATH:/opt/symlinks/
```

## Notes

States and configurations of tools will be put at your home directory under `.local/rutila-corium`.
