# http://docs.mongodb.org/manual/reference/ulimit/#recommended-settings
default['mongocookbook']['ulimit']['fsize'] = 'unlimited' # file_size
default['mongocookbook']['ulimit']['cpu'] = 'unlimited' # cpu_time
default['mongocookbook']['ulimit']['as'] = 'unlimited' # virtual memory
default['mongocookbook']['ulimit']['nofile'] = 64_000 # number_files
default['mongocookbook']['ulimit']['rss'] = 'unlimited' # memory_size
default['mongocookbook']['ulimit']['nproc'] = 32_000 # processes
