sinatra-eventmachine-example
============================

Short and workin Sinatra and EventMachine

Plain text responce
-------------------

Here are results without EM:

    $ siege -c 50 -b -t 10S http://localhost:9292/without_em 

    Transactions:		          16 hits
    Availability:		      100.00 %
    Elapsed time:		        9.55 secs
    Data transferred:	        0.00 MB
    Response time:		        5.06 secs
    Transaction rate:	        1.68 trans/sec
    Throughput:		        0.00 MB/sec
    Concurrency:		        8.47
    Successful transactions:          16
    Failed transactions:	           0
    Longest transaction:	        5.07
    Shortest transaction:	        0.00

And here with EM using `next_tick`:
    
    $ siege -c 50 -b -t 10S http://localhost:9292/with_em

    Transactions:		        3673 hits
    Availability:		      100.00 %
    Elapsed time:		        9.10 secs
    Data transferred:	        0.04 MB
    Response time:		        0.12 secs
    Transaction rate:	      403.63 trans/sec
    Throughput:		        0.00 MB/sec
    Concurrency:		       49.39
    Successful transactions:        3673
    Failed transactions:	           0
    Longest transaction:	        0.20
    Shortest transaction:	        0.07