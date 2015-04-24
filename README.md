# Safari Cookbook

[![Cookbook Version](http://img.shields.io/cookbook/v/safari.svg?style=flat-square)][cookbook]
[![Build Status](http://img.shields.io/travis/dhoer/chef-safari.svg?style=flat-square)][travis]
[![GitHub Issues](http://img.shields.io/github/issues/dhoer/chef-safari.svg?style=flat-square)][github]

[cookbook]: https://supermarket.chef.io/cookbooks/safari
[travis]: https://travis-ci.org/dhoer/chef-safari
[github]: https://github.com/dhoer/chef-safari/issues

This cookbook provides `safari_version` library method to retrieve safari version installed.

## Requirements

Chef 11.14.2 or higher.

### Platforms

- Mac OS X

## Usage

Include the safari as a dependency to make library method available.

Library method `safari_version` is provided to retrieve CFBundleShortVersionString by default:

```ruby
version = safari_version # => 8.0.4
```

You can return other version types by passing its name (e.g. BuildVersion, CFBundleVersion, ProjectName or
SourceVersion)

```ruby
bundle_version = safari_version('CFBundleVersion') # => 10600.4.10.7
```

**Tip:** use `allow_any_instance_of` to stub safari_version method when testing with rspec:

```ruby
allow_any_instance_of(Chef::Recipe).to receive(:safari_version).and_return('8.0.4')
```

## Getting Help

- Ask specific questions on [Stack Overflow](http://stackoverflow.com/questions/tagged/chef-safari).
- Report bugs and discuss potential features in [Github issues](https://github.com/dhoer/chef-safari/issues).

## Contributing

Please refer to [CONTRIBUTING](https://github.com/dhoer/chef-safari/blob/master/CONTRIBUTING.md).

## License

MIT - see the accompanying [LICENSE](https://github.com/dhoer/chef-safari/blob/master/LICENSE.md) file for details.
