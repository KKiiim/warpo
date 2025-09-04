#include <cstdio>

#include "warpo/support/Color.hpp"

#if _WIN32
#include <io.h>
#define ISATTY _isatty
#define FILENO _fileno
#else
#include <unistd.h>
#define ISATTY isatty
#define FILENO fileno
#endif

bool warpo::support::isTTY() noexcept {
  static const bool tty = 0 != ISATTY(FILENO(stdout));
  return tty;
}
