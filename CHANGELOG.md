opendkim CHANGELOG
==================

This file is used to list changes made in each version of the `opendkim` cookbook.

## v1.0.0 (2015-09-03)

* Fix Ubuntu `15.04` support.
* Add Oracle Linux and Scientific Linux support.
* Improve platforms support using `node['platform_family']` node attribute.
* metadata: Add `source_url` and `issues_url` links.
* Update contact information and links after migration.

* Testing:
 * Integrate Travis CI with kitchen-docker using `kitchen-in-travis`.
 * Use `SoloRunner` to run ChefSpec tests faster.
 * Gemfile: Update RuboCop to `0.33.0`.
 * Add Vagrantfile.
 * Move ChefSpec tests to *test/unit*.

## v0.2.0 (2015-07-06)

* Create user and group before a directory owned by them ([issue #1](https://github.com/zuazo/opendkim-cookbook/pull/1), thanks [Michael Burns](https://github.com/mburns)).
* Document attributes in the metadata.
* README: Fix and improve some examples.
* Add a Dockerfile.
* Gemfile: Update RuboCop to `0.32.1`.

## v0.1.0 (2015-05-21)

* Initial release of `opendkim`.
