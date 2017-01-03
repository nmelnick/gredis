namespace GRedis {
    public interface Operation {
        public abstract Redis.Context context { get; }

        public Redis.Reply oper(string format, ...) throws RedisError {
            var list = va_list();
            return voper( format, list );
        }

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

        public bool oper_simple(string format, ...) throws RedisError {
            var list = va_list();
            var reply = voper( format, l );
            if (reply.type == Redis.ReplyType.STRING) {
                if ( ( (string) reply.str ) == "OK" ) {
                    return true;
                }
            } else {
                throw new RedisError.UNHANDLED("Unknown reply type %d".printf(reply.type));
            }
            return false;
        }
    }
}