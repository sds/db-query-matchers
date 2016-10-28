## master

## 0.7.0

- Add new `db_event` configuration option to allow non-ActiveRecord ORMs.
  Thanks, @sethjeffery. [#20]

## 0.6.0

- Add new `log_backtrace` and `backtrace_filter` options

## 0.5.0

- Add new `schemaless` option

## 0.4.2

- Support a `on_query_counted` configuration option that is a callback for
  arbitrary code.

## 0.4.1

- Fix wrong error messages for nested block expectations.

## 0.4.0

- Support passing a range to the count: option, by calling the case
  equality operator on the argument.

## 0.3.1

- Add `matching` option that allows you to target certain queries.

## 0.3.0

- Restore RSpec 2 support.
- Add manipulative option to match CREATE, UPDATE and DELETE FROM queries.
- Add .projections.json configuration file.

## 0.2.3

- Fix issue #2.

## 0.2.2

- Add configuration option that will allow you to ignore certain queries.

## 0.2.1

- Fix Bundler auto-requiring.

## 0.2.0

- Update for RSpec 3.

## 0.1.2

- Fixed file inclusions in gemspec file.

## 0.1.1

- Fix bug preventing proper inclusion in external projects.

## 0.1.0

- Initial release.
