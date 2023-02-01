load("@io_bazel_rules_scala//scala:scala_import.bzl", "scala_import")
load("@io_bazel_rules_scala//scala:scala.bzl", "scala_library")
java_library(
    name = "scalatest_compatible",
    exports = [
        "//external:jar/org/scalatest/scalatest_compatible"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)



scala_import(
    name = "scalatest_core",
    jars = [
        "//external:jar/org/scalatest/scalatest_core_2_13"
    ],
    runtime_deps = [
        "//3rdparty/jvm/org/scala_lang/modules:scala_xml",
        "//3rdparty/jvm/org/scala_lang:scala_library",
        "//3rdparty/jvm/org/scala_lang:scala_reflect",
        "//3rdparty/jvm/org/scalactic:scalactic",
        ":scalatest_compatible"
    ],
    visibility = [
        "//3rdparty/jvm:__subpackages__"
    ]
)


