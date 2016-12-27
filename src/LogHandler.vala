namespace GRedis {
    public class LogHandler : Object {
        public enum LogLevel {
            TRACE,
            DEBUG,
            INFO,
            WARN,
            ERROR
        }

        public virtual void vlog(string format, va_list v) {
            stdout.vprintf(format + "\n", v);
        }

        public virtual void log(string format, ...) {
            vlog(format, va_list());
        }

        public virtual void trace(string format, ...) {
            stdout.vprintf("TRACE " + format, va_list());
        }

        public virtual void debug(string format, ...) {
            stdout.vprintf("DEBUG " + format, va_list());
        }

        public virtual void info(string format, ...) {
            stdout.vprintf("INFO  " + format, va_list());
        }

        public virtual void warn(string format, ...) {
            stdout.vprintf("WARN  " + format, va_list());
        }

        public virtual void error(string format, ...) {
            stdout.vprintf("ERROR " + format, va_list());
        }
    }
}