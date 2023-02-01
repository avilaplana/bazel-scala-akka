load("@io_bazel_rules_scala//scala:scala_import.bzl", "scala_import")
load("@io_bazel_rules_scala//scala:scala.bzl", "scala_library")
java_library(
    name = "config",
    exports = [
        "//external:jar/com/typesafe/config"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)



scala_import(
    name = "ssl_config_core",
    jars = [
        "//external:jar/com/typesafe/ssl_config_core_2_13"
    ],
    runtime_deps = [
        "//3rdparty/jvm/org/scala_lang/modules:scala_parser_combinators",
        "//3rdparty/jvm/org/scala_lang:scala_library",
        ":config"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)


