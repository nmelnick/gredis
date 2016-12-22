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

    [CCode (cname = "redisConnect")]
    public Context? connect(string ip, int port);

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
    
    [Compact]
    [CCode (cname = "redisContext", free_function = "redisFree")]
    public class Context {
        public int err;
        public char errstr[128];
        public int fd;
        public int flags;
        public string obuf;
        public Reader reader;
        public ConnectionType connection_type;
        public TimeVal timeout;

        [PrintfFunction]
        [CCode (cname = "redisCommand", has_target = false, has_type_id = false)]
        public Reply redis_command(string format, ...);
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
}