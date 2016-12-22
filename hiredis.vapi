/* 
  Copyright (C) 2017, Nicholas Melnick

  Permission is hereby granted, free of charge, to any person obtaining a copy of
  this software and associated documentation files (the "Software"), to deal in
  the Software without restriction, including without limitation the rights to
  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
  of the Software, and to permit persons to whom the Software is furnished to do
  so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in all
  copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  SOFTWARE.
*/

[CCode (cheader_filename = "hiredis/hiredis.h")]
namespace Redis {

    /**
     * Connect to a Redis instance.
     *
     * @param ip Hostname or IP address
     * @param port Port number (defaults to 6379)
     * @return Redis.Context instance
     */
    [CCode (cname = "redisConnect")]
    public Context? connect(string ip, int port = 6379);

    [CCode (cname = "redisConnectWithTimeout")]
    public Context? connect_with_timeout(string ip, int port, TimeVal tv);

    [CCode (cname = "redisConnectNonBlock")]
    public Context? connect_nonblock(string ip, int port = 6379);

    [CCode (cname = "redisConnectBindNonBlock")]
    public Context? connect_bind_nonblock(string ip, int port, string source_addr);

    [CCode (cname = "redisConnectBindNonBlockWithReuse")]
    public Context? connect_bind_nonblock_with_reuse(string ip, int port, string source_addr);

    [CCode (cname = "redisConnectUnix")]
    public Context? connect_unix(string path);

    [CCode (cname = "redisConnectUnixWithTimeout")]
    public Context? connect_unix_with_timeout(string path, TimeVal tv);

    [CCode (cname = "redisConnectUnixNonBlock")]
    public Context? connect_unix_nonblock(string path);

    [SimpleType]
    [CCode(cname = "struct timeval")]
    public struct TimeVal {
        [CCode(cname = "*")]
        public static TimeVal(Posix.timeval v);
    }

    [CCode(cname = "redisConnectionType", cprefix = "REDIS_CONN_", has_type_id = false)]
    public enum ConnectionType {
        TCP,
        UNIX
    }
    
    /**
     * Redis connection context for performing operations.
     */
    [Compact]
    [CCode (cname = "redisContext", free_function = "redisFree")]
    public class Context {
        public int err;
        public char errstr[128];
        public int fd;
        public int flags;
        public uint8[] obuf;
        public Reader reader;
        public ConnectionType connection_type;
        public TimeVal timeout;

        /**
         * Send a command to Redis.
         *
         * In a blocking context, it is identical to calling append_command,
         * followed by get_reply. The function will return null if there was an
         * error in performing the request, otherwise it will return the reply.
         * In a non-blocking context, it is identical to calling only
         * append_command and will always return null.
         *
         * @param format String to send to Redis, or a printf-style format
         *               string, followed by arguments.
         */
        [PrintfFunction]
        [CCode (cname = "redisCommand", has_target = false, has_type_id = false)]
        public Reply command(string format, ...);
        
        [CCode (cname = "redisvCommand", has_target = false, has_type_id = false)]
        public Reply v_command(string format, va_list ap);

        /**
         * Reconnect the given context using the saved information.
         *
         * This re-uses the exact same connect options as in the initial
         * connection.
         * host, ip (or path), timeout and bind address are reused,
         * flags are used unmodified from the existing context.
         *
         * Returns RedisResponse.OK on successfull connect or RedisResponse.ERR
         * otherwise.
         */
        [CCode (cname = "redisReconnect", has_target = false, has_type_id = false)]
        public RedisResponse reconnect();
        
        [CCode (cname = "redisSetTimeout", has_target = false, has_type_id = false)]
        public RedisResponse set_timeout(TimeVal tv);
        
        [CCode (cname = "redisEnableKeepAlive", has_target = false, has_type_id = false)]
        public RedisResponse enable_keep_alive();
        
        [CCode (cname = "redisBufferRead", has_target = false, has_type_id = false)]
        public RedisResponse buffer_read();
        
        [CCode (cname = "redisBufferWrite", has_target = false, has_type_id = false)]
        public RedisResponse buffer_write(int* done);
        
        /**
         * In a blocking context, this function first checks if there are
         * unconsumed replies to return and returns one if so. Otherwise, it
         * flushes the output buffer to the socket and reads until it has a
         * reply. In a non-blocking context, it will return unconsumed replies
         * until there are no more.
         */
        [CCode (cname = "redisGetReply", has_target = false, has_type_id = false)]
        public RedisResponse get_reply(out Reply reply);

        /**
         * In a blocking context, this function first checks if there are
         * unconsumed replies to return and returns one if so. Otherwise, it
         * flushes the output buffer to the socket and reads until it has a
         * reply. In a non-blocking context, it will return unconsumed replies
         * until there are no more.
         */
        [CCode (cname = "redisGetReplyFromReader", has_target = false, has_type_id = false)]
        public RedisResponse get_reply_from_reader(out Reply reply);

        /**
         * Write a formatted command to the output buffer. Use these functions
         * in blocking mode to get a pipeline of commands.
         */
        [CCode (cname = "redisAppendFormattedCommand", has_target = false, has_type_id = false)]
        public RedisResponse append_formatted_command(string cmd);

        /**
         * Write a command to the output buffer. Use these functions in blocking
         * mode to get a pipeline of commands.
         */
        [CCode (cname = "redisvAppendCommand", has_target = false, has_type_id = false)]
        public RedisResponse v_append_command(string cmd, va_list ap);

    }

    [Compact]
    [CCode (cname = "redisReply", free_function = "freeReplyObject")]
    public class Reply {
        public int type;
        public int64 integer;
        [CCode (array_length_cname = "len", array_length_type = "int")]
        public uint8[] str;
        [CCode (array_length_cname = "elements", array_length_type = "size_t")]
        public Reply[] element;
    }

    [CCode (cheader_filename = "hiredis/read.h", cname = "redisReadTask", free_function = "", unref_function = "")]
    public struct ReadTask {
        int type;
        int elements;
        int idx;
        void* obj;
        void* parent;
        void* privdata;
    }

    [CCode (has_target = false)]
    public delegate void CreateString (ReadTask rt, [CCode (array_length_type = "size_t")] uint8[] str);
    [CCode (has_target = false)]
    public delegate void CreateArray (ReadTask rt, int i);
    [CCode (has_target = false)]
    public delegate void CreateInteger (ReadTask rt, uint64 i);
    [CCode (has_target = false)]
    public delegate void CreateNil (ReadTask rt);
    [CCode (has_target = false)]
    public delegate void FreeFunc (void* v);

    [SimpleType]
    [CCode (cheader_filename = "hiredis/read.h", cname = "redisReplyObjectFunctions", free_function = "", unref_function = "")]
    public struct ReplyObjectFunctions {
        CreateString cs;
        CreateArray ca;
        CreateInteger ci;
        CreateNil cn;
        FreeFunc f;
    }

    [SimpleType]
    [CCode (cheader_filename = "hiredis/read.h", cname = "redisReader", free_function = "redisReaderFree", unref_function = "")]
    public struct Reader {
        int err;
        char errstr[128];
        char[] buf;
        size_t pos;
        size_t len;
        size_t maxbuf;
        ReadTask rstack[9];
        int ridx;
        Reply reply;
        ReplyObjectFunctions fn;
        void* privdata;

        [CCode (cname = "redisReaderCreateWithFunctions", has_target = false, has_type_id = false)]
        public static Reader create_with_functions(ReplyObjectFunctions fn);

        [CCode (cname = "redisReaderFeed", has_target = false, has_type_id = false)]
        public int feed([CCode (array_length_cname = "len", array_length_type = "size_t")] char[] buf);
        
        [CCode (cname = "redisReaderGetReply", has_target = false, has_type_id = false)]
        public int get_reply(out Reply reply);
    }


    [CCode (cname = "int", cprefix = "REDIS_", has_type_id = false)]
    [Flags]
    public enum Flags {
        BLOCK,
        CONNECTED,
        DISCONNECTING,
        FREEING,
        IN_CALLBACK,
        SUBSCRIBED,
        MONITORING,
        REUSEADDR
    }

    [CCode (cname = "int", cprefix = "REDIS_", has_type_id = false)]
    public enum RedisResponse {
        ERR,
        OK
    }

    [CCode (cname = "int", cprefix = "REDIS_ERR_", has_type_id = false)]
    public enum RedisError {
        IO,
        EOF,
        PROTOCOL,
        OOM,
        OTHER
    }

}