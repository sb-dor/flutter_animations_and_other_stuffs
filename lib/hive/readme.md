for using Hive you should install two packages

    hive: [version]
    hive_flutter: ^1.1.0
    hive_generator: ^2.0.1
    path_provider: [version]


    dev_dependencies:
        build_runner: ^2.4.13

file "hive_database_helper" is created for just getting updating deleting inserting. That is why you should
create your own class which will have have own logic to communicate with "hive_database_helper"


for generating adapters:

    dart run build_runner watch

