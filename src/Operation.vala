namespace GRedis {
    public interface Operation {
        public abstract Redis.Context context { get; }

        public Redis.Reply oper(string format, ...) throws RedisError {
            var list = va_list();
            var reply = context.v_command(format, list);
            if (reply == null) {
                if (context.err == Redis.RedisError.IO) {
                    throw new RedisError.IO((string) context.errstr);
                }
                throw new RedisError.GENERAL((string) context.errstr);
            }
            return reply;
        }
    }
}