---
slug: /en/operations/system-tables/server_settings
---
# server_settings

Contains information about global settings for the server, which were specified in `config.xml`.
Currently, the table shows only settings from the first layer of `config.xml` and doesn't support nested configs (e.g. [logger](../../operations/server-configuration-parameters/settings.md#server_configuration_parameters-logger)).

Columns:

-   `name` ([String](../../sql-reference/data-types/string.md)) — Server setting name.
-   `value` ([String](../../sql-reference/data-types/string.md)) — Server setting value.
-   `default` ([String](../../sql-reference/data-types/string.md)) — Server setting default value.
-   `changed` ([UInt8](../../sql-reference/data-types/int-uint.md#uint-ranges)) — Shows whether a setting was specified in `config.xml`
-   `description` ([String](../../sql-reference/data-types/string.md)) — Short server setting description.
-   `type` ([String](../../sql-reference/data-types/string.md)) — Server setting value type.

**Example**

The following example shows how to get information about server settings which name contains `thread_pool`.

``` sql
SELECT *
FROM system.server_settings
WHERE name LIKE '%thread_pool%'
```

``` text
┌─name─────────────────────────┬─value─┬─default─┬─changed─┬─description─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┬─type───┐
│ max_thread_pool_size         │ 5000  │ 10000   │       1 │ The maximum number of threads that could be allocated from the OS and used for query execution and background operations.                           │ UInt64 │
│ max_thread_pool_free_size    │ 1000  │ 1000    │       0 │ The maximum number of threads that will always stay in a global thread pool once allocated and remain idle in case of insufficient number of tasks. │ UInt64 │
│ thread_pool_queue_size       │ 10000 │ 10000   │       0 │ The maximum number of tasks that will be placed in a queue and wait for execution.                                                                  │ UInt64 │
│ max_io_thread_pool_size      │ 100   │ 100     │       0 │ The maximum number of threads that would be used for IO operations                                                                                  │ UInt64 │
│ max_io_thread_pool_free_size │ 0     │ 0       │       0 │ Max free size for IO thread pool.                                                                                                                   │ UInt64 │
│ io_thread_pool_queue_size    │ 10000 │ 10000   │       0 │ Queue size for IO thread pool.                                                                                                                      │ UInt64 │
└──────────────────────────────┴───────┴─────────┴─────────┴─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┴────────┘
```

Using of `WHERE changed` can be useful, for example, when you want to check 
whether settings in configuration files are loaded correctly and are in use.

<!-- -->

``` sql
SELECT * FROM system.server_settings WHERE changed AND name='max_thread_pool_size'
```

**See also**

-   [Settings](../../operations/system-tables/settings.md)
-   [Configuration Files](../../operations/configuration-files.md)
-   [Server Settings](../../operations/server-configuration-parameters/settings.md)
