# Change Log
All notable changes to the `opendkim` cookbook will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/) and this project adheres to [Semantic Versioning](http://semver.org/).

## [2.0.0] - 2017-03-31
### Added in 2.0.0
- Chef `13` support.
- metadata: Add `chef_version`.
- README: Add GitHub badge.

### Changed in 2.0.0
- CHANGELOG: Follow "Keep a CHANGELOG".

### Removed in 2.0.0
- Drop Chef `< 12` and Ruby `< 2.2` support.

### Improved in 2.0.0
- README: Add doc and license badges.
- Improve TESTING documentation.
- Update RuboCop to `0.48`.

## [1.0.0] - 2015-09-03
### Addeed in 1.0.0
- Add Oracle Linux and Scientific Linux support.
- metadata: Add `source_url` and `issues_url` links.

### Fixed in 1.0.0
- Fix Ubuntu `15.04` support.

### Changed in 1.0.0
- Update contact information and links after migration.

### Improved in 1.0.0
- Improve platforms support using `node['platform_family']` node attribute.
- Gemfile: Update RuboCop to `0.33.0`.

## [0.2.0] - 2015-07-06
### Added in 0.2.0
- Create user and group before a directory owned by them ([issue #1](https://github.com/zuazo/opendkim-cookbook/pull/1), thanks [Michael Burns](https://github.com/mburns)).

### Improved in 0.2.0
- README: Fix and improve some examples.
- Update RuboCop to `0.32.1`.

## 0.1.0 - 2015-05-21
- Initial release of `opendkim`.

[Unreleased]: https://github.com/zuazo/opendkim-cookbook/compare/2.0.0...HEAD
[2.0.0]: https://github.com/zuazo/opendkim-cookbook/compare/1.0.0...2.0.0
[1.0.0]: https://github.com/zuazo/opendkim-cookbook/compare/0.2.0...1.0.0
[0.2.0]: https://github.com/zuazo/opendkim-cookbook/compare/0.1.0...0.2.0
