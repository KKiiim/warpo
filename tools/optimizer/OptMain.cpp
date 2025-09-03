#include <argparse/argparse.hpp>
#include <cstddef>
#include <fmt/format.h>

#include "fmt/base.h"
#include "warpo/passes/Runner.hpp"
#include "warpo/support/Opt.hpp"

static warpo::cli::Opt<std::string> inputPath{
    "-i",
    "--input",
    [](argparse::Argument &arg) -> void { arg.help("input file").required(); },
};

static warpo::cli::Opt<std::string> outputPath{
    "-o",
    "--output",
    [](argparse::Argument &arg) -> void { arg.help("output file").required(); },
};

void optMain(int argc, char const *argv[]) {
  using namespace warpo;

  passes::init();
  argparse::ArgumentParser program("warpo", "git@" GIT_COMMIT);
  cli::init(program, argc, argv);
  passes::runAndEmit(inputPath.get(), outputPath.get());
}

int main(int argc, const char *argv[]) {
  try {
    optMain(argc, argv);
  } catch (std::exception const &e) {
    fmt::println("ERROR: {}", e.what());
    return 1;
  }
}
