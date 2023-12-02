for using Hive you should install two packages

    hive: [version]
    path_provider: [version]

file "hive_database_helper" is created for just getting updating deleting inserting. That is why you should
create your own class which will have have own logic to communicate with "hive_database_helper"