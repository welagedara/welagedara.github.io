---
layout: post
title: "The Gaming Rig Part 7; Benchmarking the PC"
categories: junk
author: "Pubudu Welagedara"
meta: "Computer Hardware"
comments: true
---

Benchmarking the GPU and the CPU are considered integral parts of any PC build. 

## GPU Benchmark( [FRAPS][fraps])

To measure the GPU performance, Frames Per Second( FPS) is measured against the resolution( 1080p, 1440p, 4K etc). 

The G- SYNC panel in Alienware AW2518H has a native resolution of 1080p. Therefore benchmarking was done at 1080p with all graphics settings set to the highest in Black Ops 4 Multiplayer( Arsenal).

{% assign image = "BlackOps4.png" %}
{% assign alt = "FPS" %}
{% include srcset.html %}

In the graph, x- Axis  depicts the frame number and the y- Axis depicts the time each frame was displayed on the screen. 

### Benchmark Results

- Resolution: 1920X1080( Full HD)
- Duration: 1min 59s =~ 2mins
- Average: 7.79ms => (1/7.79)/10^(-3) =~ 128 FPS
- 1% Low: 13.8ms => (1/13.8)/10^(-3) =~ 73 FPS 
- 0.1% Low: 18ms => (1/18)/10^(-3) =~ 56 FPS

Notes: 
- For Computer Gaming, Frame Rates above 30 FPS is considered sufficient
- G- SYNC from Nvidia matches the frame rate of the Nvidia Graphics Card to that of the Monitor eliminating the screen tear
- Higher Frame Rate is preferred over a Higher Resolution in Gaming

## [Cinebench R15][cinebench] Benchmark

Cinebench is a Test Suite that evaluates a Computer's performance. This benchmark gives a score( Number of FPS for GPU performance and Points for CPU performance) based on the tests performed. Your results can be compared against other systems with similar specifications to see where yours stand.

### Cinebench CPU Benchmark Results

{% assign image = "cpu.png" %}
{% assign alt = "Cinebench CPU" %}
{% include srcset.html %}

### Cinebench GPU Benchmark Results

{% assign image = "gpu.png" %}
{% assign alt = "Cinebench GPU" %}
{% include srcset.html %}


[fraps]: http://www.fraps.com/
[cinebench]: https://www.maxon.net/en/products/cinebench/



















