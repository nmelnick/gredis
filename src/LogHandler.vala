/*
 * LogHandler.vala
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

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