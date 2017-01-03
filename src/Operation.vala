namespace GRedis {
    /**
     * Core operation logic.
     */
    public interface Operation {
        public abstract Redis.Context context { get; }

        /**
         * Run a hiredis operation with the given format and values, throw a
         * RedisError on error, otherwise, return a Redis.Reply.
         */
        public Redis.Reply oper(string format, ...) throws RedisError {
            var list = va_list();
            return voper( format, list );
        }

        /**
         * Run a hiredis operation with the given format and va_list, throw a
         * RedisError on error, otherwise, return a Redis.Reply.
         */
        public Redis.Reply voper(string format, va_list l) throws RedisError {
            var reply = context.v_command(format, l);
            if (reply == null) {
                if (context.err == Redis.RedisError.IO) {
                    throw new RedisError.IO((string) context.errstr);
                }
                throw new RedisError.GENERAL((string) context.errstr);
            }
            return reply;
        }

        /**
         * Run a hiredis operation with the given format and values, throw a
         * RedisError on error, otherwise, return a boolean true if the response
         * is a status of "OK".
         */
        public bool oper_simple(string format, ...) throws RedisError {
            var list = va_list();
            var reply = voper( format, list );
            if (reply.type == Redis.ReplyType.STATUS) {
                if ( ( (string) reply.str ) == "OK" ) {
                    return true;
                }
            } else {
                throw new RedisError.UNHANDLED("Unknown reply type %d".printf(reply.type));
            }
            return false;
        }

        /**
         * Run a hiredis operation with the given format and values, throw a
         * RedisError on error, otherwise, return a boolean true if the response
         * is an integer of 1, or false on 0.
         */
        public bool oper_intbool(string format, ...) throws RedisError {
            var list = va_list();
            var reply = voper( format, list );
            if (reply.type == Redis.ReplyType.INTEGER) {
                return ( reply.integer == 1 ? true : false );
            } else {
                throw new RedisError.UNHANDLED("Unknown reply type %d".printf(reply.type));
            }
            return false;
        }

        /**
         * Run a hiredis operation with the given format and values, throw a
         * RedisError on error, otherwise, return the string value of the
         * response integer or string.
         */
        public string? oper_string(string format, ...) throws RedisError {
            var list = va_list();
            var reply = voper( format, list );
            if (reply.type == Redis.ReplyType.INTEGER) {
                return reply.integer.to_string();
            } else if (reply.type == Redis.ReplyType.STRING) {
                return (string) reply.str;
            } else if (reply.type == Redis.ReplyType.NIL) {
                return null;
            } else {
                throw new RedisError.UNHANDLED("Unknown reply type %d".printf(reply.type));
            }
        }
    }
}