This document pertains to the entire LibreELEC tree and all of it's branches.

#### Table of Contents

- [Package Version Bumps](https://github.com/LibreELEC/LibreELEC.tv/blob/master/RULES.md#package-version-bumps)
  - [LibreELEC Testing Window](https://github.com/LibreELEC/LibreELEC.tv/blob/master/RULES.md#libreelec-testing-window)
  - [LibreELEC Release Window](https://github.com/LibreELEC/LibreELEC.tv/blob/master/RULES.md#libreelec-release-window)
  - [Major Packages](https://github.com/LibreELEC/LibreELEC.tv/blob/master/RULES.md#major-packages)
  - [Minor Packages](https://github.com/LibreELEC/LibreELEC.tv/blob/master/RULES.md#minor-packages)
- [Fixes](https://github.com/LibreELEC/LibreELEC.tv/blob/master/RULES.md#fixes)
- [Reverts](https://github.com/LibreELEC/LibreELEC.tv/blob/master/RULES.md#reverts)
- [Trust](https://github.com/LibreELEC/LibreELEC.tv/blob/master/RULES.md#trust)
- [Changes to RULES.md](https://github.com/LibreELEC/LibreELEC.tv/blob/master/RULES.md#changes-to-mastermd)

## Package Version Bumps

If a package version is broken it must be signified with a comment stating what is broken and possibly a linked bug report.
```
# version 1.23 is broken on some systems, see https://bug.report.com/123456
```

#### LibreELEC Testing Window

Anything listed in the [Major Packages](https://github.com/LibreELEC/LibreELEC.tv/blob/master/RULES.md#major-packages) section **MUST** be submitted as a PR and reviewed.

Anything listed in the [Major Packages](https://github.com/LibreELEC/LibreELEC.tv/blob/master/RULES.md#major-packages) section will **NOT** be bumped unless there is majority support for it.

Anything listed in the [Minor Packages](https://github.com/LibreELEC/LibreELEC.tv/blob/master/RULES.md#minor-packages) section may be bumped

#### LibreELEC Release Window

Once an LibreELEC release has entered beta anything in the [Major Packages](https://github.com/LibreELEC/LibreELEC.tv/blob/master/RULES.md#major-packages) section will **NOT** be bumped with the exception of Kodi as it progresses to it's final release.

Once an LibreELEC release has entered beta anything in the [Minor Packages](https://github.com/LibreELEC/LibreELEC.tv/blob/master/RULES.md#minor-packages) section may be bumped **ONLY** if it fixes an outstanding issue.

#### Major Packages

- connman
- curl
- ffmpeg
- gcc
- glibc
- kodi
- linux
- mesa
- python
- systemd
- xf86-video-nvidia
- xorg-server

- VDR
- boblightd

#### Minor Packages

Anything not listed in the [Major Packages](https://github.com/LibreELEC/LibreELEC.tv/blob/master/RULES.md#major-packages) section

## Commits

All commits **must** be submitted as a pull request

All commits **must** be formatted similar to as follows
```
RPi2/options: enable some option
```
```
kodi: add patch to fix something
```
```
systemd: update to 229
```

## Pull Requests

Merging can only be done so after the pull request has been reviewed and signed off by the submitter and a team member

## Fixes

Any fixes to outstanding issues must be submitted as a PR **and** be tested.

## Reverts

Any reverts must be submitted as a PR **and** provide information about why the revert needs to occur.

## Trust

These master are of course only practical if we can trust each other to use them accordingly.

If these master are broken, trust is broken.

## Changes to RULES.md

Any changes being made to this document must be submitted as a PR and reviewed by the current LibreELEC Team.
