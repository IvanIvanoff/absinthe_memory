# AbsintheMemory

This repository shows that the peak heap memory usage of an Absinthe query can reach over 50 times the size of the result.

Opening the GraphiQL endpoint: http://localhost:4000/api/graphiql and executing this query:
```graphql
{
  getMetric{
    timeseriesDataPerAsset{
      datetime
      data{ value asset } 
    }
  }
}
```
we observe that the query is killed because the 50mb max heap size has been reached.
If the `Process.flag(:max_heap_size, ...)` line is deleted from the `metric_resolver.ex` file
and we execute the query again, we observe that the size of the whole HTTP response is just 828 kB.

HTTP response size if `:max_heap_size` is not set:
![](2023-05-26-14-03-56.png)

`error_logger` log if `:max_heap_size` is set:
```sh
[error]      Process:            #PID<0.641.0> 
     Context:            maximum heap size reached
     Max Heap Size:      6553600
     Total Heap Size:    7959521
     Kill:               true
     Error Logger:       true
     Message Queue Len:  0
     GC Info:            [
  old_heap_block_size: 2984878,
  heap_block_size: 4974798,
  mbuf_size: 0,
  recent_size: 2144512,
  stack_size: 152,
  old_heap_size: 0,
  heap_size: 2487244,
  bin_vheap_size: 7401,
  bin_vheap_block_size: 46422,
  bin_old_vheap_size: 0,
  bin_old_vheap_block_size: 46422
```