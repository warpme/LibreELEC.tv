This document pertains to the entire LibreELEC tree and all of it's branches.

#### Table of Contents

- [Package Version Bumps](#package-version-bumps)
  - [LibreELEC Testing Window](#libreelec-testing-window)
  - [LibreELEC Release Window](#libreelec-release-window)
  - [Major Packages](#major-packages)
  - [Minor Packages](#minor-packages)
- [Commits](#commits)
- [Pull Requests](#pull-requests)
- [Fixes](#fixes)
- [Reverts](#reverts)
- [Changes to RULES.md](#changes-to-rulesmd)

## Package Version Bumps

If a package version is broken it must be signified with a comment stating what is broken and possibly a linked bug report.
```
# version 1.23 is broken on some systems, see https://bug.report.com/123456
```

#### LibreELEC Testing Window

Anything listed in the [Major Packages](#major-packages) section **MUST** be submitted as a PR and reviewed by more than one LibreELEC team member.

Anything listed in the [Minor Packages](#minor-packages) section **MUST** be submitted as a PR and reviewed.

#### LibreELEC Release Window

Once a LibreELEC release has entered beta anything in the [Major Packages](#major-packages) section may be changed **ONLY** if it fixes an outstanding issue.

Once a LibreELEC release has entered beta anything in the [Minor Packages](#minor-packages) section may be changed **ONLY** if it fixes an outstanding issue.

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

Anything not listed in the [Major Packages](#major-packages) section

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

Merging can only be done after the pull request has been reviewed and signed off by the submitter and a team member

## Fixes

Any fixes to outstanding issues must be submitted as a PR **and** be tested.

## Reverts

Any reverts must be submitted as a PR **and** provide information about why the revert needs to occur.

## Changes to RULES.md

Any changes being made to this document must be submitted as a PR and reviewed by the current LibreELEC Team.
