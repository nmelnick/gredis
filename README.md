# GRedis

This is a work in progress to get a simple Redis client working in Vala, using
hiredis natively in the background. Should work very well in Vala or Genie, or
anything else that consumes GLib, but I doubt it makes much sense in languages
that are not Vala or Genie.

Questions or comments, feel free to email, file an issue, or find me in #vala.

## Building/Installing on Linux/FreeBSD/*nix/WSL

* Install requirements
  * Vala 0.22 or higher
  * glib 2.32 or higher
  * gee-0.8
  * libhiredis + libhiredis-dev (tested on 0.13+)
* Clone or download the repository
* mkdir build
* cd build
* cmake ..
* make && sudo make install

## Basic Usage

```
public static int main(string[] args) {
    try {
        var c = new GRedis.Connection("127.0.0.1", 6379);
        if ( c.set("foo", "bar") ) {
            var value = c.get("foo");
            stdout.printf("foo is '%s'\n", value);
            c.del("foo");
        }
        if ( c.hset("foo", "baz", "bar") ) {
            var value = c.hget("foo", "baz");
            stdout.printf("foo:baz is '%s'\n", value);
            c.hdel("foo", "baz");
        }
    } catch (Error e) {
        stderr.printf("Oh noes, %s\n", e.message);
    }
}
```

## What works?

* A working, complete VAPI for libhiredis
* A library that compiles that provides a slightly more sane wrapper that looks
  like other Redis libraries
  * Supports Single operations (set, get, ...)
  * Supports Hash operations (hset, hget, ...)
  * Supports List operations (lindex, lpush, rpop, ...)
* Live unit tests

## What is still in progress?

* Geo operations
* Bit operations
* Config operations
* Sorted set operations
* Any other operations
* Async functionality (in the vapi, not in gredis)
* Mock unit tests

## What isn't happening any time soon?

* redis-cluster support. Not natively implemented in hiredis. There is
  a wrapper available, apparently, but have not looked into it yet
